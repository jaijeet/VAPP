classdef IrVisitorNodeCollapse < IrVisitor
% IRVISITORNODECOLLAPSE discovers node collapse statements and constructs a
% decision tree for collapsing nodes
%

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Tue Feb 21, 2017  12:15PM
%==============================================================================
    properties (Access = private)
        ifElseTree = IrNode.empty;
        ifElseTreeVec = IrNode.empty; % this is a vector IrNodeIfElse objects
        nestedIfElseTree = IrNode.empty;
        nestedIfElseTreeVec = IrNode.empty;
    end

    methods

        function obj = IrVisitorNodeCollapse(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end

        function traverseSub = visitGeneric(thisVisitor, irNode)
            traverseSub = true;
        end

        function endTraversal(thisVisitor, module)
            module.setNodeCollapseTree(thisVisitor.getNestedIfElseTree);
        end


        function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
        % VISITIRNODEIFELSE mark if-else nodes -> to be used later in node
        % collapse operations.
            traverseSub = false;
            nChild = ifElseNode.getNChild();

            % nChild is at least 2.
            % if nChild == 2 => no else statement
            % if nChild == 3 => else statement

            condNode = ifElseNode.getChild(1);

            condDigger = IrVisitorRhsDigger(condNode);
            condParmVec = condDigger.getParmVec();
            condVarVec = condDigger.getVarVec();

            %pfVec = condDigger.getPfVec();
            %if isempty(pfVec) == false
            %    errorStr = sprintf(['Error in node collapse condition: the',...
            %                        ' condition %s dependens on a bias',...
            %                        ' dependent quantity.\n'], condNode.sprintAll());
            %    errorStr = sprintf([errorStr, 'Dependencies:\n']);
            %    for pfObj = pfVec
            %        errorStr = sprintf([errorStr, pfObj.getLabel(), '\n']);
            %    end
            %    error(errorStr);
            %end


            thenNode = ifElseNode.getChild(2);

            childVisitorThen = IrVisitorNodeCollapse(thenNode);
            thenTreeVec = childVisitorThen.getIfElseTreeVec();
            nestedThenTree = childVisitorThen.getNestedIfElseTree();

            if nChild == 3
                elseNode = ifElseNode.getChild(3);
                childVisitorElse = IrVisitorNodeCollapse(elseNode);
                elseTreeVec = childVisitorElse.getIfElseTreeVec();
                nestedElseTree = childVisitorElse.getNestedIfElseTree();
            else
                elseTreeVec = IrNode.empty;
                nestedElseTree = IrNode.empty;
            end

            condNode = condNode.copyDeep();
            if isempty(thenTreeVec) == true && isempty(elseTreeVec) == false
                condNode = IrNodeNumerical.getNegationOfNode(condNode);
                thenTreeVec = elseTreeVec;
                elseTreeVec = IrNode.empty;
                nestedThenTree = nestedElseTree;
                nestedElseTree = IrNode.empty;
            end

            % at this point there is no chance of the then block being empty
            % while the else block is not.
            ifElseTree = IrNode.empty;
            nestedIfElseTree = IrNode.empty;
            if isempty(thenTreeVec) == false
                for varObj = condVarVec
                    varObj.setInNodeCollapse();
                end

                for parmObj = condParmVec
                    parmObj.setInNodeCollapse();
                end

                ifElseTree = IrNodeIfElse();
                nestedIfElseTree = IrNodeIfElse();

                ifElseTree.addChild(condNode.copyDeep());
                thenBlock = IrNodeBlock();
                thenBlock.setIndentLevel(0);
                ifElseTree.addChild(thenBlock);
                for thenTree = thenTreeVec
                    thenBlock.addChild(thenTree.copyDeep());
                end

                nestedIfElseTree.addChild(condNode.copyDeep());
                nestedIfElseTree.addChild(nestedThenTree);

                if isempty(elseTreeVec) == false
                    elseBlock = IrNodeBlock();
                    elseBlock.setIndentLevel(0);
                    ifElseTree.addChild(elseBlock);
                    for elseTree = elseTreeVec
                        elseBlock.addChild(elseTree.copyDeep());
                    end

                    nestedIfElseTree.addChild(nestedElseTree);
                end
            end

            thisVisitor.ifElseTreeVec = [thisVisitor.ifElseTreeVec, ifElseTree];
            thisVisitor.nestedIfElseTreeVec = ...
                            [thisVisitor.nestedIfElseTreeVec, nestedIfElseTree];
            thisVisitor.ifElseTree = IrNode.empty;
        end

        function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
            traverseSub = false;

            lhsNode = contribNode.getLhsNode();
            lhsPfObj = lhsNode.getPfObj();
            rhsNode = contribNode.getRhsNode();

            % check if we are in a node collapse statement
            if lhsNode.isPotential() == true && ...
                    rhsNode.hasType('IrNodeConstant') && ...
                                        (rhsNode.getValue() == 0)
                if isempty(thisVisitor.ifElseTree) == true
                    treeBlock = IrNodeBlock();
                    treeBlock.setIndentLevel(0);
                    thisVisitor.ifElseTree = treeBlock;
                end
                cbNode = IrNodeCollapseBranch(lhsPfObj.getBranch());
                thisVisitor.ifElseTree.addChild(cbNode);
            end
        end

        function ietVec = getIfElseTreeVec(thisVisitor)
        % GETIFELSETREE
            ietVec = [thisVisitor.ifElseTreeVec, thisVisitor.ifElseTree];
        end

        function nestIfElseTreeVec(thisVisitor)
        % NESTIFELSETREES
            nestedIfElseTreeVec = [thisVisitor.nestedIfElseTreeVec, ...
                                                        thisVisitor.ifElseTree];

            nTree = numel(nestedIfElseTreeVec);

            if nTree > 0
                %innerTree = IrNodeBlock();
                %innerTree.setIndentLevel(0);
                %innerTree.addChild(nestedIfElseTreeVec(nTree).copyDeep());
                innerTree = IrNode.empty;
                for i = nTree:-1:1
                    outerTree = nestedIfElseTreeVec(i).copyDeep();
                    IrVisitorNestIfElseTree(outerTree, innerTree);

                    innerTree = outerTree;
                end

                thisVisitor.nestedIfElseTree = innerTree;
            end
        end

        function nestedTree = getNestedIfElseTree(thisVisitor)
        % GETNESTEDTREEVEC
            if isempty(thisVisitor.nestedIfElseTree)
                thisVisitor.nestIfElseTreeVec();
            end
            nestedTree = thisVisitor.nestedIfElseTree;
        end
    % end methods
    end

% end classdef
end
