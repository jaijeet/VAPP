classdef IrNodeCase < IrNode
% IRNODECASE represents a Verilog-A case statement

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

% FIXME: the frontend does not handle case statements in a function correctly
    methods

        function obj = IrNodeCase(uniqIdGen)
        % IRNODECASE
            obj = obj@IrNode(uniqIdGen);
        end

        function [outStr, traverseSub] = sprintFront(thisNode)
        % SPRINTFRONT
            traverseSub = false;
            nChild = thisNode.getNChild();
            caseArgument = thisNode.getChild(1);
            outStr = ['switch ', caseArgument.sprintAll(), '\n'];

            for i=2:nChild
                childStr = thisNode.getChild(i).sprintAll();
                outStr = [outStr, thisNode.sprintfIndent(childStr)];
            end

            outStr = [outStr, 'end\n'];
        end
        
    % end methods
    end
    
% end classdef
end
