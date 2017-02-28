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
% Last modified: Wed Jan 04, 2017  03:54PM
%==============================================================================

    properties
        rhsPfVecC = {}; %MsPotential.empty;
        rhsVarVecC = {}; %MsVariable.empty;
        rhsParmVecC = {}; %MsParameter.empty;
        ifElseParmVecC = {}; %MsParameter.empty;
        ifElseVarVecC = {}; %MsVariable.empty;
        ifElsePfVecC = {}; %MsPotential.empty;
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
            thenDigger.setIfElseVecCs(thisVisitor, condDigger);
            thenDigger.traverseIr(thenNode);

            if ifElseNode.getNChild() > 2
                elseNode = ifElseNode.getChild(3);
                elseDigger = IrVisitorGenerateDependency();
                elseDigger.setIfElseVecCs(thisVisitor, condDigger);
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

            thisVisitor.setRhsVecCs(digger);
            thisVisitor.addRhsVecCsToDifferentiable(lhsVarObj);

            % once we add the dependencies to lhsVarObj, lhsVarObj will contain
            % all the dependecies of the objects in digger.varVecC and
            % digger.PfVecC. So we can just copy them over to the node.
            lhsNode.setDependPfMap(lhsVarObj.getDependPfMap());
            lhsNode.setDependVarMap(lhsVarObj.getDependVarMap());
        end

        function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
            traverseSub = false;

            digger = IrVisitorRhsDigger();
            rhsNode = contribNode.getRhsNode();
            digger.traverseIr(rhsNode);

            lhsNode = contribNode.getLhsNode();
            lhsPfObj = lhsNode.getPfObj();

            thisVisitor.setRhsVecCs(digger);

            if contribNode.isImplicit() == false
                thisVisitor.addRhsVecCsToDifferentiable(lhsPfObj);

                lhsNode.setDependPfMap(lhsPfObj.getDependPfMap());
                lhsNode.setDependVarMap(lhsPfObj.getDependVarMap());
            else
                tempVarObj = MsVariable();
                thisVisitor.addRhsVecCsToDifferentiable(tempVarObj);
                tempPfVecC = tempVarObj.getDependPfVecC();
                if contribNode.isNullEqn() == false
                    % if this contribution is implicit and is not a
                    % nullEquation, add the lhs IO to the rhsDependPfVecC
                    tempPfVecC = [tempPfVecC, {lhsPfObj}];
                end
                % we have no lhsPfObj. Create a temporary MsVar obj and use its
                % addDependPf/addDependVar functions
                contribNode.setImplicitEqnDependPfVecC(tempPfVecC);
                contribNode.setImplicitEqnDependVarVecC(tempVarObj.getDependVarVecC());
            end
        end

        function addRhsVecCsToDifferentiable(thisVisitor, differentiable)
        
            for dependPf = thisVisitor.rhsPfVecC
                differentiable.addDependPf(dependPf{:});
            end

            for dependVar = thisVisitor.rhsVarVecC
                differentiable.addDependVar(dependVar{:});
            end

            for dependParm = thisVisitor.rhsParmVecC
                differentiable.addDependParm(dependParm{:});
            end
            
        end

        function setRhsVecCs(thisVisitor, digger)
            thisVisitor.rhsVarVecC  = [thisVisitor.ifElseVarVecC, ...
                                                            digger.getVarVecC()];
            thisVisitor.rhsPfVecC   = [thisVisitor.ifElsePfVecC, ...
                                                            digger.getPfVecC()];
            thisVisitor.rhsParmVecC = [thisVisitor.ifElseParmVecC, ...
                                                        digger.getParmVecC()];
        end

        function setIfElseVecCs(thisVisitor, parentVisitor, digger)
        % SETIFELSEVECC
            thisVisitor.ifElseVarVecC  = [parentVisitor.ifElseVarVecC, ...
                                                          digger.getVarVecC()];
            thisVisitor.ifElsePfVecC   = [parentVisitor.ifElsePfVecC, ...
                                                           digger.getPfVecC()];
            thisVisitor.ifElseParmVecC = [parentVisitor.ifElseParmVecC, ...
                                                         digger.getParmVecC()];
        end
    % end methods
    end
    
% end classdef
end
