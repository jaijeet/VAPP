function out_str = VAPP_combine_lines(input_str, parms, str_utils)
    
    % parms should be a struct, and parms.combine_lines_allow_whitespace should 
    % exist and be either true or false. If true, then a "\" followed by an 
    % arbitrary amount of whitespace followed by a newline character indicates 
    % that the current line is continued on the next line. If false, then only 
    % a "\" followed immediately by a newline character indicates line 
    % continuation (no whitespace allowed between the "\" and the newline 
    % character).

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik, A. Gokcen Mahmutoglu, Xufeng Wang
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================
    allow_whitespace = parms.combine_lines_allow_whitespace;

    out_str = '';
    seen_backslash = false;

    for idx = 1:1:length(input_str)

        ch = input_str(idx);

        if ~seen_backslash

            if ch == '\'
                seen_backslash = true;
                backslash_buffer = ch;

            else
                out_str = [out_str, ch];

            end

        else

            if str_utils.is_newline_char(ch)
                backslash_buffer = strrep(backslash_buffer,'\',' ');
                out_str = [out_str, backslash_buffer, ' ']; % use whitespace to replace the '\' character
                seen_backslash = false;

            elseif ch == '\'
                out_str = [out_str, backslash_buffer];
                backslash_buffer = ch;

            elseif str_utils.is_whitespace_char(ch) && allow_whitespace
                out_str = [out_str, ch];
                %backslash_buffer = [backslash_buffer, ch];

            else
                out_str = [out_str, backslash_buffer, ch];
                seen_backslash = false;

            end

        end

    end

    if seen_backslash
        out_str = [out_str, backslash_buffer];
    end

end

