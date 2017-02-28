classdef IrNodeParameter < IrNodeNumerical
% IRNODEPARAMETER represents a parameter in Verilog-A
% This class is a container for an MsParameter object.
% See also MSPARAMETER.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties
        parmObj = {};
    end

    methods
        function obj = IrNodeParameter(uniqIdGen, parmObj)
            obj = obj@IrNodeNumerical(uniqIdGen);
            if nargin > 1
                obj.parmObj = parmObj;
            end
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

        function [headNode, traverseSub] = generateDerivative(thisNode, derObj)
            traverseSub = false;
            headNode = IrNodeNumericalNull(thisNode.uniqIdGen);
        end

    % end methods
    end

end
