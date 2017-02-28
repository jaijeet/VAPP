classdef IrNodeCaseCandidates < IrNode
% IRNODECASECANDIDATE represents Verilog-A candidates to a case statement

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties
        default = false;
    end

    methods

        function obj = IrNodeCaseCandidates(uniqIdGen)
        % IRNODECASECANDIDATES
            obj = obj@IrNode(uniqIdGen);
        end

        function setDefault(thisNode)
            thisNode.default = true;
        end

        function out = isDefault(thisNode)
            out = thisNode.default;
        end

        function [outStr, traverseSub] = sprintFront(thisNode)
            traverseSub = false;
            nChild = thisNode.getNChild(); 
            outStr = '';
            if nChild > 1
                outStr = '{';
            end

            for i=1:nChild
                childStr = thisNode.getChild(i).sprintAll();
                outStr = [outStr, childStr];
                if i ~= nChild
                    outStr = [outStr, ', '];
                end
            end

            if nChild > 1
                outStr = [outStr, '}'];
            end
        end
    % end methods
    end
    
% end classdef
end
