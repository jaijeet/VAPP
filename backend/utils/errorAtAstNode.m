function errorAtAstNode(errMsg, astNode)
% VAPP_ERROR displays error message and the file name/line number of the
% AstNode

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu
% Last modified: Wed Jun 29, 2016  11:28AM
%==============================================================================


fprintf(2, '\nVAPP backend: Error while creating the IR tree.\n');
fprintf(2, [errMsg, '\n']);
if nargin > 1
    pos = astNode.get_pos();
    pos = pos{:};
    lineNum = pos.lineno;
    colNum = pos.linepos;
    fileName = pos.infile_path;

    fprintf(2, ['file: %s\n',...
                'line number: %d -- %d\n',...
                'column number: %d -- %d\n'],...
                                            fileName,...
                                            lineNum(1), lineNum(2),...
                                            colNum(1), colNum(2));
end

    
end
