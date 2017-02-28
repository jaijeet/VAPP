classdef IrVisitorExplore < IrVisitor
% IRVISITOREXPLORE print the IR tree

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods

        function obj = IrVisitorExplore(rootNode)
            obj = obj@IrVisitor();
            if nargin>0
                obj.traverseIr(rootNode, 0);
            end
        end

        function traverseIr(thisVisitor, irNode, indentLevel)

            % traverse the tree recursively and visit every node
            
            nChild = irNode.getNChild();

            out = thisVisitor.visit(irNode, indentLevel);

            if iscell(out)
                traverseSub = out{1};
            else
                traverseSub = out;
            end

            if traverseSub == true
                indentLevel = indentLevel+1;
                for i=1:nChild
                    thisVisitor.traverseIr(irNode.getChild(i), indentLevel);
                end
            end

            if irNode.isModule() == true
                thisVisitor.endTraversal(irNode);
            end
        end

        function out = visitGeneric(thisVisitor, irNode, indentLevel)
            out =  true;
            thisVisitor.printIndent(class(irNode), indentLevel);
        end

        function out = visitIrNodeInputOutput(thisVisitor, ioNode, indentLevel)
            out = true;
            outStr = sprintf('InputOutput: %s, dummy: %d',...
                                             ioNode.getIoObj.getLabel(),...
                                             ioNode.isDummy());
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodeOperation(thisVisitor, opNode, indentLevel)
            out = true;
            outStr= sprintf('Operation: %s, ddtTopNode: %d, onDdtPath = %d',...
                                                         opNode.getOpType(),...
                                                         opNode.isDdtTopNode(),...
                                                         opNode.isOnDdtPath());
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodeVariable(thisVisitor, varNode, indentLevel)
            out = true;
            outStr = sprintf('Variable: %s, connected=%d', varNode.getName(),...
                                                   varNode.isConnectedToModule);
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodeParameter(thisVisitor, parmNode, indentLevel)
            out = true;
            outStr = sprintf('Parameter: %s', parmNode.getName());
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodeConstant(thisVisitor, constNode, indentLevel)
            out = true;
            outStr = sprintf('Constant: type = %s, value = %g, onDdtPath = %d',...
                                                     constNode.getDataType(),...
                                                     constNode.getValue(),...
                                                     constNode.isOnDdtPath());
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodeFunction(thisVisitor, funcNode, indentLevel)
            out = true;
            outStr = sprintf('Function: %s, ddtTopNode: %d', ...
                                                        funcNode.getName(),...
                                                        funcNode.isDdtTopNode);
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodeAnalogFunction(thisVisitor, afNode, indentLevel)
            out = true;
            outStr = sprintf('AnalogFunction: %s, inList: %s, outList: %s',...
                                                        afNode.getName(),...
                                        cell2str_vapp(afNode.getInputList()),...
                                         cell2str_vapp(afNode.getOutputList()));
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodeContribution(thisVisitor, contribNode, indentLevel)
            out = true;
            outStr = sprintf('Contribution: eqn idx: %d, null: %d',...
                                                 contribNode.getEqnIdx(),...
                                                 contribNode.isNullEqn());
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodePotentialFlow(thisVisitor, pfNode, indentLevel)
            out = true;
            pfObj = pfNode.getPfObj;

            outStr = sprintf(['PotentialFlow: %s, pfObj: %s, inverse: %d, ',...
                              'probe: %d, contrib: %d'],...
                                                        pfObj.getLabel(),...
                                                        class(pfObj),...
                                                        pfNode.isInverse(),...
                                                        pfObj.isProbe(),...
                                                        pfObj.isContrib());
            thisVisitor.printIndent(outStr, indentLevel);
        end

        function out = visitIrNodeCollapseBranch(thisVisitor, cbNode, indentLevel)
            out = true;
            outStr = sprintf('CollapseBranch: %s', cbNode.getBranch().getLabel());
            thisVisitor.printIndent(outStr, indentLevel);
        end

    end

    methods (Static)
        function outStr = printIndent(inStr, indentLevel)
            indentStr = repmat('  ', 1, indentLevel);
            fprintf([indentStr, inStr, '\n']);
        end
    end
end
