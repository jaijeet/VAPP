function errorAtIrNode(errMsg, irNode)
% VAPP_ERROR displays error message and the file name/line number of the
% AstNode

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu
% Last modified: Wed Feb 22, 2017  08:01PM
%==============================================================================


    posStr = '';
    if nargin > 1
        pos = irNode.getPosition();
        pos = pos{:};
        lineNum = pos.lineno;
        colNum = pos.linepos;
        fileName = pos.infile_path;

        posStr= sprintf(['file: %s\n',...
                    'line number: %d -- %d\n',...
                    'column number: %d -- %d\n'],...
                                                fileName,...
                                                lineNum(1), lineNum(2),...
                                                colNum(1), colNum(2));
    end
    errorStr = sprintf('\nVAPP backend: Error while creating the IR tree.\n');
    errorStr = sprintf([errorStr, errMsg, '\n', posStr]);
    error(errorStr);

    
end
