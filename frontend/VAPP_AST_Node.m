classdef VAPP_AST_Node < handle %& matlab.mixin.Copyable
    % VAPP_AST_Node Abstract syntax tree node
    %
    % ATTENTION: if you are adding a reference to another VAPP_AST_Node object, make
    % sure that it is under attrs. Even in that case the deep copy will only
    % work if the reference is to a child node of this node. If you don't want
    % to follow this rule but still want to be able to deep copy the object,
    % make the appropriate changes in the copyElement method.  
    % NOTE: int this case your "deep copy" might leave the reference to the
    % node which is not a child of this node as it is.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik, A. Gokcen Mahmutoglu, Xufeng Wang
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================
    properties (Access = private)
        uniqID;
        parent;
        children;
        Type;
        attrs;
        
        valint_result;
        pos;
        % "pos" contains the position information of this node. Each cell within "pos" is the node's position associated with a certain file. 
        % self.pos{1}.infile_path: file name and path for this cell 
        % self.pos{1}.range: the range of this node in the file string 
        % self.pos{1}.lineno: the line number of this node in this file 
        % self.pos{1}.linepos: the range of this node within this line
        % 
        % For example, if this node spans 2 files, 'file1.va' and 'file2.va', it shall have the following entries
        % self.pos{1}.infile_path = 'file1.va'; self.pos{1}.range = [13 45];
        % self.pos{1}.lineno = [2 3]; self.pos{1}.linepos = [3 12];
        % self.pos{2}.infile_path = 'file2.va';
        % ......
        % The rule here is that a node may span several files, but within each file, it must be a single, continous block. Meanwhile, a token can only be from a single file.
        %
        % "valint_msg" contains the VALint comment to this node. One node can have multiple VALint comments, with each stored as a cell. 
        % Within each cell, the first string is the rule name, second string is the message type, and the last string is the message.
        % 
        % For example, if this node has one error and one warning
        % self.valint_msg{1} = {'valint_rule_initial_step_forbidden' 'error' 'The use of "initial_step" is forbidden!'}
        % self.valint_msg{2} = {'valint_rule_parameter_range' 'warning' 'Missing parameter range!'}
        
    end

    methods

        % constructor

        function self = VAPP_AST_Node(uniqID_generator)
            if nargin > 0
                self.uniqID = uniqID_generator.get_uniqID();
            end
            self.parent = [];
            self.children = {};
            self.Type = 'None';
            self.attrs = struct();
            self.valint_result = {};
            
            self.pos={};
        end

        % getters
        
        function out = get_uniqID(self)
            out = self.uniqID;
        end
        
        function out = get_parent(self)
            out = self.parent;
        end
        
        function out = get_children(self)
            out = self.children;
        end
        
        function out = get_child(self, child_idx)
            out = self.children{child_idx};
        end

        function out = get_type(self)
            out = self.Type;
        end

        function out = get_attrs(self)
            out = self.attrs;
        end

        function out = get_num_children(self)
            out = numel(self.children);
        end

        function out = get_child_idx(self, child)
            out = 0;
            iter = 1;
            while iter <= self.get_num_children
                if self.children{iter} == child
                    out = iter;
                    break;
                else
                    iter = iter + 1;
                end
            end
        end

        function out = get_child_uid(self, uid)
            % get child with uniqID uid
            out = {};
            for i=1:self.get_num_children()
                child = self.children{i};
                if child.get_uniqID() == uid
                    out = child;
                end
            end
        end

        % setters

        function set_type(self, Type)
            self.Type = Type;
        end

        function set_parent(self, parent)
            self.parent = parent;
        end

        % methods for handling attrs

        function out = get_attr(self, attr)
            out = self.attrs.(attr);
        end

        function set_attr(self, attr, value)
            self.attrs.(attr) = value;
        end

        function del_attr(self, attr)
            self.attrs = rmfield(self.attrs, attr);
        end

        function out = get_attr_names(self)
            out = fieldnames(self.attrs);
        end

        % methods for handling range and infile_path
        
        function out = get_range(self)
            out = self.range;
        end
        
        function out = get_pos(self)
            out = self.pos;
        end
        
        function add_range(self, tok_or_AST)
            % 1. Always keep the maximum and minimum of all token ranges
            % inside the node
            % 2. Check if the infile_path is identical. For now, return an
            % error if infile_path is not identical.
            if isobject(tok_or_AST)
                % AST
                % loop through add_range to add positions from each file
                for this_pos = tok_or_AST.get_pos
                    add_range(self, this_pos{1});
                end
                
            elseif isstruct(tok_or_AST)
                % token
                tok = tok_or_AST;
                
                for index = 1:(length(self.pos)+1)
                    % for each file
                    if index == (length(self.pos)+1) || isempty(self.pos{index})
                        % no existing entry with same filename found
                        % create a new one
                        self.pos{index}.infile_path = tok.infile_path;
                        self.pos{index}.lineno = [];
                        self.pos{index}.linepos = [];
                        self.pos{index}.range = [];
                        
                    end
                    
                    if strcmp(self.pos{index}.infile_path, tok.infile_path)
                        % find an existing entry with same filename
                        
                        %% range
                        min_range = min([self.pos{index}.range tok.range]);
                        max_range = max([self.pos{index}.range tok.range]);
                        
                        self.pos{index}.range = [min_range max_range];
                        
                        %% lineno & linepos
                        [min_lineno, min_index] = min([self.pos{index}.lineno tok.lineno]);
                        [max_lineno, max_index] = max([self.pos{index}.lineno tok.lineno]);
                        linepos = [self.pos{index}.linepos tok.linepos];
                        
                        self.pos{index}.lineno = [min_lineno max_lineno];
                        self.pos{index}.linepos = [linepos(min_index) linepos(max_index)];
                        
                        break
                    end
                    
                end
                
            else
                % unidentified type
                
            end

        end
        
        function out = get_infile_path(self)
            out = self.infile_path;
        end
        
        % VALint results
        
        function out = get_valint_result(self)
            out = self.valint_result;
        end
        
        function add_valint_result(self, valint_rule, valint_msg_type, valint_msg)
            % valint_rule: the specific rule
            % valint_msg: customized message for this rule
            self.valint_result{end+1} = {valint_rule, valint_msg_type, valint_msg};
        end
        
        % core methods

        function add_child(self, child)

            % Note: saying "child.parent = self;" here does not work. Only 
            % changes to self are retained by MATLAB, not changes to child. A
            % workaround is to always remember to call set_parent whenever you 
            % call add_child from the outside (you can write a function to 
            % simplify/automate this).

            % child.parent = self;
            self.children = [self.children, {child}];
            
            self.add_range(child);
        end

        function out = has_type(self, Type)
            % Type can be a cell array. In that case we return true if the type
            % of the node matches any of the strings in the Type input.
            out = any(strcmp(self.Type, Type));
        end

        function out = has_name(self, name)
            out = any(strcmp(self.attrs.name, name));
        end

        function out = has_attr(self, attr, val)
            % val can be a cell array
            if isfield(self.attrs, attr) == false
                out = false;
            elseif nargin > 2
                if ischar(val) || iscell(val)
                    out = any(strcmp(self.attrs.(attr), val));
                else
                    out = any(self.attrs.(attr) == val);
                end
            end
        end

        function name = get_name(self)
            name = self.attrs.name;
        end

        function varargout = get_child_names(self)
            nChild = self.get_num_children();
            if nargout ~= nChild
                error('Number of outputs does not match the number of children!');
            else
                for i=1:nChild
                    varargout{i} = self.children{i}.get_attr('name');
                end
            end

        end

        function set_children(self, childArr)
            self.children = childArr;
        end

    % end methods
    end

end

