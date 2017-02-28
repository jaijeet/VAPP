classdef IrNodeAnalog < IrNode
% IRNODEANALOG represents a Verilog-A analog block

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods
        function obj = IrNodeAnalog(uniqIdGen)
            obj = obj@IrNode(uniqIdGen);
        end
    end
end
