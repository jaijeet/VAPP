function AST = VAPP_parse(toks, str_utils)
% TODO: 
%    parameter real l=3e-2 exclud 0;        // inductance (H)
%                                |
% this error is not caught correctly
% (exclud should be exclude)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik, A. Gokcen Mahmutoglu, Xufeng Wang
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================

    uniqID_generator = VAPP_UniqID_Generator();

    next_pos = 1;
    children = {};
    % addition by gokcen:
    % data structure to hold access function info, i.e, function string,
    % nature, discipline.
    nature_map = containers.Map(); % values: natures -> keys: access strings
    access_map = containers.Map(); % values: access strings -> keys nature labels
    discipline_map = containers.Map();

    while next_pos <= length(toks)
        
        tok = toks{next_pos};

        if is_keyword(tok, 'nature')
            % nature ... endnature
            % NOTE (gokcen): implement a parsing function here
            %next_pos = skip_to_keyword('endnature', toks, next_pos+1) + 1;
            next_pos = parse_nature(toks, next_pos, nature_map, access_map);

        elseif is_keyword(tok, 'discipline')
            % discipline ... enddiscipline
            % NOTE (gokcen): implement a parsing function here
            %next_pos = skip_to_keyword('enddiscipline', toks, next_pos+1) + 1;
            next_pos = parse_discipline(toks, next_pos, nature_map, ...
                                                    access_map, discipline_map);

        elseif is_keyword(tok, 'module')
            % module ... endmodule
            [module_AST, next_pos] = parse_module(toks, next_pos,...
                                                  discipline_map, nature_map,...
                                                  uniqID_generator, str_utils);
            % if error from parse_module
            if next_pos == -1
                AST = VAPP_AST_Node.empty;
                return;
            end

            children = [children, {module_AST}];
        elseif is_keyword(tok, 'analog')

            tok2 = toks{next_pos+1};

            if is_keyword(tok2, 'function')
                % analog function ... endfunction
                [module_AST, next_pos] = parse_analog_function(toks, next_pos, ...
                                                               nature_map, ...
                                                               uniqID_generator, ...
                                                               str_utils);
            end
            % if error from parse_module
            if next_pos == -1
                AST = VAPP_AST_Node.empty;
                return;
            end

            children = [children, {module_AST}];

        else
            AST = VAPP_AST_Node.empty;
            VAPP_error('Unexpected token', tok);
            return;
        end

        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            return;
        end
        
    end

    AST = create_root_AST(children, uniqID_generator);

end

