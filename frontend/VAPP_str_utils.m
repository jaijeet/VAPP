function out = VAPP_str_utils()

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================
    out.ch_in_str = @ch_in_str;
    out.str_in_arr = @str_in_arr;
    out.is_whitespace = @is_whitespace;
    out.is_whitespace_char = @is_whitespace_char;
    out.is_newline_char = @is_newline_char;
    out.is_lower_alpha = @is_lower_alpha;
    out.is_upper_alpha = @is_upper_alpha;
    out.is_alpha = @is_alpha;
    out.is_non_zero_digit = @is_non_zero_digit;
    out.is_digit = @is_digit;
    out.is_alpha_num = @is_alpha_num;
    out.lstrip = @lstrip;
    out.rstrip = @rstrip;
    out.strip = @strip;
    out.join = @join;
    out.starts_with = @starts_with;
    out.ends_with = @ends_with;
    out.str_arr_to_str = @str_arr_to_str;
    out.augment_unique_str_arr = @augment_unique_str_arr;

end

function out_str = lstrip(in_str)
    % remove whitespace from the beginning of a string
    idx = 1;
    while idx <= length(in_str) && is_whitespace_char(in_str(idx))
        idx = idx + 1;
    end
    out_str = in_str(idx:end);
end

function out_str = rstrip(in_str)
    % remove whitespace from the end of a string
    idx = length(in_str);
    while idx > 0 && is_whitespace_char(in_str(idx))
        idx = idx - 1;
    end
    out_str = in_str(1:idx);
end

function out_str = strip(in_str)
    % remove whitespace from either end of a string
    out_str = lstrip(rstrip(in_str));
end

function out = is_whitespace_char(ch)
    % returns true if ch is a whitespace character, else returns false
    whitespace_chars = sprintf(' \t\n\r');
    out = ch_in_str(ch, whitespace_chars);
end

function out = is_newline_char(ch)
    % returns true if ch is a newline character, else returns false
    newline_chars = sprintf('\n\r');
    out = ch_in_str(ch, newline_chars);
end

function out = is_whitespace(str)
    % returns true if str is full of whitespace chars, else returns false
    for idx = 1:1:length(str)
        ch = str(idx);
        if ~is_whitespace_char(ch)
            out = false;
            return
        end
    end
    out = true;
end

function out = is_lower_alpha(ch)
    out = ch_in_str(ch, 'abcdefghijklmnopqrstuvwxyz');
end

function out = is_upper_alpha(ch)
    out = ch_in_str(ch, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
end

function out = is_alpha(ch)
    out = (is_lower_alpha(ch) || is_upper_alpha(ch));
end

function out = is_non_zero_digit(ch)
    out = ch_in_str(ch, '123456789');
end

function out = is_digit(ch)
    out = ch_in_str(ch, '0123456789');
end

function out = is_alpha_num(ch)
    out = (is_alpha(ch) || is_digit(ch));
end

function out = ch_in_str(ch, str)
    % returns true if ch is in str, else returns false
    for idx = 1:1:length(str)
        if ch == str(idx)
            out = true;
            return;
        end
    end
    out = false;
end

function out = str_in_arr(str, arr)
    % returns true if the string str is in the cell array of strings arr, and 
    % false otherwise
    for idx = 1:1:length(arr)
        if strcmp(arr{idx}, str)
            out = true;
            return;
        end
    end
    out = false;
end

function out_str = join(join_chars, strs)

    % similar to Python's join_chars.join(list_of_strings) function
        % except here, strs is a cell array of strings

    if length(strs) == 0
        out_str = '';
        return;
    end

    out_str = strs{1};
    for idx = 2:1:length(strs)
        out_str = [out_str, join_chars, strs{idx}];
    end

end

function out = starts_with(str, prefix, pos)

    % Returns true if str starts with prefix at index pos, false otherwise (pos
    % is an optional argument that defaults to 1). That is, this function 
    % returns true if str(pos:(pos+length(prefix)-1)) is equal to prefix, and 
    % false otherwise.

    if nargin == 2
        pos = 1;
    end

    try
        out = strcmp(str(pos:(pos+length(prefix)-1)), prefix);
    catch
        out = false;
    end

end

function out = ends_with(str, suffix, pos)

    % Returns true if str ends with suffix at index pos, false otherwise (pos
    % is an optional argument that defaults to length(str)). That is, this 
    % function returns true if str((pos-length(suffix)+1):pos) is equal to 
    % suffix, and false otherwise.

    if nargin == 2
        pos = length(str);
    end

    try
        out = strcmp(str((pos-length(suffix)+1):pos), suffix);
    catch
        out = false;
    end

end

function out = str_arr_to_str(str_arr)

    % Convert a cell array of strings into a single string

    quoted_str_arr = {};
    for idx = 1:1:length(str_arr)
        quoted_str = ['''', str_arr{idx}, ''''];
        quoted_str_arr = [quoted_str_arr, {quoted_str}];
    end
    
    out = ['{', join(', ', quoted_str_arr), '}'];

end

function out = augment_unique_str_arr(str_arr, str)
    if isempty(str_arr) || any(strcmp(str, str_arr)) == false
       out = [str_arr, {str}];
   else
       out = str_arr;
   end
end
