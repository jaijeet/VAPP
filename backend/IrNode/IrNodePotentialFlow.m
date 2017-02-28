classdef IrNodePotentialFlow < IrNodeDifferentiable
% IRNODEPOTENTIALFLOW is a wrapper for either a MsPotential or a MsFlow class
%
% This class could be called IrNodeAccess. But the current name reflects that
% its functionality is limited by wrapping up potential and flow objects. If
% any other kind of physical quantity is to be added to VAPP, this class has
% to be adapted accordingly.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Jan 03, 2017  12:55PM
%==============================================================================
    properties
        pfObj = {};
        inverse = false; % true if we are dealing with an inverse pfObj
                         % e.g., we have V(n1,n2) but we want to use V(n2,n1)
        dummy = false; % true if used as a dummy node in an implicit eqn
        lhs = false; % true if pf object is on the lhs of a contribution
    end

    methods

        function obj = IrNodePotentialFlow(uniqIdGen, pfObj, inverse)
        % IRNODEPOTENTIALFLOW
        % the first argument is a MsPotentialFlow object and the second
        % argument is a boolean indicating if the potential or flow represented
        % by this node is the inverse of pfObj.
            obj = obj@IrNodeDifferentiable(uniqIdGen);

            if nargin > 1
                obj.pfObj = pfObj;

                if nargin > 2
                    obj.inverse = inverse;
                end

                if obj.inverse == true
                    obj.additive = -1;       % inherited from IrNodeNumerical
                else
                    obj.additive = 1;
                end
            end
            obj.multiplicative = 1; % inherited from IrNodeNumerical
        end

        function pfObj = getPfObj(thisPF)
        % GETPFOBJ
            pfObj = thisPF.pfObj;
        end

        function varObj = getVarObj(thisPF)
        % GETVAROBJ
            varObj = thisPF.pfObj;
        end

        function label = getLabel(thisPF)
        % GETLABEL
        % Here we use the concept of an "auxiliary label".
        % A potential/flow object prints and auxiliary label instead of its
        % original label in the following case.
        % We have a potential/flow that is an internal unknown but has a
        % contribution as well. In this case we need to write down an internal
        % equation that sets the internal unknown and the contribution to that
        % potential/flow equal to each other.
            label = thisPF.pfObj.getLabel();
        end

        function fLabel = getFLabel(thisPF)
        % GETFLABEL
        % The F label is used when
        % 1. printing a contribution
        % 2. printing an output
        % So:
        % 1.1. When printing a contribution, we have lhs property of thisPF set
        % to true.
        % 2.1. When printing an output we will only print f/q parts of those
        % PFs that are not input variables (i.e, not internal unks, other IOs).
            if thisPF.lhs == true 
                fLabel = ['f_', thisPF.getLabel()];
            else
                fLabel = thisPF.pfObj.getFLabel();
            end
        end

        function qLabel = getQLabel(thisPF)
        % GETQLABEL
            if thisPF.lhs == true 
                qLabel = ['q_', thisPF.getLabel()];
            else
                qLabel = thisPF.pfObj.getQLabel();
            end
        end

        function derivLabel = getDerivLabel(thisPF, derivObj)
        % GETDERIVLABEL
            derivLabel = thisPF.pfObj.getDerivLabel(derivObj);
        end

        function derivLabel = getDerivFLabel(thisPF, derivObj)
        % GETDERIVFLABEL
            derivLabel = ['d_', thisPF.getFLabel(), '_d_', derivObj.getLabel()];
        end

        function derivLabel = getDerivQLabel(thisPF, derivObj)
        % GETDERIVQLABEL
            qLabel = thisPF.getQLabel();
            if isempty(qLabel) == false
                derivLabel = ['d_', thisPF.getQLabel(), '_d_', derivObj.getLabel()];
            else
                derivLabel = '';
            end
        end

        function out = isDependentOnDerivObj(thisPF, derivObj)
            out = thisPF.pfObj.isDependentOnDerivObj(derivObj);
        end

        function setOnDdtPath(thisPF)
            % a potential/flow cannot be on a ddt path
            error('A potential/flow object cannot be on a ddt path!');
        end

        function out = isPotential(thisPF)
            out = thisPF.pfObj.isPotential();
        end

        function out = isFlow(thisPF)
            out = thisPF.pfObj.isFlow();
        end

        function setContrib(thisPF, cIdx)
            thisPF.pfObj.setContrib(cIdx);
        end

        function setProbe(thisPF, aIdx)
            thisPF.pfObj.setProbe(aIdx);
        end

        function out = isContrib(thisPF)
        % ISCONTRIB
            out = thisPF.pfObj.isContrib();
        end

        function out = isProbe(thisPF)
        % ISPROBE
            out = thisPF.pfObj.isProbe();
        end

        function out = isInput(thisPF)
        % ISINPUT
            out = thisPF.pfObj.isInput();
        end

        function setInverse(thisPF)
        % SETINVERSE
            thisPF.inverse = true;
        end

        function out = isInverse(thisPF)
        % ISINVERSE
            out = thisPF.inverse;
        end

        function setDummy(thisPF)
        % SETDUMMY
            thisPF.dummy = true;
        end

        function out = isDummy(thisPF)
        % ISDUMMY
            out = thisPF.dummy;
        end

        function setLhs(thisPF)
        % SETLHS
            thisPF.lhs = true;
        end

        function out = isLhs(thisPF)
        % ISLHS
            out = thisPF.lhs;
        end

        function out = isIndependent(thisPF)
        % ISINDEPENDENT
            out = thisPF.pfObj.isIndependent();
        end

        % methods inhereted (abstract) from IrNodeNumerical
        function outStr = sprintNumerical(thisNode, ~)
            varSfx =  thisNode.VARSFX;
            if thisNode.dummy == true
                outStr = '';
            else
                % use getLabel instead of the property .label.
                % See the comment in getLabel() for an explanation why.
                outStr = [thisNode.getLabel(), varSfx];
                if thisNode.inverse == true
                    outStr = ['(-', outStr, ')'];
                end
            end
        end

        function outStr = sprintInit(thisPF)
        % SPRINTINIT
            varSfx =  thisPF.VARSFX;
            outStr = [thisPF.getFLabel(), varSfx, ' = 0;\n'];
            outStr = [outStr, thisPF.getQLabel(), varSfx, ' = 0;\n'];
        end

        function outStr = addToF(thisPF, rhsStr)
        % ADDTOF
            outStr = thisPF.addToEqn(rhsStr, 'f');
        end

        function outStr = addToQ(thisPF, rhsStr)
        % ADDTOF
            outStr = thisPF.addToEqn(rhsStr, 'q');
        end

        function outStr = addToEqn(thisPF, rhsStr, fOrQ)
        % ADDTOEQN
            varSfx =  thisPF.VARSFX;
            if strcmp(fOrQ, 'f')
                lhsStr = [thisPF.getFLabel(), varSfx];
            elseif strcmp(fOrQ, 'q')
                lhsStr = [thisPF.getQLabel(), varSfx];
            end

            if thisPF.inverse == false
                outStr = [lhsStr, ' = ', lhsStr, ' + ', rhsStr];
            else
                outStr = [lhsStr, ' = ', lhsStr, ' - ', '(', rhsStr, ')'];
            end
        end

        function headNode = generateDerivativeFQ(thisPF, derivObj, fOrQ)
        % GENERATEDERIVATIVEVAR
            
            fWanted = false;
            qWanted = false;

            if nargin == 3
                if strcmp(fOrQ, 'f') == true
                    fWanted = true;
                elseif strcmp(fOrQ, 'q') == true
                    qWanted = true;
                else
                    error(['The second argument of this method must be either',...
                           ' ''f'' or ''q''!']);
                end
            end

            headNode = IrNodeNumericalNull(thisPF.uniqIdGen);
            pfObj = thisPF.pfObj;
            varSfx =  thisPF.VARSFX;

            if thisPF.dummy == false
                % Here is what is going to happen here
                % We will first check if the PF is an input. If it is indeed an
                % input, it cannot depend on any other variables/PFs. So we
                % will check if the pfObj is the PF itself, and if it is, we
                % will set the derivative to 1 or -1 (depending on the
                % direction of the PF).
                %if pfObj.isInput() == true && thisPF.lhs == false
                if  thisPF.lhs == false && derivObj == pfObj && qWanted == false 
                        if thisPF.inverse == true
                            constVal = -1;
                        else
                            constVal = 1;
                        end
                        headNode = IrNodeNumerical.getConstantNode(thisPF.uniqIdGen, constVal);
                    %end
                else
                    % the PF is not an input or it is the auxiliary quantity
                    % used on the LHS of a contribution for an input PF.
                    % here we can encounter the following options:
                    % 1. The PF is an independent quantity and its numerical
                    % value is set by contributions to the PF. In this case we
                    % have to check its dependencies and generate derivative
                    % variables.
                    % 2. The PF is a dependent quantity.
                    % In this case it will depend on independent PFs (some of
                    % which will be inputs). These dependencies would have been
                    % set by the module in the process of running
                    % IrNodeModule.generateIoDefs.
                    if pfObj.isDependentOnPf(derivObj) == true
                        if fWanted == true
                            derivLabel = getDerivFLabel(thisPF, derivObj);
                        elseif qWanted == true
                            derivLabel = getDerivQLabel(thisPF, derivObj);
                        else
                            derivLabel = getDerivLabel(thisPF, derivObj);
                        end
                        % derivLabel can be empty for PFs that don't have a q part.
                        % check for it first
                        if isempty(derivLabel) == false
                            derivLabel = [derivLabel, varSfx];
                            varNode = IrNodeVariable(thisPF.uniqIdGen, derivLabel);
                            if thisPF.inverse == false
                                headNode = varNode;
                            else
                                headNode = IrNodeNumerical.getNegativeOfNode(thisPF.uniqIdGen, varNode);
                            end
                        end
                    end
                end
                % WARNING: here we assume that PFs only depend on other PFs.
                % I.e., they don't depend on variables. This is only so because
                % we assign every PF that appears on the RHS of an
                % equation/contribution as either an independent input or a
                % combination of independent inputs.
            end
        end

        function headNode = resetDerivativeToZero(thisPF, derivObj)
        % RESETDERIVATIVETOZERO
        % This is the counterpart of the
        % IrNodePotentialFlow.resetDerivativeToZero method. Before node
        % collapse we didn't need this but with node collapse we do. Reason:
        % this method only gets called if an equation is in an if/else
        % statement and might have accumulated other dependecies along the way.
        % Without node collapse we never call the resetDerivativeToZero method
        % of an IrNodePotentialFlow. Bu with node collapse we encapsulate the
        % IO definitions in if/else conditions, so we need to have a dummy
        % resetDerivativeToZero method.

            headNode = IrNodeNumericalNull(thisPF.uniqIdGen);
        end

        function [headNode, generateSub] = generateDerivative(thisPF, derivObj)
            % GENERATEDERIVATIVE
            generateSub = false;

            headNode = thisPF.generateDerivativeFQ(derivObj);
        end
    % end methods
    end

% end classdef
end
