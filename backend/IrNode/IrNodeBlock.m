classdef IrNodeBlock < IrNode
% IRNODEBLOCK represents a Verilog-A block

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods
        function obj = IrNodeBlock(indentLevel)
            obj = obj@IrNode();
            if nargin > 0
                obj.setIndentLevel(indentLevel);
            end
        end
    end

% end classdef
end
