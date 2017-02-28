classdef IrNodeSimulatorFunction < IrNodeFunction
% IRNODESIMULATORFUNCTION represents a simulator function in Verilog-A

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods
        function obj = IrNodeSimulatorFunction(uniqIdGen, name)
            obj = obj@IrNodeFunction(uniqIdGen);
            if nargin > 1
                obj.name = name;
            end
        end

        function outStr = sprintNumerical(thisSimFunc, sprintAllFlag)

            funcName = ['sim_', thisSimFunc.name, '_vapp'];

            outStr = '';

            % add the first child to the argument list (this is not in the
            % for loop below because we don't want to put a comma before
            % the first argument).
            if thisSimFunc.getNChild() > 0
                childNode = thisSimFunc.getArgumentNode(1);
                if sprintAllFlag == 0
                    outStr = [outStr, sprintAll(childNode)];
                elseif sprintAllFlag == 1
                    outStr = [outStr, sprintAllDdt(childNode)];
                end
            end
            % add all the remaining children to the argument list if any
            for i = 2:thisSimFunc.nChild
                childNode = thisSimFunc.getArgumentNode(i);
                if sprintAllFlag == 0
                    outStr = [outStr, ', ', sprintAll(childNode)];
                elseif sprintAllFlag == 1
                    outStr = [outStr, ', ', sprintAllDdt(childNode)];
                end
            end

            if thisSimFunc.hasName('param_given')
                if thisSimFunc.getNChild() > 1
                    error(['$param_given simulator function can only have',...
                           ' one argument!']);
                end
                outStr = ['''', outStr, '''', ', MOD__'];
            elseif thisSimFunc.hasName('temperature')
                outStr = [outStr, 'MOD__'];
            end

           % if thisSimFunc.hasName('strobe')
           %     outStr = ['[', outStr, ', "###n]"'];
           % end

            outStr = [funcName, '(', outStr, ')'];

            if thisSimFunc.hasName('strobe')
                outStr = [outStr, ';\n'];
            end
        end

        function [headNode, generateSub] = generateDerivative(thisSimFunc, derivObj)
        % GENERATEDERIVATIVE
            headNode = IrNodeNumericalNull(thisSimFunc.uniqIdGen);
            generateSub = false;
        end
    end

end
