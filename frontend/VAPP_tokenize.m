function [tok_list, new_macro_definitions, new_context_stack] = ...
            VAPP_tokenize(input_str, ...
                          macro_definitions, ...
                          context_stack, ...
                          identifier_replacements, ...
                          parms, ...
                          str_utils)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik, A. Gokcen Mahmutoglu, Xufeng Wang
% Last modified: Tue Feb 14, 2017  04:16PM
%==============================================================================
    keywords = VA_keywords();
    punctuation_symbols = VA_punctuation_symbols();
    punctuation_indicator_str = first_characters(punctuation_symbols);

    % if  VAPP macro is not defined, define it
    if macro_exists('__VAPP__', macro_definitions) == false
        vapp_macro = struct();
        vapp_macro.name = '__VAPP__';
        vapp_macro.object_like = 1;
        vapp_macro.body = '';
        macro_definitions = add_macro(vapp_macro, macro_definitions);
    end

    % if  VAMS_COMPACT_MODELING macro is not defined, define it
    if macro_exists('__VAMS_COMPACT_MODELING__', macro_definitions) == false
        vams_macro = struct();
        vams_macro.name = '__VAMS_COMPACT_MODELING__';
        vams_macro.object_like = 1;
        vams_macro.body = '';
        macro_definitions = add_macro(vams_macro, macro_definitions);
    end

    tok_list = {}; next_pos = skip_whitespace(input_str, 1, str_utils);
    while next_pos <= length(input_str)
        pre_pos = next_pos; % record start location of the token

        ch = input_str(next_pos);

        if ch == '`'
            % compiler directive
            [toks, macro_definitions, context_stack, next_pos] = ...
                process_compiler_directive(input_str, next_pos, ...
                                           macro_definitions, context_stack, ...
                                           identifier_replacements, parms, ...
                                           str_utils);
        elseif ch == '$'
            % simulator directive
            [toks, next_pos] = process_simulator_directive(input_str, ...
                                                           next_pos, ...
                                                           str_utils);

        elseif (str_utils.is_alpha(ch) || ch == '_')
            % keyword or identifier
            [toks, next_pos] = ...
                parse_keyword_or_identifier(input_str, next_pos, keywords, ...
                                            identifier_replacements, ...
                                            str_utils);

        elseif (str_utils.is_digit(ch) || ch == '.')
            % number
            [toks, next_pos] = parse_number(input_str, next_pos, str_utils);

        elseif ch == '"'
            % string literal
            [toks, next_pos] = parse_string(input_str, next_pos, str_utils);

        elseif str_utils.ch_in_str(ch, punctuation_indicator_str)
            % Type "P": punctuation symbol
            [toks, next_pos] = parse_punctuation_symbol(input_str, next_pos, ...
                                                        punctuation_symbols, ...
                                                        str_utils);
            % if toks is a semicolon and the last tok in the tok_list is a
            % semicolon as well (i.e., we have a double, triple etc. semicolon)
            % we ignore this token.
            if isempty(tok_list) == false
                if is_semicolon(toks{1}) && is_semicolon(tok_list{end})
                    next_pos = skip_whitespace(input_str, next_pos, str_utils);
                    continue;
                end
            end
        else
            % escape special characters
            ch = regexprep(ch, {'\\', '%%'}, {'\\\', '%%%'});
            fprintf(2, ['Error while reading the input file: ',...
                        'Character "', ch, '" does not begin a valid token.']);
            break;
        end
        
        if ~isempty(toks) && is_permissive(context_stack)
            toks{1}.range = [pre_pos next_pos-1]; % index range of this token over the file string
            toks{1}.infile_path = parms.infile_path; % token file name
            
            n_toks = numel(toks);
            tok_list(end+1:end+n_toks) = toks;
        end
        
        next_pos = skip_whitespace(input_str, next_pos, str_utils);
        
    end
    
    new_macro_definitions = macro_definitions;
    new_context_stack = context_stack;
    
end

function out = VA_keywords()

    out = {
                        'abs', ...
                     'abstol', ...
                     'access', ...
                       'acos', ...
                      'acosh', ...
                 'aliasparam', ...
                     'analog', ...
                       'asin', ...
                      'asinh', ...
                       'atan', ...
                      'atan2', ...
                      'atanh', ...
                      'begin', ...
                     'branch', ...
                       'case', ...
                       'ceil', ...
                        'cos', ...
                       'cosh', ...
                        'ddt', ...
                 'ddt_nature', ...
                        'ddx', ...
                    'default', ...
                 'discipline', ...
                     'domain', ...
                       'else', ...
                        'end', ...
                    'endcase', ...
              'enddiscipline', ...
                'endfunction', ...
                  'endmodule', ...
                  'endnature', ...
                    'exclude', ...
                        'exp', ...
                      'floor', ...
                       'flow', ...
                        'for', ...
                       'from', ...
                   'function', ...
                      'hypot', ...
                 'idt_nature', ...
                         'if', ...
                        'inf', ...
                      'inout', ...
                      'input', ...
                    'integer', ...
                     'limexp', ...
                         'ln', ...
                        'log', ...
                        'max', ...
                        'min', ...
                     'module', ...
                     'nature', ...
                     'output', ...
                  'parameter', ...
                  'potential', ...
                        'pow', ...
                       'real', ...
                     'repeat', ...
                        'sin', ...
                       'sinh', ...
                     'string', ...
                       'sqrt', ...
                        'tan', ...
                       'tanh', ...
                      'units', ...
                      'while', ...
          };

end

function out = VA_punctuation_symbols()

    out = {
               '+', ...
               '-', ...
               '*', ...
               '/', ...
               '%', ...
               '<', ...
               '>', ...
               '!', ...
               '=', ...
               '(', ...
               ')', ...
               '[', ...
               ']', ...
               '{', ...
               '}', ...
               ',', ...
               ';', ...
               ';', ...
              '''', ...
               '?', ...
               ':', ...
               '$', ...
              '**', ...
              '<=', ...
              '>=', ...
              '==', ...
              '!=', ...
              '&&', ...
              '||', ...
              '<+', ...
              '@', ...
          };

end

function out_str = first_characters(C)

    % Given a cell array of strings C, return a new string out_str where each 
    % character in out_str forms the first (left-most) character of at least 
    % one string in C. The returned string out_str does not contain duplicate 
    % characters.

    % collect all first characters (with duplicates) in a cell array F
    F = {};
    for idx = 1:1:length(C)
        F{idx} = C{idx}(1);
    end

    % remove duplicates from F
    F = union(F, {});

    % build out_str from F
    out_str = '';
    for idx = 1:1:length(F)
        out_str = [out_str, F{idx}];
    end

end

function new_next_pos = skip_whitespace(input_str, next_pos, str_utils)

    % Skip whitespace, if any, in input_str beginning at next_pos. Return the 
    % index of the next non-whitespace character (if one exists). If the 
    % supplied next_pos is already greater than the length of input_str, the 
    % supplied next_pos is returned as it is. If the supplied next_pos is valid
    % but there is no non-whitespace character at or after next_pos, we return
    % 1 + length(input_str).

    while (    next_pos <= length(input_str) ...
            && str_utils.is_whitespace_char(input_str(next_pos)) )
        next_pos = next_pos + 1;
    end

    new_next_pos = next_pos;

end

function [toks, new_macro_definitions, new_context_stack, new_next_pos] = ...
            process_compiler_directive(input_str, ...
                                       next_pos, ...
                                       macro_definitions, ...
                                       context_stack, ...
                                       identifier_replacements, ...
                                       parms, ...
                                       str_utils)

    % We know that a compiler directive starts at input_str(next_pos). That 
    % means input_str(next_pos) must be a backtick ('`') character. We need to 
    % look at what follows the backtick character to determine what kind of 
    % compiler directive this is. Supported compiler directives include 
    % `define, `undef, `include, `ifdef, `ifndef, `elsif, `else, `endif, and 
    % macro calls. Then, based on what compiler directive this is, we will do 
    % the appropriate thing.

    % make sure that the character at next_pos is indeed a backtick
    if input_str(next_pos) ~= '`'
        error('Expected a "`", but did not find it');
    end

    % figure out what the directive is, and do the needful
    next_pos = next_pos + 1;
    [identifier, next_pos] = parse_identifier(input_str, next_pos, str_utils);
    toks = {};

    if strcmp(identifier, 'define')
        % `define
        next_pos = skip_whitespace(input_str, next_pos, str_utils);
        [macro_definitions, next_pos] = ...
                process_define_directive(input_str, next_pos, ...
                                         macro_definitions, context_stack, ...
                                         str_utils);

    elseif strcmp(identifier, 'undef')
        % `undef
        next_pos = skip_whitespace(input_str, next_pos, str_utils);
        [macro_definitions, next_pos] = ...
                process_undef_directive(input_str, next_pos, ...
                                        macro_definitions, context_stack, ...
                                        str_utils);

    elseif strcmp(identifier, 'include')
        % `include
        next_pos = skip_whitespace(input_str, next_pos, str_utils);
        [toks, macro_definitions, next_pos] = ...
                process_include_directive(input_str, next_pos, ...
                                          macro_definitions, context_stack, ...
                                          parms, str_utils);

    elseif strcmp(identifier, 'ifdef')
        % `ifdef
        next_pos = skip_whitespace(input_str, next_pos, str_utils);
        [context_stack, next_pos] = ...
                process_ifdef_directive(input_str, next_pos, ...
                                        macro_definitions, context_stack, ...
                                        str_utils);

    elseif strcmp(identifier, 'ifndef')
        % `ifndef
        next_pos = skip_whitespace(input_str, next_pos, str_utils);
        [context_stack, next_pos] = ...
                process_ifndef_directive(input_str, next_pos, ...
                                         macro_definitions, context_stack, ...
                                         str_utils);

    elseif strcmp(identifier, 'elsif')
        % `elsif
        next_pos = skip_whitespace(input_str, next_pos, str_utils);
        [context_stack, next_pos] = ...
                process_elsif_directive(input_str, next_pos, ...
                                        macro_definitions, context_stack, ...
                                        str_utils);

    elseif strcmp(identifier, 'else')
        % `else
        [context_stack, next_pos] = ...
                process_else_directive(input_str, next_pos, context_stack, ...
                                       str_utils);

    elseif strcmp(identifier, 'endif')
        % `endif
        [context_stack, next_pos] = ...
                process_endif_directive(input_str, next_pos, context_stack, ...
                                        str_utils);

    else
        % macro call
        [toks, next_pos] = ...
                process_macro_call(identifier, input_str, next_pos, ...
                                   macro_definitions, context_stack, ...
                                   identifier_replacements, parms, str_utils);
    end

    new_macro_definitions = macro_definitions;
    new_context_stack = context_stack;
    new_next_pos = next_pos;

end

function [out, new_next_pos] = parse_identifier(input_str, next_pos, str_utils)

    % input_str at next_pos is known to begin an identifier. We are to scan for 
    % that identifier using a "maximal munch approach" and return the 
    % identifier, plus the new value of next_pos once this identifier is 
    % scanned.
    
    % Paraphrasing from the Accellera Verilog-AMS 2.4 reference manual: "Any 
    % sequence of letters, digits, dollar signs, and underscore characters that 
    % does not start with a digit or a dollar sign is a valid identifier.".

    orig_next_pos = next_pos;

    % scan the first character
    ch = input_str(next_pos);
    if (~str_utils.is_alpha(ch) && ch ~= '_')
        error('First character of identifier is not a letter/underscore');
    end
    scanned_chars = ch;
    next_pos = next_pos + 1;

    % scan subsequent characters
    while next_pos <= length(input_str)
        ch = input_str(next_pos);
        if (str_utils.is_alpha_num(ch) || ch == '$' || ch == '_')
            scanned_chars = [scanned_chars, ch];
            next_pos = next_pos + 1;
        else
            break;
        end
    end

    out = scanned_chars;
    new_next_pos = orig_next_pos + length(out);

end

function [new_macro_definitions, new_next_pos] = ...
                process_define_directive(input_str, ...
                                         next_pos, ...
                                         macro_definitions, ...
                                         context_stack, ...
                                         str_utils)
    
    % We are trying to define a new macro here (context_stack permitting). This 
    % involves the following:
    %
    %     1. We find out details about the new macro to be defined: its name, 
    %        whether it is an object-like macro or a function-like macro, the 
    %        number and names of its formal arguments (if it is a function-like 
    %        macro), its body (definition), etc. 
    %
    %        Finding the name of the macro is easy: we just extract an
    %        identifier from the current position next_pos. We then look at the 
    %        character immediately after this identifier. If the character is 
    %        an open parenthesis ('('), the macro is a function-like macro. 
    %        Otherwise it's an object-like macro. If the macro is function-like, 
    %        we parse the formal argument list of the macro (a comma separated 
    %        list of identifier strings), beginning at the '(' character and 
    %        ending at a corresponding ')' character. Finally, we extract the 
    %        body of the macro (as a string): for this, we extract the portion 
    %        of input_str from the current position to the next newline
    %        character, and then strip this extracted portion to obtain the body 
    %        of the macro.
    %
    %     2. We check to make sure that context_stack allows the addition of 
    %        new macros. For instance, if we're in an ifdef context that's 
    %        false, we can't add a new macro. In this case, we just set 
    %        new_macro_definitions to macro_definitions and return. If the 
    %        context is "favourable", we continue to the next step.
    %
    %     3. We confirm that the macro name that we want to define is not 
    %        already defined, and if that's the case, we add the given macro 
    %        definition to the list of existing macros. 
    %   

    % find macro details
    [macro.name, next_pos] = parse_identifier(input_str, next_pos, str_utils);
    if input_str(next_pos) == '('
        macro.object_like = false;
        [macro.formal_arg_names, next_pos] = ...
                parse_formal_args(input_str, next_pos, str_utils);
    else
        macro.object_like = true;
    end

    eol_pos = next_end_of_line(input_str, next_pos, str_utils);
    macro.body = str_utils.strip(input_str(next_pos:eol_pos));
    new_next_pos = eol_pos + 1;

    % does context_stack allow macro addition?
    if ~is_permissive(context_stack)
        new_macro_definitions = macro_definitions;
        return;
    end

    % context_stack allows macro addition
    % add macro if it doesn't already exist
    new_macro_definitions = add_macro(macro, macro_definitions);

end

function [arg_names, new_next_pos] = ...
            parse_formal_args(input_str, next_pos, str_utils)

    % Parse a formal argument list from input_str starting at next_pos. The 
    % character at next_pos should be an open parenthesis '(', because that's 
    % what indicates the start of the argument list. Following this '(' is a 
    % comma separated list of identifier strings, terminated by a close 
    % parenthesis ')'.
    %
    % The parsing algorithm is simple: we start at the character immediately to 
    % the right of the open parenthesis. We keep going until we find either a 
    % comma or a close parenthesis. In either case, we add the argument just 
    % scanned (stripped of whitespace) to the cell array arg_names. If we 
    % encountered a comma, we continue the process beginning at the character 
    % immediately after the comma. But if we encountered a close parenthesis, 
    % we break.
    %

    % check that the character at next_pos is indeed a '('
    if input_str(next_pos) ~= '('
        error('Expected a "(" but did not find it');
    end

    % scan subsequent characters
    next_pos = next_pos + 1;
    seen_close_paren = false;
    arg_names = {};
    while ~seen_close_paren
        % get the next arg_name
        scanned_chars = '';
        seen_comma = false;
        while (~seen_comma && ~seen_close_paren)
            ch = input_str(next_pos);
            if ch == ','
                seen_comma = true;
            elseif ch == ')'
                seen_close_paren = true;
            else
                scanned_chars = [scanned_chars, ch];
            end
            next_pos = next_pos + 1;
        end
        arg_name = str_utils.strip(scanned_chars);
        if seen_close_paren && isempty(arg_name) && isempty(arg_names)
            % empty argument list
            break;
        elseif ~is_valid_identifier(arg_name, str_utils)
            error(['Invalid arg_name: ', arg_name]);
        else
            arg_names = [arg_names, {arg_name}];
        end
    end

    new_next_pos = next_pos;

end

function out = is_valid_identifier(s, str_utils)
    
    % empty strings are not valid identifiers
    if isempty(s)
        out = false;
        return;
    end

    % the first character must be a letter or an underscore
    first_ch = s(1);
    if (~str_utils.is_alpha(first_ch) && first_ch ~= '_')
        out = false;
        return;
    end

    % subsequent characters must all be letters, digits, dollar signs, or 
    % underscores
    for idx = 2:1:length(s)
        ch = s(idx);
        if (~str_utils.is_alpha_num(ch) && ch ~= '$' && ch ~= '_')
            out = false;
            return;
        end
    end

    % if the code comes here, s is a valid identifier
    out = true;

end

function eol_pos = next_end_of_line(input_str, next_pos, str_utils)

    % Find the smallest index eol_pos such that eol_pos >= next_pos and 
    % input_str(eol_pos) is a newline character. If there is no such eol_pos, 
    % raise an exception.

    while true
        if next_pos > length(input_str)
            error('Input ended before end of line could be found');
        end
        ch = input_str(next_pos);
        if str_utils.is_newline_char(ch)
            eol_pos = next_pos;
            return;
        end
        next_pos = next_pos + 1;
    end

end

function new_macro_definitions = add_macro(macro, macro_definitions)

    % Confirm that macro.name is not already defined, and if that is the case, 
    % define it.

    % check to see if macro already exists; if so, raise an exception
    if macro_exists(macro.name, macro_definitions)
        error(['Multiple definitions for macro "', macro.name, '"']);
    end

    % macro does not exist
    new_macro_definitions = [macro_definitions, {macro}];

end

function out = macro_exists(macro_name, macro_definitions)
    
    for idx = 1:1:length(macro_definitions)
        if strcmp(macro_definitions{idx}.name, macro_name)
            out = true;
            return;
        end
    end

    out = false;

end

function [success, macro] = search_for_macro(macro_name, macro_definitions)

    for idx = 1:1:length(macro_definitions)
        curr_macro = macro_definitions{idx};
        if strcmp(curr_macro.name, macro_name)
            success = true;
            macro = curr_macro;
            return;
        end
    end

    success = false;
    macro = 'None';

end

function [new_macro_definitions, new_next_pos] = ...
            process_undef_directive(input_str, ...
                                    next_pos, ...
                                    macro_definitions, ...
                                    context_stack, ...
                                    str_utils)
    
    % find the name of the macro that we're trying to undefine
    eol_pos = next_end_of_line(input_str, next_pos, str_utils);
    macro_name = str_utils.strip(input_str(next_pos:eol_pos));
    new_next_pos = eol_pos + 1;

    % does context_stack allow macro removal?
    if ~is_permissive(context_stack)
        new_macro_definitions = macro_definitions;
        return;
    end

    % context_stack allows macro removal
    % remove macro after checking to see that it is defined exactly once
    new_macro_definitions = remove_macro(macro_name, macro_definitions);

end

function new_macro_definitions = remove_macro(macro_name, macro_definitions)

    % Confirm that macro_name is already defined exactly once, and if that is 
    % the case, undefine it.

    count = 0;
    new_macro_definitions = {};
    for idx = 1:1:length(macro_definitions)
        macro = macro_definitions{idx};
        if strcmp(macro.name, macro_name)
            count = count + 1;
        else
            new_macro_definitions = [new_macro_definitions, {macro}];
        end
    end

    if count ~= 1
        error(['Macro "', macro_name, '" not defined exactly once']);
    end
        
end

function [toks, new_macro_definitions, new_next_pos] = ...
            process_include_directive(input_str, ...
                                      next_pos, ...
                                      macro_definitions, ...
                                      context_stack, ...
                                      parms, ...
                                      str_utils)

    % find the next newline character: that's where this include statement 
    % ends
    eol_pos = next_end_of_line(input_str, next_pos, str_utils);
    new_next_pos = eol_pos + 1;

    % if the context stack does not permit inclusion of tokens, return
    if ~is_permissive(context_stack)
        toks = {};
        new_macro_definitions = macro_definitions;
        return;
    end
    
    % context stack does permit inclusion of tokens

    % get the argument specified for the include operation
    include_arg = str_utils.strip(input_str(next_pos:eol_pos));

    % tokenize include_arg (because it could be a macro call, etc.)
        % Note: macro_definitions and context_stack will remain the same 
        % through this tokenize call, so I'm going to ignore the updated 
        % values for these returned by tokenize.
    identifier_replacements = {};
    [arg_toks, oof_1, oof_2] = ...
            VAPP_tokenize(include_arg, macro_definitions, context_stack, ...
                          identifier_replacements, parms, str_utils);

    % arg_toks should consist of a single token, which should be a string 
    % literal
    if length(arg_toks) ~= 1 || ~strcmp(arg_toks{1}.Type, 'S')
        error('Argument of include does not tokenize into a string literal')
    end

    % arg_toks{1} is indeed a string literal token: it specifies the path to 
    % the file to be included. This path can be absolute or relative. Figure 
    % out the full absolute path.
    file_path = arg_toks{1}.value;
    if file_exists_and_is_readable(file_path)
        full_path = file_path;
    else
        search_dirs = [{parms.include_cwd}, parms.include_dirs];
        [success, full_path] = search_for_file(file_path, search_dirs);
        if ~success
            error(['Include file "', file_path, ' "not found']);
        end
    end

    % now you have the full path of the file to be included. Pre-process the 
    % file and return the resulting list of tokens.
    [toks, new_macro_definitions] = ...
            VAPP_pre_process(full_path, macro_definitions, parms, str_utils);

end

function out = file_exists_and_is_readable(full_absolute_path)

    try
        fid = fopen(full_absolute_path, 'r');
        fclose(fid);
        out = true;
    catch
        out = false;
    end

end

function [success, full_path] = search_for_file(file_path, include_dirs)
    
    for idx = 1:1:length(include_dirs)
        curr_full_path = [include_dirs{idx}, filesep(), file_path];
        if file_exists_and_is_readable(curr_full_path)
            success = true;
            full_path = curr_full_path;
            return;
        end
    end

    success = false;
    full_path = '';

end

function [new_context_stack, new_next_pos] = ...
            process_ifdef_directive(input_str, ...
                                    next_pos, ...
                                    macro_definitions, ...
                                    context_stack, ...
                                    str_utils)

    % find the next newline character: that's where this ifdef ends
    eol_pos = next_end_of_line(input_str, next_pos, str_utils);
    new_next_pos = eol_pos + 1;

    % find the macro name associated with this ifdef
    macro_name = str_utils.strip(input_str(next_pos:eol_pos));
    
    % add a new context to the stack

    if isempty(context_stack)
        C.global_context = true;
    else
        top = context_stack{end};
        C.global_context = top.global_context && top.local_context;
    end

    if macro_exists(macro_name, macro_definitions)
        C.local_context = true;
        C.local_context_history = true;
    else
        C.local_context = false;
        C.local_context_history = false;
    end

    new_context_stack = [context_stack, {C}];
end

function [new_context_stack, new_next_pos] = ...
            process_ifndef_directive(input_str, ...
                                     next_pos, ...
                                     macro_definitions, ...
                                     context_stack, ...
                                     str_utils)

    % find the next newline character: that's where this ifndef ends
    eol_pos = next_end_of_line(input_str, next_pos, str_utils);
    new_next_pos = eol_pos + 1;

    % find the macro name associated with this ifndef
    macro_name = str_utils.strip(input_str(next_pos:eol_pos));
    
    % add a new context to the stack

    if isempty(context_stack)
        C.global_context = true;
    else
        top = context_stack{end};
        C.global_context = top.global_context && top.local_context;
    end

    if ~macro_exists(macro_name, macro_definitions)
        C.local_context = true;
        C.local_context_history = true;
    else
        C.local_context = false;
        C.local_context_history = false;
    end

    new_context_stack = [context_stack, {C}];

end

function [new_context_stack, new_next_pos] = ...
            process_elsif_directive(input_str, ...
                                    next_pos, ...
                                    macro_definitions, ...
                                    context_stack, ...
                                    str_utils)

    % find the next newline character: that's where this elsif ends
    eol_pos = next_end_of_line(input_str, next_pos, str_utils);
    new_next_pos = eol_pos + 1;

    % find the macro name associated with this elsif
    macro_name = str_utils.strip(input_str(next_pos:eol_pos));
    
    % change the local fields of the context at the top of the stack

    top = context_stack{end};

    if ~top.local_context_history && macro_exists(macro_name, macro_definitions)
        top.local_context = true;
        top.local_context_history = true;
    else
        top.local_context = false;
    end

    new_context_stack = [context_stack{1:(end-1)}, {top}];

end

function [new_context_stack, new_next_pos] = ...
            process_else_directive(input_str, ...
                                   next_pos, ...
                                   context_stack, ...
                                   str_utils)

    % find the next newline character: that's where this else ends
    eol_pos = next_end_of_line(input_str, next_pos, str_utils);
    new_next_pos = eol_pos + 1;

    % change the local fields of the context at the top of the stack

    top = context_stack{end};

    if ~top.local_context_history
        top.local_context = true;
        top.local_context_history = true;
    else
        top.local_context = false;
    end

    new_context_stack = [context_stack(1:(end-1)), {top}];

end

function [new_context_stack, new_next_pos] = ...
            process_endif_directive(input_str, ...
                                    next_pos, ...
                                    context_stack, ...
                                    str_utils)

    % find the next newline character: that's where this endif ends
    eol_pos = next_end_of_line(input_str, next_pos, str_utils);
    new_next_pos = eol_pos + 1;

    % remove the top of the stack
    new_context_stack = context_stack(1:(end-1));

end

function out = is_permissive(context_stack)

    if isempty(context_stack)
        out = true;
    else
        top = context_stack{end};
        out = top.global_context && top.local_context;
    end

end

function [toks, new_next_pos] = ...
            process_macro_call(macro_name, ...
                               input_str, ...
                               next_pos, ...
                               macro_definitions, ...
                               context_stack, ...
                               identifier_replacements, ...
                               parms, ...
                               str_utils)

    % if the context stack does not allow adding tokens, return an empty list 
    % of tokens
    if ~is_permissive(context_stack)
        toks = {};
        new_next_pos = next_pos;
        return;
    end

    % context stack allows adding tokens

    % search through the list of macros defined and identify the called macro
    [success, macro] = search_for_macro(macro_name, macro_definitions);
    if ~success
        error(['Macro "', macro_name, '" called but not defined']);
    end

    % if the macro is a function-like macro, extract an argument list from 
    % input_str
    if ~macro.object_like

        next_pos = skip_whitespace(input_str, next_pos, str_utils);

        if input_str(next_pos) ~= '('
            error('Expected a "(" but did not find it')
        end

        [arg_strs, next_pos] = parse_actual_arg_strs(input_str, ...
                                                     next_pos, str_utils);

        if length(arg_strs) ~= length(macro.formal_arg_names)
            error(['Macro "', macro.name, '": formal and actual args differ']);
        end

    end

    new_next_pos = next_pos;

    % if the macro is a function like macro, figure out identifier replacements
    % for its arguments by tokenizing each string in arg_strs; otherwise, there 
    % are no arguments, so there will be no identifier replacements while 
    % invoking the macro.

    if macro.object_like

        new_identifier_replacements = {};

    else

        % tokenize each arg_str to get a cell array of tokens for each argument

        arg_toks = {};
        for idx = 1:1:length(arg_strs)
            arg_str = arg_strs{idx};

            [arg_tok_array, oof_1, oof_2] = ...
                    VAPP_tokenize(arg_str, macro_definitions, context_stack, ...
                                  identifier_replacements, parms, str_utils);

            arg_toks = [arg_toks, {arg_tok_array}];
        end

        % build a list of new identifier replacements to be used while invoking 
        % this macro
        new_identifier_replacements = {};
        for idx = 1:1:length(arg_strs)
            R.identifier = macro.formal_arg_names{idx};
            R.replacement = arg_toks{idx};
            new_identifier_replacements = [new_identifier_replacements, {R}];
        end

    end

    % call the macro (by tokenizing its body) using new_identifier_replacements, 
    % and return the resulting list of tokens
    [toks, oof_1, oof_2] = ...
            VAPP_tokenize(macro.body, macro_definitions, context_stack, ...
                          new_identifier_replacements, parms, str_utils);

end

function [arg_strs, new_next_pos] = ...
            parse_actual_arg_strs(input_str, ...
                                  next_pos, ...
                                  str_utils)

    % Parse an actual argument list from input_str starting at next_pos. The 
    % character at next_pos should be an open parenthesis '(', because that's 
    % what indicates the start of the argument list. Following the '(' is a
    % comma separated list terminated by a close parenthesis ')'.
    %
    % The parsed argument list is returned as a cell array of strings arg_strs, 
    % with one string per argument in the list.
    %
    % Note: parsing an argument list is NOT trivial. You can't just grep for 
    % the next comma because you could have things like '(f(a, b), c, d)' with
    % arbitrary nesting. You might also encounter tricky things like 
    % '("he,llo(", a, b)'.
    
    % check that the character at next_pos is indeed a '('
    if input_str(next_pos) ~= '('
        error('Expected a "(" but did not find it');
    end

    % scan subsequent characters
    next_pos = next_pos + 1;
    seen_close_paren = false;
    arg_strs = {};
    while ~seen_close_paren
        % get tokens for the next argument
        seen_comma = false;
        orig_pos = next_pos;
        while (~seen_comma && ~seen_close_paren)
            ch = input_str(next_pos);
            if ch == '"'
                next_pos = 1 + find_matching_double_quote(input_str, ...
                                                          next_pos, str_utils);
            elseif str_utils.ch_in_str(ch, '({[')
                next_pos = 1 + find_matching_bracket(input_str, ...
                                                     next_pos, str_utils);
            elseif ch == ','
                seen_comma = true;
            elseif ch == ')'
                seen_close_paren = true;
            else
                next_pos = next_pos + 1;
            end
        end
        % now there's either a ',' or a ')' at next_pos
        arg_str = str_utils.strip(input_str(orig_pos:(next_pos-1)));
        if seen_close_paren && isempty(arg_strs) && isempty(arg_str)
            % empty argument list
            break;
        else
            arg_strs = [arg_strs, {arg_str}];
        end
        next_pos = next_pos + 1;
    end

    new_next_pos = next_pos;

end

function match_idx = find_matching_double_quote(input_str, next_pos, str_utils)

    % We know that input_str(next_pos) is a double-quote character (that 
    % supposedly opens a quoted string literal). We want to scan the subsequent 
    % characters of input_str to find a matching close double quote character 
    % (keeping in mind escape sequences initiated by \ characters). Once we 
    % find this matching close double quote, we return its index as match_idx.

    % make sure the character at next_pos is a double quote
    if input_str(next_pos) ~= '"'
        error('Expected an opening double quote but did not find it')
    end
    next_pos = next_pos + 1;
    
    % scan subsequent characters
    escape = false;
    while true
        ch = input_str(next_pos);
        if escape
            if ~str_utils.ch_in_str(ch, 'nt\"')
                error(['Unrecognized escape sequence "\', ch, '"']);
            end
            escape = false;
        else
            if ch == '\'
                escape = true;
            elseif ch == '"'
                % matching close quote found
                match_idx = next_pos;
                return;
            end
        end
        next_pos = next_pos + 1;
    end

end

function match_idx = find_matching_bracket(input_str, next_pos, str_utils)

    % We know that input_str(next_pos) is an "open bracket" character (i.e., 
    % '(', '{', or '['). We want to scan the subsequent characters of input_str 
    % to find a matching close bracket character, keeping in mind that further 
    % brackets may be opened and string literals may be defined before this 
    % close bracket character occurs. Eventually, once we find the matching 
    % close bracket, we return its index as match_idx.

    % make sure the character at next_pos is an open bracket character
    ch = input_str(next_pos);
    if ~str_utils.ch_in_str(ch, '({[')
        error('Expected an opening bracket character but did not find it')
    end
    
    % initialize the stack
    stack = {ch};
    next_pos = next_pos + 1;
    
    % scan subsequent characters
    while true

        ch = input_str(next_pos);

        if ch == '"'
            % find a matching double quote
            match_idx = find_matching_double_quote(input_str, ...
                                                   next_pos, str_utils);
            next_pos = match_idx + 1;

        elseif str_utils.ch_in_str(ch, '({[')
            % push the open bracket into the stack
            stack = [stack, ch];
            next_pos = next_pos + 1;

        elseif str_utils.ch_in_str(ch, ')}]')
            % check that the top of the stack contains the correct opening
            % bracket that matches this close bracket just found
            if isempty(stack)
                error('Stack is empty, but I expected to find an open bracket')
            end
            top = stack{end};
            if (    (ch == ')' && top ~= '(') ...
                 || (ch == '}' && top ~= '{') ...
                 || (ch == ']' && top ~= '[') ...
               )
                error('Top of stack does not match close bracket')
            end
            % OK, top of stack holds the correct opening bracket: remove it 
            % from the stack
            stack = stack(1:(end-1));
            % Is the stack empty? If so, this is the close bracket character
            % that we set out to find.
            if isempty(stack)
                match_idx = next_pos;
                return;
            else
                next_pos = next_pos + 1;
            end

        else
            next_pos = next_pos + 1;

        end

    end

end

function [toks, new_next_pos] = ...
            process_simulator_directive(input_str, ...
                                        next_pos, ...
                                        str_utils)

    % We know that a simulator directive starts at input_str(next_pos). That 
    % means input_str(next_pos) must be a dollar ('$') character. We need to 
    % look at the identifier that follows the dollar character to determine 
    % what kind of simulator directive this is. We then return a token 
    % corresponding to this directive.
    
    % make sure that the character at next_pos is indeed a dollar character
    if input_str(next_pos) ~= '$'
        error('Expected a "$", but did not find it');
    end

    % figure out what the simulator directive is
    next_pos = next_pos + 1;
    [identifier, next_pos] = parse_identifier(input_str, next_pos, str_utils);

    % build the appropriate token
    tok.Type = 'SD';
    tok.value = identifier;

    % return the result
    toks = {tok};
    new_next_pos = next_pos;

end

function [toks, new_next_pos] = ...
            parse_keyword_or_identifier(input_str, ...
                                        next_pos, ...
                                        keywords, ...
                                        identifier_replacements, ...
                                        str_utils)

    % We know that a keyword/identifier starts at input_str(next_pos). We need
    % to extract an identifier that begins at next_pos, figure out whether it's 
    % a keyword or not, figure out whether it needs to be replaced by a list of 
    % tokens or not, and return an appropriate cell array of tokens. 
    
    % extract the identifier
    [identifier, next_pos] = parse_identifier(input_str, next_pos, str_utils);
    new_next_pos = next_pos;

    % is this identifier a keyword?
    is_keyword = false;
    for idx = 1:1:length(keywords)
        if strcmp(identifier, keywords{idx})
            is_keyword = true;
            break;
        end
    end

    % return the appropriate token if this identifier is a keyword
    if is_keyword
        tok.Type = 'K'; tok.value = identifier; toks = {tok};
        return;
    end

    % not a keyword

    % is there a replacement list for this identifier?
    should_replace = false;
    for idx = 1:1:length(identifier_replacements)
        R = identifier_replacements{idx};
        if strcmp(identifier, R.identifier)
            should_replace = true;
            replacement = R.replacement;
            break;
        end
    end

    % return the appropriate cell array of tokens depending on whether the 
    % identifier must be replaced or not
    if should_replace
        toks = replacement;
    else
        tok.Type = 'I'; tok.value = identifier;
        toks = {tok};
    end

end

function [toks, new_next_pos] = parse_number(input_str, next_pos, str_utils)

    % We know that a number begins at position next_pos in input_str. We are to 
    % parse it and return the result as a cell array containing 1 token. The 
    % "Type" field of this token will be 'NI' if the number is an integer, and 
    % 'NF' if the number is a floating point number. Either way, the "value" 
    % field of this token will be a MATLAB double. We are also to return the 
    % new next_pos after the number has been scanned.
    %
    % Note: Verilog-A has a *very* complicated way to specify all kinds of 
    % numbers like binary, octal, hexadecimal, etc., with various flags and 
    % signed and unsigned bits and sizes and so on. I'm not going to bother 
    % with all that. My format will only support simple numbers of the form 
    % below:
    %
    %     42
    %     42.42, .42
    %     42e6, 42E6, 42e-6, 42E-6
    %     42.42e6, 42.42E6, 42.42e-6, 42.42E-6, .42e6, .42E6, .42e-6, .42E-6
    %     42k, 42.42k
    %         * the following scale factors are supported:
    %             * T: 1e12
    %             * G: 1e9
    %             * M: 1e6
    %             * K, k: 1e3
    %             * m: 1e-3
    %             * u: 1e-6
    %             * n: 1e-9
    %             * p: 1e-12
    %             * f: 1e-15
    %             * a: 1e-18
    %
    % Note: 42e-4.2 is invalid: the parsing will stop at 42e-4 and return that.
    %

    num_as_str = '';
    num_type = 'NI';

    % read the integer part of the number
    possibly_empty = true;
    [int_part, next_pos] = parse_sequence_of_digits(input_str, next_pos, ...
                                                    possibly_empty, str_utils);
    
    % if the integer part is empty, the only possibility is that the character 
    % at next_pos is a decimal point
    if isempty(int_part)
        int_part = '0';
        if input_str(next_pos) ~= '.'
            error('Expected a decimal point but did not find it')
        end
    end
    num_as_str = int_part;

    if next_pos > length(input_str)
        tok.Type = num_type; tok.value = str2num(num_as_str);
        toks = {tok};
        new_next_pos = next_pos;
        return;
    end

    % there is a character at next_pos
        % it could be a decimal point, or
        % it could be an exponent indicator ('e'/'E'), or
        % it could be a scale indicator ('n'/'u'/'k'/'G', etc.), or
        % it could be something else altogether
    ch = input_str(next_pos);
    if ch == '.'
        % that's a decimal point
        num_type = 'NF';
        % get the fractional part
        next_pos = next_pos + 1;
        possibly_empty = false;
        [frac_part, next_pos] = parse_sequence_of_digits(input_str, ...
                                                         next_pos, ...
                                                         possibly_empty, ...
                                                         str_utils);
        num_as_str = [num_as_str, '.', frac_part];
        if next_pos > length(input_str)
            tok.Type = num_type; tok.value = str2num(num_as_str);
            toks = {tok};
            new_next_pos = next_pos;
            return;
        end
    end

    % there is a character at next_pos
        % it could be an exponent indicator ('e'/'E'), or
        % it could be a scale indicator ('n'/'u'/'k'/'G', etc.), or
        % it could be something else altogether
    ch = input_str(next_pos);
    if (ch == 'e' || ch == 'E')
        % that's the exponent indicator
        num_type = 'NF';
        % get the exponent part
        next_pos = next_pos + 1;
        % there is a character at next_pos
            % it could be a plus sign, or
            % it could be a minus sign, or
            % it could be a digit signifying the beginning of the exponent
        ch = input_str(next_pos);
        if ch == '+'
            % the exponent is positive
            exp_part = '';
            next_pos = next_pos + 1;
        elseif ch == '-'
            % the exponent is negative
            exp_part = '-';
            next_pos = next_pos + 1;
        else
            exp_part = '';
        end
        possibly_empty = false;
        [abs_exp_part, next_pos] = parse_sequence_of_digits(input_str, ...
                                                            next_pos, ...
                                                            possibly_empty, ...
                                                            str_utils);
        exp_part = [exp_part, abs_exp_part];
        num_as_str = [num_as_str, 'e', exp_part];

    elseif str_utils.ch_in_str(ch, 'TGMKkmunpfa')
        % that's the scale indicator
        num_type = 'NF';
        scale_part = scale_str_from_scale_factor(ch);
        num_as_str = [num_as_str, scale_part];
        next_pos = next_pos + 1;

    end

    tok.Type = num_type; tok.value = str2num(num_as_str);
    toks = {tok};
    new_next_pos = next_pos;

end

function [out, new_next_pos] = ...
            parse_sequence_of_digits(input_str, ...
                                     next_pos, ...
                                     possibly_empty, ...
                                     str_utils)

    orig_next_pos = next_pos;
    scanned_digits = '';
    while true
        if next_pos > length(input_str)
            break;
        end
        ch = input_str(next_pos);
        if ~str_utils.is_digit(ch)
            break;
        end
        scanned_digits = [scanned_digits, ch];
        next_pos = next_pos + 1;
    end

    if (~possibly_empty && isempty(scanned_digits))
        error('Expecting a digit but did not find it')
    end
    
    out = scanned_digits;
    new_next_pos = orig_next_pos + length(out);

end

function out = scale_str_from_scale_factor(ch)

    if ch == 'T'
        out = 'e12';

    elseif ch == 'G'
        out = 'e9';

    elseif ch == 'M'
        out = 'e6';

    elseif (ch == 'K' || ch == 'k')
        out = 'e3';

    elseif ch == 'm'
        out = 'e-3';

    elseif ch == 'u'
        out = 'e-6';

    elseif ch == 'n'
        out = 'e-9';

    elseif ch == 'p'
        out = 'e-12';

    elseif ch == 'f'
        out = 'e-15';

    elseif ch == 'a'
        out = 'e-18';

    end

end

function [toks, new_next_pos] = parse_string(input_str, next_pos, str_utils)

    % We know that a string literal begins at next_pos within input_str. So 
    % input_str(next_pos) must be a double-quote character. We scan the 
    % subsequent characters of input_str to find a matching close double quote 
    % character (keeping in mind escape sequences initiated by \ characters). 
    % We return a token corresponding to the scanned string: the "Type" field 
    % of this token will be 'S', and the "value" field will be a MATLAB string 
    % representing the extracted string literal from input_str. Also, we return 
    % an updated value for next_pos after this string has been scanned from 
    % input_str.

    % make sure the character at next_pos is a double quote
    if input_str(next_pos) ~= '"'
        error('First character of string is not a double quote')
    end
    scanned_chars = ''; 
    next_pos = next_pos + 1;
    
    % scan subsequent characters
    escape = false;
    while true
        ch = input_str(next_pos);
        if escape
            if ch == 'n'
                scanned_chars = [scanned_chars, sprintf('\n')];
            elseif ch == 't'
                scanned_chars = [scanned_chars, sprintf('\t')];
            elseif (ch == '\' || ch == '"')
                scanned_chars = [scanned_chars, ch];
            else
                error(['Unrecognized escape sequence "\', ch, '"']);
            end
            escape = false;
        else
            if ch == '\'
                escape = true;
            else
                if ch == '"'
                    break;
                else
                    scanned_chars = [scanned_chars, ch];
                end 
            end
        end
        next_pos = next_pos + 1;
    end

    % next_pos now points to the index of the closing double quote
    next_pos = next_pos + 1;

    % build the token
    tok.Type = 'S'; 
    tok.value = scanned_chars;

    % return the result
    toks = {tok};
    new_next_pos = next_pos;

end

function [toks, new_next_pos] = ...
            parse_punctuation_symbol(input_str, ...
                                     next_pos, ...
                                     valid_symbols, ...
                                     str_utils)

    % valid_symbols is assumed to be a cell array of non-empty strings without 
    % duplicates. We know that input_str contains one of the strings in 
    % valid_symbols beginning at index next_pos. We are to figure out which 
    % symbol this is (using a "maximal munch" approach), and we are to return 
    % that symbol as a cell array of 1 token, with the "Type" field of the 
    % token being 'P', and the "value" field being the extracted symbol as a 
    % MATLAB string. We also return the new next_pos once this symbol has been 
    % scanned.

    orig_next_pos = next_pos;

    unmatched_suffixes = valid_symbols;
    matched_chars = ''; longest_matched_symbol = '';
    while (next_pos <= length(input_str) && ~isempty(unmatched_suffixes))
        % try to narrow down the possibilities based on the next input character
        ch = input_str(next_pos);
        new_matched_chars = [matched_chars, ch];
        new_unmatched_suffixes = {};
        for idx = 1:1:length(unmatched_suffixes)
            suf = unmatched_suffixes{idx};
            if ch ~= suf(1)
                % this symbol no longer a possibility
                continue;
            end
            if length(suf) == 1
                % new longest match found
                longest_matched_symbol = new_matched_chars;
            else
                % symbol not fully matched, but still in the running
                new_unmatched_suffixes = [new_unmatched_suffixes, suf(2:end)];
            end
        end
        unmatched_suffixes = new_unmatched_suffixes;
        matched_chars = new_matched_chars;
        next_pos = next_pos + 1;
    end

    if isempty(longest_matched_symbol)
        error('Expected a punctuation symbol, but did not find it')
    end

    new_next_pos = orig_next_pos + length(longest_matched_symbol);

    % build a token, and return the result
    tok.Type = 'P'; tok.value = longest_matched_symbol;
    toks = {tok};

end

function out = is_semicolon(tok)

    if strcmp(tok.Type, 'P') == true && strcmp(tok.value, ';') == true
        out = true;
    else
        out = false;
    end

end
