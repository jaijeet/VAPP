function VAPP_lint(AST, output_format)
% This function traverses through the AST and begin to check for poor
% Verilog-A practices

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Xufeng Wang
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================
% VALint check
valint_check(AST);

% VALint result structure
valint_result = valint_make_print_struct(AST, {});

% Print VALint result in certain format
switch output_format
    case 'default'
        valint_print_default(valint_result);
        
    case 'html'
        valint_print_html(valint_result);
        
    otherwise
        
end

end % END of function lint_result

function valint_check(AST)
% this function checks the AST against a set of Verilog-A practice rules
%valint_debug_printinfo(AST);

% Rule book
valint_rules = {
 'valint_rule_parameter_range_needed'   
};

% Check all rules
for this_rule = valint_rules
    feval(this_rule{1},AST);
end

if ~isempty(AST.get_children)
    % if children exists, recursively get each child
    for this_child = AST.get_children
        % for each child
        valint_check(this_child{1});
    end
end

end % END of function valint_check

function valint_result = valint_make_print_struct(AST, valint_result)
% This function turns an AST tree into a special VALint print structure

this_result = AST.get_valint_result;

if ~isempty(this_result)
    % this node has VAlint rule output
    
    for this_cell = this_result    
        % for each VALint msg
        
        for this_pos = AST.get_pos
            % for each file origin
            
            for index = 1:(length(valint_result)+1)
                
                if index == (length(valint_result)+1)
                    % no existing matching file found
                    valint_result{index}=[];
                    valint_result{index}.infile_path = this_pos{1}.infile_path;
                    
                    valint_result{index}.lineno = [];
                    valint_result{index}.linepos = [];
                    valint_result{index}.valint_msg = {};
                end
                
                if strcmp(valint_result{index}.infile_path, this_pos{1}.infile_path)
                    % existing matching file found
                    valint_result{index}.lineno = [valint_result{index}.lineno; this_pos{1}.lineno];
                    valint_result{index}.linepos = [valint_result{index}.linepos; this_pos{1}.linepos];
                    valint_result{index}.valint_msg = {valint_result{index}.valint_msg{:}, this_cell{1}};
                    
                    break;
                end
            end
        end
    end
end

if ~isempty(AST.get_children)
    % if children exists, recursively get each child
    for this_child = AST.get_children
        % for each child
        valint_result = valint_make_print_struct(this_child{1}, valint_result);
    end
end

end % END of valint_make_print_struct

function valint_print_default(valint_result)
% this function traverses the AST and print all the VALint outputs
fprintf('--------------------------------------------------------\n');
fprintf('----------------- VALint results -----------------------\n');
fprintf('--------------------------------------------------------\n');

for this_file = valint_result
    % for VALint msg in each file
    fprintf('FILE: %s\n\n',this_file{1}.infile_path);
    
    lineno = this_file{1}.lineno;
    linepos = this_file{1}.linepos;
    valint_msg = this_file{1}.valint_msg;
    
    for index = 1:size(lineno,1)
        % for each line
        fprintf('[%s] ', valint_msg{index}{2});

        if lineno(index,1) == lineno(index,2)
            % error is on same line
            fprintf('Line %4.0d (%3.0d : %3.0d)>>', lineno(index,1), linepos(index,1), linepos(index,2));
            
        else
            % error is not on same line
            fprintf('Lines %4.0d (%3.0d) : %4.0d (%3.0d)>>', lineno(index,1), linepos(index,1), lineno(index,2), linepos(index,2));
            
        end
        
        fprintf(' %s\n', valint_msg{index}{3});

    end
    
end

end % END of function valint_print

function valint_debug_printinfo(AST)
% print the node information
if ~isempty(AST.get_infile_path)
    s = VAPP_file_to_str(AST.get_infile_path);
end

range = AST.get_range;

fprintf('-----------------------------------------------------------------\n')
fprintf('Node %d: [%s], Type = %s, infile_path = %s\n', AST.get_uniqID, num2str(range), AST.get_type, AST.get_infile_path);
if ~isempty(range)
    fprintf('      Content: "%s"\n\n',s(range(1):range(2)));
end
end
