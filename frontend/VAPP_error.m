function VAPP_error(errMsg, tok)
% VAPP_ERROR displays error message and the file name/line number of the token

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu
% Last modified: Sat Feb 20, 2016  10:01PM
%==============================================================================


fprintf(2, '\nError while parsing the input file.\n');
fprintf(2, [errMsg, '\n']);
if nargin > 1
    lineNum = tok.lineno;
    colNum = tok.linepos;
    fileName = tok.infile_path;
    tokVal = tok.value;

    fprintf(2, ['at token: %s\n',...
                'file: %s\n',...
                'line number: %d -- %d\n',...
                'column number: %d -- %d\n'],...
                                            tokVal,...
                                            fileName,...
                                            lineNum(1), lineNum(2),...
                                            colNum(1), colNum(2));
end

    
end
