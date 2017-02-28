classdef IrVisitor < handle
% IRVISITOR abstract class implementing the visitor pattern for IR trees.
% For details about the use of the visitor patterns please see the AstVisitor
% class.
% See also ASTVISITOR

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Wed Jan 04, 2017  03:30PM
%==============================================================================

    properties (Access = protected)
        uniqIdGen = {};
    end

    methods

        function setUniqIdGen(thisVisitor, uniqIdGen)
        % SETUNIQIDGEN
            thisVisitor.uniqIdGen = uniqIdGen;
        end

        function traverseIr(thisVisitor, irNode)
            % by default we don't use the varargin. Let the individual classes
            % use it if they need it.

            % traverse the tree recursively and visit every node
            traverseSub = thisVisitor.visit(irNode);

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

        function out = visit(thisVisitor, irNode, varargin)
        % VISITASTNODE
            nodeType = irNode.getType();
            switch nodeType
                case 'IrNodeModule'
                    out = thisVisitor.visitIrNodeModule(irNode, varargin{:});
                case 'IrNodeAssignment'
                    out = thisVisitor.visitIrNodeAssignment(irNode, varargin{:});
                case 'IrNodeBlock'
                    out = thisVisitor.visitIrNodeBlock(irNode, varargin{:});
                case 'IrNodeContribution'
                    out = thisVisitor.visitIrNodeContribution(irNode, varargin{:});
                case 'IrNodeIfElse'
                    out = thisVisitor.visitIrNodeIfElse(irNode, varargin{:});
                case 'IrNodeInputOutput'
                    out = thisVisitor.visitIrNodeInputOutput(irNode, varargin{:});
                case 'IrNode'
                    out = thisVisitor.visitIrNode(irNode, varargin{:});
                case 'IrNodeOperation'
                    out = thisVisitor.visitIrNodeOperation(irNode, varargin{:});
                case 'IrNodeParameter'
                    out = thisVisitor.visitIrNodeParameter(irNode, varargin{:});
                case 'IrNodeVariable'
                    out = thisVisitor.visitIrNodeVariable(irNode, varargin{:});
                case 'IrNodeConstant'
                    out = thisVisitor.visitIrNodeConstant(irNode, varargin{:});
                case 'IrNodeAnalog'
                    out = thisVisitor.visitIrNodeAnalog(irNode, varargin{:});
                case 'IrNodeFunction'
                    out = thisVisitor.visitIrNodeFunction(irNode, varargin{:});
                case 'IrNodeSimulatorFunction'
                    out = thisVisitor.visitIrNodeSimulatorFunction(irNode, varargin{:});
                case 'IrNodeSimulatorStatement'
                    out = thisVisitor.visitIrNodeSimulatorStatement(irNode, varargin{:});
                case 'IrNodeAnalogFunction'
                    out = thisVisitor.visitIrNodeAnalogFunction(irNode, varargin{:});
                case 'IrNodeCase'
                    out = thisVisitor.visitIrNodeCase(irNode, varargin{:});
                case 'IrNodeCaseItem'
                    out = thisVisitor.visitIrNodeCaseItem(irNode, varargin{:});
                case 'IrNodeCaseCandidates'
                    out = thisVisitor.visitIrNodeCaseCandidates(irNode, varargin{:});
                case 'IrNodeWhile'
                    out = thisVisitor.visitIrNodeWhile(irNode, varargin{:});
                case 'IrNodeFor'
                    out = thisVisitor.visitIrNodeFor(irNode, varargin{:});
                case 'IrNodeNumerical'
                    out = thisVisitor.visitIrNodeNumerical(irNode, varargin{:});
                case 'IrNodeDerivativeBlock'
                    out = thisVisitor.visitIrNodeDerivativeBlock(irNode, varargin{:});
                case 'IrNodeDerivativeContribution'
                    out = thisVisitor.visitIrNodeDerivativeContribution(irNode, varargin{:});
                case 'IrNodeNumericalNull'
                    out = thisVisitor.visitIrNodeNumericalNull(irNode, varargin{:});
                case 'IrNodePotentialFlow'
                    out = thisVisitor.visitIrNodePotentialFlow(irNode, varargin{:});
                case 'IrNodeOutput'
                    out = thisVisitor.visitIrNodeOutput(irNode, varargin{:});
                case 'IrNodeJacobian'
                    out = thisVisitor.visitIrNodeJacobian(irNode, varargin{:});
                case 'IrNodeModel'
                    irNode.computeCoreModel();
                    out = thisVisitor.visitIrNodeModel(irNode, varargin{:});
                case 'IrNodeCollapseBranch'
                    out = thisVisitor.visitIrNodeCollapseBranch(irNode, varargin{:});
                otherwise
                    error('IR nodes of type "%s" are not known to me!', ...
                                                                    nodeType);
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
