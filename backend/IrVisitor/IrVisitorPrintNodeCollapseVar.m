classdef IrVisitorPrintNodeCollapseVar < IrVisitor
% IRVISITORPRINTNODECOLLAPSEVAR prints variables and parameters that are
% required to evaluate the node collapse if/else tree

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Thu Feb 16, 2017  05:18PM
%==============================================================================

    properties (Access = private)
        ncStr = '';
    end

    methods
        
        function obj = IrVisitorPrintNodeCollapseVar(irTree)
            if nargin > 0
                obj.traverseIr(irTree);
            end
        end

        function traverseSub = visitGeneric(thisVisitor, irNode)
            traverseSub = true;
        end

        function traverseSub = visitIrNodeAssignment(thisVisitor, assignNode)
        % VISITIRNODEASSIGNMENT
            traverseSub = false;
            lhsNode = assignNode.getLhsNode();
            lhsVarObj = lhsNode.getVarObj();
            if lhsVarObj.isInNodeCollapse() == true
                thisVisitor.ncStr = [thisVisitor.ncStr, assignNode.sprintAll()];
            end
        end

        function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
        % VISITIRNODEIFELSE
            traverseSub = false;
            condNode = ifElseNode.getChild(1);

            thenNode = ifElseNode.getChild(2);
            thenVisitor = IrVisitorPrintNodeCollapseVar(thenNode);
            thenStr = thenVisitor.getNcStr();

            elseStr = '';
            if ifElseNode.getNChild() > 2
                elseNode = ifElseNode.getChild(3);
                elseVisitor = IrVisitorPrintNodeCollapseVar(elseNode);
                elseStr = elseVisitor.getNcStr();
            end

            % switch thenStr with elseStr if thenStr isempty (and thenStr is
            % not).
            if isempty(thenStr) == true && isempty(elseStr) == false
                condNode = IrNodeNumerical.getNegationOfNode(condNode.copyDeep());
                thenStr = elseStr;
                elseStr = '';
            end

            % at this point if thenStr is empty, we don't print the if else
            % statement.
            ncStr = '';
            if isempty(thenStr) == false
                ncStr = ['if ', condNode.sprintAll(), '\n'];
                ncStr = [ncStr, ...
                         ifElseNode.sprintfIndent(thenStr)];
                if isempty(elseStr) == false
                    ncStr = [ncStr, 'else\n'];
                    ncStr = [ncStr, ...
                            ifElseNode.sprintfIndent(elseStr)];
                end
                ncStr = [ncStr, 'end\n'];
            end
            thisVisitor.ncStr = [thisVisitor.ncStr, ncStr];
        end

        function outStr = getNcStr(thisVisitor)
        % GETOUTSTR
            outStr = sprintf(thisVisitor.ncStr);
        end

    % end methods
    end
    
% end classdef
end 
