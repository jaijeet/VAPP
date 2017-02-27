function [tok_list, new_macro_definitions] = ...
            VAPP_pre_process(infile_path, macro_definitions, parms, str_utils)

    % This function converts the given Verilog-A input file into a cell array 
    % of tokens.
    
    % set parms.include_cwd to the infile_path directory so that this directory 
    % will be searched when the `include directive is used within infile. Having 
    % a separate field "include_cwd" is arguably better than pre-pending this
    % directory to parms.include_dirs because if you have a file A that includes
    % a file B that includes a file C, you don't really want to search for C in
    % the directory containing A, but you *do* want to search for C in the
    % directory containing B.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik, A. Gokcen Mahmutoglu, Xufeng Wang
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================

    [dir_name, file_base_name, file_ext] = fileparts(infile_path);
    parms.include_cwd = dir_name;

    % Step 1: Create a string with the contents of the given file
    s = VAPP_file_to_str(infile_path);
    s_1 = s;
    
    s_newline_mask = +(s_1==10); % newline character = 1; others = 0
    s_newline_pos_mask = s_newline_mask;
    s_linepos_count = 0;
    for index = 1:length(s_newline_pos_mask)
        if s_newline_pos_mask(index) == 1
            s_linepos_count = 1; % reset s_linepos_count
        else
            s_linepos_count = s_linepos_count + 1;
            s_newline_pos_mask(index) = s_linepos_count;
        end
    end
    
    % Step 2: Combine lines (i.e., process line continuations)
    s = VAPP_combine_lines(s, parms, str_utils);
    s_2 = s;
    
    % Step 3: Strip comments
    s = VAPP_strip_comments(s);
    s_3 = s;
    
    % DEBUG
    % Check the integraty of the processed string. We have opted to replace
    % discarded content with whitespaces, so other than whitespaces,
    % everything else shall be identical.
    non_ws_index = (double(s_3)~=32);
    if ~isequal(s_1(non_ws_index), s_2(non_ws_index), s_3(non_ws_index))
        fprintf('ERROR: Processed inputfile is corrupted!\n');
    else
        fprintf('Pre-processing file "%s" successful!\n', infile_path);
    end
    % End of DEBUG
    
    % Step 4: Tokenize
    context_stack = {};
    identifier_replacements = {};
    parms.infile_path = infile_path; % current file
    [tok_list, new_macro_definitions, new_context_stack] = ...
        VAPP_tokenize(s, macro_definitions, context_stack, ...
        identifier_replacements, parms, str_utils);
    
    % Step 5: Write token line number and line range
    %         lineno: Line numbers for starting and ending positions.
    %         linepos: The positions within the line.
    for index = 1:length(tok_list)
        this_tok = tok_list{index};
        
        if ~strcmp(this_tok.infile_path, infile_path)
            % only process tokens from infile_path
            continue;
        end
        
        % line number
        this_lineno_start = 1 + sum(s_newline_mask(1:this_tok.range(1)));
        this_lineno_end = 1 + sum(s_newline_mask(1:this_tok.range(2)));
        
        tok_list{index}.lineno = [this_lineno_start this_lineno_end];
        
        % range within this line
        tok_list{index}.linepos = [s_newline_pos_mask(this_tok.range(1)) s_newline_pos_mask(this_tok.range(2))];
    end
    
    % DEBUG
    % Iterate through toks to see if the value is consistent with the range
%     for index = 1:length(tok_list)
%         this_tok = tok_list{index};
%         if (isnumeric(this_tok.value))
%             % comparing numeric values
%             if (str2double(s_1(this_tok.range(1):this_tok.range(2)))~=this_tok.value)
%                 fprintf('Token inconsistency! Value from file ''%d'' and token value ''%d'' differ!\n', s_1(this_tok.range(1):this_tok.range(2)),this_tok.value);
%             end
%         elseif ischar(this_tok.value)
%             % compareing string values
%             if (strcmp(s_1(this_tok.range(1):this_tok.range(2)),this_tok.value)==0)
%                 fprintf('Token inconsistency! Value from file ''%s'' and token value ''%s'' differ!\n', s_1(this_tok.range(1):this_tok.range(2)),this_tok.value);
%             end
%         else
%             % unknown type
%             fprintf('Unknown token type found!\n');      
%         end
%     end
    % End of DEBUG
end

