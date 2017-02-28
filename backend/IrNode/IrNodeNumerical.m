classdef IrNodeNumerical < IrNode
% IRNODENUMERICAL abstract class for IrNodes that are encountered in
% assignments and contributions. These are nodes such as operations, functions,
% constants, variables, etc. Main functionality added by IrNodeNumerical is the
% functionality given by the sprintAllDdt method. This method prints only the
% ddt part of a numerical statement. The usual method (sprintAll), on the other
% hand, does NOT print the ddt part.
%
% Classes that implement IrNodeNumerical must define the sprintAllNumerical
% method and they inherit the sprintAllDdt method.
% sprintAllDdt prints a numeric object depending on its ddtTopNode and
% onDdtPath properties.
%
% A ddtTopNode is a node which has a multiplicative path to a ddt function or
% the ddt function itself.
%
%   3*(I(p,s) + 2*ddt(I(p,n))) -> 2 is ddtTopNode
%
% A node is onDdtPath if it has a multiplicative and/or additive connection to
% a ddtTopNode.
%
%   3*(I(p,s) + 2*ddt(I(p,n))) -> '+' and 3 are onDdtPath, I(p,s) is not.
%
% the ddt part of the above contribution will be printed as
%
%   3*(+2*ipn)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Jan 03, 2017  12:22PM
%==============================================================================
    properties
        additive = 0; % 1 when an IO appears without being multiplied by anything.
        % -1 when IO is inverseIo.
        % this is used by IrVisitorMark1 to determine if a contribution is a
        % nullEqn.
        multiplicative = false; % do we have a multiplicative path to the ddtTopNode?
        affine = false; % is the node +,-,* or /?
        ddtTopNode = false; % an operation or a function can be a ddtTopNode
        % ddtTopNode property is currently set by IrVisitorMark1
        onDdtPath = false; % do we print this node when we are printing the ddt
                           % part?
        VARSFX = '__';
    end

    methods
        function obj = IrNodeNumerical(uniqIdGen)
            obj = obj@IrNode(uniqIdGen);
        end

        function addChild(thisNode, childNode)
            addChild@IrNode(thisNode, childNode);
            childNode.setAdditive(thisNode.additive);
        end

        function setAdditive(thisNode, inVal)
            thisNode.additive = thisNode.additive*inVal;
        end

        function out = isAdditive(thisNode)
            out = thisNode.additive;
        end

        function out = isMultiplicative(thisNode)
            out = thisNode.multiplicative;
        end

        function out = isAffine(thisNode)
            out = thisNode.affine;
        end

        function setDdtTopNode(thisNode)
            thisNode.ddtTopNode = true;
        end

        function out = isDdtTopNode(thisNode)
            out = thisNode.ddtTopNode;
        end

        function setOnDdtPath(thisNode)
            thisNode.onDdtPath = true;
        end

        function out = isOnDdtPath(thisNode)
            out = thisNode.onDdtPath;
        end

        function headNode = generateDerivativeTree(thisNode, derObj)
            [headNode, generateSub] = thisNode.generateDerivative(derObj);

            if generateSub == true
                for childNode = thisNode.childVecC
                    childTree = childNode{:}.generateDerivativeTree(derObj);
                    headNode.addChild(childTree);
                end
            end
        end

        function out = isDependentOnDerivObj(thisNode, derivObj)
            out = false;
            for childNode = thisNode.childVecC
                out = childNode{:}.isDependentOnDerivObj(derivObj);
                if out == true
                    break;
                end
            end
        end

        function [outStr, printSub] = sprintAll(thisNode)
            % if this node is a ddtTopNode don't print anything and stop
            % printing the children as well.
            if thisNode.ddtTopNode == true
                outStr = '';
            else
                % if not call the sprintNumerical method of this object
                outStr = thisNode.sprintNumerical(0);
                % the @sprintAll argument above tells the object that it should
                % call the sprintAll method of its children.
                % Octave modification: (replace the @sprintAll function handle
                % with a flag) 0 means call the sprintAll method of child
                % nodes, 1 means call the sprintAllDdt method of the child
                % nodes.
            end
            printSub = false;
        end

        function outStr = sprintAllDdt(thisNode)
            if thisNode.ddtTopNode == true
                % if this a ddtTopNode, every child of this node belongs to a
                % ddt contribution. HENCE, CALL THE SPRINTNUMERICAL METHOD
                % ALONG WITH ITS CHILDREN'S SPRINTALL METHODS
                % Octave modification: (replace the @sprintAll function handle
                % with a flag) 0 means call the sprintAll method of child
                % nodes, 1 means call the sprintAllDdt method of the child
                % nodes.
                outStr = thisNode.sprintNumerical(0);
            elseif thisNode.onDdtPath == true
                % if this node is not a ddtTopNode but it's on the ddtPath,
                % call this objects sprintAllNumerical method BUT TELL IT TO
                % CALL ITS CHILDREN'S SPRINTALLDDT METHODS
                outStr = thisNode.sprintNumerical(1);
            else
                % if not a ddtTopNode or onDdtPath this node does not get
                % printed in the ddt contribution. Hence don't print anything
                % and directly call its children's sprintAllDdt methods.
                % Note that a child of this node can still be onDdtPath or even
                % ddtTopNode.
                outStr = '';
                for i=1:thisNode.nChild
                    outStr = [outStr, thisNode.childVecC{i}.sprintAllDdt()];
                end
            end
        end

        function fTree = copyFSubTree(thisNode)
            if thisNode.ddtTopNode == true
                fTree = IrNodeNumericalNull(thisNode.uniqIdGen);
            else
                fTree = thisNode.copyBare();
                for childNode = thisNode.childVecC
                    childTree = childNode{:}.copyFSubTree();
                    fTree.addChild(childTree);
                end
            end
        end

        function qTree = copyQSubTree(thisNode)
            if thisNode.ddtTopNode == true
                qTree = thisNode.copyBare();
                qTree.ddtTopNode = false;
                for childNode = thisNode.childVecC
                    childTree = childNode{:}.copyFSubTree();
                    qTree.addChild(childTree);
                end
            elseif thisNode.onDdtPath == true
                qTree = thisNode.copyBare();
                for childNode = thisNode.childVecC
                    childTree = childNode{:}.copyQSubTree();
                    qTree.addChild(childTree);
                end
            else
                qTree = IrNodeNumericalNull(thisNode.uniqIdGen);
            end
        end

        function out = isNull(thisNode)

            % IrNodeNumericalNull overrides this function and returns true
            % There are no other uses of this function
            out = false;
        end


    % end methods
    end

    methods (Static)

        function joinNode = joinNodesWithOperation(uniqIdGen, opStr, varargin)
            nChild = nargin - 2;
            joinNode = IrNodeOperation(uniqIdGen, opStr);
            for i = 1:nChild
                joinNode.addChild(varargin{i});
            end
        end

        function uMinusNode = getNegativeOfNode(uniqIdGen, irNode)
        % GETNEGATIVEOFNODE
            if isa(irNode, 'IrNodeNumerical') == false
                error(['This node cannot be used in the getNegativeOfNode ',...
                    'function because it is not of class IrNodeNumerical!']);
            end

            uMinusNode = IrNodeOperation(uniqIdGen, 'u-');
            uMinusNode.addChild(irNode);
        end

        function minusNode = getDifferenceOfNodes(uniqIdGen, irNode1, irNode2)
        % GETNEGATIVEOFNODE
            minusNode = IrNodeNumerical.joinNodesWithOperation(uniqIdGen, ...
                                                               '-', ...
                                                               irNode1, ...
                                                               irNode2);
        end

        function prodNode = getProductOfNodes(uniqIdGen, irNode1, irNode2)
            prodNode = IrNodeNumerical.joinNodesWithOperation(uniqIdGen, ...
                                                              '*', ...
                                                              irNode1,...
                                                              irNode2);
        end

        function summNode = getSummOfNodes(uniqIdGen, irNode1, irNode2)
            summNode = IrNodeNumerical.joinNodesWithOperation(uniqIdGen, ...
                                                              '+', ...
                                                              irNode1,...
                                                              irNode2);
        end

        function divNode = getDivisionOfNodes(uniqIdGen, irNode1, irNode2)
            divNode = IrNodeNumerical.joinNodesWithOperation(uniqIdGen, ...
                                                             '/', ...
                                                             irNode1,...
                                                             irNode2);
        end

        function expNode = getExponentiationOfNodes(uniqIdGen, irNode1, irNode2)
            expNode = IrNodeNumerical.joinNodesWithOperation(uniqIdGen, ...
                                                             '**', ...
                                                             irNode1,...
                                                             irNode2);
        end

        function qmcolNode = getQuestionMarkColumnOfNodes(uniqIdGen, condNode, ...
                                                             thenNode, elseNode)
        % GETQUESTIONMARKCOLUMNOFNODES
            qmcolNode = IrNodeNumerical.joinNodesWithOperation(uniqIdGen, ...
                                                               '?:', ...
                                                               condNode, ...
                                                               thenNode, ...
                                                               elseNode);
        end

        function sqrNode = getSquareOfNode(uniqIdGen, irNode)
            twoNode = IrNodeConstant(uniqIdGen, 'real', 2);
            sqrNode = IrNodeNumerical.getExponentiationOfNodes(uniqIdGen, irNode, twoNode);
        end

        function summNode = getNodePlusOne(uniqIdGen, irNode)
            oneNode = IrNodeConstant(uniqIdGen, 'real', 1);
            summNode = IrNodeNumerical.getSummOfNodes(uniqIdGen, irNode, oneNode);
        end

        function minusNode = getNodeMinusOne(uniqIdGen, irNode)
            oneNode = IrNodeConstant(uniqIdGen, 'real', 1);
            minusNode = IrNodeNumerical.getDifferenceOfNodes(uniqIdGen, irNode, oneNode);
        end

        function minusNode = getOneMinusNode(uniqIdGen, irNode)
            oneNode = IrNodeConstant(uniqIdGen, 'real', 1);
            minusNode = IrNodeNumerical.getDifferenceOfNodes(uniqIdGen, oneNode, irNode);
        end

        function divNode = getOneOverNode(uniqIdGen, irNode)
            oneNode = IrNodeConstant(uniqIdGen, 'real', 1);
            divNode = IrNodeNumerical.getDivisionOfNodes(uniqIdGen, oneNode, irNode);
        end

        function sqrtNode = getSqrtOfNode(uniqIdGen, irNode)
            sqrtNode = IrNodeFunction(uniqIdGen, 'sqrt');
            sqrtNode.addChild(irNode);
        end

        function funcNode = getFunctionOfNode(uniqIdGen, irNode, funcStr)
            funcNode = IrNodeFunction(uniqIdGen, funcStr);
            funcNode.addChild(irNode);
        end

        function negNode = getNegationOfNode(uniqIdGen, irNode)
        % GETNEGATIONOFNODE
            negNode = IrNodeOperation(uniqIdGen, '!');
            negNode.addChild(irNode);
        end

        function constNode = getConstantNode(uniqIdGen, const)
            constNode = IrNodeConstant(uniqIdGen, 'real', const);
        end

        function linCombNode = getLinearCombination(uniqIdGen, rhsNodeVecC, signVec)

            nRhsNode = numel(rhsNodeVecC);
            if numel(signVec) ~= nRhsNode
                error('Number of rhs nodes and number of signs do not match!');
            end

            if signVec(1) == 1
                linCombNode = rhsNodeVecC{1};
            else
                linCombNode = IrNodeNumerical.getNegativeOfNode(uniqIdGen, rhsNodeVecC{1});
            end

            for i = 2:nRhsNode
                if signVec(i) == 1
                    linCombNode = IrNodeNumerical.getSummOfNodes(uniqIdGen, linCombNode, ...
                                                                 rhsNodeVecC{i});
                else
                    linCombNode = IrNodeNumerical.getDifferenceOfNodes(uniqIdGen, linCombNode,...
                                                                       rhsNodeVecC{i});
                end
            end

        end

    end

% end classdef
end
