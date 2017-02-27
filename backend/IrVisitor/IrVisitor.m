classdef IrVisitor < handle
% IRVISITOR abstract class implementing the visitor pattern for IR trees.
% For details about the use of the visitor patterns please see the AstVisitor
% class.
% See also ASTVISITOR

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods (Abstract)
        % use visitGeneric method to perform a default operation for every node
        % that has not a specific visit method in your Visitor class
        out = visitGeneric(thisVisitor, irNode, varargin);
    end

    methods

        function traverseIr(thisVisitor, irNode)
            % by default we don't use the varargin. Let the individual classes
            % use it if they need it.

            % traverse the tree recursively and visit every node
            traverseSub = irNode.acceptVisitor(thisVisitor);

            if traverseSub == true
                thisVisitor.traverseChildren(irNode);
            end

            if irNode.isModule() == true
                thisVisitor.endTraversal(irNode);
            end
        end

        function traverseChildren(thisVisitor, irNode)
            nChild = irNode.getNChild();
            for i=1:nChild
                thisVisitor.traverseIr(irNode.getChild(i));
            end
        end

        function out = visitIrNodeModule(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeAssignment(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeBlock(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeContribution(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeIfElse(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeInputOutput(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end
        
        function out = visitIrNode(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeOperation(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeParameter(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeVariable(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeConstant(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeAnalog(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeFunction(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeSimulatorFunction(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeSimulatorStatement(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeAnalogFunction(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeCase(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeCaseItem(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeCaseCandidates(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeWhile(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeFor(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeNumerical(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeDerivativeBlock(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeDerivativeContribution(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeNumericalNull(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodePotentialFlow(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeOutput(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeJacobian(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeCollapseBranch(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function out = visitIrNodeModel(thisVisitor, irNode, varargin)
            out = thisVisitor.visitGeneric(irNode, varargin{:});
        end

        function endTraversal(thisVisitor, module)
            % ENDTRAVERSAL gets called after all children of a root node are
            % traversed
            %
            % overload this method to wrap up a traversal.
        end
    end


% end classdef
end
