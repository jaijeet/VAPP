classdef IrVisitorMark001 < IrVisitor
% IRVISITORMARKDEVICECOMPONENTS (Visitor order) = 1
%
% This visitor has to be run first.
% It traverses assignments and contributions and marks nodes and branches.
% Nodes and branches are marked as contributed or probed
%
% The job of IrVisitorMark1 is the following:
% 1. Visit assignments and find out which variables are being initialized
% 2. Visit contributions and mark them as explicit/implicit/nullEqn
%    discover dummy IOs if any. 
% 3. mark variables as initialized/uninitialized and as used/unused
% 4. mark Potential and Flow objects as contribs and probes
% 5. mark potential and flows as lhs if they are on the LHS of a contribution

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

% NOTE: when implementing contrib/probe tokens ->
% probe token is assigned at the first probe and does not chage afterwards
% contrib token is assigned anew at every encounter with a contribution

    properties
        module = IrNodeModule.empty;
    end

    methods

        function obj = IrVisitorMark001(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end

        function traverseSub = visitGeneric(thisVisitor, irNode)
            traverseSub = true;
        end

        function traverseSub = visitIrNodeModule(thisVisitor, moduleNode)
            traverseSub = true;
            thisVisitor.module = moduleNode;
        end

        function traverseSub = visitIrNodeAssignment(thisVisitor, assignNode)
            traverseSub = false;
            % if I set this to true, I must handle the statements below that
            % call setUsed for rhs variables

            accessIdx = assignNode.getAccessIdx();

            rhsNode = assignNode.getRhsNode();
            digger = IrVisitorRhsDigger(rhsNode);

            % Note that it is important to first set the rhs vars as used before
            % setting the lhs var as initialized.
            rhsVarVec = digger.getVarVec();

            for varObj = rhsVarVec
                varObj.setUsed();
            end

            lhsNode = assignNode.getLhsNode();
            lhsVarObj = lhsNode.getVarObj();
            lhsVarObj.setInit();

            rhsPfVec = digger.getPfVec();
            for pfObj = rhsPfVec
                pfObj.setProbe(accessIdx);
            end

        end

        function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
            traverseSub = false;

            module = thisVisitor.module;

            accessIdx = contribNode.getAccessIdx();

            lhsNode = contribNode.getLhsNode();
            lhsPfObj = lhsNode.getPfObj();
            rhsNode = contribNode.getRhsNode();

            % check if we are in a node collapse statement
            if lhsNode.isPotential() == true && ...
                    rhsNode.hasType('IrNodeConstant') && ...
                                        (rhsNode.getValue() == 0)
                contribNode.setNodeCollapse();
            else
                % create digger and dig through the RHS
                digger = IrVisitorRhsDigger(rhsNode, lhsPfObj);

                % set rhs vars used and rhs potentials and flows as probed
                rhsVarVec = digger.getVarVec();

                for varObj = rhsVarVec
                    varObj.setUsed();
                end

                rhsPfVec = digger.getPfVec();
                for pfObj = rhsPfVec
                    pfObj.setProbe(accessIdx);
                end

                % now check if the equation is an implicit one
                % we have to do this here because e.g. if lhsNode is a dummy node
                % in an implicit equation, we don't mark its pfObj as a contrib.
                lhsPfObj = lhsNode.getPfObj();
                nMatch = digger.getNMatch();
                if nMatch == 0
                    % set lhs PF as contrib
                    lhsPfObj.setContrib(accessIdx);
                    % mark the lhsNode as lhs
                    lhsNode.setLhs();
                elseif nMatch > 0
                    % add this contribution to the implicitContribVec of the module
                    module.addImplicitContrib(contribNode);
                    matchedPfNode = digger.getMatchedPfNode();
                    isAdditive = matchedPfNode.isAdditive()*lhsNode.isAdditive();
                    if nMatch == 1 && isAdditive == 1
                        % we might have dummy node here or a regular implicit equation
                        % let's check if the matchedPf is the lhsPf
                        % Here the lhsNode can also be an inverse PF. Hence, we
                        % multiply isAdditive with the sign of the lhsPfObj
                        % we have a dummy PF
                        contribNode.setNullEqn();
                        contribNode.setRhsDummyNode(matchedPfNode);
                        matchedPfNode.setDummy();
                        lhsNode.setDummy();
                    else % we have a genuine implicit equation with a lhs
                        lhsPfObj.setProbe(accessIdx);
                        % originally we had here the following
                        lhsPfObj.setContrib(accessIdx);
                        % we should replace this with something else in the new
                        % node_branch_design
                    end

                    for pfObj = rhsPfVec
                        pfObj.setInImplicitEqn();
                    end
                end
            end
        end

        function  traverseSub = visitIrNodeVariable(thisVisitor, varNode)
            %
            % THIS VISIT METHOD MUST BE IN LOCATED IN THIS VISITOR. DON'T MOVE
            % THIS METHOD. 
            %
            % Variables can be used in assignments/conditionals/contributions
            % the only time when we don't want to mark a variable as used is if
            % it's on the rhs of an assignment. This case is handled by the
            % visitAssignment method above. This means a lhs variable is never
            % visited by this visitor.
            % This visit method only handles conditional statements
            % since assignments and contributions are handled by their own
            % methods.
            traverseSub = true;
            varObj = varNode.getVarObj();
            varObj.setUsed();
        end

        function traverseSub = visitIrNodeAnalogFunction(thisVisitor, funcNode)
            traverseSub = false;
            funcVisitor = IrVisitorMark001();
            funcVisitor.module = funcNode; % again, this is ugly!
            funcVisitor.traverseChildren(funcNode);
        end

    % end methods
    end

% end classdef
end 
