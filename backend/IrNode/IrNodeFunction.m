classdef IrNodeFunction < IrNodeNumerical
% IRNODEFUNCTION represents a function call on the RHS of an assignment or a
% contribution statement.
% For the class responsible for defining a function in Verilog-A, see the
% IrNodeAnalogFunction class.
%
% See also IrNodeAnalogFunction

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Mon Nov 28, 2016  10:02AM
%==============================================================================

    properties
        VALIDFUNCTIONNAMES ={'abs',...
                            'acos',...
                            'acosh',...
                            'asin',...
                            'asinh',...
                            'atan',...
                            'atanh',...
                            'cos',...
                            'cosh',...
                            'display',...
                            'exp',...
                            'log',...
                            'ln',...
                            'max',...
                            'min',...
                            'pow',...
                            'limexp',...
                            'sign',...
                            'sin',...
                            'sinh',...
                            'sqrt',...
                            'strcmp',...
                            'strcmpi',...
                            'tan',...
                            'tanh',...
                            'floor',...
                            'ceil',...
                            'ddt',...
                            'white_noise',...
                            'flicker_noise',...
                            'ddx',...
                            };
        % NOTE: if you add a new function to the list above, you have to add
        % the derivative function as well. The derivative functions are located
        % at the end of the methods section of this class file.
        %derivMethod = @(varargin)({});
    end

    methods
        function obj = IrNodeFunction(uniqIdGen, name)
            obj = obj@IrNodeNumerical(uniqIdGen);
            obj.indentStr = '';
            if nargin > 1
                obj.name = name;
                %uCaseName = [upper(name(1)), name(2:end)];
                % Octave compatiblity: the function has to actually exist in
                % order for Octave to accept the str2fun call below.
                % pow and limexp are handled as separate 'analog fucntions' in
                % VA.
                %if any(strcmp(name, {'pow', 'limexp'})) == false
                    %obj.derivMethod = str2func(['deriv', uCaseName]);
                %end
            end
        end
        
        function argNode = getArgumentNode(thisFunc, argNum)
            argNode = thisFunc.getChild(argNum);
        end

        function nArg = getNArgument(thisFunc)
            nArg = thisFunc.getNChild();
        end

        function outStr = sprintNumerical(thisFunc, sprintAllFlag)

            funcName = thisFunc.name;
            if strcmp(funcName, 'ddt') == true
                childNode = thisFunc.getArgumentNode(1);
                outStr = childNode.sprintAll();
            else

                funcName = thisFunc.convertFuncName();

                outStr = [funcName, '('];

                % add the first child to the argument list (this is not in the
                % for loop below because we don't want to put a comma before
                % the first argument).
                childNode = thisFunc.getArgumentNode(1);
                if sprintAllFlag == 0
                    outStr = [outStr, sprintAll(childNode)];
                elseif sprintAllFlag == 1
                    outStr = [outStr, sprintAllDdt(childNode)];
                end

                % add all the remaining children to the argument list if any
                for i = 2:thisFunc.nChild
                    childNode = thisFunc.getArgumentNode(i);
                    if sprintAllFlag == 0
                        outStr = [outStr, ', ', sprintAll(childNode)];
                    elseif sprintAllFlag == 1
                        outStr = [outStr, ', ', sprintAllDdt(childNode)];
                    end
                end
                outStr = [outStr, ')'];
            end
        end

        function fTree = copyFSubTree(thisFunction)
            if thisFunction.hasName('ddt')
                if thisFunction.ddtTopNode == true
                    fTree = IrNodeNumericalNull(thisFunction.uniqIdGen);
                else
                    childTree = thisFunction.getArgumentNode(1);
                    fTree = childTree.copyFSubTree();
                end
            else
                fTree = copyFSubTree@IrNodeNumerical(thisFunction);
            end
        end

        function multNode = generateDerivativeSummand(thisFunc, argNum, derivObj)
            multNode = IrNodeOperation(thisFunc.uniqIdGen, '*');
            dFuncNode = thisFunc.generateDerivativeFunction(argNum);

            argNode = thisFunc.getArgumentNode(argNum);
            dArgNode = argNode.generateDerivativeTree(derivObj);
            multNode.addChild(dFuncNode);
            multNode.addChild(dArgNode);
        end

        function dFuncNode = generateDerivativeFunction(thisFunc, argNum)
            
            % The derivatives of elementary functions are computed in this
            % class: their names start with the 'deriv' prefix.
            % limexp is a special case. This function (if used in the model)
            % will be included as an analog function to the main module.
            % if the function is not one of the elementary functions, it must
            % be a user defined function (analog function in VA). In this case,
            % we just create another function and name it accordingly.
            % The actual derivative will be produced as a separate analog
            % function by VAPP.
            if any(strcmp(thisFunc.name, thisFunc.VALIDFUNCTIONNAMES)) == true && ...
                                thisFunc.hasName({'limexp', 'pow'}) == false
                %dFuncNode = thisFunc.derivMethod(thisFunc, argNum);
                switch thisFunc.name
                    case 'abs'   
                        dFuncNode = thisFunc.derivAbs(argNum);
                    case 'acos'
                        dFuncNode = thisFunc.derivAcos(argNum);
                    case 'acosh'
                        dFuncNode = thisFunc.derivAcosh(argNum);
                    case 'asin'
                        dFuncNode = thisFunc.derivAsin(argNum);
                    case 'asinh'
                        dFuncNode = thisFunc.derivAsinh(argNum);
                    case 'atan'
                        dFuncNode = thisFunc.derivAtan(argNum);
                    case 'atanh'
                        dFuncNode = thisFunc.derivAtanh(argNum);
                    case 'cos'
                        dFuncNode = thisFunc.derivCos(argNum);
                    case 'cosh'
                        dFuncNode = thisFunc.derivCosh(argNum);
                    case 'exp'
                        dFuncNode = thisFunc.derivExp(argNum);
                    case 'log'
                        dFuncNode = thisFunc.derivLog(argNum);
                    case 'ln'
                        dFuncNode = thisFunc.derivLn(argNum);
                    case 'max'
                        dFuncNode = thisFunc.derivMax(argNum);
                    case 'min'
                        dFuncNode = thisFunc.derivMin(argNum);
                    case 'lt'
                        dFuncNode = thisFunc.derivLt(argNum);
                    case 'gt'
                        dFuncNode = thisFunc.derivGt(argNum);
                    case 'pow'
                        dFuncNode = thisFunc.derivPow(argNum);
                    case 'sign'
                        dFuncNode = thisFunc.derivSign(argNum);
                    case 'sin'
                        dFuncNode = thisFunc.derivSin(argNum);
                    case 'sinh'
                        dFuncNode = thisFunc.derivSinh(argNum);
                    case 'sqrt'
                        dFuncNode = thisFunc.derivSqrt(argNum);
                    case 'tan'
                        dFuncNode = thisFunc.derivTan(argNum);
                    case 'tanh'
                        dFuncNode = thisFunc.derivTanh(argNum);
                end
            else
                convFuncName = thisFunc.convertFuncName();
                dFuncName = ['d_', convFuncName,...
                    '_d_arg', num2str(argNum), thisFunc.VARSFX];
                dFuncNode = IrNodeFunction(thisFunc.uniqIdGen, dFuncName);
                dFuncNode.copyArgumentsOfOtherFunction(thisFunc);
            end
        end

        function copyArgumentsOfOtherFunction(thisFunc, otherFunc)
            for argNode = otherFunc.childVecC
                cpArgNode = argNode{:}.copyDeep();
                thisFunc.addChild(cpArgNode);
            end
        end

        function dAbs = derivAbs(thisFunc, argNum)
            dAbs = IrNodeFunction(thisFunc.uniqIdGen, 'sign');
            dAbs.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dAcos = derivAcos(thisFunc, argNum)
            % argNum = 1
            % df = -1/sqrt(1 - x^2);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(thisFunc.uniqIdGen, argNodeCp);
            minusNode = IrNodeNumerical.getOneMinusNode(thisFunc.uniqIdGen, expNode);
            sqrtNode = IrNodeNumerical.getSqrtOfNode(thisFunc.uniqIdGen, minusNode);
            divNode = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, sqrtNode);
            dAcos = IrNodeNumerical.getNegativeOfNode(thisFunc.uniqIdGen, divNode);
        end

        function dAcosh = derivAcosh(thisFunc, argNum)
            % df = 1/sqrt(x^2 - 1);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(thisFunc.uniqIdGen, argNodeCp);
            minusNode = IrNodeNumerical.getNodeMinusOne(thisFunc.uniqIdGen, expNode);
            sqrtNode = IrNodeNumerical.getSqrtOfNode(thisFunc.uniqIdGen, minusNode);
            dAcosh = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, sqrtNode);
        end

        function dAsin = derivAsin(thisFunc, argNum)
            % df = 1/sqrt(1 - x^2);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(thisFunc.uniqIdGen, argNodeCp);
            minusNode = IrNodeNumerical.getOneMinusNode(thisFunc.uniqIdGen, expNode);
            sqrtNode = IrNodeNumerical.getSqrtOfNode(thisFunc.uniqIdGen, minusNode);
            dAsin = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, sqrtNode);
        end

        function dAsinh = derivAsinh(thisFunc, argNum)
            % df = 1/sqrt(x^2 + 1);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(thisFunc.uniqIdGen, argNodeCp);
            summNode = IrNodeNumerical.getNodePlusOne(thisFunc.uniqIdGen, expNode);
            sqrtNode = IrNodeNumerical.getSqrtOfNode(thisFunc.uniqIdGen, summNode);
            dAsinh = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, sqrtNode);
        end

        function dAtan = derivAtan(thisFunc, argNum)
            % df = 1/(x^2 + 1);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(thisFunc.uniqIdGen, argNodeCp);
            summNode = IrNodeNumerical.getNodePlusOne(thisFunc.uniqIdGen, expNode);
            dAtan = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, summNode);
        end

        function dAtanh = derivAtanh(thisFunc, argNum)
            % df = -1/(x^2 - 1);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(thisFunc.uniqIdGen, argNodeCp);
            minusNode = IrNodeNumerical.getNodeMinusOne(thisFunc.uniqIdGen, expNode);
            divNode = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, minusNode);
            dAtanh = IrNodeNumerical.getNegativeOfNode(thisFunc.uniqIdGen, divNode);
        end

        function dCos = derivCos(thisFunc, argNum)
            % df = -sin(x)
            sinNode = IrNodeFunction(thisFunc.uniqIdGen, 'sin');
            sinNode.copyArgumentsOfOtherFunction(thisFunc);
            dCos = IrNodeNumerical.getNegativeOfNode(thisFunc.uniqIdGen, sinNode);
        end

        function dCosh = derivCosh(thisFunc, argNum)
            % df = sinh(x);
            sinhNode = IrNodeFunction(thisFunc.uniqIdGen, 'sinh');
            sinhNode.copyArgumentsOfOtherFunction(thisFunc);
            dCosh = sinhNode;
        end

        function dExp = derivExp(thisFunc, argNum)
            dExp = IrNodeFunction(thisFunc.uniqIdGen, 'exp');
            dExp.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dLog = derivLog(thisFunc, argNum)
            % df = 1/(x*ln(10));
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            tenNode = IrNodeNumerical.getConstantNode(thisFunc.uniqIdGen, 10);
            lnNode = IrNodeNumerical.getFunctionOfNode(thisFunc.uniqIdGen, tenNode, 'ln');
            prodNode = IrNodeNumerical.getProductOfNodes(thisFunc.uniqIdGen, argNodeCp, lnNode);
            dLog = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, prodNode);
        end

        function dLn = derivLn(thisFunc, argNum)
            % df = 1/x;
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            dLn = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, argNodeCp);
        end

        function dMax = derivMax(thisFunc, argNum)
            % has two arguments, (x,y)
            % d_arg1
            % if x <= y; out = 0; else; out = 1; end
            % d_arg2
            % if y <= x; out = 0; else; out = 1;
            
            % use gt and lt
            % greater than, less than
            if argNum == 1
                dMax = IrNodeFunction(thisFunc.uniqIdGen, 'gt');
            elseif argNum ==2
                dMax = IrNodeFunction(thisFunc.uniqIdGen, 'lt');
            end
            dMax.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dMin = derivMin(thisFunc, argNum)
            if argNum == 1
                dMin = IrNodeFunction(thisFunc.uniqIdGen, 'lt');
            elseif argNum ==2
                dMin = IrNodeFunction(thisFunc.uniqIdGen, 'gt');
            end
            dMin.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dLt = derivLt(thisFunc, argNum)
            warning('Encountered derivative of ''lt'', setting it to zero!');
            dLt = IrNodeConstant(thisFunc.uniqIdGen, 'real', 0);
        end

        function dGt = derivGt(thisFunc, argNum) 
            warning('Encountered derivative of ''gt'', setting it to zero!');
            dGt = IrNodeConstant(thisFunc.uniqIdGen, 'real', 0);
        end

        %function dPow = derivPow(thisFunc, argNum)
        %    argNode1 = thisFunc.getArgumentNode(1);
        %    argNode2 = thisFunc.getArgumentNode(2);
        %    argNode1Cp = argNode1.copyDeep();

        %    if argNum == 1
        %        argNode2Cp1 = argNode2.copyDeep();
        %        argNode2Cp2 = argNode2.copyDeep();
        %        powNode = IrNodeFunction('pow');
        %        powNode.addChild(argNode1Cp);
        %        powNode.addChild(IrNodeNumerical.getNodeMinusOne(argNode2Cp1));
        %        dPow = IrNodeNumerical.getProductOfNodes(powNode, argNode2Cp2);
        %    elseif argNum == 2
        %        powNode = thisFunc.copyDeep();
        %        lnNode = IrNodeNumerical.getFunctionOfNode(argNode1Cp, 'ln');
        %        dPow = IrNodeNumerical.getProductOfNodes(powNode, lnNode);
        %    end
        %end

        function dSign = derivSign(thisFunc, argNum)
            warning('Encountered derivative of ''sign'', setting it to zero!');
            dSing = IrNodeConstant(thisFunc.uniqIdGen, 'real', 0);
        end

        function dSin = derivSin(thisFunc, argNum)
            dSin = IrNodeFunction(thisFunc.uniqIdGen, 'cos');
            dSin.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dSinh = derivSinh(thisFunc, argNum)
            dSinh = IrNodeFunction(thisFunc.uniqIdGen, 'cosh');
            dSinh.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dSqrt = derivSqrt(thisFunc, argNum)
            % df = 1/(2*sqrt(x))
            sqrtNode = thisFunc.copyDeep();
            twoNode = IrNodeNumerical.getConstantNode(thisFunc.uniqIdGen, 2);
            multNode = IrNodeNumerical.getProductOfNodes(thisFunc.uniqIdGen, twoNode, sqrtNode);
            dSqrt = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, multNode);
        end

        function dTan = derivTan(thisFunc, argNum)
            cosNode = IrNodeFunction(thisFunc.uniqIdGen, 'cos');
            cosNode.copyArgumentsOfOtherFunction(thisFunc);
            squareNode = IrNodeNumerical.getSquareOfNode(thisFunc.uniqIdGen, cosNode);
            dTan = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, squareNode);
        end

        function dTanh = derivTanh(thisFunc, argNum)
            cosNode = IrNodeFunction(thisFunc.uniqIdGen, 'cosh');
            cosNode.copyArgumentsOfOtherFunction(thisFunc);
            squareNode = IrNodeNumerical.getSquareOfNode(thisFunc.uniqIdGen, cosNode);
            dTanh = IrNodeNumerical.getOneOverNode(thisFunc.uniqIdGen, squareNode);
        end

        function dDdt = derivDdt(thisFunc, argNum)

            % this function should never be called
            error('Derivative of ''ddt'' requested!');
        end

        function newFuncName = convertFuncName(thisFunc)
            % add function names that should be overridden by VAPP here
            funcName = thisFunc.name;
            switch funcName
                case 'ln'
                    newFuncName = 'log';
                case 'log'
                    newFuncName = 'log10';
                case {'pow', 'limexp'}
                    newFuncName = [funcName, '_vapp'];
                otherwise
                    newFuncName = funcName;
            end
        end

        function [headNode, generateSub] = generateDerivative(thisFunc, derivObj)
            if thisFunc.hasName('ddt')
                generateSub = true;
                headNode = IrNodeFunction(thisFunc.uniqIdGen, 'ddt');
            else
                generateSub = false; % because we don't want to traverse the arguments
                headNode = IrNodeNumericalNull(thisFunc.uniqIdGen);

                if thisFunc.nChild > 0
                    arg1 = thisFunc.getArgumentNode(1);
                    if arg1.isDependentOnDerivObj(derivObj)
                        multNode = thisFunc.generateDerivativeSummand(1, derivObj);
                        headNode = multNode;
                    end

                    for i = 2:thisFunc.nChild
                        argi = thisFunc.getArgumentNode(i);
                        if argi.isDependentOnDerivObj(derivObj)
                            summNode = IrNodeOperation(thisFunc.uniqIdGen, '+');
                            summNode.addChild(headNode);

                            multNode = thisFunc.generateDerivativeSummand(i, derivObj);
                            summNode.addChild(multNode);

                            headNode = summNode;
                        end
                    end
                end
            end
        end

	% end methods
    end

end
