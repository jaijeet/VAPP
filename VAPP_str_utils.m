
function out = VAPP_str_utils()
    out.ch_in_str = @ch_in_str;
    out.is_whitespace = @is_whitespace;
    out.is_whitespace_char = @is_whitespace_char;
    out.rstrip = @rstrip;
    out.lstrip = @lstrip;
    out.join = @join;
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

function out = is_whitespace_char(ch)
    % returns true if ch is a whitespace character, else returns false
    whitespace_chars = sprintf(' \t\n\r');
    out = ch_in_str(ch, whitespace_chars);
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
