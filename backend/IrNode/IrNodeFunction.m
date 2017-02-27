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
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

    properties (Constant)
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
                            }
        % NOTE: if you add a new function to the list above, you have to add
        % the derivative function as well. The derivative functions are located
        % at the end of the methods section of this class file.
    end

    properties
        derivMethod = @(varargin)(IrNodeFunction.empty);
    end

    methods
        function obj = IrNodeFunction(name)
            obj = obj@IrNodeNumerical();
            obj.name = name;
            obj.indentStr = '';
            uCaseName = [upper(name(1)), name(2:end)];
            obj.derivMethod = str2func(['deriv', uCaseName]);
        end
        
        function argNode = getArgumentNode(thisFunc, argNum)
            argNode = thisFunc.getChild(argNum);
        end

        function nArg = getNArgument(thisFunc)
            nArg = thisFunc.getNChild();
        end

        function outStr = sprintNumerical(thisFunc, sprintAllFunc)

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
                outStr = [outStr, sprintAllFunc(childNode)];
                % add all the remaining children to the argument list if any
                for i = 2:thisFunc.nChild
                    childNode = thisFunc.getArgumentNode(i);
                    outStr = [outStr, ', ', sprintAllFunc(childNode)];
                end
                outStr = [outStr, ')'];
            end
        end

        function fTree = copyFSubTree(thisFunction)
            if thisFunction.hasName('ddt')
                if thisFunction.ddtTopNode == true
                    fTree = IrNodeNumericalNull();
                else
                    childTree = thisFunction.getArgumentNode(1);
                    fTree = childTree.copyFSubTree();
                end
            else
                fTree = copyFSubTree@IrNodeNumerical(thisFunction);
            end
        end

        function multNode = generateDerivativeSummand(thisFunc, argNum, derivObj)
            multNode = IrNodeOperation('*');
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
                dFuncNode = thisFunc.derivMethod(thisFunc, argNum);
            else
                convFuncName = thisFunc.convertFuncName();
                dFuncName = ['d_', convFuncName,...
                    '_d_arg', num2str(argNum), thisFunc.VARSFX];
                dFuncNode = IrNodeFunction(dFuncName);
                dFuncNode.copyArgumentsOfOtherFunction(thisFunc);
            end
        end

        function copyArgumentsOfOtherFunction(thisFunc, otherFunc)
            for argNode = otherFunc.childVec
                cpArgNode = argNode.copyDeep();
                thisFunc.addChild(cpArgNode);
            end
        end

        function dAbs = derivAbs(thisFunc, argNum)
            dAbs = IrNodeFunction('sign');
            dAbs.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dAcos = derivAcos(thisFunc, argNum)
            % argNum = 1
            % df = -1/sqrt(1 - x^2);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(argNodeCp);
            minusNode = IrNodeNumerical.getOneMinusNode(expNode);
            sqrtNode = IrNodeNumerical.getSqrtOfNode(minusNode);
            divNode = IrNodeNumerical.getOneOverNode(sqrtNode);
            dAcos = IrNodeNumerical.getNegativeOfNode(divNode);
        end

        function dAcosh = derivAcosh(thisFunc, argNum)
            % df = 1/sqrt(x^2 - 1);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(argNodeCp);
            minusNode = IrNodeNumerical.getNodeMinusOne(expNode);
            sqrtNode = IrNodeNumerical.getSqrtOfNode(minusNode);
            dAcosh = IrNodeNumerical.getOneOverNode(sqrtNode);
        end

        function dAsin = derivAsin(thisFunc, argNum)
            % df = 1/sqrt(1 - x^2);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(argNodeCp);
            minusNode = IrNodeNumerical.getOneMinusNode(expNode);
            sqrtNode = IrNodeNumerical.getSqrtOfNode(minusNode);
            dAsin = IrNodeNumerical.getOneOverNode(sqrtNode);
        end

        function dAsinh = derivAsinh(thisFunc, argNum)
            % df = 1/sqrt(x^2 + 1);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(argNodeCp);
            summNode = IrNodeNumerical.getNodePlusOne(expNode);
            sqrtNode = IrNodeNumerical.getSqrtOfNode(summNode);
            dAsinh = IrNodeNumerical.getOneOverNode(sqrtNode);
        end

        function dAtan = derivAtan(thisFunc, argNum)
            % df = 1/(x^2 + 1);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(argNodeCp);
            summNode = IrNodeNumerical.getNodePlusOne(expNode);
            dAtan = IrNodeNumerical.getOneOverNode(summNode);
        end

        function dAtanh = derivAtanh(thisFunc, argNum)
            % df = -1/(x^2 - 1);
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            expNode = IrNodeNumerical.getSquareOfNode(argNodeCp);
            minusNode = IrNodeNumerical.getNodeMinusOne(expNode);
            divNode = IrNodeNumerical.getOneOverNode(minusNode);
            dAtanh = IrNodeNumerical.getNegativeOfNode(divNode);
        end

        function dCos = derivCos(thisFunc, argNum)
            % df = -sin(x)
            sinNode = IrNodeFunction('sin');
            sinNode.copyArgumentsOfOtherFunction(thisFunc);
            dCos = IrNodeNumerical.getNegativeOfNode(sinNode);
        end

        function dCosh = derivCosh(thisFunc, argNum)
            % df = sinh(x);
            sinhNode = IrNodeFunction('sinh');
            sinhNode.copyArgumentsOfOtherFunction(thisFunc);
            dCosh = sinhNode;
        end

        function dExp = derivExp(thisFunc, argNum)
            dExp = IrNodeFunction('exp');
            dExp.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dLog = derivLog(thisFunc, argNum)
            % df = 1/(x*ln(10));
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            tenNode = IrNodeNumerical.getConstantNode(10);
            lnNode = IrNodeNumerical.getFunctionOfNode(tenNode, 'ln');
            prodNode = IrNodeNumerical.getProductOfNodes(argNodeCp, lnNode);
            dLog = IrNodeNumerical.getOneOverNode(prodNode);
        end

        function dLn = derivLn(thisFunc, argNum)
            % df = 1/x;
            argNode = thisFunc.getArgumentNode(argNum);
            argNodeCp = argNode.copyDeep();
            dLn = IrNodeNumerical.getOneOverNode(argNodeCp);
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
                dMax = IrNodeFunction('gt');
            elseif argNum ==2
                dMax = IrNodeFunction('lt');
            end
            dMax.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dMin = derivMin(thisFunc, argNum)
            if argNum == 1
                dMin = IrNodeFunction('lt');
            elseif argNum ==2
                dMin = IrNodeFunction('gt');
            end
            dMin.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dLt = derivLt(thisFunc, argNum)
            warning('Encountered derivative of ''lt'', setting it to zero!');
            dLt = IrNodeConstant('real', 0);
        end

        function dGt = derivGt(thisFunc, argNum) 
            warning('Encountered derivative of ''gt'', setting it to zero!');
            dGt = IrNodeConstant('real', 0);
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
            dSing = IrNodeConstant('real', 0);
        end

        function dSin = derivSin(thisFunc, argNum)
            dSin = IrNodeFunction('cos');
            dSin.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dSinh = derivSinh(thisFunc, argNum)
            dSinh = IrNodeFunction('cosh');
            dSinh.copyArgumentsOfOtherFunction(thisFunc);
        end

        function dSqrt = derivSqrt(thisFunc, argNum)
            % df = 1/(2*sqrt(x))
            sqrtNode = thisFunc.copyDeep();
            twoNode = IrNodeNumerical.getConstantNode(2);
            multNode = IrNodeNumerical.getProductOfNodes(twoNode, sqrtNode);
            dSqrt = IrNodeNumerical.getOneOverNode(multNode);
        end

        function dTan = derivTan(thisFunc, argNum)
            cosNode = IrNodeFunction('cos');
            cosNode.copyArgumentsOfOtherFunction(thisFunc);
            squareNode = IrNodeNumerical.getSquareOfNode(cosNode);
            dTan = IrNodeNumerical.getOneOverNode(squareNode);
        end

        function dTanh = derivTanh(thisFunc, argNum)
            cosNode = IrNodeFunction('cosh');
            cosNode.copyArgumentsOfOtherFunction(thisFunc);
            squareNode = IrNodeNumerical.getSquareOfNode(cosNode);
            dTanh = IrNodeNumerical.getOneOverNode(squareNode);
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

	% end methods
    end

    methods (Access = protected)

        function [headNode, generateSub] = generateDerivative(thisFunc, derivObj)
            if thisFunc.hasName('ddt')
                generateSub = true;
                headNode = IrNodeFunction('ddt');
            else
                generateSub = false; % because we don't want to traverse the arguments
                headNode = IrNodeNumericalNull();

                if thisFunc.nChild > 0
                    arg1 = thisFunc.getArgumentNode(1);
                    if arg1.isDependentOnDerivObj(derivObj)
                        multNode = thisFunc.generateDerivativeSummand(1, derivObj);
                        headNode = multNode;
                    end

                    for i = 2:thisFunc.nChild
                        argi = thisFunc.getArgumentNode(i);
                        if argi.isDependentOnDerivObj(derivObj)
                            summNode = IrNodeOperation('+');
                            summNode.addChild(headNode);

                            multNode = thisFunc.generateDerivativeSummand(i, derivObj);
                            summNode.addChild(multNode);

                            headNode = summNode;
                        end
                    end
                end
            end
        end

    end

end
