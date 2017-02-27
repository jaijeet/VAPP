classdef  IrVisitorGenerateDependency < IrVisitor
%  IRVISITORDEPENDENCYGENERATOR

% This visitor sets dependencies for MsPotentialFlow and MsVariable objects. It
% also keeps a copy of the same dependencies in IrNodeDifferentiable objects.
% The reason for the copy is:
% When this visitor goes through the whole tree, the potential/flow and
% variable objects will contain all the dependencies in all the equations.
% I.e., if there are multiple assignments to the same variable, this variable
% object will contain the dependencies for both assignments. However, the first
% IrNodeVariable object will only contain the dependencies from the first
% assignment.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Sat Dec 10, 2016  07:23PM
%==============================================================================

    properties
        rhsPfVec = MsPotential.empty;
        rhsVarVec = MsVariable.empty;
        rhsParmVec = MsParameter.empty;
        ifElseParmVec = MsParameter.empty;
        ifElseVarVec = MsVariable.empty;
        ifElsePfVec = MsPotential.empty;
    end

    methods

        function obj = IrVisitorGenerateDependency(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end

        function traverseSub = visitGeneric(thisVisitor, irNode)
            traverseSub = true;
        end

        function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
        % VISITIRNODEIFELSE
            traverseSub = false;

            condNode = ifElseNode.getChild(1);
            condDigger = IrVisitorRhsDigger(condNode);

            thenNode = ifElseNode.getChild(2);
            thenDigger = IrVisitorGenerateDependency();
            thenDigger.setIfElseVecs(thisVisitor, condDigger);
            thenDigger.traverseIr(thenNode);

            if ifElseNode.getNChild() > 2
                elseNode = ifElseNode.getChild(3);
                elseDigger = IrVisitorGenerateDependency();
                elseDigger.setIfElseVecs(thisVisitor, condDigger);
                elseDigger.traverseIr(elseNode);
            end
        end
        
        function traverseSub = visitIrNodeAssignment(thisVisitor, assignNode)
            traverseSub = false;

            % first generate dependency structure using diggers
            % This cannot be done in IrVisitorMark1 because we need information
            % about independent variables (i.e., which IOs are explicitOuts etc).

            digger = IrVisitorRhsDigger();
            rhsNode = assignNode.getRhsNode();
            digger.traverseIr(rhsNode);

            lhsNode = assignNode.getLhsNode();
            lhsVarObj = lhsNode.getVarObj();

            thisVisitor.setRhsVecs(digger);
            thisVisitor.addRhsVecsToDifferentiable(lhsVarObj);

            % once we add the dependencies to lhsVarObj, lhsVarObj will contain
            % all the dependecies of the objects in digger.varVec and
            % digger.PfVec. So we can just copy them over to the node.
            lhsNode.setDependPfVec(lhsVarObj.getDependPfVec());
            lhsNode.setDependVarVec(lhsVarObj.getDependVarVec());
        end

        function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
            traverseSub = false;

            digger = IrVisitorRhsDigger();
            rhsNode = contribNode.getRhsNode();
            digger.traverseIr(rhsNode);

            lhsNode = contribNode.getLhsNode();
            lhsPfObj = lhsNode.getPfObj();

            thisVisitor.setRhsVecs(digger);

            if contribNode.isImplicit() == false
                thisVisitor.addRhsVecsToDifferentiable(lhsPfObj);

                lhsNode.setDependPfVec(lhsPfObj.getDependPfVec());
                lhsNode.setDependVarVec(lhsPfObj.getDependVarVec());
            else
                tempVarObj = MsVariable();
                thisVisitor.addRhsVecsToDifferentiable(tempVarObj);
                tempPfVec = tempVarObj.getDependPfVec();
                if contribNode.isNullEqn() == false
                    % if this contribution is implicit and is not a
                    % nullEquation, add the lhs IO to the rhsDependPfVec
                    tempPfVec = [tempPfVec, thisVisitor.addRhsDependPf(lhsPfObj)];
                end
                % we have no lhsPfObj. Create a temporary MsVar obj and use its
                % addDependPf/addDependVar functions
                contribNode.setImplicitEqnDependPfVec(tempPfVec);
                contribNode.setImplicitEqnDependVarVec(tempVarObj.getDependVarVec());
            end
        end

        function addRhsVecsToDifferentiable(thisVisitor, differentiable)
        
            for dependPf = thisVisitor.rhsPfVec
                differentiable.addDependPf(dependPf);
            end

            for dependVar = thisVisitor.rhsVarVec
                differentiable.addDependVar(dependVar);
            end

            for dependParm = thisVisitor.rhsParmVec
                differentiable.addDependParm(dependParm);
            end
            
        end

        function setRhsVecs(thisVisitor, digger)
            thisVisitor.rhsVarVec  = [thisVisitor.ifElseVarVec, ...
                                                            digger.getVarVec()];
            thisVisitor.rhsPfVec   = [thisVisitor.ifElsePfVec, ...
                                                            digger.getPfVec()];
            thisVisitor.rhsParmVec = [thisVisitor.ifElseParmVec, ...
                                                        digger.getParmVec()];
        end

        function setIfElseVecs(thisVisitor, parentVisitor, digger)
        % SETIFELSEVEC
            thisVisitor.ifElseVarVec  = [parentVisitor.ifElseVarVec, ...
                                                          digger.getVarVec()];
            thisVisitor.ifElsePfVec   = [parentVisitor.ifElsePfVec, ...
                                                           digger.getPfVec()];
            thisVisitor.ifElseParmVec = [parentVisitor.ifElseParmVec, ...
                                                         digger.getParmVec()];
        end
    % end methods
    end
    
% end classdef
end
