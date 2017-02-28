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
        ifElseTree = {}; %IrNode.empty;
        ifElseTreeVecC = {}; %IrNode.empty; % this is a vector IrNodeIfElse objects
        nestedIfElseTree = {}; %IrNode.empty;
        nestedIfElseTreeVecC = {}; %IrNode.empty;
    end

    methods

        function obj = IrVisitorNodeCollapse(irTree)
            if nargin > 0
                obj.uniqIdGen = irTree.getUniqIdGen();
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
            condParmVecC = condDigger.getParmVecC();
            condVarVecC = condDigger.getVarVecC();

            thenNode = ifElseNode.getChild(2);

            childVisitorThen = IrVisitorNodeCollapse(thenNode);
            thenTreeVecC = childVisitorThen.getIfElseTreeVecC();
            nestedThenTree = childVisitorThen.getNestedIfElseTree();

            if nChild == 3
                elseNode = ifElseNode.getChild(3);
                childVisitorElse = IrVisitorNodeCollapse(elseNode);
                elseTreeVecC = childVisitorElse.getIfElseTreeVecC();
                nestedElseTree = childVisitorElse.getNestedIfElseTree();
            else
                elseTreeVecC = {}; %IrNode.empty;
                nestedElseTree = {}; %IrNode.empty;
            end

            condNode = condNode.copyDeep();
            if isempty(thenTreeVecC) == true && isempty(elseTreeVecC) == false
                condNode = IrNodeNumerical.getNegationOfNode(thisVisitor.uniqIdGen, condNode);
                thenTreeVecC = elseTreeVecC;
                elseTreeVecC = {}; %IrNode.empty;
                nestedThenTree = nestedElseTree;
                nestedElseTree = {}; %IrNode.empty;
            end

            % at this point there is no chance of the then block being empty
            % while the else block is not.
            ifElseTree = {}; %IrNode.empty;
            nestedIfElseTree = {}; %IrNode.empty;
            if isempty(thenTreeVecC) == false
                for varObj = condVarVecC
                    varObj{:}.setInNodeCollapse();
                end

                for parmObj = condParmVecC
                    parmObj{:}.setInNodeCollapse();
                end

                ifElseTree = IrNodeIfElse(thisVisitor.uniqIdGen);
                nestedIfElseTree = IrNodeIfElse(thisVisitor.uniqIdGen);

                ifElseTree.addChild(condNode.copyDeep());
                thenBlock = IrNodeBlock(thisVisitor.uniqIdGen);
                thenBlock.setIndentLevel(0);
                ifElseTree.addChild(thenBlock);
                for thenTree = thenTreeVecC
                    thenBlock.addChild(thenTree{:}.copyDeep());
                end

                nestedIfElseTree.addChild(condNode.copyDeep());
                nestedIfElseTree.addChild(nestedThenTree);

                if isempty(elseTreeVecC) == false
                    elseBlock = IrNodeBlock(thisVisitor.uniqIdGen);
                    elseBlock.setIndentLevel(0);
                    ifElseTree.addChild(elseBlock);
                    for elseTree = elseTreeVecC
                        elseBlock.addChild(elseTree{:}.copyDeep());
                    end

                    nestedIfElseTree.addChild(nestedElseTree);
                end
            end

            if isempty(ifElseTree) == false
                thisVisitor.ifElseTreeVecC = [thisVisitor.ifElseTreeVecC, {ifElseTree}];
            end

            if isempty(nestedIfElseTree) == false
                thisVisitor.nestedIfElseTreeVecC = ...
                            [thisVisitor.nestedIfElseTreeVecC, {nestedIfElseTree}];
            end
            thisVisitor.ifElseTree = {}; %IrNode.empty;
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
                    treeBlock = IrNodeBlock(thisVisitor.uniqIdGen);
                    treeBlock.setIndentLevel(0);
                    thisVisitor.ifElseTree = treeBlock;
                end
                cbNode = IrNodeCollapseBranch(thisVisitor.uniqIdGen, lhsPfObj.getBranch());
                thisVisitor.ifElseTree.addChild(cbNode);
            end
        end

        function ietVecC = getIfElseTreeVecC(thisVisitor)
        % GETIFELSETREE
            if isempty(thisVisitor.ifElseTree) == false
                ietVecC = [thisVisitor.ifElseTreeVecC, {thisVisitor.ifElseTree}];
            else
                ietVecC = thisVisitor.ifElseTreeVecC;
            end
        end
        
        function nestIfElseTreeVecC(thisVisitor)
        % NESTIFELSETREES
            nestedIfElseTreeVecC = thisVisitor.nestedIfElseTreeVecC;
            if isempty(thisVisitor.ifElseTree) == false
                nestedIfElseTreeVecC = [nestedIfElseTreeVecC, ...
                                                        {thisVisitor.ifElseTree}];
            end

            nTree = numel(nestedIfElseTreeVecC);

            if nTree > 0
                %innerTree = IrNodeBlock();
                %innerTree.setIndentLevel(0);
                %innerTree.addChild(nestedIfElseTreeVecC(nTree).copyDeep());
                innerTree = {}; %IrNode.empty;
                for i = nTree:-1:1
                    outerTree = nestedIfElseTreeVecC{i}.copyDeep();
                    IrVisitorNestIfElseTree(outerTree, innerTree);

                    innerTree = outerTree;
                end

                thisVisitor.nestedIfElseTree = innerTree;
            end
        end

        function nestedTree = getNestedIfElseTree(thisVisitor)
        % GETNESTEDTREE
            if isempty(thisVisitor.nestedIfElseTree)
                thisVisitor.nestIfElseTreeVecC();
            end
            nestedTree = thisVisitor.nestedIfElseTree;
        end
    % end methods
    end

% end classdef
end
