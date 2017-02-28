classdef IrNodeCollapseBranch < IrNode
% IRNODECOLLAPSEBRANCH

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Thu Feb 16, 2017  05:17PM
%==============================================================================
    properties
        branch = {}; %MsBranch.empty;
    end

    methods

        function obj = IrNodeCollapseBranch(uniqIdGen, branchObj)
        % IRNODECOLLAPSEBRANCH
            obj = obj@IrNode(uniqIdGen);
            if nargin > 1
                obj.branch = branchObj;
            end
        end

        function branchObj = getBranch(thisNode)
        % GETBRANCH
            branchObj = thisNode.branch;
        end

        function [outStr, printSub] = sprintFront(thisNode)
        % SPRINTALL
            printSub = false;
            outStr = sprintf('//Collapse branch: %s\n', thisNode.branch.getLabel());
        end
        
    % end methods
    end
    
% end classdef
end

