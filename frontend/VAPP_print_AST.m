function VAPP_print_AST(AST, str_utils, outfile_path)

    % This function pretty-prints the given AST, in a format similar to the 
    % Unix command "tree". If outfile_path is empty, it outputs to console. 
    % Otherwise it outputs to the file specified in outfile_path. Note: AST is 
    % assumed to be a single AST node representing the root of the tree.
     
%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================
    to_console = nargin == 2 || isempty(outfile_path);

    if to_console
        fid = '';
    else
        fid = fopen(outfile_path, 'w');
    end

    % display the root of the AST
    root_str = AST_node_to_string(AST, str_utils);
    disp_or_write_to_file(root_str, fid);

    % display all children
    children = AST.get_children();
    prefix = '';
    for idx = 1:1:length(children)
        child = children{idx};
        is_last_child = (idx == length(children));
        pprint_AST(child, prefix, is_last_child, str_utils, fid);
    end

    if ~to_console
        fclose(fid);
    end

end

function out = AST_node_to_string(node, str_utils)

    Type = node.get_type();

    strs = {};
    attr_names = sort(node.get_attr_names());
    for idx = 1:1:length(attr_names)
        key = attr_names{idx};
        value = to_string(node.get_attr(key), str_utils);
        s = sprintf('%s: %s', key, value);
        strs = [strs, {s}];
    end
    attrs_str = str_utils.join(', ', strs);

    if isempty(attrs_str)
        out = sprintf('[%s]', Type);
    else
        out = sprintf('[%s] %s', Type, attrs_str);
    end

end

function out = to_string(x, str_utils)

    if isfloat(x)
        if (abs(x) < 1000) && (ceil(x) - floor(x) < 1e-12)
            out = num2str(x);
        else
            out = sprintf('%.16f', x);
        end

    elseif ischar(x)
        out = mat2str(x);

    elseif iscell(x)
        strs = {};
        for idx = 1:1:length(x)
            s = to_string(x{idx}, str_utils);
            strs = [strs, {s}];
        end
        out = sprintf('{%s}', str_utils.join(', ', strs));

    elseif islogical(x)
        if x == true
            out = 'true';
        else
            out = 'false';
        end
    else
        % TODO: expand the above logic as you add new kinds of attrs and remove
        % this fall-back case.
        out = '';
    end

end

function pprint_AST(node, prefix, is_last_child, str_utils, fid)

    % convert node to string
    node_str = AST_node_to_string(node, str_utils);

    % display the node
    if is_last_child
        ch = '`';
    else
        ch = '|';
    end
    node_line = sprintf('%s%s-- %s', prefix, ch, node_str);
    disp_or_write_to_file(node_line, fid);

    % display all children
    children = node.get_children();
    if is_last_child
        ch = ' ';
    else
        ch = '|';
    end
    next_prefix = sprintf('%s%s   ', prefix, ch);
    for idx = 1:1:length(children)
        child = children{idx};
        next_is_last_child = (idx == length(children));
        pprint_AST(child, next_prefix, next_is_last_child, str_utils, fid);
    end

end

function out = disp_or_write_to_file(s, fid)
    if isempty(fid)
        disp(s);
    else
        fwrite(fid, sprintf('%s\n', s));
    end
end

