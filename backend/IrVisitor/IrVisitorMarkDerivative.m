classdef IrVisitorMarkDerivative < IrVisitor
% IRVISITORMARKDERIVATIVE runs IrVisitorMark001 on derivatives

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties
        derivOrder = 0;
    end

    methods

        function obj = IrVisitorMarkDerivative(derivOrder, irNode)
        % IRVISITORMARKDERIVATIVE
            obj = obj@IrVisitor();
            obj.derivOrder = derivOrder;
            if nargin > 1
                obj.traverseIr(irNode);
            end
        end

        function traverseSub = visitGeneric(thisVisitor, irNode)
        % VISITGENERIC
            traverseSub = true;
            % do nothing here
        end

        function traverseSub = visitIrNodeDerivativeBlock(thisVisitor, dbNode)
        % IRNODEDERIVATIVEBLOCK
            traverseSub = false;
            if thisVisitor.derivOrder == 1
                mark1Vis = IrVisitorMark001();
                mark1Vis.traverseChildren(dbNode);
            else
                derivVis = IrVisitorMarkDerivative(thisVisitor.deriVOrder-1);
                derivVis.traverseChildren(dbNode);
            end
        end
        
    % end methods
    end
    
% end classdef
end
