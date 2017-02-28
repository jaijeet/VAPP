classdef IrNodeAnalogFunction < IrNodeModule
% IRNODEANALOGFUNCTION represents Verilog-A analog function
%
% This class is derived from IrNodeModule because it has it's own scope for
% variables. This way we can add MsVariable objects to it and use
% IrNodeModule's functionality for initializing them.
%
% See also IRNODEMODULE

% NOTE: Verilog-A's support for multiple outputs is weird.
% See Agilent Technologies Verilog-A Reference Manual Sec. 2-4
% This is to be investigated in future.
    
%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

    properties
        inputList = {};
        outputList = {};
        auxFuncVecC = {};
    end

    methods

        function obj = IrNodeAnalogFunction(uniqIdGen, name)
            obj = obj@IrNodeModule(uniqIdGen);
            if nargin > 1
                obj.name = name;
                % We add the function name as a variable here. This is useful when
                % no output names are given in the VA code. In this case it is
                % assumed that the output has the same name as the function.
                obj.addVar(name, IrNodeConstant(obj.uniqIdGen, 'real', 0));
            end
        end

        % we are redefining the addChild method (inhereted from IrNode) below
        % because of functions like limexp.
        % These functions have to be added to the top module. But there is a
        % chance that they are first encountered in an analog function. Hence,
        % we would like them to be added to the parent of this analog function.
        % The same reasoning would apply if Verilog-A allowed analog function
        % declarations in other analog functions. But it does not.
        function addChild(thisFunc, childNode)
            if childNode.hasType('IrNodeAnalogFunction') == true
                thisFunc.auxFuncVecC = [thisFunc.auxFuncVecC, {childNode}];
            end
            addChild@IrNode(thisFunc, childNode);
        end

        function setParent(thisFunc, parentNode)
            for aFuncNode = thisFunc.auxFuncVecC
                aFuncNode{:}.removeParent();
                thisFunc.removeChild(aFuncNode{:});
                parentNode.addChild(aFuncNode{:});
            end
            thisFunc.auxFuncVecC = {};
            setParent@IrNode(thisFunc, parentNode);
        end

        function setName(thisFunc, name)
            thisFunc.name = name;
        end

        function setInputList(thisFunc, inputList)
            thisFunc.inputList = inputList;
        end

        function setOutputList(thisFunc, outputList)
            thisFunc.outputList = outputList;
        end

        function setFuncMap(thisFunc, funcMap)
            thisFunc.funcMap = funcMap;
        end

        function out = isInput(thisFunc, inputName)
            out = any(strcmp(thisFunc.inputList, inputName));
        end

        function out = isOutput(thisFunc, outputName)
            out = any(strcmp(thisFunc.outputList, outputName));
        end

        function inList = getInputList(thisFunc)
            inList = thisFunc.inputList;
        end

        function outList = getOutputList(thisFunc)
            outList = thisFunc.outputList;
        end

        function out = getNInput(thisFunc)
            out = numel(thisFunc.inputList);
        end

        function out = getNOutput(thisFunc)
            out = numel(thisFunc.outputList);
        end

        function seal(thisFunc)
            if isempty(thisFunc.outputList)
                thisFunc.outputList = {thisFunc.name};
            end
        end

        function [outStr, printSub] = sprintFront(thisFunc)
            outStr = '';
            printSub = false;
        end

        function [outStr] = sprintBack(thisFunc)
            outStr = '';
        end

        function [outStr, printSub] = sprintAnalogFunction(thisFunc)
            printSub = true;

            funcInList = thisFunc.inputList;
            funcOutList = thisFunc.outputList;
            funcName = thisFunc.name;

            %if isempty(funcOutList)
            %    funcOutList = {thisFunc.name};
            %end

            numOut = numel(funcOutList); 

            if numOut == 1
                funcOutStr = funcOutList{1};
            else
                funcOutStr = ['[', cell2str_vapp(funcOutList), ']'];
            end

            funcInStr = cell2str_vapp(funcInList);

            outStr = sprintf('function %s = %s(%s)\n', funcOutStr,...
                                                      funcName,...
                                                      funcInStr);

            outStr = [outStr, thisFunc.sprintInitVars()];
            outStr = [outStr, thisFunc.sprintChildren()];
            outStr = [outStr, 'end\n'];
        end

        function outStr = sprintInitVars(thisFunc)
            varArr = thisFunc.varMap.getValueArr();
            nVar = numel(varArr);
            outStr = '';

            for i=1:nVar
                varObj = varArr{i};
                if varObj.isUsedBeforeInit() == true && ...
                                thisFunc.isInput(varObj.getName) == false 
                    outStr = [outStr, sprintf('%s = 0;\n', varObj.getName())];
                end
            end

            if isempty(outStr) == false
                outStr = ['// initializing variables\n', outStr];
            end

            outStr = thisFunc.sprintfIndent(outStr);
        end

    % end methods
    end
end
