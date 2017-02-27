classdef IrVisitorNestIfElseTree < IrVisitor
% IRVISITORNESTIFELSETREE is used by IrVisitorNodeCollapse to construct a
% nested if/else tree (i.e., a decision tree)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Thu Feb 16, 2017  05:18PM
%==============================================================================
    properties (Access = private)
        nestedTree = IrNode.empty;
        subTree = IrNode.empty;
        foundNestedIfElse = false;
    end

    methods

        function obj = IrVisitorNestIfElseTree(irTree, subTree)
            if nargin > 1
                obj.subTree = subTree;
                % the subtree might not have an else node, if so, append a
                % block to it (notice an if-else tree must have at least 2
                % children).
                if isempty(subTree) == false && subTree.getNChild() < 3
                    subTreeCp = subTree.copyDeep();
                    subTreeCp.addChild(IrNodeBlock(0));
                    obj.subTree = subTreeCp;
                end

            end

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
            subTree = thisVisitor.subTree;
            thisVisitor.foundNestedIfElse = true;

            % ifElseNode has at least two nodes
            condNode = ifElseNode.getChild(1);
            thenNode = ifElseNode.getChild(2);
            
            thenVisitor = IrVisitorNestIfElseTree(thenNode, subTree);

            if thenVisitor.foundNestedIfElse == false
                if isempty(subTree) == false
                    thenNode.addChild(subTree.copyDeep());
                end
            end

            if ifElseNode.getNChild() > 2
                elseNode = ifElseNode.getChild(3);
                elseVisitor = IrVisitorNestIfElseTree(elseNode, subTree);

                if elseVisitor.foundNestedIfElse == false
                    if isempty(subTree) == false
                        elseNode.addChild(subTree.copyDeep());
                    end
                end
            else
                elseNode = IrNodeBlock(0);
                ifElseNode.addChild(elseNode);
                if isempty(subTree) == false
                    elseNode.addChild(subTree.copyDeep());
                end
            end
        end
        
    % end methods
    end
    
% end classdef
end
