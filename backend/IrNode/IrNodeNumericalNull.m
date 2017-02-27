classdef IrNodeNumericalNull < IrNodeNumerical
% IRNODENUMERICALNULL empty IrNodeNumerical class
% This class is used whenever we need to fill up a child of a node with an
% empty object

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods
        function outStr = sprintNumerical(thisNode, sprintAllFuncHandle)
            outStr = '';
        end

        function out = isNull(thisNode)
            out = true;
        end
        
    % end methods
    end

    methods (Access = protected)
        function [headNode, generateSub] = generateDerivative(thisNode, derObj)
            generateSub = false;
            headNode = IrNodeNumericalNull();
        end
    end

    methods (Static)
        function label = getLabel()
            label = '';
        % GETLABEL
        end

        function fLabel = getFLabel()
            fLabel = '';
        % GETLABEL
        end

        function qLabel = getQLabel()
            qLabel = '';
        % GETLABEL
        end

    end
    
% end classdef
end
