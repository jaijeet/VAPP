classdef IrNode < handle %& matlab.mixin.Heterogeneous & matlab.mixin.Copyable
% IRNODE superclass for the nodes of the intermediate representation tree
%
% Subclasses derived from IrNode have two main functionalities:
%   1. Store information about model objects like IOs, contributions etc.
%   2. Supply an interface to represent the model information contained in this
%   node and its child nodes in printed form, e.g., as MATLAB code.
%
% Subclasses derived from IrNode have their names prefixed with "IrNode"
%
% See also IRVISITOR, IRNODE.SPRINTALL

% NOTE this class has to be derived from matlab.mixin.Heterogeneous.
% Otherwise, we cannot bundle all the sub-classes derived from IrNode into
% a tree because childVec property is a regular array -> not a cell array.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Jan 03, 2017  11:15AM
%==============================================================================

    properties
        childVecC = {}; % IrNode.empty % hold a list of children here
        parent = {};   % pointer to the parent
        nChild = 0;              % number of children
        name = '';
        indentStr = '';          % indent string 
        tabStr = '    ';         % tab string
        indentLevel = 1;
        nodeType = '';
        % The difference between indentStr and tabStr is the following:
        % indentStr is the main property that is used when indenting node
        % outputs, e.g., for printing the ModSpec model. It is by default set
        % to be equal to the tabStr. The reason we have tabStr is the plan to
        % offer this property as a configuration parameter at the user
        % interface. This way one can switch between tabs/spaces and set how
        % wide the spaces should be.
        connectedToModule = false;
        uniqId = 0; % added for Octave compatibility (see note about eq()
                    % for handle objects)
        uniqIdGen = {};
        position;
    end

    methods

        function obj = IrNode(uniqIdGen)
            obj.uniqIdGen = uniqIdGen;
            obj.uniqId = uniqIdGen.generateId();
            obj.indentStr = obj.tabStr;
            obj.nodeType = class(obj);
        end

        function out = hasType(thisNode, irType)
            out = any(strcmp(class(thisNode), irType));
        end

        function nodeType = getType(thisNode)
            nodeType = thisNode.nodeType;
        end

        function setParent(thisNode, parentNode)
            if isempty(thisNode.parent)
                thisNode.parent = parentNode;
                if parentNode.isConnectedToModule() == true
                    thisNode.setConnectedToModule();
                end
            else
                error(['This node has already a parent. ',...
                       'Use removeParent function first to remove it.']);
            end
        end

        function setConnectedToModule(thisNode)
        % SETCONNECTEDTOMODULE
            thisNode.connectedToModule = true;
            for childNode = thisNode.childVecC
                childNode{:}.setConnectedToModule();
            end
        end

        function setDisconnectedFromModule(thisNode)
        % SETDISCONNECTEDFROMMODULE
            thisNode.connectedToModule = false;
            for childNode = thisNode.childVecC
                childNode{:}.setDisconnectedFromModule();
            end
        end

        function out = isConnectedToModule(thisNode)
        % ISCONNECTEDTOMODULE
            out = thisNode.connectedToModule;
        end

        function addChild(thisNode, childNode)
            thisNode.childVecC = [thisNode.childVecC, {childNode}];
            thisNode.nChild = thisNode.nChild + 1;
            childNode.setParent(thisNode);
        end

        function addAsFirstChild(thisNode, childNode)
            thisNode.childVecC = [{childNode}, thisNode.childVecC];
            thisNode.nChild = thisNode.nChild + 1;
            childNode.setParent(thisNode);
        end

        function addChildNoSetParent(thisNode, childNode)
            thisNode.childVecC = [thisNode.childVecC, {childNode}];
            thisNode.nChild = thisNode.nChild + 1;
        end

        function nChild = getNChild(thisNode)
            nChild = thisNode.nChild;
        end

        function childNode = getChild(thisNode, childIdx)
            activeNode = thisNode;
            for idx = childIdx
                childNode = activeNode.childVecC{idx};
                activeNode = childNode;
            end
        end

        function childIdx = getChildIdx(thisNode, childNode)
            childIdx = findIdxOfObjInCellVec(thisNode.childVecC, childNode);
        end

        function removeChild(thisNode, childNode)
            childIdx = thisNode.getChildIdx(childNode);
            thisNode.childVecC(childIdx) = [];
            thisNode.nChild = thisNode.nChild - 1;
        end

        function replaceChild(thisNode, oldChildNode, newChildNode)
            childIdx = thisNode.getChildIdx(oldChildNode);
            oldChildNode.removeParent();
            thisNode.childVecC{childIdx} = newChildNode;
            newChildNode.setParent(thisNode);
        end

        function removeParent(thisNode)
            thisNode.parent = {};
            if thisNode.connectedToModule == true
                thisNode.setDisconnectedFromModule();
            end
        end

        function varObj = addVarToModule(thisNode, varLabel, isDerivative)
        % ADDVARTOMODULE
            if nargin > 2
                varObj = thisNode.parent.addVarToModule(varLabel, isDerivative);
            else
                varObj = thisNode.parent.addVarToModule(varLabel);
            end
        end

        function parentNode = getParent(thisNode)
            parentNode = thisNode.parent;
        end

        function name = getName(thisNode)
            name = thisNode.name;
        end

        function setName(thisNode, name)
            thisNode.name = name;
        end

        function out = hasName(thisNode, name)
            out = any(strcmp(thisNode.name, name));
        end

        function setIndentLevel(thisNode, indentLevel)
            thisNode.indentLevel = indentLevel;
            thisNode.indentStr = repmat(thisNode.tabStr, 1, indentLevel);
        end

        function printSub = fprintAll(thisNode, outFileId)
        % FPRINTALL print an m-code representation of this node to a file
        % See also IRNODE.SPRINTALL
            [outStr, printSub] = thisNode.sprintAll();
            outStr = thisNode.convertDelimiters(outStr);
            fprintf(outFileId, outStr);
        end

        % The methods below are used to generate a printed version of the
        % ModSpec model in form of a MATLAB file.

        function [outStr, printSub] = sprintAll(thisNode)
        % SPRINTALL print the m-code represantation of this node
        % See also IRNODE.SPRINTFRONT IRNODE.SPRINTBACK
        
            % We are going to break the print function of the node into
            % multiple sub-parts. The reason: we want to give greater control
            % to the subclassses.
            [outStr, printSub] = thisNode.sprintFront();
            if printSub == true
                outStr = [outStr, thisNode.sprintChildren()];
            end
            outStr = sprintf([outStr, thisNode.sprintBack()]);
        end

        function outStr = sprintChildren(thisNode)
            outStr = '';
            for i=1:thisNode.nChild
                outStr = [outStr, thisNode.sprintChild(i)];
            end
        end

        function outStr = sprintChild(thisNode, childIdx)
            childNode = thisNode.childVecC{childIdx};
            outStr = thisNode.sprintfIndent(childNode.sprintAll());
        end

        function [outStr, printSub] = sprintFront(thisNode)
        % SPRINTFRONT print the front portion of this node
        % The front portion of this node comes before the printed version of
        % its children and is followed by the back portion after all children's
        % print methods are called. For instance, the IrNodeModule class prints
        % all the information contained in the module and it's children here
        % and prints book keeping/wrap-up related stuff in sprintBack.
        % See also IRNODE.SPRINTBACK
            
            % generic print function
            % This function is intentionally left blank for subclasses to
            % override.
            printSub = true;
            outStr = '';
        end

        function outStr = sprintBack(thisNode)
        % SPRINTBACK print book keeping and wrap-up related parts of the node
        % See also IRNODE.SPRINTFRONT

            % generic print function
            % This function is intentionally left blank
            outStr = '';
        end
        
        function outStr = sprintfIndent(thisNode, inStr)
            % (?-s:.) means treat . as every character but the new line
            outStr = sprintf(inStr); % in case inStr is not formatted
            % TODO: make sure every input to this function is formatted and
            % remove the line above.
            %outStr = regexprep(outStr, '^(?-s:.)*$', [thisNode.indentStr, '$0'], 'lineanchors');
            % this regex is simpler but does the same job: match every
            % character sequence except for newlines and prepend the matched
            % sequence with the indentation string.
            outStr = regexprep(outStr, '([^\n]*)', [thisNode.indentStr, '$1']);
        end

        function setPosition(thisNode, pos)
        % SETPOSITION
            thisNode.position = pos;
        end

        function pos = getPosition(thisNode)
        % GETPOSITION
            pos = thisNode.position;
        end

        function cpNode = copyBare(thisNode)
            classConstructor = str2func(class(thisNode));
            propList = fieldnames(thisNode);
            nProp = numel(propList);
            cpNode = classConstructor(thisNode.uniqIdGen);
            for i = 1:nProp
                propName = propList{i};
                %pAttr = thisNode.findprop(propName);
                %if pAttr.Constant == false
                %    cpNode.(propName) = thisNode.(propName);
                %end
                if strcmp(propName, 'uniqId') == false
                    cpNode.(propName) = thisNode.(propName);
                end

            end

            cpNode.parent = {};
            cpNode.childVecC = {};
            cpNode.nChild = 0;
        end

        function cpNode = copyDeep(thisNode)
            cpNode = thisNode.copyBare();

            for childNode = thisNode.childVecC
                cpNode.addChild(childNode{:}.copyDeep());
            end
        end

        function uniqIdGen = getUniqIdGen(thisModule)
        % GETUNIQIDGEN
            uniqIdGen = thisModule.uniqIdGen;
        end

    end

    methods (Static)
        function outStr = convertDelimiters(inStr)
        % CONVERTDELIMITERS convert symbols used internally by VAPP for
        % commenting etc. to MATLAB's delimiters.
        %
        % VAPP needs internal delimiters because it prints IrNodes recursively.
        % If we use the same delimiters as MATLAB, sprintf calls will convert
        % those delimiters. An example: if we use '%' for comments and want to
        % print a comment like '%% ex nihilo quodlibet', this would work fine
        % in the first level
        %   sprintf('%% ex nihilo quodlibet') -> % ex nihilo quodlibet
        % but
        %   sprintf(sprintf('%% ex nihilo quodlibet') -> % ex nihilo quodlibet)
        % results in an empty string!
        %
        % See also IRNODE.FPRINTALL
        
            % internal to VAPP: use
            % // for comments (%)
            % " for a single quote (')
            % ### for a backslash (\)
            outStr = regexprep(inStr, {'//', '##"', '###'}, ...
                                      {'%%', '''' , '\\\'});
        end

        function out = isModule()
        % ISMODULE
            out = false;
        end

    end

    methods (Sealed)

        function out = eq(thisNode, otherNode)
        % EQ defined for Octave compatibility
            out = (thisNode.uniqId == otherNode.uniqId);
        end

    end

% end classdef
end
