classdef IrNodeParameter < IrNodeNumerical
% IRNODEPARAMETER represents a parameter in Verilog-A
% This class is a container for an MsParameter object.
% See also MSPARAMETER.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties (Access = private)
        parmObj = MsParameter.empty;
    end

    methods
        function obj = IrNodeParameter(parmObj)
            obj = obj@IrNodeNumerical();
            obj.parmObj = parmObj;
            obj.additive = 1;
            obj.multiplicative = 1;
        end

        function parmObj = getParmObj(thisNode)
        % GETPARMOBJ
            parmObj = thisNode.parmObj;
        end

        function parmName = getName(thisParameter)
            parmName = thisParameter.parmObj.getName();
        end

        function outStr = sprintNumerical(thisNode, ~)
            outStr = thisNode.getName();
        end
    end

    methods (Access = protected)

        function [headNode, traverseSub] = generateDerivative(thisNode, derObj)
            traverseSub = false;
            headNode = IrNodeNumericalNull();
        end

    end

end
