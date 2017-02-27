classdef IrNodeFor < IrNode
% IRNODEFOR represents a for loop in Verilog-A

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods
        function [outStr, traverseSub] = sprintFront(thisNode)
        % SPRINTFRONT
            
            traverseSub = false;

            % this node has always 4 children

            assgnNode1 = thisNode.getChild(1);
            condNode = thisNode.getChild(2);
            assgnNode2 = thisNode.getChild(3);
            blockNode = thisNode.getChild(4);

            outStr = assgnNode1.sprintAll();
            outStr = [outStr, 'while ', condNode.sprintAll(), '\n'];
            blockStr = blockNode.sprintAll();
            outStr = [outStr, thisNode.sprintfIndent(blockStr)];
            assgnStr2 = assgnNode2.sprintAll();
            outStr = [outStr, thisNode.sprintfIndent(assgnStr2)];
            outStr = [outStr, 'end\n'];
        end
    % end methods
    end
    
% end classdef
end
