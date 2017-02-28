classdef IrNodeBlock < IrNode
% IRNODEBLOCK represents a Verilog-A block

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Jan 03, 2017  11:11AM
%==============================================================================
    methods
        function obj = IrNodeBlock(uniqIdGen, indentLevel)
            obj = obj@IrNode(uniqIdGen);
            if nargin > 1
                obj.setIndentLevel(indentLevel);
            end
        end
    end

% end classdef
end