function test()
    
    str_utils = VAPP_str_utils();
    uniqID_generator = VAPP_UniqID_Generator();

    % +-----------------------------------------------------------------------+
    % |                      EXPRESSION PARSING TESTS                         |
    % +-----------------------------------------------------------------------+
    
    %{
    % expr = 'c0*v + c1*v1*ln(cosh((v - v0)/v1))';
    % expr = 'a?b?sin(c):d()+e(f,g(h,i),j):k*l?(m+n):(p+q*r)';
    expr = 'I0 * (exp(vpn/$vt($temperature))-1)';

    [toks, oof_1, oof_2] = VAPP_tokenize(expr, {}, {}, {}, struct(), str_utils);
    AST = parse_expression(toks, uniqID_generator, str_utils);

    disp(sprintf('Expression: %s', expr));
    disp('Expression AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                 VARIABLE DECLARATION PARSING TESTS                    |
    % +-----------------------------------------------------------------------+
    
    %{
    var_decl_stmt = 'real a = 1.25, b, c = 2, d = 1 + sqrt(4.5), e, f, g = 2.25;';
    % var_decl_stmt = 'integer a = 1, b, c = 2, d = 4096 - 1024, e;';
    % var_decl_stmt = 'string a, b, c = "hello";';
    
    [toks, oof_1, oof_2] = VAPP_tokenize(var_decl_stmt, {}, {}, {}, ...
                                         struct(), str_utils);
    [AST, new_next_pos] = ...
        parse_variable_declaration_statement(toks, 1, uniqID_generator, ...
                                             str_utils);

    disp(sprintf('Variable declaration statement: %s', var_decl_stmt));
    disp('Variable declaration statement AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                PARAMETER DECLARATION PARSING TESTS                    |
    % +-----------------------------------------------------------------------+
    
    %{
    parm_decl_stmt = 'parameter real c0 = 1p from (0:inf) exclude [20:sqrt(1000)];';
    % parm_decl_stmt = 'parameter string s = "hello" exclude "world";';
    % parm_decl_stmt = 'parameter real Beta = 0.5*alpha;';
    % parm_decl_stmt = 'parameter string Type = "NMOS" from ''{"NMOS", "PMOS"};';
    % parm_decl_stmt = 'parameter integer a = -5 from (-100:100) exclude (a+b+c)*3;';
    % parm_decl_stmt = 'parameter integer a = 0, b = 1;';

    [toks, oof_1, oof_2] = VAPP_tokenize(parm_decl_stmt, {}, {}, {}, ...
                                         struct(), str_utils);
    [AST, new_next_pos] = ...
        parse_parameter_declaration_statement(toks, 1, uniqID_generator, ...
                                              str_utils);

    disp(sprintf('Parameter declaration statement: %s', parm_decl_stmt));
    disp('Parameter statement AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                 CONTRIBUTION STATEMENT PARSING TESTS                  |
    % +-----------------------------------------------------------------------+
    
    %{
    contrib_stmt = 'I(d, di) <+ V(d, di) * gdpr;';

    [toks, oof_1, oof_2] = VAPP_tokenize(contrib_stmt, {}, {}, {}, ...
                                         struct(), str_utils);
    [AST, new_next_pos] = ...
        parse_contribution_statement(toks, 1, uniqID_generator, str_utils);

    disp(sprintf('Contribution statement: %s', contrib_stmt));
    disp('Contribution AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                     IF STATEMENT PARSING TESTS                        |
    % +-----------------------------------------------------------------------+
    
    %{
    % if_stmt = '';
    % if_stmt = [if_stmt, sprintf('\n'), 'if (vgfbPD < 0.0) begin'];
    % if_stmt = [if_stmt, sprintf('\n'), '    T3 = (vgfbPD - T2) / gammaPD;'];
    % if_stmt = [if_stmt, sprintf('\n'), '    psip = -ln(1.0 - T2 + T3*T3);'];
    % if_stmt = [if_stmt, sprintf('\n'), 'end else begin'];
    % if_stmt = [if_stmt, sprintf('\n'), '    T3 = exp(-T2);'];
    % if_stmt = [if_stmt, sprintf('\n'), '    T1 = 0.5 * gammaPD;'];
    % if_stmt = [if_stmt, sprintf('\n'), '    T2 = sqrt(vgfbPD - 1.0 + T3 + T1*T1) - T1;'];
    % if_stmt = [if_stmt, sprintf('\n'), '    psip = T2*T2 + 1.0 - T3;'];
    % if_stmt = [if_stmt, sprintf('\n'), 'end'];
    % contrib_allowed = true;

    % if_stmt = '';
    % if_stmt = [if_stmt, sprintf('\n'), 'if (index > 0)'];
    % if_stmt = [if_stmt, sprintf('\n'), '    if (i > j)'];
    % if_stmt = [if_stmt, sprintf('\n'), '        result = i;'];
    % if_stmt = [if_stmt, sprintf('\n'), '    else begin'];
    % if_stmt = [if_stmt, sprintf('\n'), '        result = j;'];
    % if_stmt = [if_stmt, sprintf('\n'), '        x = sqrt(k);'];
    % if_stmt = [if_stmt, sprintf('\n'), '    end'];
    % contrib_allowed = true;
    
    if_stmt = '';
    if_stmt = [if_stmt, sprintf('\n'), 'if (index > 0) begin'];
    if_stmt = [if_stmt, sprintf('\n'), '    if (i > j)'];
    if_stmt = [if_stmt, sprintf('\n'), '        result = i;'];
    if_stmt = [if_stmt, sprintf('\n'), 'end else begin : my_block_name'];
    if_stmt = [if_stmt, sprintf('\n'), '    result = j;'];
    if_stmt = [if_stmt, sprintf('\n'), '    x = sqrt(k);'];
    if_stmt = [if_stmt, sprintf('\n'), 'end'];
    contrib_allowed = true;

    [toks, oof_1, oof_2] = VAPP_tokenize(if_stmt, {}, {}, {}, struct(), ...
                                         str_utils);
    [AST, new_next_pos] = ...
        parse_if_statement(toks, 1, contrib_allowed, uniqID_generator, ...
                           str_utils);

    disp(sprintf('If statement: %s', if_stmt));
    disp('If AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                    CASE STATEMENT PARSING TESTS                       |
    % +-----------------------------------------------------------------------+

    %{
    case_stmt = '';
    case_stmt = [case_stmt, sprintf('\n'), 'case(rgeo)'];
    case_stmt = [case_stmt, sprintf('\n'), '    1, 2, 5:'];
    case_stmt = [case_stmt, sprintf('\n'), '        begin'];
    case_stmt = [case_stmt, sprintf('\n'), '            if (nuEnd == 0.0)'];
    case_stmt = [case_stmt, sprintf('\n'), '                Rend = 0.0;'];
    case_stmt = [case_stmt, sprintf('\n'), '            else'];
    case_stmt = [case_stmt, sprintf('\n'), '                Rend = Rsh * DMCG / (Weffcj * nuEnd);'];
    case_stmt = [case_stmt, sprintf('\n'), '        end'];
    case_stmt = [case_stmt, sprintf('\n'), '    3, 4, 6:'];
    case_stmt = [case_stmt, sprintf('\n'), '        begin'];
    case_stmt = [case_stmt, sprintf('\n'), '            if (nuEnd == 0.0)'];
    case_stmt = [case_stmt, sprintf('\n'), '                Rend = 0.0;'];
    case_stmt = [case_stmt, sprintf('\n'), '            else'];
    case_stmt = [case_stmt, sprintf('\n'), '                Rend = Rsh * Weffcj / (3.0 * nuEnd * (DMCG + DMCI));'];
    case_stmt = [case_stmt, sprintf('\n'), '        end'];
    case_stmt = [case_stmt, sprintf('\n'), '    default: '];
    case_stmt = [case_stmt, sprintf('\n'), '        Rend = 0.0;'];
    case_stmt = [case_stmt, sprintf('\n'), 'endcase'];
    contrib_allowed = true;

    % case_stmt = '';
    % case_stmt = [case_stmt, sprintf('\n'), 'case(x)'];
    % case_stmt = [case_stmt, sprintf('\n'), '    a, sqrt(b):'];
    % case_stmt = [case_stmt, sprintf('\n'), '        if (c == 0)'];
    % case_stmt = [case_stmt, sprintf('\n'), '            d = 0;'];
    % case_stmt = [case_stmt, sprintf('\n'), '        else'];
    % case_stmt = [case_stmt, sprintf('\n'), '            d = a*b;'];
    % case_stmt = [case_stmt, sprintf('\n'), '    2.2, sqrt(a), 1+b:'];
    % case_stmt = [case_stmt, sprintf('\n'), '        begin'];
    % case_stmt = [case_stmt, sprintf('\n'), '            d = 1;'];
    % case_stmt = [case_stmt, sprintf('\n'), '            e = 2;'];
    % case_stmt = [case_stmt, sprintf('\n'), '        end'];
    % case_stmt = [case_stmt, sprintf('\n'), '    1.25, a?b?c:d:e?f:g:'];
    % case_stmt = [case_stmt, sprintf('\n'), '        d = 2;'];
    % case_stmt = [case_stmt, sprintf('\n'), '    default: '];
    % case_stmt = [case_stmt, sprintf('\n'), '        d = -1.0;'];
    % case_stmt = [case_stmt, sprintf('\n'), 'endcase'];
    % contrib_allowed = true;

    [toks, oof_1, oof_2] = VAPP_tokenize(case_stmt, {}, {}, {}, struct(), ...
                                         str_utils);
    [AST, new_next_pos] = ...
        parse_case_statement(toks, 1, contrib_allowed, nature_map, ...
                             uniqID_generator,  str_utils);

    disp(sprintf('Case statement: %s', case_stmt));
    disp('Case AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                        FOR LOOP PARSING TESTS                         |
    % +-----------------------------------------------------------------------+

    %{
    for_loop = '';
    for_loop = [for_loop, sprintf('\n'), 'for (i = 0; i < NF; i = i+1) begin : forloop'];
    for_loop = [for_loop, sprintf('\n'), '    T0 = 1.0 / NF / (SA + 0.5*L_mult + i * (SD +L_mult));'];
    for_loop = [for_loop, sprintf('\n'), '    T1 = 1.0 / NF / (SB + 0.5*L_mult + i * (SD +L_mult));'];
    for_loop = [for_loop, sprintf('\n'), '    Inv_sa = Inv_sa + T0;'];
    for_loop = [for_loop, sprintf('\n'), '    Inv_sb = Inv_sb + T1;'];
    for_loop = [for_loop, sprintf('\n'), 'end'];
    contrib_allowed = true;

    [toks, oof_1, oof_2] = VAPP_tokenize(for_loop, {}, {}, {}, struct(), ...
                                         str_utils);
    [AST, new_next_pos] = ...
        parse_for_loop(toks, 1, contrib_allowed, uniqID_generator, str_utils);

    disp(sprintf('For loop: %s', for_loop));
    disp('For loop AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                      REPEAT LOOP PARSING TESTS                        |
    % +-----------------------------------------------------------------------+

    %{
    repeat_loop = '';
    repeat_loop = [repeat_loop, sprintf('\n'), 'repeat (NF + 1 - 1) begin : repeatloop'];
    repeat_loop = [repeat_loop, sprintf('\n'), '    T0 = 1.0 / NF / (SA + 0.5*L_mult + i * (SD +L_mult));'];
    repeat_loop = [repeat_loop, sprintf('\n'), '    T1 = 1.0 / NF / (SB + 0.5*L_mult + i * (SD +L_mult));'];
    repeat_loop = [repeat_loop, sprintf('\n'), '    Inv_sa = Inv_sa + T0;'];
    repeat_loop = [repeat_loop, sprintf('\n'), '    Inv_sb = Inv_sb + T1;'];
    repeat_loop = [repeat_loop, sprintf('\n'), 'end'];
    contrib_allowed = true;

    [toks, oof_1, oof_2] = VAPP_tokenize(repeat_loop, {}, {}, {}, struct(), ...
                                         str_utils);
    [AST, new_next_pos] = ...
        parse_repeat_loop(toks, 1, contrib_allowed, uniqID_generator, ...
                          str_utils);

    disp(sprintf('Repeat loop: %s', repeat_loop));
    disp('Repeat loop AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                      WHILE LOOP PARSING TESTS                         |
    % +-----------------------------------------------------------------------+

    %{
    while_loop = '';
    while_loop = [while_loop, sprintf('\n'), 'while (i < NF) begin : whileloop'];
    while_loop = [while_loop, sprintf('\n'), '    T0 = 1.0 / NF / (SA + 0.5*L_mult + i * (SD +L_mult));'];
    while_loop = [while_loop, sprintf('\n'), '    T1 = 1.0 / NF / (SB + 0.5*L_mult + i * (SD +L_mult));'];
    while_loop = [while_loop, sprintf('\n'), '    Inv_sa = Inv_sa + T0;'];
    while_loop = [while_loop, sprintf('\n'), '    Inv_sb = Inv_sb + T1;'];
    while_loop = [while_loop, sprintf('\n'), '    i = i + 1;'];
    while_loop = [while_loop, sprintf('\n'), 'end'];
    contrib_allowed = true;

    [toks, oof_1, oof_2] = VAPP_tokenize(while_loop, {}, {}, {}, struct(), ...
                                         str_utils);
    [AST, new_next_pos] = ...
        parse_while_loop(toks, 1, contrib_allowed, uniqID_generator, ...
                          str_utils);

    disp(sprintf('While loop: %s', while_loop));
    disp('While loop AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                    ANALOG FUNCTION PARSING TESTS                      |
    % +-----------------------------------------------------------------------+

    %{
    analog_func_defn = '';
    analog_func_defn = [analog_func_defn, sprintf('\n'), 'analog function real max_value;'];
    analog_func_defn = [analog_func_defn, sprintf('\n'), '    input n1, n2;'];
    analog_func_defn = [analog_func_defn, sprintf('\n'), '    real n1, n2, n3;'];
    analog_func_defn = [analog_func_defn, sprintf('\n'), '    begin'];
    analog_func_defn = [analog_func_defn, sprintf('\n'), '        n3 = n1 > n2 ? n1 : n2;'];
    analog_func_defn = [analog_func_defn, sprintf('\n'), '        max_value = n3;'];
    analog_func_defn = [analog_func_defn, sprintf('\n'), '    end'];
    analog_func_defn = [analog_func_defn, sprintf('\n'), 'endfunction'];

    [toks, oof_1, oof_2] = VAPP_tokenize(analog_func_defn, {}, {}, {}, ...
                                         struct(), str_utils);
    [AST, new_next_pos] = ...
        parse_analog_function(toks, 1, uniqID_generator, str_utils);

    disp(sprintf('Analog function definition: %s', analog_func_defn));
    disp('Analog function AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

    % +-----------------------------------------------------------------------+
    % |                         MODULE PARSING TESTS                          |
    % +-----------------------------------------------------------------------+
    
    %{
    module_defn = '';
    module_defn = [module_defn, sprintf('\n'), 'module varactor(p, n);'];
    module_defn = [module_defn, sprintf('\n'), '    inout p, n;'];
    module_defn = [module_defn, sprintf('\n'), '    electrical p, n;'];
    module_defn = [module_defn, sprintf('\n'), '    parameter real c0 = 1p from (0:inf);'];
    module_defn = [module_defn, sprintf('\n'), '    parameter real c1 = 0.5p from [0:c0);'];
    module_defn = [module_defn, sprintf('\n'), '    parameter real v0 = 0;'];
    module_defn = [module_defn, sprintf('\n'), '    parameter real v1 = 1 from (0:inf);'];
    module_defn = [module_defn, sprintf('\n'), '    real q, v;'];
    module_defn = [module_defn, sprintf('\n'), '    analog begin'];
    module_defn = [module_defn, sprintf('\n'), '        v = V(p,n);'];
    module_defn = [module_defn, sprintf('\n'), '        q = c0*v + c1*v1*ln(cosh((v - v0)/v1));'];
    module_defn = [module_defn, sprintf('\n'), '        I(p, n) <+ ddt(q);'];
    module_defn = [module_defn, sprintf('\n'), '    end'];
    module_defn = [module_defn, sprintf('\n'), 'endmodule'];

    [toks, oof_1, oof_2] = VAPP_tokenize(module_defn, {}, {}, {}, struct(), ...
                                         str_utils);
    [AST, new_next_pos] = parse_module(toks, 1, uniqID_generator, str_utils);

    disp(sprintf('Module definition: %s', module_defn));
    disp('Module AST: ');
    VAPP_print_AST(AST, str_utils);
    %}

end

function out = is_keyword(tok, kw)

    if ~strcmp(tok.Type, 'K')
        out = false;
    elseif nargin > 1 && ~strcmp(tok.value, kw)
        out = false;
    else
        out = true;
    end

end

function out = is_one_of_the_keywords(tok, kw_arr, str_utils)
    out = strcmp(tok.Type, 'K') && str_utils.str_in_arr(tok.value, kw_arr);
end

function out = is_symbol(tok, sym)

    if ~strcmp(tok.Type, 'P')
        out = false;
    elseif nargin > 1 && ~strcmp(tok.value, sym)
        out = false;
    else
        out = true;
    end

end

function out = is_one_of_the_symbols(tok, sym_arr, str_utils)
    out = strcmp(tok.Type, 'P') && str_utils.str_in_arr(tok.value, sym_arr);
end

function out = is_one_of_the_symbols_or_keywords(tok, ...
                                                 sym_arr, ...
                                                 kw_arr, ...
                                                 str_utils)

    out = (    is_one_of_the_symbols(tok, sym_arr, str_utils) ...
            || is_one_of_the_keywords(tok, kw_arr, str_utils) );

end

function out = is_identifier(tok, id_name)

    if ~strcmp(tok.Type, 'I')
        out = false;
    elseif nargin > 1 && ~strcmp(tok.value, id_name)
        out = false;
    else
        out = true;
    end

end

function out = is_one_of_the_identifiers(tok, id_arr, str_utils)
    out = strcmp(tok.Type, 'I') && str_utils.str_in_arr(tok.value, id_arr);
end

function out = is_numeric_constant(tok)
    out = strcmp(tok.Type, 'NI') || strcmp(tok.Type, 'NF');
end

function out = is_string(tok)
    out = strcmp(tok.Type, 'S');
end

function out = is_constant(tok)
    out = is_numeric_constant(tok) || is_string(tok);
end

function out = is_simulator_directive(tok)
    out = strcmp(tok.Type, 'SD');
end

function out = is_subset(sub_cell, super_cell, str_utils)
    % sub_cell and super_cell are cell arrays of strings. We return true if
    % every string in sub_cell also exists in super_cell.
    for idx = 1:1:length(sub_cell)
        if ~str_utils.str_in_arr(sub_cell{idx}, super_cell)
            out = false;
            return;
        end
    end
    out = true;
end

function out = const_dtypes_multi_map()

    % Return a cell array of cell arrays of strings, where each inner cell 
    % array is of the form {VA dtype, tok Type, AST dtype}.

    out = { { 'integer', 'NI',   'int' }, ...
            {    'real', 'NF', 'float' }, ...
            {  'string',  'S',   'str' } 
          };

end

function [success, value] = multi_map_lookup(multi_map, key, key_idx, value_idx)

    % Search the given multi_map for key and return the corresponding value.
    % The multi-map should be a cell array of cell arrays. The key (value) is 
    % located at index key_idx (value_idx) of the inner cell array.

    for idx = 1:1:length(multi_map)
        multi_map_entry = multi_map{idx};
        multi_map_key = multi_map_entry{key_idx};
        multi_map_value = multi_map_entry{value_idx};
        if isequal(key, multi_map_key)
            value = multi_map_value;
            success = true;
            return;
        end
    end

    success = false;
    value = 'None';

end

function out = convert_const_dtype(from_type, to_type, key)

    idxs_err_msgs_multi_map = { {  'VA_dtype', 1, 'Verilog-A data type' }, ...
                                {  'tok_Type', 2,          'token type' }, ...
                                { 'AST_dtype', 3,       'AST data type' } 
                              };

    [success, key_idx] = ...
        multi_map_lookup(idxs_err_msgs_multi_map, from_type, 1, 2);

    if ~success
        error('Not a valid "from_type"');
    end

    [success, value_idx] = ...
        multi_map_lookup(idxs_err_msgs_multi_map, to_type, 1, 2);

    if ~success
        error('Not a valid "to_type"');
    end

    multi_map = const_dtypes_multi_map();
    [success, out] = multi_map_lookup(multi_map, key, key_idx, value_idx);

    if ~success
        [oof, err_type] = ...
            multi_map_lookup(idxs_err_msgs_multi_map, from_type, 1, 3);
        VAPP_error(['Not a valid constant ', err_type]);
        out = -1;
        return;
    end

end

function success = assert_keyword(tok, kw)
    success = 0;
    if nargin == 1
        if ~is_keyword(tok)
            success = -1;
            VAPP_error('Expected a keyword token, but did not find it', tok);
        end
    else
        if ~is_keyword(tok, kw)
            success = -1;
            VAPP_error(sprintf('Expected keyword "%s", but did not find it', kw), tok);
        end
    end
end

function success = assert_one_of_the_keywords(tok, kw_arr, str_utils)
    success = 0;
    if ~is_one_of_the_keywords(tok, kw_arr, str_utils)
        s = str_utils.str_arr_to_str(kw_arr);
        success = -1;
        VAPP_error(['Expected one of the keywords ', s, ', but did not find it'], tok);
    end
end

function success = assert_symbol(tok, sym)
    success = 0;
    if nargin == 1
        if ~is_symbol(tok)
            success = -1;
            VAPP_error('Expected a punctuation symbol token, but did not find it', tok);
        end
    else
        if ~is_symbol(tok, sym)
            success = -1;
            VAPP_error(sprintf('Expected symbol "%s", but did not find it', sym), tok);
        end
    end
end

function success = assert_one_of_the_symbols(tok, sym_arr, str_utils)
    success = 0;
    if ~is_one_of_the_symbols(tok, sym_arr, str_utils)
        success = -1;
        s = str_utils.str_arr_to_str(sym_arr);
        VAPP_error(['Expected one of the symbols ', s, ', but did not find it'], tok);
    end
end

function success = assert_one_of_the_symbols_or_keywords(tok, ...
                                               sym_arr, ...
                                               kw_arr, ...
                                               str_utils)
    success = 0;
    if ~is_one_of_the_symbols_or_keywords(tok, sym_arr, kw_arr, str_utils)

        success = -1;
        s_sym = str_utils.str_arr_to_str(sym_arr);
        s_kw = str_utils.str_arr_to_str(kw_arr);

        VAPP_error(['Expected one of the symbols ', s_sym, ...
               ' or one of the keywords ', s_kw, ', but did not find it'], tok);

    end

end

% this function does not throw a user related error
% no need to use VAPP_error
function assert_subset(sub_cell, super_cell, str_utils)
    if ~is_subset(sub_cell, super_cell, str_utils)
        s_sub = str_utils.str_arr_to_str(sub_cell);
        s_super = str_utils.str_arr_to_str(super_cell);
        error([s_sub, ' not a subset of ', s_super]);
    end
end

function success = assert_identifier(tok, id_name)
    success = 0;
    if nargin == 1
        if ~is_identifier(tok)
            success = -1;
            VAPP_error('Expected an identifier token, but did not find it', tok);
        end
    else
        if ~is_identifier(tok, id_name)
            success = -1;
            VAPP_error(sprintf('Expected identifier "%s", but did not find it', ...
                          id_name), tok);
        end
    end
end

function success = assert_one_of_the_identifiers(tok, id_arr, str_utils)
    success = 0;
    if ~is_one_of_the_identifiers(tok, id_arr, str_utils)
        s = str_utils.str_arr_to_str(id_arr);
        success = -1;
        VAPP_error(['Expected one of the identifiers ', s, ', but did not find it'], tok);
    end
end

function success = assert_simulator_directive(tok)
    success = 0;
    if ~is_simulator_directive(tok)
        success = -1;
        VAPP_error('Expected a simulator directive token, but did not find it', tok);
    end
end

function success = assert_string(tok)
    success = 0;
    if ~is_string(tok)
        success = -1;
        VAPP_error('Expected a string token, but did not find it', tok);
    end
end

function success = assert_numeric_constant(tok)
% ASSERT_NUMERIC_CONSTANT
    success = 0;
    if ~is_numeric_constant(tok)
        success = -1;
        VAPP_error('Expected a numeric constant token, but did not find it', tok);
    end
end

function new_next_pos = skip_to_keyword(kw, toks, next_pos)

    % Returns the index of the next token (in toks, at or after next_pos) that 
    % matches the given keyword kw

    for idx = next_pos:1:length(toks)

        tok = toks{idx};

        if is_keyword(tok, kw)
            new_next_pos = idx;
            return;
        end

    end

    new_next_pos = -1;
    VAPP_error(['Keyword token "', kw, '" not found'], tok);

end

function new_next_pos = skip_to_symbol(sym, toks, next_pos)

    % Returns the index of the next token (in toks, at or after next_pos) that 
    % matches the given punctuation symbol sym

    tok = [];
    for idx = next_pos:1:length(toks)

        tok = toks{idx};

        if is_symbol(tok, sym)
            new_next_pos = idx;
            return;
        end

    end

    new_next_pos = -1;
    if isempty(tok) == false
        VAPP_error(['Symbol token "', sym, '" not found'], tok);
    else
        VAPP_error(['Symbol token "', sym, '" not found']);
    end

end

function new_next_pos = ...
            skip_to_one_of_the_symbols(sym_arr, toks, next_pos, str_utils)

    % Returns the index of the next token (in toks, at or after next_pos) that 
    % matches one of the punctuation symbols in sym_arr

    for idx = next_pos:1:length(toks)

        tok = toks{idx};

        if is_one_of_the_symbols(tok, sym_arr, str_utils)
            new_next_pos = idx;
            return;
        end

    end

    s = str_utils.str_arr_to_str(sym_arr);
    new_next_pos = -1;
    VAPP_error(['None of the symbols ', s, ' found'], tok);

end

function new_next_pos = skip_to_one_of_the_symbols_or_keywords(sym_arr, ...
                                                               kw_arr, ...
                                                               toks, ...
                                                               next_pos, ...
                                                               str_utils)

    % Returns the index of the next token (in toks, at or after next_pos) that 
    % matches either one of the punctuation symbols in sym_arr or one of the 
    % keywords in kw_arr

    for idx = next_pos:1:length(toks)

        tok = toks{idx};

        if is_one_of_the_symbols_or_keywords(tok, sym_arr, kw_arr, str_utils)
            new_next_pos = idx;
            return;
        end

    end

    s_sym = str_utils.str_arr_to_str(sym_arr);
    s_kw = str_utils.str_arr_to_str(kw_arr);
    new_next_pos = -1;
    VAPP_error(['None of the symbols ', s_sym, ' or keywords ', s_kw, ' found'], tok);

end

function new_next_pos = parse_nature(toks, next_pos, nature_map, access_map)
% PARSE_NATURE

% allowed keywords in a nature block:
% units, access, ddt_nature, idt_nature, abstol

    if next_pos == -1
        new_next_pos = -1;
        return;
    end

    % following the same structure as Aidthya's parsing code

    nature = struct(); % structure to hold nature attribute

    [tok, next_pos] = get_next_token(toks, next_pos + 1, 'identifier');
    if next_pos == -1
        new_next_pos = -1;
        return;
    end

    nature_name = tok.value;
    nature.name = nature_name;

    access_label = '';
    while true
        % get next token here
        try
            tok = toks{next_pos};
        catch
            new_next_pos = -1;
            VAPP_error('Expected keyword "endnature", but did not find it',...
                                                           toks{next_pos-1});
            return;
        end

        % build a conditional for allowed keywords (inside nature)

        if is_keyword(tok, 'access')
            [tok, next_pos] = get_lhs_token(toks, next_pos + 1);
            if isempty(tok) == false
                success = assert_identifier(tok);
                nature.access = tok.value;
                access_label = tok.value;
                access_map(nature_name) = access_label;
            end
        elseif is_keyword(tok, 'units')
            [tok, next_pos] = get_lhs_token(toks, next_pos + 1);
            if isempty(tok) == false
                success = assert_string(tok);
                nature.units = tok.value;
            end
        elseif is_keyword(tok, 'ddt_nature')
            [tok, next_pos] = get_lhs_token(toks, next_pos + 1);
            if isempty(tok) == false
                success = assert_identifier(tok);
                nature.ddt_nature = tok.value;
            end
        elseif is_keyword(tok, 'idt_nature')
            [tok, next_pos] = get_lhs_token(toks, next_pos + 1);
            if isempty(tok) == false
                success = assert_identifier(tok);
                nature.idt_nature = tok.value;
            end
        elseif is_keyword(tok, 'abstol')
            [tok, next_pos] = get_lhs_token(toks, next_pos + 1);
            if isempty(tok) == false
                success = assert_numeric_constant(tok);
                nature.abstol = tok.value;
            end
        else
            % if not an allowed keyword break
            break;
        end

        if next_pos == -1 || success == -1
            % NOTE: the ordering of the above conditional is important.
            % if reversed, we might not have a success variable in the
            % workspace if next_pos == -1
            new_next_pos = -1;
            return;
        end

    end

    % check for endnature
    tok = toks{next_pos};
    success = assert_keyword(tok, 'endnature');

    if success == -1
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;
    new_next_pos = next_pos;
    if isempty(access_label) == false
        nature_map(access_label) = nature;
    end
    
end

function new_next_pos = parse_discipline(toks, next_pos, nature_map,...
                                                    access_map, discipline_map)
% PARSE_DISCIPLINE

    if next_pos == -1
        new_next_pos = -1;
        return;
    end


    discipline = struct();

    [tok, next_pos] = get_next_token(toks, next_pos + 1, 'identifier');

    if next_pos == -1
        new_next_pos = -1;
        return;
    end

    discipline_name = tok.value;
    discipline.name = discipline_name;

    while true
        try
            tok = toks{next_pos};
        catch
            new_next_pos = -1;
            VAPP_error('Expected keyword "enddiscipline", but did not find it',...
                                                           toks{next_pos-1});
            return;
        end

        if is_keyword(tok, 'potential')
            [tok, next_pos] = get_next_token_and_semicolon(toks,...
                                                    next_pos + 1, 'identifier');
            if isempty(tok) == false
                success = assert_identifier(tok);
                nature_name = tok.value;

                try 
                    access_label = access_map(nature_name);
                    nature_struct = nature_map(access_label);
                    discipline.potential = nature_struct;
                catch
                    success = -1;
                    next_pos = -1;
                    VAPP_error(['Tried to access the potential "', ...
                                nature_name, '" but could not find it. ',...
                                ' This nature has to be defined prior to',...
                                ' this discipline definition!'], tok);
                end

            end
        elseif is_keyword(tok, 'flow')
            [tok, next_pos] = get_next_token_and_semicolon(toks,...
                                                    next_pos + 1, 'identifier');
            if isempty(tok) == false
                success = assert_identifier(tok);
                nature_name = tok.value;

                try 
                    access_label = access_map(nature_name);
                    nature_struct = nature_map(access_label);
                    discipline.flow = nature_struct;
                catch
                    success = -1;
                    next_pos = -1;
                    VAPP_error(['Tried to access the flow "', ...
                                nature_name, '" but could not find it. ',...
                                ' This nature has to be defined prior to',...
                                ' this discipline definition!'], tok);
                end
            end
        elseif is_keyword(tok, 'domain')
            [tok, next_pos] = get_next_token_and_semicolon(toks,...
                                                    next_pos + 1, 'identifier');
            success = 1;
            % don't do anything here.
        else
            % if not an allowed keyword break
            break;
        end

        if next_pos == -1 || success == -1
            % NOTE: the ordering of the above conditional is important.
            % if reversed, we might not have a success variable in the
            % workspace if next_pos == -1
            new_next_pos = -1;
            return;
        end

    end
    
    % check for enddiscipline
    tok = toks{next_pos};
    success = assert_keyword(tok, 'enddiscipline');

    if success == -1
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;
    new_next_pos = next_pos;
    
    if isempty(discipline_name) == false
        discipline_map(discipline_name) = discipline;
    end
end

function [tok, new_next_pos] = get_next_token(toks, next_pos, expected_token_type)
% GET_NEXT_TOKEN check if there is a next token and return it if any
%
% return an empty token if the file ends here.
    
    if nargin < 3
        expected_token_paren = '';
    else
        expected_token_paren = ['(', expected_token_type, ')'];
    end

    try
        tok = toks{next_pos};
    catch
        tok = [];
        new_next_pos = -1;
        VAPP_error(['Expected another token ', expected_token_paren ,...
                                     'but did not find it!'], toks{next_pos-1});
        return;
    end

    new_next_pos = next_pos + 1;
end

function [tok, new_next_pos] = get_next_token_and_semicolon(toks, next_pos,...
                                                            expected_token_type)
% GET_NEXT_TOKEN_AND_SEMICOLON

    if nargin > 2
        [tok, next_pos] = get_next_token(toks, next_pos, expected_token_type);
    else
        [tok, next_pos] = get_next_token(toks, next_pos);
    end

    if next_pos == -1
        new_next_pos = -1;
        return;
    end

    [tok_semicolon, new_next_pos] = get_next_token(toks, next_pos, 'semicolon');

    if new_next_pos == -1
        tok = [];
        return;
    end

    success = assert_symbol(tok_semicolon, ';');

    if success == -1
        tok = [];
        new_next_pos = -1;
        return;
    end

    % at this point we have found one semicolon. We are going to ignore if
    % another semicolon comes after this.
    %while success == 0
    %    [tok_semicolon, new_next_pos] = get_next_token(toks, new_next_pos, 'semicolon');
    %    if is_symbol(tok_semicolon, ';') == false
    %        success = -1;
    %    end
    %end

    %if success == -1
    %    new_next_pos = new_next_pos - 1;
    %end
    
end

function [tok, new_next_pos] = get_lhs_token(toks, next_pos) % get_lhs_token get token after an equals sign (=)
% This function looks for an expression on the LHS that consists of only one
% token. If there is an expression consisting of multiple tokens (e.g., abstol =
% 2*1e-6) it will result in an error.

    [tok, new_next_pos] = get_next_token(toks, next_pos, 'equals sign');
    if new_next_pos == -1 %  the file has ended, tok is empty
        return;
    end

    next_pos = new_next_pos;
    success = assert_symbol(tok, '=');

    if success == -1
        new_next_pos = -1;
        tok = [];
        return;
    end

    [tok, new_next_pos] = get_next_token_and_semicolon(toks, next_pos);

    if new_next_pos == -1
        tok = [];
        VAPP_error('Expected a LHS expression, but did not find it',...
                                                           toks{next_pos});
        return;
    end

end

function [AST, new_next_pos] = ...
            parse_module(toks, next_pos, discipline_map, nature_map, ...
                                                 uniqID_generator, str_utils)

    % A module begins at next_pos. It is of the form:
    %    * a module declaration,
    %        - see parse_module_declaration() below
    %    * followed by zero or more of the following:
    %        * inout statements,
    %        * electrical statements,
    %        * branch statements,
    %        * thermal statements,
    %        * parameter declaration statements,
    %        * aliasparam statements,
    %        * variable declaration statements,
    %        * analog function definitions, and
    %        * analog sections
    %    * followed by the 'endmodule' keyword
    %
    % Example: 
    %
    %    module varactor(p, n);
    %        inout p, n;
    %        electrical p, n;
    %        parameter real c0 = 1p from (0:inf);
    %        parameter real c1 = 0.5p from [0:c0);
    %        parameter real v0 = 0;
    %        parameter real v1 = 1 from (0:inf);
    %        real q, v;
    %        analog begin
    %            v = V(p,n);
    %            q = c0*v + c1*v1*ln(cosh((v - v0)/v1));
    %            I(p, n) <+ ddt(q);
    %        end
    %    endmodule
    %
    % We parse the module definition above and return the result as an AST node 
    % of Type 'module'. Each statement/block parsed above will be a child of 
    % this AST node. Also, this AST node will contain 2 attributes:
    %    * 'name': a string representing the name of the module, and
    %    * 'terminals': a cell array representing the terminals of the module

    % the module declaration
    [module_name, terminal_names, next_pos] = ...
        parse_module_declaration(toks, next_pos);

    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the statements
    stmts = {};
    contrib_allowed = true;

    % reduced nature map will contain only those natures that belong to the
    % disciplines that are declared in this module.
    access_arr = {};
    discipline_arr = discipline_map.keys;
    while true

        try
            tok = toks{next_pos};
        catch
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            VAPP_error('Expected keyword "endmodule", but did not find it',...
                                                           toks{next_pos-1});
            return;
        end

        if is_keyword(tok, 'inout')
            next_pos = parse_inout_statement(toks, next_pos);
            addl_stmts = {};

        % We will check next if we have a node declaration.
        % Node declarations start with "keywords" that are declared in the
        % disciplines file. These "keywords", however, are not real keywords
        % since they have to be read from the discipline file. This leaves us
        % with two options:
        %
        % 1) treat the disciplines file separately when creating the tokens in
        % VAPP_pre_process and VAPP_tokenize.
        %
        % OR
        %
        % 2) We DON'T look for a keyword here and parse an identifier instead.
        %
        % Option 2 is not totally compliant with theory is not clean but it is
        % easier to implement. I will go with option 2.
        elseif is_one_of_the_identifiers(tok, discipline_arr, str_utils)
            discipline_name = tok.value;
            discipline = discipline_map(discipline_name);
            [stmt, next_pos] = parse_discipline_statement(toks, next_pos, ...
                                                          discipline, ...
                                                          uniqID_generator);
            potential_access = discipline.potential.access;
            flow_access = discipline.flow.access;

            access_arr = str_utils.augment_unique_str_arr(access_arr,...
                                                          potential_access);
            access_arr = str_utils.augment_unique_str_arr(access_arr,...
                                                          flow_access);
            addl_stmts = {stmt};

        elseif is_keyword(tok, 'branch')
            [stmt, next_pos] = parse_branch_statement(toks, next_pos, ...
                                                      uniqID_generator);
            addl_stmts = {stmt};

        elseif is_keyword(tok, 'parameter')
            [stmt, next_pos] = ...
                parse_parameter_declaration_statement(toks, next_pos, ...
                                                      access_arr, ...
                                                      uniqID_generator, ...
                                                      str_utils);
            addl_stmts = {stmt};

        elseif is_keyword(tok, 'aliasparam')
            [stmt, next_pos] = parse_aliasparam_statement(toks, next_pos, ...
                                                          uniqID_generator);
            addl_stmts = {stmt};

        elseif is_one_of_the_keywords(tok, {'integer', 'real', 'string'}, ...
                                      str_utils)
            [stmt, next_pos] = ...
                parse_variable_declaration_statement(toks, next_pos, ...
                                                     access_arr, ...
                                                     uniqID_generator, ...
                                                     str_utils);
            addl_stmts = {stmt};

        elseif is_keyword(tok, 'analog')

            tok2 = toks{next_pos+1};

            if is_keyword(tok2, 'function')
                parse_func = @parse_analog_function;
            else
                parse_func = @parse_analog_section;
            end

            [stmt, next_pos] = feval(parse_func, toks, next_pos, ...
                                     access_arr, uniqID_generator, str_utils);

            % if error from parse_func
            if next_pos == -1
                new_next_pos = -1;
                AST = VAPP_AST_Node.empty;
                return;
            end

            addl_stmts = {stmt};
        
        else
            break;

        end

        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        stmts = [stmts, addl_stmts];

    end

    % the 'endmodule' keyword
    tok = toks{next_pos};
    success = assert_keyword(tok, 'endmodule');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % create the AST and return
    AST = create_module_AST(module_name, terminal_names, stmts, ...
                            uniqID_generator);
    new_next_pos = next_pos;

end

function [module_name, terminal_names, new_next_pos] = ...
            parse_module_declaration(toks, next_pos)

    % A module declaration begins at next_pos. It is of the form:
    %    * the 'module' keyword,
    %    * followed by the name of the module,
    %    * followed by an open paren,
    %    * followed by a comma separated list of terminals,
    %    * followed by a close paren,
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    module varactor(p, n);
    %
    % We parse the above and return the name of the module (as a string), and
    % the names of the terminals of the module (as a cell array of strings). 
    
    % the 'module' keyword
    success = assert_keyword(toks{next_pos}, 'module');

    % if error from assert_keyword
    if success == -1
        module_name = '';
        terminal_names = {};
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the name of the module
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        module_name = '';
        terminal_names = {};
        new_next_pos = -1;
        return;
    end

    module_name = tok.value;
    next_pos = next_pos + 1;

    % the open paren
    success = assert_symbol(toks{next_pos}, '(');

    % if error from assert_symbol
    if success == -1
        module_name = '';
        terminal_names = {};
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the comma separated list of terminals
    [terminal_names, next_pos] = ...
        parse_comma_separated_identifiers(toks, next_pos);

    % if error from parse_comma_separated_identifiers
    if next_pos == -1
        module_name = '';
        terminal_names = {};
        new_next_pos = -1;
        return;
    end

    % the close paren
    success = assert_symbol(toks{next_pos}, ')');

    % if error from assert_symbol
    if success == -1
        module_name = '';
        terminal_names = {};
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the semicolon
    success = assert_symbol(toks{next_pos}, ';');

    % if error from assert_symbol
    if success == -1
        module_name = '';
        terminal_names = {};
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_analog_section(toks, next_pos, access_arr, ...
                                 uniqID_generator, str_utils)

    % An analog section begins at next_pos. It is of the form:
    %    * the 'analog' keyword,
    %    * followed by a core statement or statement block
    %
    % Example: 
    %
    %    analog begin
    %        v = V(p,n);
    %        q = c0*v + c1*v1*ln(cosh((v - v0)/v1));
    %        I(p, n) <+ ddt(q);
    %    end
    %
    % We parse the section above and return the result as an AST node of Type 
    % 'analog'. The statement/block parsed above will be the only child of 
    % the AST node, and the node will have no attributes.

    % the 'analog' keyword
    tok = toks{next_pos};
    success = assert_keyword(tok, 'analog');

    if success == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    next_pos = next_pos + 1;

    % the statement/block
    contrib_allowed = true;
    [stmt, next_pos] = parse_core_statement_or_block(toks, next_pos, ...
                                                     contrib_allowed, ...
                                                     access_arr, ...
                                                     uniqID_generator, ...
                                                     str_utils);

    % if error from parse_core_statement_or_block
    if next_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    % create the AST and return
    AST = create_analog_AST(stmt, uniqID_generator);
    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_analog_function(toks, next_pos, access_arr, ...
                                  uniqID_generator, str_utils)

    % An analog function begins at next_pos. It is of the form:
    %    * an analog function declaration,
    %        - see parse_analog_function_declaration() below
    %    * followed by zero or more of the following:
    %        * input statements,
    %        * output statements, and
    %        * variable declarations
    %    * followed by a core statement or block,
    %    * followed by the 'endfunction' keyword
    %
    % Example: 
    %
    %    analog function real max_value;
    %        input n1, n2;
    %        real n1, n2;
    %        begin
    %            max_value = n1 > n2 ? n1 : n2;
    %        end
    %    endfunction
    %
    % We parse the definition above and return the result as an AST node of 
    % Type 'analog_func'. Each statement/block parsed above will be a child of 
    % this AST node. Also, this AST node will contain 2 attributes:
    %    * 'name', representing the name of this function, and
    %    * 'return_type': one of {'int', 'float'} representing the return 
    %      type of this function

    % the analog function declaration
    [return_type, func_name, next_pos] = ...
        parse_analog_function_declaration(toks, next_pos, str_utils);

    % the statements
    stmts = {};
    contrib_allowed = false;
    while true

        tok = toks{next_pos};
        break_after_parse = false;

        if is_keyword(tok, 'input')
            [stmt, next_pos] = parse_input_statement(toks, next_pos, ...
                                                     uniqID_generator);
            addl_stmts = {stmt};

        elseif is_keyword(tok, 'output')
            [stmt, next_pos] = parse_output_statement(toks, next_pos, ...
                                                      uniqID_generator);
            addl_stmts = {stmt};

        elseif is_one_of_the_keywords(tok, {'integer', 'real', 'string'}, ...
                                      str_utils)
            [stmt, next_pos] = ...
                parse_variable_declaration_statement(toks, next_pos, ...
                                                     access_arr, ...
                                                     uniqID_generator, ...
                                                     str_utils);
            addl_stmts = {stmt};

        else
            [stmt, next_pos] = ...
                parse_core_statement_or_block(toks, next_pos, ...
                                              contrib_allowed, ...
                                              access_arr, ...
                                              uniqID_generator, str_utils);
            addl_stmts = {stmt};
            break_after_parse = true;

        end

        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        stmts = [stmts, addl_stmts];

        if break_after_parse
            break;
        end

    end

    % the 'endfunction' keyword
    tok = toks{next_pos};
    success = assert_keyword(tok, 'endfunction');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % create the AST and return
    AST = create_analog_func_AST(func_name, return_type, stmts, ...
                                 uniqID_generator);
    new_next_pos = next_pos;

end

function [AST_dtype, func_name, new_next_pos] = ...
            parse_analog_function_declaration(toks, next_pos, str_utils)

    % An analog function declaration begins at next_pos. It is of the form:
    %    * the 'analog' keyword,
    %    * followed by the 'function' keyword,
    %    * OPTIONALLY followed by the return type of the function
    %        * either the 'integer' keyword or the 'real' keyword
    %    * followed by the name of the function (an identifier),
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    analog function real my_func;
    %    analog function lexp;
    %
    % We parse the declaration above and return the result as an AST data type
    % ('int' or 'float') representing the return type of the function and a
    % string containing the name of the function. Note: if the return type is 
    % not specified, the Verilog-A standard says that it is assumed to be 'real'
    % by default, which is what we will do.

    % the 'analog' keyword
    success = assert_keyword(toks{next_pos}, 'analog');

    if success == -1
        AST_dtype = -1;
        func_name = '';
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the 'function' keyword
    success = assert_keyword(toks{next_pos}, 'function');

    if success == -1
        AST_dtype = -1;
        func_name = '';
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the optional return type
    tok = toks{next_pos};
    if is_one_of_the_keywords(tok, {'integer', 'real'}, str_utils)
        VA_dtype = tok.value;
        next_pos = next_pos + 1;
    else
        VA_dtype = 'real';
    end
    AST_dtype = convert_const_dtype('VA_dtype', 'AST_dtype', VA_dtype);

    % if error from convert_const_dtype
    if AST_dtype == -1
        new_next_pos = -1;
        func_name = '';
        return;
    end

    % the name of the function
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        AST_dtype = -1;
        func_name = '';
        new_next_pos = -1;
        return;
    end

    func_name = tok.value;
    next_pos = next_pos + 1;

    % the semicolon
    tok = toks{next_pos};
    success = assert_symbol(tok, ';');

    % if error from assert_symbol
    if success == -1
        AST_dtype = -1;
        func_name = '';
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    new_next_pos = next_pos;
end

function new_next_pos = parse_inout_statement(toks, next_pos)
    
    % An inout statement begins at next_pos. It is of the form:
    %    * the 'inout' keyword,
    %    * followed by a comma separated list of terminals,
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    inout p, n;
    %
    % inout statements are redundant in NEEDS-certified Verilog-A because
    % the terminals that they specify must be all the device terminals, which
    % have already been listed in the module declaration. 
    % 
    % So there's nothing to do here. I'm just going to: (1) verify that the 
    % token at next_pos is the 'inout' keyword, and (2) skip straight to the
    % next statement (i.e., the token immediately after the semicolon above), 
    % without building any AST node or anything.

    % the 'inout' keyword
    success = assert_keyword(toks{next_pos}, 'inout');

    if success == -1
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % skip to the next statement
    new_next_pos = skip_to_symbol(';', toks, next_pos) + 1;
end

function [AST, new_next_pos] = parse_discipline_statement(toks, next_pos,...
                                                           discipline,...
                                                           uniqID_generator)

    % A discipline statement begins at next_pos with the label discipline_name
    % E.g., if the discipline label is electrical we will have the following:
    % An "electrical" statement begins at next_pos. It is of the form:
    %    * the 'electrical' keyword,
    %    * followed by a comma separated list of terminals (identifiers),
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    electrical p, n;
    %
    % We build and return an AST node for this statement, of Type 'electrical', 
    % with a single attribute 'terminals' (a cell array of strings).

    org_pos = next_pos;
    discipline_name = discipline.name;
    
    % the 'electrical' keyword
    success = assert_identifier(toks{next_pos}, discipline_name);

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the comma separated list of terminals
    [terminal_names, next_pos] = ...
        parse_comma_separated_identifiers(toks, next_pos);

    % if error from parse_comma_separated_identifiers
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the semicolon
    success = assert_symbol(toks{next_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % build the AST and return
    AST = create_discipline_AST(discipline, terminal_names, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);

    new_next_pos = next_pos;

end

function [AST, new_next_pos] = parse_event_control_statement(toks, ...
                                                          next_pos, ...
                                                          contrib_allowed, ...
                                                          access_arr, ...
                                                          uniqID_generator, ...
                                                          str_utils)

    % An event control statement begins at next_pos. It is of the form:
    %    * the '@' punctuation symbol
    %    * followed by an open paren,
    %    * followed by the name of the event
    %    * followed by a close paren,
    %    * followed by a core statement or block
    %        - subject to contrib_allowed
    %
    % Example: 
    %
    %    @(initial_step) begin
    %       ...
    %    end
    %
    %
    % NOTE: Verilog-A allows combining event with the "or" keyword.
    % However, for now, we will only allow one event.
    
    % the @ symbol
    org_pos = next_pos;

    % the 'if' keyword
    tok = toks{next_pos};
    success = assert_symbol(tok, '@');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the open paren
    tok = toks{next_pos};
    success = assert_symbol(tok, '(');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the event name
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    event_name = tok.value;
    next_pos = next_pos + 1;

    tok = toks{next_pos};
    success = assert_symbol(tok, ')');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the true path
    [event_control_block, next_pos] = ...
        parse_core_statement_or_block(toks, next_pos, contrib_allowed, ...
                                      access_arr, uniqID_generator, str_utils);
    
    % if error from parse_core_statement_or_block
    if next_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    % build the AST and return
    AST = create_event_control_AST(event_name, event_control_block, ...
                                                             uniqID_generator);

    new_next_pos = next_pos;
    
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = ...
            parse_electrical_statement(toks, next_pos, uniqID_generator)

    % An "electrical" statement begins at next_pos. It is of the form:
    %    * the 'electrical' keyword,
    %    * followed by a comma separated list of terminals (identifiers),
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    electrical p, n;
    %
    % We build and return an AST node for this statement, of Type 'electrical', 
    % with a single attribute 'terminals' (a cell array of strings).
    
    org_pos = next_pos;
    
    % the 'electrical' keyword
    success = assert_keyword(toks{next_pos}, 'electrical');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the comma separated list of terminals
    [terminal_names, next_pos] = ...
        parse_comma_separated_identifiers(toks, next_pos);

    % if error from parse_comma_separated_identifiers
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the semicolon
    success = assert_symbol(toks{next_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % build the AST and return
    AST = create_electrical_AST(terminal_names, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);

    new_next_pos = next_pos;
end

function [AST, new_next_pos] = ...
            parse_aliasparam_statement(toks, next_pos, uniqID_generator)

    % An "aliasparam" statement begins at next_pos. It is of the form:
    %    * the 'aliasparam' keyword,
    %    * followed by an identifier (the LHS parameter name),
    %    * followed by an equals sign,
    %    * followed by an identifier (the RHS parameter name),
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    aliasparam dtemp = trise;
    %
    % We build and return an AST node for this statement, of Type 'aliasparam', 
    % with 2 string attributes 'lhs_parm' and 'rhs_parm', and with no children.
    org_pos = next_pos;
    
    % the 'aliasparam' keyword
    success = assert_keyword(toks{next_pos}, 'aliasparam');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the left parameter name
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    lhs_parm_name = tok.value;
    next_pos = next_pos + 1;
    % the equals sign
    success = assert_symbol(toks{next_pos}, '=');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the right parameter name
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    rhs_parm_name = tok.value;
    next_pos = next_pos + 1;

    % the semicolon
    success = assert_symbol(toks{next_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % build the AST and return
    AST = create_aliasparam_AST(lhs_parm_name, rhs_parm_name, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);

    new_next_pos = next_pos;

end

function [id_names, new_next_pos] = ... 
            parse_comma_separated_identifiers(toks, next_pos)

    % A comma separated list of identifiers, i.e., a sequence of the form 
    % {identifier, comma, identifier, comma ... identifier} begins here. We 
    % parse these identifiers and return their names in a cell array id_names, 
    % going as far along the list of tokens as possible. Note: the list of 
    % identifiers may also be empty.
    
    tok = toks{next_pos};

    if ~is_identifier(tok)
        % empty list
        id_names = {};
        new_next_pos = next_pos;
        return;
    end

    id_names = {tok.value};
    next_pos = next_pos + 1;

    while true

        if next_pos > length(toks) || ~is_symbol(toks{next_pos}, ',')
            break;
        end

        next_pos = next_pos + 1;
        
        tok = toks{next_pos};
        success = assert_identifier(tok);

        % if error from assert_identifier
        if success == -1
            id_names = {};
            new_next_pos = -1;
            return;
        end

        id_name = tok.value;
        id_names = [id_names, {id_name}];
        next_pos = next_pos + 1;

    end

    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_branch_statement(toks, next_pos, uniqID_generator)

    % A "branch" statement begins at next_pos. It is of the form:
    %    * the 'branch' keyword,
    %    * followed by an open paren ("(") symbol,
    %    * followed by a comma separated list of ports or identifiers,
    %        * see parse_parse_port_or_identifier()
    %    * followed by a close paren (")") symbol,
    %    * followed by the name of the branch (an identifier),
    %    * followed by a semicolon
    %
    % Examples: 
    %
    %    branch (<p>) probe_p;
    %    branch (p, n) br;
    %    branch (d, s) br_ds;
    %
    % We build and return an AST node for this statement, of Type 'branch', 
    % with 1 attribute: 
    %    * 'name': the name of the branch (a MATLAB string)
    % In addition, the AST node above will have one child (of Type 'var' or 
    % 'port') for each identifier/port found between the open and close 
    % parentheses above.
    org_pos = next_pos;
    
    % the 'branch' keyword
    success = assert_keyword(toks{next_pos}, 'branch');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the open paren
    success = assert_symbol(toks{next_pos}, '(');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the comma separated list of ports or identifiers
    [children, next_pos] = ...
        parse_comma_separated_ports_and_identifiers(toks, next_pos, ...
                                                    uniqID_generator);

    % if error from parse_comma_separated_ports_and_identifiers
    if next_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    % the close paren
    success = assert_symbol(toks{next_pos}, ')');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the name of the branch
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    branch_name = tok.value;
    next_pos = next_pos + 1;

    % the semicolon
    success = assert_symbol(toks{next_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % build the AST and return
    AST = create_branch_AST(branch_name, children, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);

    new_next_pos = next_pos;

end

function [ASTs, new_next_pos] = ... 
            parse_comma_separated_ports_and_identifiers(toks, ...
                                                        next_pos, ...
                                                        uniqID_generator)

    % A comma separated list of ports and identifiers, i.e., a sequence of the 
    % form {port_or_identifier, comma, port_or_identifier, comma ... 
    % port_or_identifier} begins at next_pos. We parse this and return the 
    % result as a cell array of AST nodes. Each identifier becomes a 'var' node 
    % and each port becomes a 'port' node in the cell array. We go as far as
    % possible along the list of tokens looking for ports/identifiers. Note: 
    % the list of ports/identifiers may also be empty.
    % NOTE from Gokcen: (ad note above from Aadithya) I don't understand why
    % this list should be allowed to be empty. Changing this behavior in the
    % first if statement below.

    tok = toks{next_pos};
    if ~is_symbol(tok, '<') && ~is_identifier(tok)
        % empty list
        ASTs = {};
        new_next_pos = -1;
        VAPP_error('List of ports/identifiers cannot be empty', tok);
        return;
    end

    ASTs = {};
    while true

        [AST, next_pos] = parse_port_or_identifier(toks, next_pos, ...
                                                   uniqID_generator);

        % if error from parse_port
        if next_pos == -1
            new_next_pos = -1;
            ASTs = VAPP_AST_Node.empty;
            return;
        end

        ASTs = [ASTs, {AST}];

        if next_pos > length(toks) || ~is_symbol(toks{next_pos}, ',')
            break;
        end

        next_pos = next_pos + 1;
        
    end

    if isempty(ASTs)
        new_next_pos = -1;
        VAPP_error('List of ports/identifiers cannot be empty', tok);
        return;
    end

    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_port_or_identifier(toks, next_pos, uniqID_generator)

    % A port or an identifier begins at next_pos. We detect which it is and 
    % return an appropriate AST node for it. If this is an identifier, we 
    % return a 'var' AST node. Otherwise, we return a 'port' AST node.

    tok = toks{next_pos};

    if is_identifier(tok)
        % identifier
        org_pos = next_pos;
        
        var_name = tok.value;
        AST = create_var_AST(var_name, uniqID_generator);
        AST_add_range(AST, toks, org_pos, next_pos);
        
        new_next_pos = next_pos + 1;
    else
        % port
        [AST, new_next_pos] = parse_port(toks, next_pos, uniqID_generator);

        % if error from parse_port
        if new_next_pos == -1
            AST = VAPP_AST_Node.empty;
            return;
        end
    end

end

function [AST, new_next_pos] = parse_port(toks, next_pos, uniqID_generator)

    % A port begins at next_pos. It is of the form:
    %    * a '<' symbol,
    %    * followed by an identifier (the name of the port),
    %    * followed by a '>' symbol
    % 
    % Examples:
    %
    %    <p>
    %    <drain>
    %
    % We parse the above, and return the result as an AST node of Type 'port', 
    % with no children, and with a single attribute 'name' representing the 
    % name of the port specified above (as a MATLAB string).
    org_pos = next_pos;
    
    % the '<' symbol
    success = assert_symbol(toks{next_pos}, '<');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the name of the port
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    port_name = tok.value;
    next_pos = next_pos + 1;

    % the '>' symbol
    success = assert_symbol(toks{next_pos}, '>');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % create the AST and return
    AST = create_port_AST(port_name, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_input_statement(toks, next_pos, uniqID_generator)

    % An "input" statement begins at next_pos. It is of the form:
    %    * the 'input' keyword,
    %    * followed by a comma separated list of inputs (identifiers),
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    input x, y, my_special_input;
    %
    % We build and return an AST node for this statement, of Type 'input', 
    % with a single attribute 'inputs' (a cell array of strings).
    org_pos = next_pos;
    
    % the 'input' keyword
    success = assert_keyword(toks{next_pos}, 'input');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the comma separated list of inputs
    [input_names, next_pos] = parse_comma_separated_identifiers(toks, next_pos);

    % if error from parse_comma_separated_identifiers
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the semicolon
    success = assert_symbol(toks{next_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % build the AST and return
    AST = create_input_AST(input_names, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_output_statement(toks, next_pos, uniqID_generator)

    % An "output" statement begins at next_pos. It is of the form:
    %    * the 'output' keyword,
    %    * followed by a comma separated list of outputs (identifiers),
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    output x, y, my_special_output;
    %
    % We build and return an AST node for this statement, of Type 'output', 
    % with a single attribute 'outputs' (a cell array of strings).
    org_pos = next_pos;
    
    % the 'output' keyword
    success = assert_keyword(toks{next_pos}, 'output');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the comma separated list of outputs
    [output_names, next_pos] = ...
        parse_comma_separated_identifiers(toks, next_pos);

    % if error from parse_comma_separated_identifiers
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the semicolon
    success = assert_symbol(toks{next_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % build the AST and return
    AST = create_output_AST(output_names, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_variable_declaration_statement(toks, ...
                                                 next_pos, ...
                                                 access_arr, ...
                                                 uniqID_generator, ...
                                                 str_utils)

    % The token at next_pos begins begins a variable declaration statement.
    % This statement is of the form:
    %    * the data type of the variables being declared, 
    %        - one of the keywords 'integer', 'real', or 'string'
    %    * followed by one or more comma separated variable declarations,
    %        - see the parse_variable_declaration() function below
    %    * followed by a semicolon
    %
    % Examples:
    %
    %    real a = 1.25, b, c = 2, d = 1 + sqrt(4.5), e, f, g = 2.25;
    %    integer a = 1, b, c = 2, d = 4096 - 1024, e;
    %    string a, b, c = "hello";
    %
    % We parse such a statement and return the result as a 'var_decl_stmt' 
    % AST, with no attributes and with one child (of Type 'var_decl') for each 
    % variable declared in the statement.
    org_pos = next_pos;

    % the data type
    tok = toks{next_pos};
    success = assert_one_of_the_keywords(tok, {'integer', 'real', 'string'}, str_utils);

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    VA_dtype = tok.value;
    AST_dtype = convert_const_dtype('VA_dtype', 'AST_dtype', VA_dtype);

    % if error from convert_const_dtype
    if AST_dtype == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the variable declarations

    var_decl_children = {};
    while true

        [var_decl_AST, next_pos] = ...
            parse_variable_declaration(AST_dtype, toks, next_pos, ...
                                       access_arr, uniqID_generator, str_utils);

        % if error from parse_variable_declaration
        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        var_decl_children = [var_decl_children, {var_decl_AST}];

        % we are now at either a comma or a semicolon
        tok = toks{next_pos};
        success = assert_one_of_the_symbols(tok, {',', ';'}, str_utils);

        % if error from assert_one_of_the_symbols
        if success == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        next_pos = next_pos + 1;

        if is_symbol(tok, ';')
            break;
        end

    end
    
    % create the AST and return
    AST = create_var_decl_stmt_AST(var_decl_children, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = next_pos;

end

function [AST, new_next_pos] = parse_variable_declaration(AST_dtype, ...
                                                          toks, ...
                                                          next_pos, ...
                                                          access_arr, ...
                                                          uniqID_generator, ...
                                                          str_utils)

    % The token at next_pos begins begins a variable declaration of type 
    % AST_dtype (one of {'int', 'float', 'str'}). This variable declaration is
    % of the form:
    %    * EITHER just a declaration (i.e., just an identifier specifying the 
    %      name of the declared variable,
    %    * OR an initialization
    %        * this is an assignment (see parse_assignment), whose RHS 
    %          expression is terminated by either a semicolon or a comma. Note: 
    %          the terminating semicolon or comma is itself NOT considered part 
    %          of the variable declaration, but it is used to figure out where 
    %          the expression ends. So, if an expression is specified as part 
    %          of the variable declaration, the new_next_pos returned by this 
    %          function will be the index of the terminating comma or semicolon.
    %
    % Examples:
    %
    %    a
    %    b = 1.25
    %    c = 1 + sqrt(4.5)
    %    d = 4096 - 1024
    %    e = "hello"
    %    
    % We parse such a variable declaration and return the result as an AST node
    % of type 'var_decl' with 3 attributes:
    %    * 'dtype': the data type of the variable (a MATLAB string that is
    %      one of {'int', 'float', 'str'}),
    %    * 'name': the name of the variable, and
    %    * 'is_initialized': one of {'True', 'False'} depending, respectively, 
    %      on whether the variable is initialized or just declared
    % The returned AST node will have no children if it's not initialized. 
    % Otherwise, it will have 1 child corresponding to the expression specified 
    % above while initializing the variable.

    % Is this just a declaration or is it an initialization? Well, if the token 
    % immediately after next_pos is an equals sign, it's an initialization. 
    % Otherwise, it's just a declaration.
    org_pos = next_pos;
    
    is_initialized = (    next_pos + 1 <= length(toks) ...
                       && is_symbol(toks{next_pos+1}, '=') );

    sym_arr = {',', ';'};
    if is_initialized
        kw_arr = {};
        [var_name, expr_AST, comma_or_semicolon_pos] = ...
            parse_assignment(toks, next_pos, sym_arr, kw_arr, access_arr, ...
                             uniqID_generator, str_utils);

        % if error from parse_assignment
        if comma_or_semicolon_pos == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end
    else
        tok = toks{next_pos};
        success = assert_identifier(tok);

        % if error from assert_identifier
        if success == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        var_name = tok.value;
        comma_or_semicolon_pos = next_pos + 1;

    end
    success = assert_one_of_the_symbols(toks{comma_or_semicolon_pos}, sym_arr, str_utils);

    % if error from assert_one_of_the_symbols
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end


    % create the AST node and return
    if is_initialized
        AST = create_initialized_var_decl_AST(AST_dtype, var_name, ...
                                              expr_AST, uniqID_generator);

    else
        AST = create_uninitialized_var_decl_AST(AST_dtype, var_name, ...
                                                uniqID_generator);

    end
    
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = comma_or_semicolon_pos;

end

function [AST, new_next_pos] = ...
            parse_parameter_declaration_statement(toks, ...
                                                  next_pos, ...
                                                  access_arr, ...
                                                  uniqID_generator, ...
                                                  str_utils)

    % The token at next_pos begins begins a parameter declaration statement.
    % This statement is of the form:
    %    * the 'parameter' keyword, 
    %    * the data type of the parameters being declared, 
    %    * followed by one or more comma separated parameter declarations,
    %        - see the parse_parameter_declaration() function below
    %    * followed by a semicolon
    %
    % Examples:
    %
    %    parameter real c0 = 1p from (0:inf) exclude [20:sqrt(1000)];
    %    parameter string s = "hello" exclude "world";
    %    parameter real Beta = 0.5*alpha;
    %    parameter string Type = "NMOS" from '{"NMOS", "PMOS"};
    %    parameter integer a = -5 from (-100:100) exclude (a+b+c)*3;
    %    parameter integer a = 0, b = 1;
    %
    % We parse such a statement and return the result as a 'parm_stmt' AST 
    % node, with no attributes and with one child (of Type 'parm') for each 
    % parameter declared in the statement.
    org_pos = next_pos;

    % the 'parameter' keyword, 
    tok = toks{next_pos};
    success = assert_keyword(tok, 'parameter');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the data type
    tok = toks{next_pos};
    success = assert_one_of_the_keywords(tok, {'integer', 'real', 'string'}, str_utils);

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    VA_dtype = tok.value;
    AST_dtype = convert_const_dtype('VA_dtype', 'AST_dtype', VA_dtype);

    % if error from convert_const_dtype
    if AST_dtype == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the parameter declarations

    parm_children = {};
    while true

        [parm_AST, next_pos] = ...
            parse_parameter_declaration(AST_dtype, toks, next_pos, ...
                                        access_arr, uniqID_generator, str_utils);

        % if error from parse_parameter_declaration
        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        parm_children = [parm_children, {parm_AST}];

        % we are now at either a comma or a semicolon
        tok = toks{next_pos};
        success = assert_one_of_the_symbols(tok, {',', ';'}, str_utils);

        % if error from assert_one_of_the_symbols
        if success == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end


        next_pos = next_pos + 1;

        if is_symbol(tok, ';')
            break;
        end

    end
    
    % create the AST and return
    AST = create_parm_stmt_AST(parm_children, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_parameter_declaration(AST_dtype, ...
                                        toks, ...
                                        next_pos, ...
                                        access_arr, ...
                                        uniqID_generator, ...
                                        str_utils)

    % The token at next_pos begins begins a parameter declaration of type 
    % AST_dtype (one of {'int', 'float', 'str'}). This parameter declaration is
    % of the form:
    %    * an "assignment",
    %        - this assignment specifies the name of the parameter on the left
    %        - this assignment will be terminated by either a comma or a 
    %          semicolon or the 'from' keyword or the 'exclude' keyword, 
    %          although this terminator token is NOT considered part of the 
    %          parameter declaration
    %    * followed by zero or more parameter ranges
    %        - see the parse_parameter_range() function below
    %
    % Examples:
    %
    %    c0 = 1p from (0:inf) exclude [20:sqrt(1000)]
    %    s = "hello" exclude "world"
    %    Beta = 0.5*alpha
    %    Type = "NMOS" from '{"NMOS", "PMOS"}
    %    a = -5 from (-100:100) exclude (a+b+c)*3
    %    a = 0
    %    b = 1
    %    
    % We parse such a parameter declaration and return the result as an AST 
    % node of Type 'parm', with 2 attributes:
    %    * 'dtype': the data type of the parameter (a MATLAB string that is
    %      one of {'int', 'float', 'str'}), and
    %    * 'name': the name of the parameter (a MATLAB string)
    %
    % The first child of the above node will be an expression corresponding to 
    % the right hand side of the assignment above. In addition, the node will 
    % have one child of Type 'parm_range' for every parameter range specified 
    % in the declaration.
    org_pos = next_pos;

    % the assignment
    sym_arr = {',', ';'}; kw_arr = {'from', 'exclude'};
    [parm_name, parm_default_expr_AST, next_pos] = ...
        parse_assignment(toks, next_pos, sym_arr, kw_arr, access_arr, ...
                         uniqID_generator, str_utils);

    % if error from parse_assignment
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    tok = toks{next_pos};
    success = assert_one_of_the_symbols_or_keywords(tok, sym_arr, kw_arr, str_utils);

    % if error from assert_one_of_the_symbols_or_keywords
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the zero or more parameter ranges
    parm_range_children = {};
    while true
        
        tok = toks{next_pos};

        if ~is_one_of_the_keywords(tok, {'from', 'exclude'}, str_utils)
            break;
        end

        [parm_range_AST, next_pos] = ...
            parse_parameter_range(toks, next_pos, access_arr, uniqID_generator, str_utils);

        % if error from parse_parameter_range
        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        parm_range_children = [parm_range_children, {parm_range_AST}];

    end

    success = assert_one_of_the_symbols(tok, sym_arr, str_utils);

    % if error from assert_one_of_the_symbols
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % create the AST and return
    AST = create_parm_AST(AST_dtype, parm_name, parm_default_expr_AST, ...
                          parm_range_children, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
                      
    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_parameter_range(toks, ...
                                  next_pos, ...
                                  access_arr, ...
                                  uniqID_generator, ...
                                  str_utils)

    % The token at next_pos begins begins a parameter range of the form:
    %    * the 'from' keyword followed by a parameter interval,
    %        - see the parse_parameter_interval() function below
    %    * [OR] the 'exclude' keyword followed by a parameter interval,
    %    * [OR] the 'exclude' keyword followed by an expression
    %        - this expression will be terminated by either a semicolon, or a 
    %          comma, or the 'from' keyword, or the 'exclude' keyword. However,
    %          this "expression terminator" token is itself NOT considered part 
    %          of the parameter range
    %
    % Examples:
    %
    %    from (0:inf)
    %    exclude [20:sqrt(1000)]
    %    exclude "world"
    %    from '{"NMOS", "PMOS"}
    %    from (-100:100)
    %    exclude (a+b+c)*3
    %    exclude 0
    %    
    % We parse such a parameter range and return the result as an AST node of 
    % Type 'parm_range', with exactly 1 attribute:
    %    * 'Type': this attribute indicates the type of the parameter range (a 
    %      MATLAB string that is one of {'from', 'exclude_value', 
    %      'exclude_interval'})
    %
    % The AST node above will have exactly 1 child, as follows:
    %    * if the 'Type' attribute above is set to 'exclude_value', the child 
    %      will correspond to the expression specified for the excluded value
    %    * otherwise (if the 'Type' attribute is either 'from' or 
    %      'exclude_interval'), the child (of Type 'parm_interval') will 
    %      correspond to the specified parameter interval
    org_pos = next_pos;

    % define a couple of useful things
    sym_arr = {',', ';'}; kw_arr = {'from', 'exclude'};

    % make sure we are at either the 'from' or the 'exclude' keyword
    success = assert_one_of_the_keywords(toks{next_pos}, kw_arr, str_utils);

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % Is this a 'from' range, an 'exclude_value' range, or an 'exclude_interval'
    % range? Detect this and do the needful.
    Type = detect_parm_range_Type(toks, next_pos, str_utils);

    if isempty(Type)
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;
    if str_utils.str_in_arr(Type, {'from', 'exclude_interval'})
        % parse the specified interval
        [child, next_pos] = ...
            parse_parameter_interval(toks, next_pos, access_arr, ...
                                     uniqID_generator, str_utils);
    
    else
        % parse the given expression
        [child, next_pos] = ...
            parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                           access_arr, uniqID_generator, str_utils);

    end

    % if error from parse_and_skip_over_expression or parse_parameter_interval
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    tok = toks{next_pos};
    success = assert_one_of_the_symbols_or_keywords(tok, sym_arr, kw_arr, str_utils);
    
    % if error from assert_one_of_the_symbols_or_keywords
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % create the AST and return
    AST = create_parm_range_AST(Type, child, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = next_pos;

end

function Type = detect_parm_range_Type(toks, next_pos, str_utils)

    % A "parameter range" begins at next_pos. Our job is to detect whether it 
    % is a 'from' range, an 'exclude_value' range, or an 'exclude_interval' 
    % range.

    kw_arr = {'from', 'exclude'};

    tok = toks{next_pos};
    success = assert_one_of_the_keywords(tok, kw_arr, str_utils);

    if success == -1
        Type = '';
        return;
    end

    if is_keyword(tok, 'from')
        Type = 'from';
        return;
    end

    % either 'exclude_value' or 'exclude_interval'
    
    next_pos = next_pos + 1;
    tok2 = toks{next_pos};

    if is_one_of_the_symbols(tok2, {'[', ''''}, str_utils)
        Type = 'exclude_interval';
        return;

    elseif ~is_symbol(tok2, '(')
        Type = 'exclude_value';
        return;

    end

    % we found an open paren after the 'exclude' keyword. This could go one of 
    % two ways: either this open paren begins an open interval (hence this is 
    % an 'exclude_interval' kind of range), or this open paren begins an 
    % expression that just happens to start with an open paren (hence this is 
    % an 'exclude_value' kind of range). Which is it? 
    %
    % Well, we're going to find out by *trying* to skip over an expression 
    % terminated by either a comma, a semicolon, or one of the keywords 
    % {'from', 'exclude'}. If this is indeed an 'exclude_value' kind of range, 
    % we will be able to skip over such an expression successfully. But if this 
    % is an 'exclude_interval' kind of range, then there will be a colon token
    % that will mess things up and raise an exception.
    
    sym_arr = {',', ';'};

    tmp = skip_over_expression(toks, next_pos, sym_arr, kw_arr, str_utils);
    if tmp ~= -1
        Type = 'exclude_value';
    else
        Type = 'exclude_interval';
    end

end

function [AST, new_next_pos] = ...
            parse_parameter_interval(toks, ...
                                     next_pos, ...
                                     access_arr, ...
                                     uniqID_generator, ...
                                     str_utils)

    % The token at next_pos begins begins a parameter interval of the form:
    %    * either a numeric parameter interval
    %        - see the parse_numeric_parameter_interval() function below
    %    * [OR] a string set parameter interval
    %        - see the parse_string_set_parameter_interval() function below
    %
    % Examples:
    %
    %    (0:inf)
    %    [20:sqrt(1000)]
    %    '{"NMOS", "PMOS"}
    %    (-100:100)
    %    (a+b+c)*3
    %
    % We parse such a parameter interval and return the result as an AST node 
    % of Type 'parm_interval', with either 2 or 3 attributes:
    %    * 'Type': this attribute is always present and indicates the type of 
    %      the parameter interval (one of {'numeric', 'string_set'}),
    %    * if the 'Type' attribute above is set to 'numeric', then the returned 
    %      AST node will have 2 additional attributes:
    %        * 'left_side': one of {'open', 'closed'}
    %        * 'right_side': one of {'open', 'closed'}
    %    * on the other hand, if the 'Type' attribute above is set to 
    %      'string_set', then the returned AST node will have only 1 additional 
    %      attribute:
    %        * 'allowed_strs': a cell array of strings
    % In addition, the node above will have either 0 or 2 children, as follows:
    %    * if the 'Type' attribute above is set to 'numeric', then the node 
    %      will have 2 children representing the expressions supplied for the 
    %      minimum and maximum values of the interval (in addition to normal 
    %      expression nodes like those of Type 'op' or 'func', these nodes 
    %      could also be of Type 'inf' to indicate +/- infinity)
    %    * on the other hand, if the 'Type' attribute above is set to 
    %      'string_set', then the node will have no children
    org_pos = next_pos;

    tok = toks{next_pos};

    if is_one_of_the_symbols(tok, {'(', '['}, str_utils)
        parse_func = @parse_numeric_parameter_interval;

    elseif is_symbol(tok, '''')
        parse_func = @parse_string_set_parameter_interval;

    else
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        VAPP_error('Expected one of {"(", "[", "''"}, but did not find it', tok);
        return;
    end

    [AST, new_next_pos] = feval(parse_func, toks, next_pos, access_arr, ...
                                uniqID_generator, str_utils);

    % if error from parse_func
    if new_next_pos == -1
        AST = VAPP_AST_Node.empty;
        return;
    end

    AST_add_range(AST, toks, org_pos, next_pos);
    
end

function [AST, new_next_pos] = ...
            parse_numeric_parameter_interval(toks, ...
                                             next_pos, ...
                                             access_arr, ...
                                             uniqID_generator, ...
                                             str_utils)

    % The token at next_pos begins begins a numeric parameter interval of the 
    % form:
    %    * one of the symbols '(' or '[',
    %    * followed by inf, -inf, +inf, or an expression,
    %    * followed by a colon (':' symbol),
    %    * followed by another inf, -inf, +inf, or expression,
    %    * followed by one of the symbols ')' or ']'
    %
    % Examples:
    %
    %    (0:inf)
    %    [20:sqrt(1000)]
    %    (-100:100)
    %    (-inf:-1)
    %    
    % We parse such a parameter interval and return the result as an AST node 
    % of Type 'parm_interval', with 2 children representing the 2 end points 
    % of the interval (either normal expression nodes like 'op', 'func', etc., 
    % or 'inf' nodes), and 3 attributes:
    %    * 'Type': this attribute will be set to the string 'numeric'
    %    * 'left_side': one of {'open', 'closed'}
    %    * 'right_side': one of {'open', 'closed'}

    org_pos = next_pos;
    
    % one of the symbols '(' or '['
    tok = toks{next_pos};
    if is_symbol(tok, '(')
        left_side = 'open';
    elseif is_symbol(tok, '[')
        left_side = 'closed';
    else
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        VAPP_error('Expected an "(" or "[", but did not find it', tok);
        return;
    end
    next_pos = next_pos + 1;

    % -inf, +inf, inf, or an expression terminated by a colon
    sym_arr = {':'};
    [left_AST, next_pos] = ...
        parse_infty_or_expression(toks, next_pos, sym_arr, access_arr, ...
                                  uniqID_generator, str_utils);

    % the colon
    success = assert_symbol(toks{next_pos}, ':');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % -inf, +inf, inf, or an expression terminated by either ')' or ']'
    sym_arr = {')', ']'};
    [right_AST, next_pos] = ...
        parse_infty_or_expression(toks, next_pos, sym_arr, access_arr, ...
                                  uniqID_generator, str_utils);

    % if error from parse_infty_or_expression
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % one of the symbols ')' or ']'
    tok = toks{next_pos};
    if is_symbol(tok, ')')
        right_side = 'open';
    elseif is_symbol(tok, ']')
        right_side = 'closed';
    else
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        VAPP_error('Expected an ")" or "]", but did not find it', tok);
        return;
    end
    next_pos = next_pos + 1;

    % create the AST and return
    AST = create_numeric_parm_interval_AST(left_side, right_side, ...
                                           left_AST, right_AST, ...
                                           uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = next_pos;

end

function [AST, new_next_pos] = parse_infty_or_expression(toks, ...
                                                         next_pos, ...
                                                         sym_arr, ...
                                                         access_arr, ...
                                                         uniqID_generator, ...
                                                         str_utils)

    % The token at next_pos begins a +/- inf (either the 'inf' keyword, or a 
    % '+' or '-' symbol followed by the 'inf' keyword), or an expression 
    % terminated by one of the symbols in sym_arr. We find out which it is and 
    % return an appropriate AST node.

    org_pos = next_pos;
    
    tok = toks{next_pos};

    if is_keyword(tok, 'inf')
        AST = create_inf_AST('+', uniqID_generator);
        new_next_pos = next_pos + 1;
        return;
    end

    is_plus = is_symbol(tok, '+');
    is_minus = is_symbol(tok, '-');

    if is_plus || is_minus

        Sign = tok.value;
        tok2 = toks{next_pos + 1};

        if is_keyword(tok2, 'inf')
            AST = create_inf_AST(Sign, uniqID_generator);
            new_next_pos = next_pos + 2;
            return;
        end

    end

    % not infty, it's a proper expression

    kw_arr = {};
    [AST, new_next_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);

    if new_next_pos == -1
        AST = VAPP_AST_Node.empty;
        return;
    end

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
end

function [AST, new_next_pos] = ...
            parse_string_set_parameter_interval(toks, ...
                                                next_pos, ...
                                                access_arr, ...
                                                uniqID_generator, ...
                                                str_utils)

    % The token at next_pos begins begins a string set parameter interval of 
    % the form:
    %    * a single quote ("'") symbol,
    %    * followed by an open curly brace ('{') symbol,
    %    * followed by a comma separated list of constant string tokens,
    %    * followed by a close curly brace ('}') symbol
    %
    % Example:
    %
    %    '{"NMOS", "PMOS"}
    %    
    % We parse such a string set parameter interval and return the result as an 
    % AST node of Type 'parm_interval', with 2 attributes:
    %    * 'Type': this attribute will be set to the string 'string_set',
    %    * 'allowed_strs': this will be a cell array of strings representing 
    %      the strings in the set above
    %
    % The returned AST node will have no children.
    org_pos = next_pos;

    % the single quote
    tok = toks{next_pos};
    success = assert_symbol(tok, '''');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the open curly brace
    tok = toks{next_pos};
    success = assert_symbol(tok, '{');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the comma separated list of string tokens
    [allowed_strs, next_pos] = parse_comma_separated_strings(toks, next_pos);

    % if error from parse_comma_separated_strings
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the close curly brace
    tok = toks{next_pos};
    success = assert_symbol(tok, '}');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % create the AST and return
    AST = create_string_set_parm_interval_AST(allowed_strs, uniqID_generator);
    AST_add_range(AST, toks, org_pos, next_pos-1);
    
    new_next_pos = next_pos;

end

function [strs, new_next_pos] = ... 
            parse_comma_separated_strings(toks, next_pos)

    % A comma separated list of strings, i.e., a sequence of the form 
    % {string, comma, string, comma ... string} begins here. We parse this and
    % return the result as a cell array of strings (strs), going as far along 
    % the list of tokens as possible. Note: the list of strings may also be 
    % empty.
    %
    % Example:
    %
    %    "NMOS", "PMOS", "LUMOS", "ROLLING_STONE_GATHERS_NO_MOSS"
    
    tok = toks{next_pos};

    if ~is_string(tok)
        % empty list
        strs = {};
        new_next_pos = next_pos;
        return;
    end

    strs = {tok.value};
    next_pos = next_pos + 1;

    while true

        if next_pos > length(toks) || ~is_symbol(toks{next_pos}, ',')
            break;
        end

        next_pos = next_pos + 1;

        tok = toks{next_pos};
        success = assert_string(tok);

        % if error from assert_string
        if success == -1
            new_next_pos = -1;
            return;
        end

        s = tok.value;
        strs = [strs, {s}];
        next_pos = next_pos + 1;

    end

    new_next_pos = next_pos;

end

function [AST, new_next_pos] = ...
            parse_core_statement_or_block(toks, ...
                                          next_pos, ...
                                          contrib_allowed, ...
                                          access_arr, ...
                                          uniqID_generator, ...
                                          str_utils)

    % A "core statement" or a "core block" begins at next_pos. A "core 
    % statement" is basically any statement that can be used inside the main 
    % section of an analog function or the main (analog) section of a module,
    % subject to constraints imposed by the contrib_allowed input above (see 
    % the parse_core_statement() function below). A "core block" is a block 
    % that consists of only "core statements" and other core blocks (again 
    % subject to contrib_allowed).
    org_pos = next_pos;
    
    tok = toks{next_pos};

    if is_keyword(tok, 'begin')
        parse_func = @parse_core_block;
    else
        parse_func = @parse_core_statement;
    end

    [AST, new_next_pos] = feval(parse_func, toks, next_pos, contrib_allowed, ...
                                access_arr, uniqID_generator, str_utils);
    % if error from parse_func
    if new_next_pos == -1
        AST = VAPP_AST_Node.empty;
        return;
    end

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
    
    % TODO: get rid of the disp() statement below
    % disp(['Processed ', num2str(new_next_pos-1), ' of ', ...
    %       num2str(length(toks)), ' tokens ...']);

end

function [AST, new_next_pos] = parse_core_block(toks, ...
                                                next_pos, ...
                                                contrib_allowed, ...
                                                access_arr, ...
                                                uniqID_generator, ...
                                                str_utils)

    % A "core block" (i.e., a block that consists of only "core statements" and 
    % other core blocks) begins at next_pos. It is of the form:
    %    * the 'begin' keyword,
    %    * OPTIONALLY followed by
    %        * a colon (":"),
    %        * followed by the name of the block (an identifier)
    %    * followed by zero or more core statements or core blocks,
    %    * followed by the 'end' keyword
    %
    % We parse the block above and return the result as an AST node of Type 
    % 'block'. Each core statement/block above between the 'begin' and the 
    % 'end' keywords becomes a child of the returned AST node. Also, the 
    % returned AST node has either 1 or 2 attributes, as follows:
    %    'is_named': 
    %        this attribute is always present. It can be either 'True' or
    %        'False', referring, respectively, to whether the block is named or 
    %        not.
    %    'name':
    %        this attribute exists only if the 'is_named' attribute above is 
    %        set to 'True'. It is a MATLAB string containing the name specified 
    %        for the block.
    org_pos = next_pos;
    
    % the 'begin' keyword
    tok = toks{next_pos};
    success = assert_keyword(tok, 'begin');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the optional name
    tok = toks{next_pos};
    if is_symbol(tok, ':')
        next_pos = next_pos + 1;
        tok = toks{next_pos};
        success = assert_identifier(tok);

        % if error from assert_identifier
        if success == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        is_named = true;
        block_name = tok.value;
        next_pos = next_pos + 1;
    else
        is_named = false;
    end

    % zero or more core statements/blocks
    children = {};
    while true

        tok = toks{next_pos};

        if is_keyword(tok, 'end')
            break;
        end

        [child, next_pos] = parse_core_statement_or_block(toks, next_pos, ...
                                                          contrib_allowed, ...
                                                          access_arr, ...
                                                          uniqID_generator, ...
                                                          str_utils);
        % if error from parse_core_statement_or_block
        if next_pos == -1
            new_next_pos = -1;
            AST = VAPP_AST_Node.empty;
            return;
        end

        children = [children, {child}];

    end

    % the 'end' keyword
        % no need to assert the 'end' keyword explicitly because it's what we 
        % used to break out of the loop above
    next_pos = next_pos + 1;

    % create the AST node and return
    if is_named
        AST = create_named_block_AST(block_name, children, uniqID_generator);
    else
        AST = create_unnamed_block_AST(children, uniqID_generator);
    end
    new_next_pos = next_pos;

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
end

function [AST, new_next_pos] = parse_core_statement(toks, ...
                                                    next_pos, ...
                                                    contrib_allowed, ...
                                                    access_arr, ...
                                                    uniqID_generator, ...
                                                    str_utils)

    % A "core statement" begins at next_pos. It is basically any statement 
    % that can be used inside the main section of an analog function or the 
    % main (analog) section of a module. So, it is one of the following:
    %    * an assignment statement,
    %        - see parse_assignment_statement() below
    %    * [OR] a variable declaration statement,
    %        - see parse_variable_declaration_statement()
    %    * [OR] an if statement,
    %        - see parse_if_statement() below
    %    * [OR] a case statement,
    %        - see parse_case_statement() below
    %    * [OR] a for loop,
    %        - see parse_for_loop() below
    %    * [OR] a repeat loop,
    %        - see parse_repeat_loop() below
    %    * [OR] a while loop,
    %        - see parse_while_loop() below
    %    * [OR] a contribution statement (only if contrib_allowed is true),
    %        - see parse_contribution_statement() below
    %    * [OR] a simulator directive statement
    %        - see parse_simulator_directive_statement() below
    %    * [OR] a event control statement
    %        - see parse_event_control_statement() below
    %
    % Note: if contrib_allowed is false, then contribution statements are not 
    % allowed, i.e., the statement parsed has to be one of the other kinds of
    % statements.
    %
    % In each case, we parse the statement and return the result as an 
    % appropriate AST node.
    org_pos = next_pos;
    
    tok = toks{next_pos};

    if is_identifier(tok)
        tok2 = toks{next_pos + 1};
        if is_symbol(tok2, '=')
            % assignment statement
            [AST, new_next_pos] = ...
                parse_assignment_statement(toks, next_pos, ...
                                           access_arr, ...
                                           uniqID_generator, ...
                                           str_utils);
        else
            % contribution statement
            if ~contrib_allowed
                new_next_pos = -1;
                AST = VAPP_AST_Node.empty;
                VAPP_error('Contribution statements not allowed here', tok);
                return;
            end
            [AST, new_next_pos] = ...
                parse_contribution_statement(toks, next_pos, ...
                                             access_arr, ...
                                             uniqID_generator, str_utils);
        end

    elseif is_one_of_the_keywords(tok, {'integer', 'real', 'string'}, ...
                                  str_utils)
        % variable declaration statement
        [AST, new_next_pos] = ...
            parse_variable_declaration_statement(toks, next_pos, access_arr, ...
                                                 uniqID_generator, str_utils);

    elseif is_keyword(tok, 'if')
        % if statement
        [AST, new_next_pos] = ...
            parse_if_statement(toks, next_pos, contrib_allowed, ...
                               access_arr, uniqID_generator, str_utils);

    elseif is_keyword(tok, 'case')
        % case statement
        [AST, new_next_pos] = ...
            parse_case_statement(toks, next_pos, contrib_allowed, ...
                                 access_arr, uniqID_generator, str_utils);

    elseif is_keyword(tok, 'for')
        % for loop
        [AST, new_next_pos] = ...
            parse_for_loop(toks, next_pos, contrib_allowed, access_arr, ...
                           uniqID_generator, str_utils);

    elseif is_keyword(tok, 'repeat')
        % repeat loop
        [AST, new_next_pos] = ...
            parse_repeat_loop(toks, next_pos, contrib_allowed, ...
                              access_arr, uniqID_generator, str_utils);

    elseif is_keyword(tok, 'while')
        % while loop
        [AST, new_next_pos] = ...
            parse_while_loop(toks, next_pos, contrib_allowed, ...
                             access_arr, uniqID_generator, str_utils);

    elseif is_simulator_directive(tok)
        % simulator directive statement
        [AST, new_next_pos] = ...
            parse_simulator_directive_statement(toks, next_pos, ...
                                                access_arr, ...
                                                uniqID_generator, str_utils);
    elseif is_symbol(tok, '@')
        % if statement
        [AST, new_next_pos] = ...
            parse_event_control_statement(toks, next_pos, contrib_allowed, ...
                                       access_arr, uniqID_generator, str_utils);
    else
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        VAPP_error('Expected a "core" statement, but did not find it', tok);
        return;
    end

    if new_next_pos == -1
        AST = VAPP_AST_Node.empty;
        return;
    end

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
end

function [AST, new_next_pos] = ...
            parse_assignment_statement(toks, ...
                                       next_pos, ...
                                       access_arr, ...
                                       uniqID_generator, ...
                                       str_utils)

    % An assignment statement begins at next_pos. It is of the form:
    %    * an assignment,
    %        - see parse_assignment() below
    %    * followed by a semicolon
    %
    % Example: 
    %
    %    q = c0*v + c1*v1*ln(cosh((v - v0)/v1));
    %
    % We build and return an AST node for this statement, of Type 'assignment', 
    % with two children representing the left and right sides of the assignment 
    % respectively, and with no attributes.

    org_pos = next_pos;
    
    % the assignment
    sym_arr = {';'}; kw_arr = {};
    [var_name, expr_AST, semicolon_pos] = parse_assignment(toks, next_pos, ...
                                                           sym_arr, kw_arr, ...
                                                           access_arr, ...
                                                           uniqID_generator, ...
                                                           str_utils);
    % if error from parse_assignment
    if semicolon_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the semicolon
    success = assert_symbol(toks{semicolon_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = semicolon_pos + 1;

    % create an 'assignment' AST and return
    var_AST = create_var_AST(var_name, uniqID_generator);
    AST = create_assignment_AST(var_AST, expr_AST, uniqID_generator);
    new_next_pos = next_pos;
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [var_name, expr_AST, terminator_pos] = ...
            parse_assignment(toks, ...
                             next_pos, ...
                             sym_arr, ...
                             kw_arr, ...
                             access_arr, ...
                             uniqID_generator, ...
                             str_utils)

    % An "assignment" begins at next_pos. It is of the form:
    %    * a variable name (an identifier),
    %    * followed by an equals sign,
    %    * followed by an expression,
    %    * followed by a "terminator": either one of the symbols in sym_arr or 
    %      one of the keywords in kw_arr
    %        - Note: the terminator is not considered part of the assignment. 
    %          But it is used to figure out where the expression part of the 
    %          assignment ends. So, when this function ends, it returns the 
    %          position in toks where the terminator is found (and hence does 
    %          not "consume" the terminator)
    %
    % Example (where the terminator is a semicolon): 
    %
    %    q = c0*v + c1*v1*ln(cosh((v - v0)/v1));
    %
    % We parse the assignment above, figure out the location of the terminator, 
    % and return both the variable name (as a string) and the parsed expression
    % (as an AST).
    
    org_pos = next_pos;

    % the variable name
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        var_name = '';
        terminator_pos = -1;
        expr_AST = VAPP_AST_Node.empty;
        return;
    end

    var_name = tok.value;
    next_pos = next_pos + 1;

    % the equals sign
    success = assert_symbol(toks{next_pos}, '=');

    % if error from assert_symbol
    if success == -1
        terminator_pos = -1;
        expr_AST = VAPP_AST_Node.empty;
        return;
    end

    next_pos = next_pos + 1;

    % the expression followed by the terminator
    [expr_AST, terminator_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);

    % if error from parse_and_skip_over_expression
    if terminator_pos == -1
        expr_AST = VAPP_AST_Node.empty;
        return;
    end

    tok = toks{terminator_pos};
    success = assert_one_of_the_symbols_or_keywords(tok, sym_arr, kw_arr, str_utils);

    % if error from assert_one_of_the_symbols_or_keywords
    if success == -1
        terminator_pos = -1;
        expr_AST = VAPP_AST_Node.empty;
        return;
    end

    AST_add_range(expr_AST, toks, org_pos, terminator_pos);
end

function [AST, new_next_pos] = parse_if_statement(toks, ...
                                                  next_pos, ...
                                                  contrib_allowed, ...
                                                  access_arr, ...
                                                  uniqID_generator, ...
                                                  str_utils)

    % An if statement begins at next_pos. It is of the form:
    %    * the 'if' keyword,
    %    * followed by an open paren ("(") symbol,
    %    * followed by an expression (the "conditional"),
    %    * followed by a close paren (")") symbol,
    %    * followed by a core statement or block (the "true path")
    %        - subject to contrib_allowed
    %    * OPTIONALLY followed by
    %        * the 'else' keyword,
    %        * followed by a core statement or block (the "false path")
    %            - subject to contrib_allowed
    %
    % Example: 
    %
    %    if (vgfbPD < 0.0) begin
    %        T3 = (vgfbPD - T2) / gammaPD;
    %        psip = -ln(1.0 - T2 + T3*T3);
    %    end else begin
    %        T3 = exp(-T2);
    %        T1 = 0.5 * gammaPD;
    %        T2 = sqrt(vgfbPD - 1.0 + T3 + T1*T1) - T1;
    %        psip = T2*T2 + 1.0 - T3;
    %    end
    %
    % We build and return an AST node for this statement, of Type 'if', with 
    % no attributes, and with either 2 or 3 children. The first child will 
    % correspond to the conditional. The second child will correspond to the 
    % true path. If there is an 'else' part, there will be a third child 
    % corresponding to the false path. If not, there will only be 2 children.
    org_pos = next_pos;

    % the 'if' keyword
    tok = toks{next_pos};
    success = assert_keyword(tok, 'if');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the open paren
    tok = toks{next_pos};
    success = assert_symbol(tok, '(');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the conditional and the close paren following it
    sym_arr = {')'}; kw_arr = {};
    [conditional_expr, close_paren_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);
    %
    % if error from parse_and_skip_over_expression
    if close_paren_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    success = assert_symbol(toks{close_paren_pos}, ')');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = close_paren_pos + 1;

    % the true path
    [true_path, next_pos] = ...
        parse_core_statement_or_block(toks, next_pos, contrib_allowed, ...
                                      access_arr, uniqID_generator, str_utils);
    
    % if error from parse_core_statement_or_block
    if next_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    % the optional false path
    false_path_present = (    next_pos <= length(toks) ...
                           && is_keyword(toks{next_pos}, 'else') );
    
    if false_path_present
        next_pos = next_pos + 1;
        [false_path, next_pos] = ...
            parse_core_statement_or_block(toks, next_pos, contrib_allowed, ...
                                          access_arr, uniqID_generator, str_utils);

        % if error from parse_core_statement_or_block
        if next_pos == -1
            new_next_pos = -1;
            AST = VAPP_AST_Node.empty;
            return;
        end
    end

    % build the AST and return
    if ~false_path_present
        AST = create_if_AST(conditional_expr, true_path, uniqID_generator);
    else
        AST = create_if_AST(conditional_expr, true_path, false_path, ...
                            uniqID_generator);
    end

    new_next_pos = next_pos;
    
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = parse_case_statement(toks, ...
                                                    next_pos, ...
                                                    contrib_allowed, ...
                                                    access_arr, ...
                                                    uniqID_generator, ...
                                                    str_utils)
    
    % A case statement begins at next_pos. It is of the form:
    %    * the 'case' keyword,
    %    * followed by an open paren ("(") symbol,
    %    * followed by an expression (the "case argument"),
    %    * followed by a close paren (")") symbol,
    %    * followed by one or more "case items",
    %        - see parse_case_item() below
    %    * followed by the 'endcase' keyword
    %
    % Example: 
    %
    %    case(rgeo)
    %        1, 2, 5:
    %            begin
    %                if (nuEnd == 0.0)
    %                    Rend = 0.0;
    %                else
    %                    Rend = Rsh * DMCG / (Weffcj * nuEnd);
    %            end
    %        3, 4, 6:
    %            begin
    %                if (nuEnd == 0.0)
    %                    Rend = 0.0;
    %                else
    %                    Rend = Rsh * Weffcj / (3.0 * nuEnd * (DMCG + DMCI));
    %            end
    %        default: 
    %            Rend = 0.0;
    %    endcase
    %
    % We build and return an AST node for this statement, of Type 'case', with 
    % no attributes. The first child of this node will correspond to the case 
    % argument. Thereafter, each child will be of Type 'case_item' and will 
    % correspond to a respective case item (see above). 
    org_pos = next_pos;
    
    % the 'case' keyword
    tok = toks{next_pos};
    success = assert_keyword(tok, 'case');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the open paren
    tok = toks{next_pos};
    success = assert_symbol(tok, '(');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the case argument and the close paren following it
    sym_arr = {')'}; kw_arr = {};
    [case_argument_expr, close_paren_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);

    % if error from parse_and_skip_over_expression
    if close_paren_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    success = assert_symbol(toks{close_paren_pos}, ')');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = close_paren_pos + 1;

    % one or more case items

    case_items_ASTs = {};

    while true

        tok = toks{next_pos};

        if is_keyword(tok, 'endcase')
            break;
        end

        [case_item_AST, next_pos] = ...
            parse_case_item(toks, next_pos, contrib_allowed, ...
                            access_arr, uniqID_generator, str_utils);
        
        % if error from parse_case_item
        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        case_items_ASTs = [case_items_ASTs, {case_item_AST}];

    end

    if isempty(case_items_ASTs)
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        VAPP_error('Case statement has to contain at least one case item', tok);
        return;
    end

    % the 'endcase' keyword
        % no need to check for it explicitly, since this is what we used to get 
        % out of the loop above
    next_pos = next_pos + 1;

    % create the AST and return
    AST = create_case_AST(case_argument_expr, case_items_ASTs, ...
                          uniqID_generator);
    new_next_pos = next_pos;

    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = parse_case_item(toks, ...
                                               next_pos, ...
                                               contrib_allowed, ...
                                               access_arr, ...
                                               uniqID_generator, ...
                                               str_utils)
    
    % A "case item" begins at next_pos. It is of the form:
    %    * a list of "case candidates",
    %        - see parse_case_candidates() below
    %    * followed by a core statement or block (the "case action")
    %
    % Examples: 
    %
    % Example 1
    % ---------
    %
    % 1, 2, 5:
    %     begin
    %         if (nuEnd == 0.0)
    %             Rend = 0.0;
    %         else
    %             Rend = Rsh * DMCG / (Weffcj * nuEnd);
    %     end
    %
    % Example 2
    % ---------
    %
    % default: 
    %     Rend = 0.0;
    %
    % We build and return an AST node for this case item, of Type 'case_item', 
    % with no attributes. The node will have exactly 2 children: the first 
    % child will be of Type 'case_candidates' and will correspond to the case 
    % candidates above. The second child will correspond to the case action 
    % above.
    org_pos = next_pos;
    
    % the case candidates
    [case_candidates_AST, next_pos] = ...
        parse_case_candidates(toks, next_pos, access_arr, ...
                                                 uniqID_generator, str_utils);

    % if error from parse_case_candidates
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end


    % the case action statement/block
    [case_action_AST, next_pos] = ...
        parse_core_statement_or_block(toks, next_pos, contrib_allowed, ...
                                      access_arr, uniqID_generator, str_utils);

    % if error from parse_core_statement_or_block
    if next_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    % build the "case item" AST and return
    AST = create_case_item_AST(case_candidates_AST, case_action_AST, ...
                               uniqID_generator);
    new_next_pos = next_pos;

    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = parse_case_candidates(toks, ...
                                                     next_pos, ...
                                                     access_arr, ...
                                                     uniqID_generator, ...
                                                     str_utils)
    
    % A "list of case candidates" begins at next_pos. It is of the form:
    %    * EITHER
    %        * a comma separated list of expressions,
    %    * OR
    %        * the 'default' keyword
    %    * followed by the colon (":") symbol
    %
    % Examples: 
    %
    %     1, 2, 5:
    %     default: 
    %     sqrt(2), 3.25, 1+x:
    %     2.2, a?b:c?d:e:
    %
    % We build and return an AST node for this case item, of Type 
    % 'case_candidates', with one attribute 'is_default', set to 'True' or 
    % 'False', to indicate, respectively, whether or not this is a "default" 
    % case item. If the 'is_default' attribute is set to 'True', this node will 
    % not have any children. But if it is set to 'False', each expression in 
    % the comma separated list above will be a child of this node.

    % the list of expressions [OR] the 'default' keyword
    
    org_pos = next_pos;

    tok = toks{next_pos};

    if is_keyword(tok, 'default')
        AST = create_default_case_candidates_AST(uniqID_generator);
        next_pos = next_pos + 1;

    else
        [expr_ASTs, next_pos] = ...
            parse_non_default_case_candidates(toks, next_pos, ...
                                              access_arr, ...
                                              uniqID_generator, str_utils);

        % if error from parse_non_default_case_candidates
        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        AST = create_non_default_case_candidates_AST(expr_ASTs, ...
                                                     uniqID_generator);
    
    end
    
    % the colon
    tok = toks{next_pos};
    success = assert_symbol(tok, ':');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    new_next_pos = next_pos;

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
end

function [ASTs, new_next_pos] = ...
            parse_non_default_case_candidates(toks, ...
                                              next_pos, ...
                                              access_arr, ...
                                              uniqID_generator, ...
                                              str_utils)
    
    % A comma separated colon terminated non-empty list of expressions begins 
    % at next_pos. We parse these expressions and return the result as a cell 
    % array of AST nodes, with one AST node per expression. When we are done, 
    % we set new_next_pos to the position of the terminating colon.

    ASTs = {};
    sym_arr = {',', ':'}; kw_arr = {};
    while true
        [AST, comma_or_colon_pos] = ...
            parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                           access_arr, uniqID_generator, str_utils);

        % if error from parse_and_skip_over_expression
        if comma_or_colon_pos == -1
            ASTs = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        ASTs = [ASTs, {AST}];
        success = assert_one_of_the_symbols(toks{comma_or_colon_pos}, sym_arr, str_utils);

        % if error from assert_one_of_the_symbols
        if success == -1
            ASTs = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        next_pos = comma_or_colon_pos + 1;
        if is_symbol(toks{comma_or_colon_pos}, ':')
            break;
        end
    end

    % set new_next_pos to the position of the terminating colon
    new_next_pos = comma_or_colon_pos;

end

function [AST, new_next_pos] = parse_for_loop(toks, ...
                                              next_pos, ...
                                              contrib_allowed, ...
                                              access_arr, ...
                                              uniqID_generator, ...
                                              str_utils)

    % A for loop begins at next_pos. It is of the form:
    %    * the 'for' keyword,
    %    * followed by an open paren,
    %    * followed by an assignment statement,
    %    * followed by an expression terminated by a semicolon,
    %    * followed by an assignment terminated by a close paren,
    %    * followed by a core statement or block (the loop body)
    %        - subject to contrib_allowed
    %
    % Example: 
    %
    %    for (i = 0; i < NF; i = i+1) begin : forloop
    %        T0 = 1.0 / NF / (SA + 0.5*L_mult + i * (SD +L_mult));
    %        T1 = 1.0 / NF / (SB + 0.5*L_mult + i * (SD +L_mult));
    %        Inv_sa = Inv_sa + T0;
    %        Inv_sb = Inv_sb + T1;
    %    end
    %
    % We build and return an AST node for this loop, of Type 'for', with 4 
    % children (the first assignment, the expression, the second assignment, 
    % and the loop body), and with no attributes.
    org_pos = next_pos;

    % the 'for' keyword
    success = assert_keyword(toks{next_pos}, 'for');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the open paren
    success = assert_symbol(toks{next_pos}, '(');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the first assignment
    [assignment_1, next_pos] = ...
        parse_assignment_statement(toks, next_pos, access_arr, ...
                                                 uniqID_generator, str_utils);

    % if error from parse_assignment_statement
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the expression terminated by a semicolon
    sym_arr = {';'}; kw_arr = {};
    [expr, semicolon_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);

    % if error from parse_and_skip_over_expression
    if semicolon_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    success = assert_symbol(toks{semicolon_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = semicolon_pos + 1;

    % the assignment terminated by a close paren
    sym_arr = {')'}; kw_arr = {};
    [var_name, rhs, close_paren_pos] = ...
        parse_assignment(toks, next_pos, sym_arr, kw_arr, access_arr, ...
                         uniqID_generator, str_utils);

    % if errror from parse_assignment
    if close_paren_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    success = assert_symbol(toks{close_paren_pos}, ')');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    lhs = create_var_AST(var_name, uniqID_generator);
    assignment_2 = create_assignment_AST(lhs, rhs, uniqID_generator);
    next_pos = close_paren_pos + 1;

    % the loop body
    [body, next_pos] = parse_core_statement_or_block(toks, next_pos, ...
                                                     contrib_allowed, ...
                                                     access_arr, ...
                                                     uniqID_generator, ...
                                                     str_utils);
    % if error from parse_core_statement_or_block
    if next_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    % create the AST and return
    defn_children = {assignment_1, expr, assignment_2};
    AST = create_for_AST(defn_children, body, uniqID_generator);
    new_next_pos = next_pos;

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
end

function [AST, new_next_pos] = parse_repeat_loop(toks, ...
                                                 next_pos, ...
                                                 contrib_allowed, ...
                                                 access_arr, ...
                                                 uniqID_generator, ...
                                                 str_utils)

    % A repeat loop begins at next_pos. It is of the form:
    %    * the 'repeat' keyword,
    %    * followed by an open paren,
    %    * followed by an expression terminated by a close paren (the repeat
    %      count)
    %    * followed by a core statement or block (the loop body)
    %        - subject to contrib_allowed
    %
    % Example:
    %
    %    repeat (NF + 1 - 1) begin : repeatloop
    %        T0 = 1.0 / NF / (SA + 0.5*L_mult + i * (SD +L_mult));
    %        T1 = 1.0 / NF / (SB + 0.5*L_mult + i * (SD +L_mult));
    %        Inv_sa = Inv_sa + T0;
    %        Inv_sb = Inv_sb + T1;
    %    end
    %
    % We build and return an AST node for this loop, of Type 'repeat', with 2
    % children (the repeat count and the loop body), and with no attributes.
    org_pos = next_pos;

    % the 'repeat' keyword
    success = assert_keyword(toks{next_pos}, 'repeat');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the open paren
    success = assert_symbol(toks{next_pos}, '(');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the expression terminated by a close paren
    sym_arr = {')'}; kw_arr = {};
    [count_expr, close_paren_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);

    % if errror from parse_and_skip_over_expression
    if semicolon_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    success = assert_symbol(toks{close_paren_pos}, ')');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = close_paren_pos + 1;

    % the loop body
    [body, next_pos] = parse_core_statement_or_block(toks, next_pos, ...
                                                     contrib_allowed, ...
                                                     access_arr, ...
                                                     uniqID_generator, ...
                                                     str_utils);

    % if error from parse_core_statement_or_block
    if next_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    % create the AST and return
    AST = create_repeat_AST(count_expr, body, uniqID_generator);
    new_next_pos = next_pos;
    
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = parse_while_loop(toks, ...
                                                next_pos, ...
                                                contrib_allowed, ...
                                                access_arr, ...
                                                uniqID_generator, ...
                                                str_utils)

    % A while loop begins at next_pos. It is of the form:
    %    * the 'while' keyword,
    %    * followed by an open paren,
    %    * followed by an expression terminated by a close paren (the while 
    %      condition)
    %    * followed by a core statement or block (the loop body)
    %        - subject to contrib_allowed
    %
    % Example: 
    %
    %    while (i < NF) begin : whileloop
    %        T0 = 1.0 / NF / (SA + 0.5*L_mult + i * (SD +L_mult));
    %        T1 = 1.0 / NF / (SB + 0.5*L_mult + i * (SD +L_mult));
    %        Inv_sa = Inv_sa + T0;
    %        Inv_sb = Inv_sb + T1;
    %        i = i + 1;
    %    end
    %
    % We build and return an AST node for this loop, of Type 'while', with 2 
    % children (the while condition and the loop body), and with no attributes.
    org_pos = next_pos;

    % the 'while' keyword
    success = assert_keyword(toks{next_pos}, 'while');

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the open paren
    success = assert_symbol(toks{next_pos}, '(');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the expression terminated by a close paren
    sym_arr = {')'}; kw_arr = {};
    [condition, close_paren_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);
    
    % if errror from parse_and_skip_over_expression
    if close_paren_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    success = assert_symbol(toks{close_paren_pos}, ')');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = close_paren_pos + 1;

    % the loop body
    [body, next_pos] = parse_core_statement_or_block(toks, next_pos, ...
                                                     contrib_allowed, ...
                                                     access_arr, ...
                                                     uniqID_generator, ...
                                                     str_utils);

    % if error from parse_core_statement_or_block
    if next_pos == -1
        new_next_pos = -1;
        AST = VAPP_AST_Node.empty;
        return;
    end

    % create the AST and return
    AST = create_while_AST(condition, body, uniqID_generator);
    new_next_pos = next_pos;
    
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = ...
            parse_simulator_directive_statement(toks, ...
                                                next_pos, ...
                                                access_arr, ...
                                                uniqID_generator, ...
                                                str_utils)

    % A simulator directive statement begins at next_pos. It is of the form:
    %    * EITHER a simulator variable OR a simulator function call,
    %        - see parse_sim_variable_or_sim_function_call()
    %    * followed by a semicolon
    %
    % Examples: 
    %
    %    $strobe(x, y, z, "hello", "goodbye");
    %    $finish(0);
    %    $stop;
    %
    % We build and return an AST node for this statement, of Type 'sim_stmt', 
    % with no attributes, and with one child of Type either 'sim_var' or 
    % 'sim_func' representing the simulator action called for above.
    org_pos = next_pos;

    % the simulator variable or function call
    [sim_var_or_sim_func_AST, next_pos] = ...
        parse_sim_variable_or_sim_function_call(toks, next_pos, ...
                                                access_arr, ...
                                                uniqID_generator, str_utils);

    % if error from parse_sim_variable_or_sim_function_call
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the semicolon
    success = assert_symbol(toks{next_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % create and return the AST
    AST = create_sim_stmt_AST(sim_var_or_sim_func_AST, uniqID_generator);
    new_next_pos = next_pos;
    
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = ...
            parse_contribution_statement(toks, ...
                                         next_pos, ...
                                         access_arr, ...
                                         uniqID_generator, ...
                                         str_utils)

    % A contribution statement begins at next_pos. It is of the form:
    %    * an expression that begins with one of the identifiers 
    %      {'V', 'I', 'Pwr'}
    %        - e.g., I(br), V(p, n), I(p, n), Pwr(rth_branch), etc.
    %    * followed by the <+ symbol,
    %    * followed by an expression,
    %    * followed by a semicolon
    %
    % Examples: 
    %
    %    I(d, di) <+ V(d, di) * gdpr;
    %    Pwr(rth_branch) <+ Temp(rth_branch) * gth;
    %
    % We build and return an AST node for this statement, of Type 
    % 'contribution', with two children representing expressions for the left 
    % and right sides of the contribution respectively, and with no attributes.
    org_pos = next_pos;

    % the 'V', 'I', or 'Pwr' identifier
    success = assert_one_of_the_identifiers(toks{next_pos}, access_arr, str_utils);

    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    % the LHS expression followed by the '<+' token
    sym_arr = {'<+'}; kw_arr = {};
    [lhs_AST, contrib_op_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);

    % if errror from parse_and_skip_over_expression
    if contrib_op_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    success = assert_symbol(toks{contrib_op_pos}, '<+');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = contrib_op_pos + 1;

    % the RHS expression followed by the semicolon
    sym_arr = {';'}; kw_arr = {};
    [rhs_AST, semicolon_pos] = ...
        parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                       access_arr, uniqID_generator, str_utils);

    % if errror from parse_and_skip_over_expression
    if semicolon_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    success = assert_symbol(toks{semicolon_pos}, ';');

    % if error from assert_symbol
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = semicolon_pos + 1;

    % build the AST
    AST = create_contribution_AST(lhs_AST, rhs_AST, uniqID_generator);
    new_next_pos = next_pos;
    
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, success] = parse_expression(toks, access_arr, ...
                                           uniqID_generator, str_utils)

    % This function parses an expression from the given sequence of tokens 
    % using a modified version of Djkstra's "Shunting yard algorithm". The
    % result is returned as an AST node.
    
    next_pos = 1; 
    op_stack = {}; expr_stack = {};
    success = 0; % -1 -> regular error, -2 -> stack error

    while next_pos <= length(toks)
        
        tok = toks{next_pos};

        if is_constant(tok)
            const_AST = create_const_AST(tok, uniqID_generator);
            expr_stack = stack_push(const_AST, expr_stack);
            next_pos = next_pos + 1;

        elseif is_keyword(tok) || is_identifier(tok)
            % could be either a variable or a function call
            [var_or_func_AST, next_pos] = ...
                parse_variable_or_function_call(toks, next_pos, access_arr, ...
                                                uniqID_generator, str_utils);
            expr_stack = stack_push(var_or_func_AST, expr_stack);

        elseif is_simulator_directive(tok)
            % simulator directive: could be either a variable or a function call
            [sim_var_or_sim_func_AST, next_pos] = ...
                parse_sim_variable_or_sim_function_call(toks, next_pos, ...
                                                        access_arr, ...
                                                        uniqID_generator, ...
                                                        str_utils);
            expr_stack = stack_push(sim_var_or_sim_func_AST, expr_stack);

        elseif is_symbol(tok, '(')
            op_stack = stack_push('(', op_stack);
            next_pos = next_pos + 1;

        elseif is_symbol(tok, ')')
            [op_stack, expr_stack] = ...
                process_close_paren_in_expression(op_stack, expr_stack, ...
                                                  uniqID_generator, str_utils);
            next_pos = next_pos + 1;

        elseif is_expr_op(tok, str_utils)
            % operator
            if next_pos > 1
                prev_tok = toks{next_pos-1};
            else
                prev_tok = [];
            end
            op = resolve_ariness(tok, prev_tok, str_utils);
            [op_stack, expr_stack] = ...
                process_operator_in_expression(op, op_stack, expr_stack, ...
                                               uniqID_generator, str_utils);

            next_pos = next_pos + 1;

        else
            AST = VAPP_AST_Node.empty;
            success = -1;
            VAPP_error('Unrecognized token while parsing expression', tok);
            return;
        end

        % if error from process_operator_in_expression
        if iscell(op_stack) == false
            AST = VAPP_AST_Node.empty;
            success = -1;
            return;
        end

        % if error from parse_variable_or_function_call or
        % parse_sim_variable_or_sim_function_call
        if next_pos == -1
            AST = VAPP_AST_Node.empty;
            success = -1;
            return;
        end

    end

    while ~isempty(op_stack)
        [op, op_stack] = stack_pop(op_stack);
        expr_stack = apply_op(op, expr_stack, uniqID_generator, str_utils);
    end

    if length(expr_stack) ~= 1
        AST = VAPP_AST_Node.empty;
        success = -2;
        VAPP_error('Expression stack does not contain exactly one item');
        return;
    end

    AST = expr_stack{1};

end

function [AST, terminator_pos] = ...
            parse_and_skip_over_expression(toks, ...
                                           next_pos, ...
                                           sym_arr, ...
                                           kw_arr, ...
                                           access_arr, ...
                                           uniqID_generator, ...
                                           str_utils)

    % An expression begins at next_pos. It is terminated either by one of the 
    % symbols in sym_arr or by one of the keywords in kw_arr. We want to figure 
    % out where exactly this terminating token is, parse the intervening 
    % expression, and return the result as an AST node for the expression, plus
    % the index of the terminating token. Also see skip_over_expression() below.

    org_pos = next_pos;
    
    terminator_pos = skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                          str_utils);

    % if error from skip_over_expression
    if terminator_pos == -1
        AST = VAPP_AST_Node.empty;
        return;
    end

    expr_toks = toks(next_pos:(terminator_pos-1));
    [AST, success] = parse_expression(expr_toks, access_arr, ...
                                      uniqID_generator, str_utils);

    % if error from parse_expression
    if success ~= 0
        if success == -2
            VAPP_error('Expected another expression before token but did not find it', ...
                                                         toks{terminator_pos});
        end
        terminator_pos = -1;
        return;
    end

    AST_add_range(AST, toks, org_pos, terminator_pos-1);
    
end

function new_next_pos = ...
            skip_over_expression(toks, next_pos, sym_arr, kw_arr, str_utils)

    % An expression begins at next_pos. It is terminated either by one of the 
    % symbols in sym_arr or by one of the keywords in kw_arr. We want to figure 
    % out and return the index of this expression terminating token.
    %
    % This is not as simple as just looking for the next occurrence of the 
    % terminating token, because this can also be a token that's legal to use 
    % within an expression. For example, the terminating token may be a colon, 
    % and the expression that occurs before this terminating colon may itself 
    % contain another colon. For example, we might have something like "a?b:c:",
    % where the first colon is part of the expression, and the second colon is 
    % the terminating colon.
    %
    % Restrictions on sym_arr: At this time, sym_arr cannot contain arbitrary 
    % symbols. It has to be a subset of {";", ")", ",", ":", "<+", "]"}. That 
    % is, every symbol in sym_arr must be either a semicolon, a close paren, a 
    % comma, a colon, a contribution symbol, or a close square bracket.
    %
    % Restrictions on kw_arr: At this time, kw_arr cannot contain arbitrary
    % keywords. It has to be a subset of {'from', 'exclude'}. That is, every 
    % keyword in kw_arr must be either 'from' or 'exclude'.

    % verify that sym_arr is a subset of {";", ")", ",", ":", "<+", "]"}
    assert_subset(sym_arr, {';', ')', ',', ':', '<+', ']'}, str_utils);

    % verify that kw_arr is a subset of {'from', 'exclude'}
    assert_subset(kw_arr, {'from', 'exclude'}, str_utils);

    % We're going to start at next_pos. Then, at each iteration, we're going to 
    % jump ahead to a significant symbol or keyword in toks.
    significant_syms = unique([{'(', '?', ')', ':'}, sym_arr]);
    significant_kws = kw_arr;

    stack = {};
    curr_pos = next_pos;

    while true

        curr_pos = skip_to_one_of_the_symbols_or_keywords(significant_syms, ...
                                                          significant_kws, ...
                                                          toks, curr_pos, ...
                                                          str_utils);

        % if error from skip_to_one_of_the_symbols_or_keywords
        if curr_pos == -1
            new_next_pos = -1;
            return;
        end

        tok = toks{curr_pos};

        if is_symbol(tok, '(')
            stack = stack_push('(', stack);

        elseif is_symbol(tok, '?')
            stack = stack_push('?', stack);

        elseif is_symbol(tok, ')')
            if isempty(stack)
                new_next_pos = curr_pos;
                break;
            else
                [top, stack] = stack_pop(stack);
                if top ~= '('
                    new_next_pos = -1;
                    VAPP_error('Mismatched parentheses', tok);
                    return;
                end
            end

        elseif is_symbol(tok, ':')
            if isempty(stack)
                new_next_pos = curr_pos;
                break;
            else
                [top, stack] = stack_pop(stack);
                if top ~= '?'
                    new_next_pos = -1;
                    VAPP_error('Mismatched conditional (?:) operator', tok);
                    return;
                end
            end

        elseif is_symbol(tok, ',')
            if isempty(stack)
                new_next_pos = curr_pos;
                break;
            else
                top = stack_peek(stack);
                if top ~= '('
                    new_next_pos = -1;
                    VAPP_error('Improper use of comma in expression', tok);
                    return;
                end
            end

        else
            % some symbol from sym_arr or keyword from kw_arr that's not legal 
            % in an expression
            if isempty(stack)
                new_next_pos = curr_pos;
                break;
            else
                new_next_pos = -1;
                VAPP_error('Syntax error in expression', tok);
                return;
            end

        end

        curr_pos = curr_pos + 1;

    end

    success = assert_one_of_the_symbols_or_keywords(tok, sym_arr, kw_arr, str_utils);

    % if error from assert_one_of_the_symbols_or_keywords
    if success == -1
        new_next_pos = -1;
        return;
    end
end

function [AST, new_next_pos] = ...
            parse_variable_or_function_call(toks, ...
                                            next_pos, ...
                                            access_arr, ...
                                            uniqID_generator, ...
                                            str_utils)

    % Either a variable or a function call begins at next_pos. We find out 
    % which it is, and then we call the appropriate parsing routine and return 
    % the corresponding AST node.
    org_pos = next_pos;

    % is this a variable or a function call?
    var_or_func = distinguish_var_from_func_call(toks, next_pos);

    % call the appropriate parsing routine
    if strcmp(var_or_func, 'var')
        [AST, new_next_pos] = parse_variable(toks, next_pos, uniqID_generator);

    else
        [AST, new_next_pos] = parse_function_call(toks, next_pos, access_arr,...
                                                  uniqID_generator, str_utils);
    end

    % if error from parse_function_call
    if new_next_pos == -1
        AST = VAPP_AST_Node.empty;
        return;
    end

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
end

function out = distinguish_var_from_func_call(toks, next_pos)
    
    % Either a variable or a function call begins at next_pos. Our job is to 
    % distinguish between the two. To do so, we look at the token immediately 
    % after next_pos. If such a token exists and is equal to the open paren, we 
    % return the string 'func'. Else we return 'var'.
    
    out = 'var';
    if next_pos + 1 <= length(toks) && is_symbol(toks{next_pos+1}, '(')
        out = 'func';
    end

end

function [AST, new_next_pos] = parse_variable(toks, next_pos, uniqID_generator)

    % A variable begins at next_pos. This is just a single identifier token, 
    % and the value of this token is the name of the variable. We create a 
    % 'var' AST node for it, with a single attribute 'name', and return this 
    % node.

    org_pos = next_pos;
    
    % the name of the variable
    tok = toks{next_pos};
    success = assert_identifier(tok);

    % if error from assert_identifier
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    var_name = tok.value;
    next_pos = next_pos + 1;

    % create the AST and return
    AST = create_var_AST(var_name, uniqID_generator);
    new_next_pos = next_pos;

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
end

function [AST, new_next_pos] = parse_function_call(toks, next_pos,...
                                                   access_arr,...
                                                   uniqID_generator,...
                                                   str_utils)

    % A function call begins at next_pos. It is of the form:
    %    * the name of the function (a keyword/identifier),
    %    * followed by
    %        * EITHER an actual argument list (if the function name is not 'V' 
    %          or 'I')
    %            - see parse_actual_args() below
    %        * OR a "V or I argument list" (if the function name is 'V' or 'I')
    %            - see parse_V_or_I_args()
    %
    % Examples:
    %
    %    f()
    %    my_func(2*x, 3*y+4*z, 2.25, "hello")
    %    confusing(f(g(x, y, z), a, b, c), h(f(x, y), g(x, y, z)))
    %    I(<p>)
    %
    % We parse the function call above and return the result as an appropriate 
    % AST node (of Type 'func', 'V', or 'I', as the case may be). If this is a 
    % 'func' node, it will have an attribute called 'name' (containing the name
    % of the function). Otherwise it will have no attributes. And each argument 
    % passed to the function (arbitrary expressions in the case of 'func', and
    % ports/identifiers in the case of 'V' or 'I') will be a child of this node.
    
    org_pos = next_pos;

    % the name of the function
    tok = toks{next_pos};
    if ~is_keyword(tok) && ~is_identifier(tok)
        VAPP_error('Expected a keyword/identifier, but did not find it', tok);
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end
    func_name = tok.value;
    next_pos = next_pos + 1;

    % the arguments
    % NOTE (gokcen): check here if the func_name is one of the access functions
    % defined in the disciplines.vams file.
    % These access functions will be stored in the access_arr argument variable.
    % We will do the following:
    % if func_name is V, I, Pwr, H, B etc.
    % then check if the access function is compatible with the discipline of
    % the nodes (or branch) given as argument.
    if str_utils.str_in_arr(func_name, access_arr)
        % V or I argument list
        [arg_nodes, next_pos] = ...
            parse_access_args(toks, next_pos, uniqID_generator);

    else
        % actual argument list
        [arg_nodes, next_pos] = parse_actual_args(toks, next_pos, ...
                                                  access_arr, ...
                                                  uniqID_generator, str_utils);

    end

    % if error from parse_actual_args or parse_access_args
    if next_pos == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end
    
    % build the AST and return
    if str_utils.str_in_arr(func_name, access_arr)
        AST_func = @create_access_AST;
    else
        AST_func = @create_func_AST;
    end
    AST = feval(AST_func, func_name, arg_nodes, uniqID_generator);
    new_next_pos = next_pos;

    AST_add_range(AST, toks, org_pos, new_next_pos-1);
end

function [ASTs, new_next_pos] = ...
            parse_access_args(toks, next_pos, uniqID_generator)

    % A "V or I argument list" begins at next_pos. It is of the form:
    %    * an open paren ("("),
    %    * followed by a (non-empty) comma separated list of ports and/or 
    %      identifiers,
    %    * followed by a close paren (")")
    %
    % Examples:
    %
    %    (<p>)
    %    (p, n)
    %    (drain, source)
    %
    % We parse the argument list above and return the result as a cell array 
    % of AST nodes, with one AST node per argument.

    % the open paren
    tok = toks{next_pos};
    success = assert_symbol(tok, '(');

    % if error from assert_symbol
    if success == -1
        ASTs = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the non-empty comma separated list of ports/identifiers
    [ASTs, next_pos] = ...
        parse_comma_separated_ports_and_identifiers(toks, next_pos, ...
                                                    uniqID_generator);

    % if error from parse_comma_separated_ports_and_identifiers
    if next_pos == -1
        new_next_pos = -1;
        ASTs = VAPP_AST_Node.empty;
        return;
    end

    % the close paren
    success = assert_symbol(toks{next_pos}, ')');

    % if error from assert_symbol
    if success == -1
        ASTs = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % set new_next_pos and return
    new_next_pos = next_pos;

end

function [ASTs, new_next_pos] = ...
            parse_actual_args(toks, next_pos, access_arr, ...
                              uniqID_generator, str_utils)

    % An actual argument list begins at next_pos. It is of the form:
    %    * an open paren ("("),
    %    * followed by a (possibly empty) comma separated list of expressions,
    %    * followed by a close paren (")")
    %
    % Examples:
    %
    %    ()
    %    (2*x, 3*y+4*z, 2.25, "hello")
    %    (f(g(x, y, z), a, b, c), h(f(x, y), g(x, y, z)))
    %
    % We parse the argument list above and return the result as a cell array 
    % of expression AST nodes, with one AST node per argument.

    % the open paren
    success = assert_symbol(toks{next_pos}, '(');

    % if error from assert_symbol
    if success == -1
        ASTs = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    next_pos = next_pos + 1;

    % the comma separated, close paren terminated expressions

    ASTs = {};

    if is_symbol(toks{next_pos}, ')')
        % empty argument list
        new_next_pos = next_pos + 1;
        return;
    end

    % non-empty argument list

    sym_arr = {',', ')'}; kw_arr = {};
    while true
        [AST, comma_or_close_paren_pos] = ...
            parse_and_skip_over_expression(toks, next_pos, sym_arr, kw_arr, ...
                                           access_arr, uniqID_generator, str_utils);

        % if error from parse_and_skip_over_expression
        if comma_or_close_paren_pos == -1
            ASTs = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        ASTs = [ASTs, {AST}];
        success = assert_one_of_the_symbols(toks{comma_or_close_paren_pos}, sym_arr, str_utils);

        % if error from assert_one_of_the_symbols
        if success == -1
            ASTs = VAPP_AST_Node.empty;
            new_next_pos = -1;
            return;
        end

        next_pos = comma_or_close_paren_pos + 1;
        if is_symbol(toks{comma_or_close_paren_pos}, ')')
            break;
        end
    end

    % set new_next_pos to the position of the terminating colon
    new_next_pos = comma_or_close_paren_pos + 1;

end

function [new_op_stack, new_expr_stack] = ...
            process_close_paren_in_expression(op_stack, ...
                                              expr_stack, ...
                                              uniqID_generator, ...
                                              str_utils)

    while true

        [op, op_stack] = stack_pop(op_stack);

        if strcmp(op, '(')
            break;
        end
        
        expr_stack = apply_op(op, expr_stack, uniqID_generator, str_utils);
    
    end

    new_op_stack = op_stack;
    new_expr_stack = expr_stack;

end

function new_expr_stack = apply_op(op, expr_stack, uniqID_generator, str_utils)

    ariness = get_ariness(op, str_utils);

    % pop "ariness" operands from expr_stack
    children = {};
    for idx = 1:1:ariness
        [expr, expr_stack] = stack_pop(expr_stack);
        children = [{expr}, children];
    end

    % apply op to operands
    expr_AST = create_op_AST(op, children, uniqID_generator);

    % push the result back onto expr_stack
    expr_stack = stack_push(expr_AST, expr_stack);

    % return
    new_expr_stack = expr_stack;

end

function out = is_expr_op(tok, str_utils)

    ops = { '!', '**', '*', '/', '%', '+', '-', '<', '<=', '>', '>=', ...
            '==', '!=', '&&', '||', '?', ':' };

    out = is_one_of_the_symbols(tok, ops, str_utils);

end

function op = resolve_ariness(tok, prev_tok, str_utils)

    op = tok.value;
    
    if ~is_one_of_the_symbols(tok, {'+', '-'}, str_utils)
        return;
    end
    
    if ( isempty(prev_tok) || is_symbol(prev_tok, '(') || ...
         is_expr_op(prev_tok, str_utils) )
        op = ['u', op];
    end

end

function [new_op_stack, new_expr_stack] = ...
            process_operator_in_expression(op, op_stack, expr_stack, ...
                                           uniqID_generator, str_utils)

    if strcmp(op, ':')

        [new_op_stack, new_expr_stack] = ...
            process_colon_in_expression(op_stack, expr_stack, ...
                                        uniqID_generator, str_utils);

        return;

    end

    [op_prec, op_assoc] = get_precedence_and_associativity(op, str_utils);

    % if error from get_precedence_and_associativity
    if op_prec == -1;
        new_op_stack = -1;
        new_expr_stack = -1;
        return;
    end
    
    while true
        
        if isempty(op_stack)
            break;
        end

        top = stack_peek(op_stack);

        if strcmp(top, '(')
            break;
        end

        [top_prec, oof] = get_precedence_and_associativity(top, str_utils);

        % if error from get_precedence_and_associativity
        if top_prec == -1;
            new_op_stack = -1;
            new_expr_stack = -1;
            return;
        end

        if top_prec > op_prec
            % top has *lower* priority than op
            break;
        elseif top_prec == op_prec && strcmp(op_assoc, 'R')
            break;
        end
        
        [oof, op_stack] = stack_pop(op_stack);
        expr_stack = apply_op(top, expr_stack, uniqID_generator, str_utils);

    end

    op_stack = stack_push(op, op_stack);

    new_op_stack = op_stack;
    new_expr_stack = expr_stack;

end

function [new_op_stack, new_expr_stack] = ...
            process_colon_in_expression(op_stack, ...
                                        expr_stack, ...
                                        uniqID_generator, ...
                                        str_utils)

    while true

        [op, op_stack] = stack_pop(op_stack);

        if strcmp(op, '?')
            break;
        end
        
        expr_stack = apply_op(op, expr_stack, uniqID_generator, str_utils);
    
    end

    op_stack = stack_push(':', op_stack);

    new_op_stack = op_stack;
    new_expr_stack = expr_stack;

end

function [prec, assoc] = get_precedence_and_associativity(op, str_utils)

    % Table of precedence and associativity of Verilog-A operators (lower 
    % precedence numbers indicate higher priority):
    %
    %    +------------+---------------+-----------+
    %    | Precedence | Associativity | Operators |
    %    +------------+---------------+-----------+
    %    |          1 | Left          | u+ u- !   |
    %    |          2 | Left          | **        |
    %    |          3 | Left          | * / %     |
    %    |          4 | Left          | + -       |
    %    |          5 | Left          | < <= > >= |
    %    |          6 | Left          | == !=     |
    %    |          7 | Left          | &&        |
    %    |          8 | Left          | ||        |
    %    |          9 | Right         | ? :       |
    %    +------------+---------------+-----------+

    prec_assoc_table = {   ...
                           { 'L', {'u+', 'u-', '!'} }, ...
                           { 'L', {'**'} }, ...
                           { 'L', {'*', '/', '%'} }, ...
                           { 'L', {'+', '-'} }, ...
                           { 'L', {'<', '<=', '>', '>='} }, ...
                           { 'L', {'==', '!='} }, ...
                           { 'L', {'&&'} }, ...
                           { 'L', {'||'} }, ...
                           { 'R', {'?', ':'} }, ...
                       };

    for idx = 1:1:length(prec_assoc_table)
        row = prec_assoc_table{idx};
        ops = row{2};
        if str_utils.str_in_arr(op, ops)
            prec = idx;
            assoc = row{1};
            return;
        end
    end

    prec = -1;
    assoc = -1;
    VAPP_error(sprintf('Operator %s not found in precedence table', op));

end

function out = get_ariness(op, str_utils)

    ariness_table = {   ...
                        { 'u+', 'u-', '!' }, ...
                        { '**', '*', '/', '%', '+', '-', '<', '<=', '>', ...
                          '>=', '==', '!=', '&&', '||' }, ...
                        { '?', ':' }, ...
                    };

    for idx = 1:1:length(ariness_table)
        ops = ariness_table{idx};
        if str_utils.str_in_arr(op, ops)
            out = idx;
            return;
        end
    end

    error(sprintf('Operator %s not found in ariness table', op));

end

function [AST, new_next_pos] = ...
            parse_sim_variable_or_sim_function_call(toks, ...
                                                    next_pos, ...
                                                    access_arr, ...
                                                    uniqID_generator, ...
                                                    str_utils)

    % Either a simulator directive variable or a simulator directive function 
    % call begins at next_pos. We find out which it is, and then we call the 
    % appropriate parsing routine and return the corresponding AST node.
    org_pos = next_pos;

    % is this simulator directive a variable or a function call?
    var_or_func = distinguish_var_from_func_call(toks, next_pos);

    % call the appropriate parsing routine
    if strcmp(var_or_func, 'var')
        [AST, new_next_pos] = parse_sim_variable(toks, next_pos, ...
                                                 uniqID_generator);

    else
        [AST, new_next_pos] = parse_sim_function_call(toks, next_pos, ...
                                                      access_arr, ...
                                                      uniqID_generator, ...
                                                      str_utils);

    end

    % if error from parse_sim_function_call or parse_sim_variable
    if new_next_pos == -1
        AST = VAPP_AST_Node.empty;
        return;
    end

    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = parse_sim_variable(toks, next_pos, ...
                                                  uniqID_generator)

    % A simulator directive variable begins at next_pos. It is of the form: 
    %    * a simulator directive token
    %        - the value of this token is the name of the variable
    %
    % Example:
    %
    %    $temperature
    %
    % We create and return a 'sim_var' AST node representing this variable, 
    % which will have a single attribute 'name', and no children.

    org_pos = next_pos;
    
    % the simulator directive token
    tok = toks{next_pos};
    success = assert_simulator_directive(tok);

    % if error from assert_simulator_directive
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end

    sim_var_name = tok.value;
    next_pos = next_pos + 1;

    % create the AST and return
    AST = create_sim_var_AST(sim_var_name, uniqID_generator);
    new_next_pos = next_pos;
    
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function [AST, new_next_pos] = ...
            parse_sim_function_call(toks, next_pos, access_arr, ...
                                                 uniqID_generator, str_utils)

    % A simulator directive function call begins at next_pos. It is of the form:
    %    * a simulator directive token
    %        - the value of this token is the name of the simulator function
    %    * followed by an actual argument list
    %        - see parse_actual_args()
    %
    % Examples:
    %
    %    $finish(0)
    %    $vt(temp1+temp2)
    %    $strobe(x, y, z, "hello", "goodbye")
    %
    % We parse the simulator function call above and return the result as a 
    % 'sim_func' AST node. This node will have an attribute called 'name' 
    % (containing the name of the simulator function). And each argument passed 
    % to the simulator function will become a child of this node.
    
    org_pos = next_pos;

    % the simulator directive token
    tok = toks{next_pos};
    success = assert_simulator_directive(tok);

    % if error from assert_simulator_directive
    if success == -1
        AST = VAPP_AST_Node.empty;
        new_next_pos = -1;
        return;
    end
    sim_func_name = tok.value;
    next_pos = next_pos + 1;

    % the argument list
    [arg_nodes, next_pos] = parse_actual_args(toks, next_pos, ...
                                              access_arr, ...
                                              uniqID_generator, str_utils);
    
    % build the 'sim_func' AST and return
    AST = create_sim_func_AST(sim_func_name, arg_nodes, uniqID_generator);
    new_next_pos = next_pos;
    
    AST_add_range(AST, toks, org_pos, new_next_pos-1);

end

function new_stack = stack_push(item, stack)
    new_stack = [stack, {item}];
end

function [item, new_stack] = stack_pop(stack)

    if isempty(stack)
        error('Unable to pop: stack is empty');
    end

    item = stack{end};
    new_stack = stack(1:end-1);

end

function item = stack_peek(stack)

    if isempty(stack)
        error('Unable to peek: stack is empty');
    end

    item = stack{end};

end

function AST = create_root_AST(children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('root');
    AST_add_children(AST, children);
    
end

function AST = create_module_AST(module_name, ...
                                 terminal_names, ...
                                 children, ...
                                 uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('module');
    AST.set_attr('name', module_name);
    AST.set_attr('terminals', terminal_names);
    AST_add_children(AST, children);

end

function AST = create_analog_AST(stmt_or_block_child, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('analog');
    AST_add_child(AST, stmt_or_block_child);

end

function AST = create_analog_func_AST(func_name, ...
                                      return_type, ...
                                      children, ...
                                      uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('analog_func');
    AST.set_attr('name', func_name);
    AST.set_attr('return_type', return_type);
    AST_add_children(AST, children);

end

function AST = create_func_AST(func_name, children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('func');
    AST.set_attr('name', func_name);
    AST_add_children(AST, children);

end

function AST = create_access_AST(access_name, children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('access');
    AST.set_attr('name', access_name)
    AST_add_children(AST, children);

end

function AST = create_port_AST(port_name, uniqID_generator)
    
    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('port');
    AST.set_attr('name', port_name);

end

function AST = create_sim_func_AST(sim_func_name, children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('sim_func');
    AST.set_attr('name', sim_func_name);
    AST_add_children(AST, children);

end

function AST = create_sim_stmt_AST(sim_var_or_sim_func_child, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('sim_stmt');
    AST_add_child(AST, sim_var_or_sim_func_child);

end

function AST = create_op_AST(op, children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('op');
    AST_op = get_AST_op_from_op(op);
    AST.set_attr('op', AST_op);
    AST_add_children(AST, children);

end

function AST_op = get_AST_op_from_op(op)

    if strcmp(op, ':')
        AST_op = '?:';
    else
        AST_op = op;
    end

end

function AST = create_const_AST(tok, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('const');
    AST_dtype = convert_const_dtype('tok_Type', 'AST_dtype', tok.Type);
    AST.set_attr('dtype', AST_dtype);
    AST.set_attr('value', tok.value);

end

function AST = create_var_AST(var_name, uniqID_generator)
    
    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('var');
    AST.set_attr('name', var_name);

end

function AST = create_sim_var_AST(sim_var_name, uniqID_generator)
    
    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('sim_var');
    AST.set_attr('name', sim_var_name);

end

function AST = create_unnamed_block_AST(children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('block');
    AST.set_attr('is_named', 'False');
    AST_add_children(AST, children);

end

function AST = create_named_block_AST(name, children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('block');
    AST.set_attr('is_named', 'True');
    AST.set_attr('name', name);
    AST_add_children(AST, children);

end

function AST = create_assignment_AST(var_AST, expr_AST, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('assignment');
    AST_add_child(AST, var_AST);
    AST_add_child(AST, expr_AST);

end

function AST = create_event_control_AST(event_name, event_control_block, ...
                                        uniqID_generator)
% AST = create_event_control_AST
    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('event_control');
    AST.set_attr('name', event_name);
    AST_add_child(AST, event_control_block);
end

function AST = create_if_AST(conditional_expr, true_path, third, fourth)
    
    if nargin == 3
        false_path_present = false;
        uniqID_generator = third;
    else
        false_path_present = true;
        false_path = third;
        uniqID_generator = fourth;
    end

    children = {conditional_expr, true_path};
    if false_path_present
        children = [children, {false_path}];
    end

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('if');
    AST_add_children(AST, children);

end

function AST = create_case_AST(case_argument_child, ...
                               case_items_children, ...
                               uniqID_generator)
    
    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('case');
    AST_add_child(AST, case_argument_child);
    AST_add_children(AST, case_items_children);

end

function AST = create_case_item_AST(case_candidates_child, ...
                                    case_action_child, ...
                                    uniqID_generator)
    
    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('case_item');
    AST_add_child(AST, case_candidates_child);
    AST_add_child(AST, case_action_child);

end

function AST = create_default_case_candidates_AST(uniqID_generator)
    
    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('case_candidates');
    AST.set_attr('is_default', 'True');

end

function AST = ...
            create_non_default_case_candidates_AST(children, uniqID_generator)
    
    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('case_candidates');
    AST.set_attr('is_default', 'False');
    AST_add_children(AST, children);

end

function AST = create_for_AST(defn_children, body_child, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('for');
    AST_add_children(AST, defn_children);
    AST_add_child(AST, body_child);

end

function AST = create_repeat_AST(count_child, body_child, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('repeat');
    AST_add_child(AST, count_child);
    AST_add_child(AST, body_child);

end

function AST = create_while_AST(cond_child, body_child, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('while');
    AST_add_child(AST, cond_child);
    AST_add_child(AST, body_child);

end

function AST = create_contribution_AST(lhs_expr, rhs_expr, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('contribution');
    AST_add_child(AST, lhs_expr);
    AST_add_child(AST, rhs_expr);

end

function AST = create_electrical_AST(terminal_names, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('electrical');
    AST.set_attr('terminals', terminal_names);

end

function AST = create_discipline_AST(discipline, terminal_names, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('discipline');
    AST.set_attr('name', discipline.name);
    AST.set_attr('potential', discipline.potential);
    AST.set_attr('flow', discipline.flow);
    AST.set_attr('terminals', terminal_names);

end

function AST = create_aliasparam_AST(lhs_parm_name, ...
                                     rhs_parm_name, ...
                                     uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('aliasparam');
    AST.set_attr('lhs_parm', lhs_parm_name);
    AST.set_attr('rhs_parm', rhs_parm_name);

end

function AST = create_branch_AST(branch_name, children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('branch');
    AST.set_attr('name', branch_name);
    AST_add_children(AST, children);

end

function AST = create_input_AST(input_names, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('input');
    AST.set_attr('inputs', input_names);

end

function AST = create_output_AST(output_names, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('output');
    AST.set_attr('outputs', output_names);

end

function AST = create_var_decl_stmt_AST(var_decl_children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('var_decl_stmt');
    AST_add_children(AST, var_decl_children);

end

function AST = create_uninitialized_var_decl_AST(AST_dtype, ...
                                                 var_name, ...
                                                 uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('var_decl');
    AST.set_attr('dtype', AST_dtype);
    AST.set_attr('name', var_name);
    AST.set_attr('is_initialized', 'False');

end

function AST = create_initialized_var_decl_AST(AST_dtype, ...
                                               var_name, ...
                                               expr_child, ...
                                               uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('var_decl');
    AST.set_attr('dtype', AST_dtype);
    AST.set_attr('name', var_name);
    AST.set_attr('is_initialized', 'True');
    AST_add_child(AST, expr_child);

end

function AST = create_parm_stmt_AST(parm_children, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('parm_stmt');
    AST_add_children(AST, parm_children);

end

function AST = create_parm_AST(dtype, ...
                               name, ...
                               default_expr_child, ...
                               parm_range_children, ...
                               uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('parm');
    AST.set_attr('dtype', dtype);
    AST.set_attr('name', name);
    AST_add_child(AST, default_expr_child);
    AST_add_children(AST, parm_range_children);

end

function AST = create_parm_range_AST(Type, child, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('parm_range');
    AST.set_attr('Type', Type);
    AST_add_child(AST, child);

end

function AST = create_numeric_parm_interval_AST(left_side, ...
                                                right_side, ...
                                                left_expr, ...
                                                right_expr, ...
                                                uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('parm_interval');
    AST.set_attr('Type', 'numeric');
    AST.set_attr('left_side', left_side);
    AST.set_attr('right_side', right_side);
    AST_add_child(AST, left_expr);
    AST_add_child(AST, right_expr);

end

function AST = create_inf_AST(Sign, uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('inf');
    AST.set_attr('Sign', Sign);

end

function AST = create_string_set_parm_interval_AST(allowed_strs, ...
                                                   uniqID_generator)

    AST = VAPP_AST_Node(uniqID_generator);
    AST.set_type('parm_interval');
    AST.set_attr('Type', 'string_set');
    AST.set_attr('allowed_strs', allowed_strs);

end

function AST_add_child(parent, child)
    child.set_parent(parent);
    parent.add_child(child);
end

function AST_add_children(parent, children)

    for idx = 1:1:length(children)
        child = children{idx};
        AST_add_child(parent, child);
    end

end

function AST_add_range(self, toks, first_pos, last_pos)
    % Add range and file path information for the AST node
    for index = first_pos:last_pos
        self.add_range(toks{index});
    end
    
end

% Some info about AST Nodes
% -------------------------
%
% Whenever you create a node, you should: 
%     1. Set its Type,
%     2. Set its attributes,
%     3. Call the AST_add_child or AST_add_children function above so as to set 
%        the children of this node (if you know the children), and
%     4. Call the AST_add_child or AST_add_children function above to set the 
%        parent of this node (i.e., to join this node to the rest of the AST)
%
% Here are the different kinds of AST nodes, classified by Type:
%
%     * 'root'
%         * this is the top-level node in the AST
%         * its parent is the empty matrix []
%         * it has no attributes
%         * each module defined in the list of tokens will be a child of this
%           node
%
%     * 'module'
%         * this represents a module in the Verilog-A file
%         * I don't know if multiple modules can be defined in the same 
%           Verilog-A file, so I'm just making each module to be a separate AST 
%           node. If the parsing is done right, each module will be a child of
%           the root node.
%         * children: each statement, analog function, and analog section 
%           between the 'module' and the 'endmodule' keywords will be a child 
%           of this node
%         * attributes:
%             * 'name': name of the module, and
%             * 'terminals': names of its terminals (a cell array of strings)
%
%     * 'func'
%         * this node represents function application (e.g., sin, cos, etc., or 
%           user defined functions)
%         * the children of this node represent the arguments of the function
%         * attributes: 
%             * 'name' (e.g., 'sin', 'cos', 'myfunc', etc.)
%
%     * 'V'
%         * this node is a 'voltage' node. It represents a situation where V
%           is used like a function call in an expression or in the left side 
%           of a contribution statement, etc. Note: V can also be used as an 
%           ordinary variable name -- and this node does not cover that.
%         * children: each argument passed to the V function above (which must 
%           be either an identifier or a port) becomes a child of this node. 
%           Identifier arguments become 'var' children and port arguments 
%           become 'port' children.
%         * attributes: None
%
%     * 'I'
%         * this node is a 'current' node. It represents a situation where I
%           is used like a function call in an expression or in the left side 
%           of a contribution statement, etc. Note: I can also be used as an 
%           ordinary variable name -- and this node does not cover that.
%         * children: each argument passed to the I function above (which must 
%           be either an identifier or a port) becomes a child of this node. 
%           Identifier arguments become 'var' children and port arguments 
%           become 'port' children.
%         * attributes: None
%
%     * 'port'
%         * this node represents a port identifier as used in a V/I function 
%           call or in a branch statement (e.g., <p>, <drain>, etc.).
%         * this is a leaf node, i.e., no children
%         * attributes:
%             * 'name': the name of the port, as a MATLAB string (e.g., 'p', 
%               'drain', etc.)
%
%     * 'op'
%         * this node represents operator application (e.g., +, <=, ?:, etc.)
%         * the children of this node represent the operands to which the 
%           operation is applied
%         * attributes: 
%             * 'op' (e.g., '+', '<=', '?:', etc.)
%
%     * 'const'
%         * this node represents a constant (number, string literal, etc.)
%         * this is a leaf node, i.e., no children
%         * attributes: 
%             * 'dtype': one of {'int', 'float', 'str'}, and
%             * 'value': either a MATLAB float or a MATLAB string
%
%     * 'var'
%         * this node represents a variable in the current scope
%         * this is a leaf node, i.e., no children
%         * attributes:
%             * 'name': the name of the variable (a MATLAB string)
%
%     * 'assignment'
%         * this node represents an assignment, such as found in an assignment 
%           statement, a for loop definition, etc.
%         * it has exactly 2 children:
%             * a 'var' node representing the left side of the assignment, and
%             * an expression node (which might be a 'func' node or a 'const' 
%               node or an 'op' node or maybe even another 'var' node, etc.) 
%               representing the right side of the assignment
%         * it has no attributes
%
%     * 'contribution'
%         * this node represents a contribution statement
%         * it has exactly 2 children:
%             * an expression AST node representing the left side of the 
%               contribution statement, and
%             * an expression AST node representing the right side of the 
%               contribution statement
%         * it has no attributes
%
%     * 'electrical'
%         * this node represents an "electrical" statement
%         * this is a leaf node, i.e., no children
%         * attributes:
%             * 'terminals': names of terminals (a cell array of strings)
%
%     * 'aliasparam'
%         * this node represents an "aliasparam" statement
%         * this is a leaf node, i.e., no children
%         * attributes: this node has 2 attributes:
%             * 'lhs_parm': the name of the parameter to the left of the 
%               equals sign in the statement (a MATLAB string)
%             * 'rhs_parm': the name of the parameter to the right of the 
%               equals sign in the statement (a MATLAB string)
%
%     * 'var_decl_stmt'
%         * this node represents a variable declaration statement
%         * children: this node has 1 child (of Type 'var_decl') for each 
%           variable declared in the statement
%         * attributes: None
%
%     * 'var_decl'
%         * this node represents a variable declaration
%         * children: this node has either 0 children or 1 child depending on 
%           whether the variable was initialized when declared. If the 
%           'is_initialized' attribute below is set to 'False', there will be 
%           no children. Otherwise there will be 1 child (which will be an 
%           expression node representing the expression used to initialize the 
%           variable)
%         * attributes: this node has 3 attributes:
%             * 'dtype': one of {'int', 'float', 'str'},
%             * 'name': the name of the variable, and
%             * 'is_initialized': one of {'True', 'False'}
%
%     * 'parm_stmt'
%         * this node represents a parameter statement
%         * children: this node has 1 child (of Type 'parm') for each 
%           parameter declared in the statement
%         * attributes: None
%
%     * 'parm'
%         * this node represents a parameter declaration
%         * children: the first child of this node will be an expression 
%           corresponding to the default value/expression for the parameter 
%           specified in the parameter declaration. In addition, this node will 
%           have one child of Type 'parm_range' for each parameter range 
%           specified in the declaration.
%         * attributes: this node has exactly 2 attributes:
%             * 'dtype': one of {'int', 'float', 'str'}, and
%             * 'name': the name of the parameter, and
%
%     * 'parm_range'
%         * this node represents a parameter range specified as part of a 
%           parameter declaration
%         * children: this node has exactly 1 child, as follows:
%             * if the 'Type' attribute below is set to 'exclude_value', the 
%               child corresponds to the expression specified for the excluded 
%               value
%             * otherwise (if the 'Type' attribute is either 'from' or 
%               'exclude_interval'), the child (of Type 'parm_interval')
%               corresponds to the specified parameter interval
%         * attributes: the node has exactly 1 attribute, as follows:
%             * 'Type': this attribute indicates the type of the parameter 
%               range (a MATLAB string that is one of {'from', 'exclude_value', 
%               'exclude_interval'})
%
%     * 'parm_interval'
%         * this node represents an interval of values specified as part of a 
%           'from' or 'exclude_interval' parameter range (see above)
%         * children: this node has either 0 or 2 children, as follows:
%             * if the 'Type' attribute below is set to 'numeric', then the 
%               node will have 2 children representing the expressions supplied 
%               for the minimum and maximum values of the interval (in addition 
%               to normal expression nodes like those of Type 'op' or 'func', 
%               these nodes could also be of Type 'inf' to indicate 
%               +/- infinity)
%             * on the other hand, if the 'Type' attribute below is set to 
%               'string_set', then the node will have no children
%         * attributes: the node will have either 2 or 3 attributes, as follows:
%             * 'Type': this attribute is always present and indicates the type 
%               of the parameter interval (one of {'numeric', 'string_set'}),
%             * if the 'Type' attribute above is set to 'numeric', then the node 
%               will have 2 additional attributes:
%                 * 'left_side': one of {'open', 'closed'}
%                 * 'right_side': one of {'open', 'closed'}
%             * on the other hand, if the 'Type' attribute above is set to 
%               'string_set', then the node will have only 1 additional 
%               attribute:
%                 * 'allowed_strs': a cell array of strings
%
%     * 'inf'
%         * this node represents infinity
%         * this is a leaf node, i.e., no children
%         * attributes: the node has exactly one attribute as follows:
%             * 'Sign': either '+' or '-' to indicate +/- infinity respectively
%
%     * 'block'
%         * this node represents a block of statements/blocks
%         * children:
%             * Each statement (or block) inside this block is a child of 
%               this node.
%         * attributes: this node has either 1 or 2 attributes, as follows
%             * 'is_named': this attribute is always present. It can be either 
%               'True' or 'False', referring, respectively, to whether the 
%               block is named or not.
%             * 'name': this attribute exists only if the 'is_named' attribute 
%               above is set to 'True'. It is a MATLAB string containing the 
%               name specified for the block.
%
%     * 'if'
%         * this node represents an if statement
%         * children: this node has either 2 or 3 children
%             * first child: the conditional expression
%             * second child: the statement or block corresponding to the true 
%               path of the if condition
%             * third child: the statement or block corresponding to the false
%               path of the if condition, if a false path is present
%         * attributes: None
%
%     * 'case'
%         * this node represents a case statement
%         * children:
%             * the first child represents the case argument (an expression)
%             * subsequent children are of Type 'case_item' and represent, in 
%               order, the case items specified in this statement
%         * attributes: None
%
%     * 'case_item'
%         * this node represents a case item specified as part of a case 
%           statement
%         * children: the node has exactly 2 children
%             * the first child is of type 'case_candidates' and corresponds to 
%               the candidate expressions compared to the case argument
%             * the second child is a statement or block representing the 
%               action to execute if one of the case candidates matches the 
%               case argument
%         * attributes: None
%
%     * 'case_candidates'
%         * this node represents the candidate expressions compared to the case 
%           argument in a case statement
%         * children:
%             * if the 'is_default' parameter below is set to 'True', this node 
%               will have no children
%             * otherwise, each expression in the list of candidate expressions 
%               will be a child of this node
%         * attributes:
%             * 'is_default': one of {'True', 'False'}, to indicate, 
%               respectively, whether or not this node represents the "default" 
%               case
%
%     * 'sim_var'
%         * this node represents a simulator directive variable
%         * this is a leaf node, i.e., no children
%         * attributes:
%             * 'name': the name of the variable (a MATLAB string)
%
%     * 'sim_func'
%         * this node represents a simulator directive function application 
%           (e.g., strobe, vt, simparam, etc.)
%         * the children of this node represent the arguments of the function
%         * attributes: 
%             * 'name' (e.g., 'strobe', 'vt', 'simparam', etc.)
%
%     * 'sim_stmt'
%         * this node represents a simulator directive statement
%           (e.g., "$strobe(x, y, z);", "$finish(0);", "$stop;", etc.)
%         * children: this node has exactly one child, of Type either 
%           'sim_func' or 'sim_var', representing the simulator function call 
%           or simulator variable in the statement
%         * attributes: None
%
%     * 'input'
%         * this node represents an "input" statement
%         * this is a leaf node, i.e., no children
%         * attributes:
%             * 'inputs': the names of the inputs specified in the statement 
%               (a cell array of strings)
%
%     * 'output'
%         * this node represents an "output" statement
%         * this is a leaf node, i.e., no children
%         * attributes:
%             * 'outputs': the names of the outputs specified in the statement 
%               (a cell array of strings)
%
%     * 'analog_func'
%         * this node represents an analog function defined inside a module
%         * children: each statement/block defined between the 'function' and 
%           the 'endfunction' keywords becomes a child of this node.
%         * attributes: this node has 2 attributes:
%             * 'name': the name of the function, and
%             * 'return_type': the return type of this function (either 'int' 
%               or 'float')
%
%     * 'analog'
%         * this node represents an analog section defined inside a module
%         * children: this node has exactly one child, namely, the statement or 
%           block defined after the 'analog' keyword
%         * attributes: None
%
%     * 'branch'
%         * this node represents a branch statement defined inside a module
%         * children: each port or identifier specified as part of the branch 
%           definition becomes a child of this node. Ports become 'port' 
%           children, and identifiers become 'var' children.
%         * attributes: this node has only 1 attribute:
%             * 'name': the name of the branch (a MATLAB string)
%
%     * 'thermal'
%         * this node represents a thermal statement defined inside a module
%         * this is a leaf node, i.e., no children
%         * attributes:
%             * 'terminals': names of the thermal nodes declared in the 
%               statement (a cell array of strings)
%
%     * 'for'
%         * this node represents a for loop of the form:
%             for (<assignment_1>; <expr_1>; <assignment_2>) <stmt_or_block_1>
%         * children: this node has 4 children, as follows:
%             * the first child (of Type 'assignment') represents assignment_1
%             * the second child represents the expression expr_1
%             * the third child (of Type 'assignment') represents assignment_2
%             * the fourth child represents the loop body stmt_or_block_1
%         * attributes: None
%
%     * 'while'
%         * this node represents a while loop
%         * children: this node has 2 children, as follows:
%             * the first child represents the while condition expression
%             * the second child represens the body of the while loop
%         * attributes: None
%
%     * 'repeat'
%         * this node represents a repeat loop
%         * children: this node has 2 children, as follows:
%             * the first child represents the repeat count expression (which
%               specifies how many times the loop should be repeated)
%             * the second child represens the body of the repeat loop
%         * attributes: None

