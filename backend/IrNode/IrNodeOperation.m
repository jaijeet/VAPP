classdef IrNodeOperation < IrNodeNumerical
% IRNODEOPERATION represents an operation node in Verilog-A
%
% Operator precedence in VA (Taken from: VAPP_parse.m)
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
%
% Operator precedence in MATLAB (taken from MATLAB documentation)
% 
% 1. ()
% 2. .', .^, ', ^
% 3. +, -, ~
% 4. .*, ./, .\, *, /, \
% 5. +, -
% 6. :
% 7. <, <=, >, >=, ==, ~=
% 8. &, |, &&, ||
    
%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Feb 02, 2017  11:57AM
%==============================================================================
    properties
        opType = '';
        opRank = 0;
        % '%' and '?:' have NaN rank because we replace them with function
        % calls. Notice how for a number a, both (a > NaN) and (a < NaN) are
        % false. This is exactly the behavior we want when printing mod() and
        % qmcol().
        %
        % A higher number indicates higher precedence
        OPARR = {'**', 'u+', 'u-', '!', '*', '/', '+', '-', '<', '<=', '>', '>=', '!=', '==', '&&', '||', '?:', '%'};
        OPRANK = [6,    5,    5,    5,   4,   4,   3,   3,   2,   2,    2,   2,    2,    2,    1,    1,    NaN,  NaN];
    end

    methods
        function obj = IrNodeOperation(uniqIdGen, opType)
            obj = obj@IrNodeNumerical(uniqIdGen);
            obj.tabStr = '';
            if nargin > 1
                obj.opType = opType;
                obj.opRank = obj.OPRANK(strcmp(opType, obj.OPARR));

                if obj.hasOpType({'+', '-'})
                    obj.additive = 1;
                    obj.affine = true;
                elseif obj.hasOpType('u+')
                    obj.additive = 1;
                    obj.affine = true;
                    obj.multiplicative = true;
                elseif obj.hasOpType('u-')
                    obj.additive = -1;
                    obj.affine = true;
                    obj.multiplicative = true;
                elseif obj.hasOpType({'*', '/'})
                    obj.multiplicative = true;
                    obj.affine = true;
                end
            end
        end

        function addChild(thisNode, childNode)
            if thisNode.hasOpType('-') && thisNode.nChild == 1
                thisNode.additive = -1;
            end

            addChild@IrNodeNumerical(thisNode, childNode);
        end

        function out = getOpType(thisNode)
            out = thisNode.opType;
        end

        function out = hasOpType(thisNode, opType)
            out = any(strcmp(thisNode.opType, opType));
        end

        function setOnDdtPath(thisNode)
            % ATTENTION: this function is here because if we multiply a ddt
            % with a constant, we also would like to print out that constant.
            % Watch for side effects -> needs thorough testing
            setOnDdtPath@IrNodeNumerical(thisNode);
            if thisNode.isMultiplicative()
                for childNode = thisNode.childVecC
                    childNode{:}.setOnDdtPath();
                end
            end
        end

        function outStr = sprintNumerical(thisNode, sprintAllFlag)
            outStr = '';
            opStr = thisNode.opType;
            
            childNode1 = thisNode.getChild(1);
            if sprintAllFlag == 0
                childStr1 = sprintAll(childNode1);
            elseif sprintAllFlag == 1
                childStr1 = sprintAllDdt(childNode1);
            end

            if thisNode.getNChild() > 1
                childNode2 = thisNode.getChild(2);
                if sprintAllFlag == 0
                    childStr2 = sprintAll(childNode2);
                elseif sprintAllFlag == 1
                    childStr2 = sprintAllDdt(childNode2);
                end
            else
                childStr2 = '';
            end

            if thisNode.getNChild() > 2
                childNode3 = thisNode.getChild(3);
                if sprintAllFlag == 0
                    childStr3 = sprintAll(childNode3);
                elseif sprintAllFlag == 1
                    childStr3 = sprintAllDdt(childNode3);
                end
            else
                childStr3 = '';
            end

            % convert operators
            if thisNode.hasOpType('**') == true
                opStr = '^';
            elseif thisNode.hasOpType('!=') == true
                opStr = '~=';
            end
                

            if thisNode.hasOpType({'u-', 'u+'}) == true
                if isempty(childStr1) == false
                    outStr = [outStr, opStr(2), childStr1];
                end
            elseif thisNode.hasOpType('!') == true
                if isempty(childStr1) == false
                    outStr = [outStr, '~', childStr1];
                end
            elseif thisNode.hasOpType('?:') == true
                % no empty strings allowed
                if isempty(childStr2)
                    childStr2 = '0';
                end

                if isempty(childStr3)
                    childStr3 = '0';
                end

                outStr = [outStr, 'qmcol_vapp(', childStr1, ', ',...
                                                 childStr2, ', ',...
                                                 childStr3, ')'];
            elseif thisNode.hasOpType('%') == true
                % no empty strings allowed
                outStr = [outStr, 'mod(', childStr1, ', ', childStr2, ')'];
            else
                if thisNode.hasOpType({'+', '-'})
                    if isempty(childStr2)
                        opStr = '';
                    end

                    if thisNode.hasOpType('+') && isempty(childStr1)
                        opStr = '';
                    end
                elseif thisNode.hasOpType({'*', '/'})
                    % TODO: if any one of the nodes is 1, don't print it
                    if isempty(childStr1) || isempty(childStr2)
                        opStr = '';
                        childStr1 = ''; 
                        childStr2 = '';
                    end
                end
                outStr = [outStr, childStr1, opStr, childStr2];
            end

            parentNode = thisNode.getParent();
            % use parenthesis if operators have the same rank: the user might
            % have considered numerical effects and  separated them in the
            % original code.
            if isempty(outStr) == false && ...
                isa(parentNode, 'IrNodeOperation') && ...
                 thisNode.opRank <= parentNode.opRank
                outStr = ['(', outStr, ')'];
            end
        end

        % TODO
        % In all of the functions below, we should check first if a node is
        % constant and simplify the expressions accordingly.

        function summNode = derivMultiplication(thisNode, derivObj)

            summNode = IrNodeOperation(thisNode.uniqIdGen, '+');

            child1 = thisNode.getChild(1);
            child2 = thisNode.getChild(2);

            child1Cp = child1.copyDeep();
            child2Cp = child2.copyDeep();

            child1Deriv = child1.generateDerivativeTree(derivObj);
            child2Deriv = child2.generateDerivativeTree(derivObj);

            multNode1 = IrNodeNumerical.getProductOfNodes(thisNode.uniqIdGen, child1Cp, child2Deriv);
            multNode2 = IrNodeNumerical.getProductOfNodes(thisNode.uniqIdGen, child1Deriv, child2Cp);

            summNode = IrNodeNumerical.getSummOfNodes(thisNode.uniqIdGen, multNode1, multNode2);
        end

        function minusNode = derivDivision(thisNode, derivObj)
            % f = g/h
            % df = g'/h - g*h'/(h^2)
            child1 = thisNode.getChild(1);
            child2 = thisNode.getChild(2);

            child1Cp = child1.copyDeep();
            child2Cp = child2.copyDeep();
            child2Cp2 = child2.copyDeep();

            child1Deriv = child1.generateDerivativeTree(derivObj);
            child2Deriv = child2.generateDerivativeTree(derivObj);

            divNode1 = IrNodeNumerical.getDivisionOfNodes(thisNode.uniqIdGen, child1Deriv, child2Cp);

            multNode = IrNodeNumerical.getProductOfNodes(thisNode.uniqIdGen, child1Cp, child2Deriv);
            squareNode = IrNodeNumerical.getSquareOfNode(thisNode.uniqIdGen, child2Cp2);
            divNode2 = IrNodeNumerical.getDivisionOfNodes(thisNode.uniqIdGen, multNode, squareNode);

            minusNode = IrNodeNumerical.getDifferenceOfNodes(thisNode.uniqIdGen, divNode1, divNode2);

        end

        function summNode = derivPower(thisNode, derivObj)

            % f(x) = g(x)**h(x)
            % f' = g**(h-1) * (g'*h + g*h'*ln(g))
            % The above is correct but not efficient for the cases where one of
            % the arguments is a constant. Instead we use
            % f' = g**(h-1)*g'*h + (g**h)*h'*ln(g)
            % protected version:
            % f' = g**(h-1)*g'*h + (g**h)*h'*(g>0?ln(g):0)

            child1 = thisNode.getChild(1);
            child2 = thisNode.getChild(2);

            child1Cp1 = child1.copyDeep(); % g
            child1Cp2 = child1.copyDeep(); % g
            child2Cp1 = child2.copyDeep(); % h
            child2Cp2 = child2.copyDeep(); % h
            child1Cp3 = child1.copyDeep(); % g

            child1Deriv = child1.generateDerivativeTree(derivObj);
            child2Deriv = child2.generateDerivativeTree(derivObj);
            % g'*h
            multNode1 = IrNodeNumerical.getProductOfNodes(thisNode.uniqIdGen, child1Deriv, child2Cp1);
            % g**(h-1)
            minusNode = IrNodeNumerical.getNodeMinusOne(thisNode.uniqIdGen, child2Cp2);
            expNode1 = IrNodeNumerical.getExponentiationOfNodes(thisNode.uniqIdGen, child1Cp1, minusNode);
            % g**(h-1)*g'*h
            multNode2 = IrNodeNumerical.getProductOfNodes(thisNode.uniqIdGen, expNode1, multNode1);

            % g**h
            expNode2 = thisNode.copyDeep();
            multNode3 = IrNodeNumerical.getProductOfNodes(thisNode.uniqIdGen, expNode2, child2Deriv);
            % ln(g)
            logNode = IrNodeNumerical.getFunctionOfNode(thisNode.uniqIdGen, child1Cp2, 'ln');
            % we have to protect against the first argument being zero
            zeroNode1 = IrNodeNumerical.getConstantNode(thisNode.uniqIdGen, 0);
            zeroNode2 = IrNodeNumerical.getConstantNode(thisNode.uniqIdGen, 0);
            condNode = IrNodeNumerical.joinNodesWithOperation(thisNode.uniqIdGen, ...
                                                              '>', ...
                                                              child1Cp3, ...
                                                              zeroNode1);
            qmColNode = IrNodeNumerical.getQuestionMarkColumnOfNodes(...
                                                                thisNode.uniqIdGen, ...
                                                                condNode, ...
                                                                logNode, ...
                                                                zeroNode2);
            multNode4 = IrNodeNumerical.getProductOfNodes(thisNode.uniqIdGen, multNode3, qmColNode);

            summNode = IrNodeNumerical.getSummOfNodes(thisNode.uniqIdGen, multNode2, multNode4);
        end

        function qmcolNode = derivQmcol(thisNode, derivObj)
            qmcolNode = IrNodeOperation(thisNode.uniqIdGen, '?:');

            child1 = thisNode.getChild(1);
            child2 = thisNode.getChild(2);
            child3 = thisNode.getChild(3);

            child1Cp = child1.copyDeep();
            child2Deriv = child2.generateDerivativeTree(derivObj);
            child3Deriv = child3.generateDerivativeTree(derivObj);

            if child2Deriv.isNull() == true
                child2Deriv = IrNodeNumerical.getConstantNode(thisNode.uniqIdGen, 0);
            end

            if child3Deriv.isNull() == true
                child3Deriv = IrNodeNumerical.getConstantNode(thisNode.uniqIdGen, 0);
            end

            qmcolNode.addChild(child1Cp);
            qmcolNode.addChild(child2Deriv);
            qmcolNode.addChild(child3Deriv);
        end

        function zeroNode = derivGreaterSmaller(thisNode, derivObj)
        % DERIVGREATERSMALLER
            zeroNode = IrNodeNumerical.getConstantNode(thisNode.uniqIdGen, 0);
        end

        function [headNode, generateSub] = generateDerivative(thisNode, derivObj)
            % valid node types for derivatives:
            % +,-,*,/,u+,u-,**
            opType = thisNode.getOpType();

            if thisNode.hasOpType({'+', '-', '*', '/', 'u+', 'u-','**', '?:',...
                                   '>', '>=', '<', '<='}) == false
                error('The operation %s cannot be used in a derivative!', opType);
            end

            if thisNode.hasOpType({'+', '-', 'u+', 'u-'})
                headNode = IrNodeOperation(thisNode.uniqIdGen, opType);
                generateSub = true;
            elseif thisNode.hasOpType('*')
                generateSub = false;
                headNode = thisNode.derivMultiplication(derivObj);
            elseif thisNode.hasOpType('/')
                generateSub = false;
                headNode = thisNode.derivDivision(derivObj);
            elseif thisNode.hasOpType('**')
                generateSub = false;
                headNode = thisNode.derivPower(derivObj);
            elseif thisNode.hasOpType('?:')
                generateSub = false;
                headNode = thisNode.derivQmcol(derivObj);
            elseif thisNode.hasOpType({'>', '>=', '<', '<='})
                generateSub = false;
                headNode = thisNode.derivGreaterSmaller(derivObj);
            end

        end

    % end methods
    end
end
