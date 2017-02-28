classdef IrNodeContribution < IrNodeNumerical
% IRNODECONTRIBUTION represents a Verilog-A contribution statement
%
% A contribution statement in Verilog-A is denoted by "<+" and has a probe (V,
% I or Pwr) on its left-hand side. E.g.,
%
%   I(p,n) <+ G*V(p,n)
%    (LHS)      (RHS)
%
% MAPP supports two types of contributions:
%  1. Explicit
%  2. Implicit
%
% Explicit contributions are those for which the RHS expression can be
% computed directly. The simple resistance equation given above is such a
% contribution.
%
% Implicit contributions have RHS expressions that depend on the LHS IO of the
% contribution itself. The following expression for a diode is such a
% contribution:
% 
%   I(p,n) <+ is*(limexp((V(p,n) - r*I(p,n))/$vt) - 1);
%
% Notice how I(p,n) appears both on the LHS and RHS of the contribution.
%
% The detection to which class a particular contribution belongs is currently
% being performed by the IrVisitorMark1 class.
%
% NOTE: VAPP currently does not support variable tracing, i.e., if a variable
% on the RHS depends on the RHS IO, this is not detected. This feature is to be
% included in the next release.
%
% See also IRVISITORMARK1 IRNODENUMERICAL

% TODO: see the note above.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Jan 03, 2017  11:46AM
%==============================================================================
    properties
        implicit = false; % is the contribution implicit?
        nullEqn = false;  % is the contribution a null-equation?
        % a null-equation is an equation where the LHS IO occurs on the RHS in
        % an additive fashion and cancels out the LHS IO.
        % null-equations are implicit equations and their LHS IOs are dummy
        % IOs.
        eqnIdx = 0;       % which row does this contribution occupy in the
                          % output vectors
        rhsDummyNode = {}; % empty if nullEqn==false,
        % otherwise points to the IR tree node that contains the RHS dummy IO.

        accessIdx = 0;
        impContribIdx = 0;
        impEqnDependPfVecC = {}; %MsPotential.empty;
        impEqnDependVarVecC = {}; %MsVariable.empty;
        nodeCollapse = false;
    end

    methods

        function obj = IrNodeContribution(uniqIdGen, lhsNode, rhsNode)
            obj = obj@IrNodeNumerical(uniqIdGen);
            obj.additive = 1;
            if nargin > 1
                obj.addChild(lhsNode);
                obj.addChild(rhsNode);
            end
            % contributions have to have additive = 1 because of their lhs IOs.
            % We need to determine if a lhs IO is an inverse IO or not in order
            % to detect implicitly defined equations.
            % To how this is done, take a look at the visitIrNodeContribution
            % method of IrVisitorMark1 class.
        end

        function aIdx = getAccessIdx(thisNode)
        % GETACCESSIDX
            aIdx = thisNode.accessIdx;
        end

        function setAccessIdx(thisNode, aIdx)
        % SETACCESSIDX
            thisNode.accessIdx = aIdx;
        end

        function setImplicit(thisContrib, idx)
        % SETIMPLICIT
            thisContrib.implicit = true;
            thisContrib.impContribIdx = idx;
        end

        function idx = getImpContribIdx(thisContrib)
        % GETIMPCONTRIBIDX
            idx = thisContrib.impContribIdx;
        end

        function out = isImplicit(thisContrib)
        % ISIMPLICIT
            out = thisContrib.implicit;
        end

        function setImplicitEqnDependPfVecC(thisContrib, pfVec)
        % SETIMPLICITEQNDEPENDPFVECC
            thisContrib.impEqnDependPfVecC = pfVec;
        end

        function setImplicitEqnDependVarVecC(thisContrib, varVec)
        % SETIMPLICITEQNDEPENDVARVEC
            thisContrib.impEqnDependVarVecC = varVec;
        end

        function pfVec = getImplicitEqnDependPfVecC(thisContrib)
        % GETIMPLICITEQNDEPENDPFVEC
            pfVec = thisContrib.impEqnDependPfVecC;
        end

        function varVec = getImplicitEqnDependVarVecC(thisContrib)
        % GETIMPLICITEQNDEPENDVARVEC
            varVec = thisContrib.impEqnDependVarVecC;
        end

        function derivLabel = getDerivLabel(thisContrib, derivObj, fOrQ)
        % GETDERIVLABEL
            lhsNode = thisContrib.getLhsNode();
            pfObj = lhsNode.getPfObj;
            varSfx = thisContrib.VARSFX;
            if strcmp(fOrQ, 'f') == true
                pfLabel = lhsNode.getFLabel();
            else
                pfLabel = lhsNode.getQLabel();
            end

            derivLabel = ['d_', pfLabel, '_d_', derivObj.getLabel()];
            %derivLabel = [fOrQ, '_', derivLabel, varSfx];
        end


        function outStr = sprintNumerical(thisContrib, ~)

            outStr = '';

            if thisContrib.implicit == false
                % contribution is explicit
                rhsNode = thisContrib.getRhsNode();
                if thisContrib.nodeCollapse == false
                    fStr = rhsNode.sprintAll();
                    qStr = rhsNode.sprintAllDdt(); % this prints the ddt chain
                    lhsPfNode = thisContrib.getLhsNode();
                    outStr = [outStr, '// contribution for ', ...
                                                    lhsPfNode.getLabel(), ';\n'];
                    if isempty(fStr) == false
                        outStr = [outStr, lhsPfNode.addToF(fStr), ';\n'];
                    end

                    if isempty(qStr) == false
                        outStr = [outStr, lhsPfNode.addToQ(qStr), ';\n'];
                    end
                end
            else
                % contribution is implicit.
                implicitEqnTree = thisContrib.getImplicitEquationTree();
                fStr = implicitEqnTree.sprintAll();
                qStr = implicitEqnTree.sprintAllDdt(); % this prints the ddt chain
                eqnIdx = thisContrib.impContribIdx;
                varSfx = thisContrib.VARSFX;

                if isempty(fStr)
                    fStr = '0';
                end

                if isempty(qStr)
                    qStr = '0';
                end

                impEqnVarLabelF = thisContrib.getImplicitEqnVarLabel('f');
                impEqnVarLabelQ = thisContrib.getImplicitEqnVarLabel('q');

                outStr = [outStr, '// implicit equation contribution\n'];

                outStr = [outStr, impEqnVarLabelF, varSfx, ' = ', fStr, ';\n'];
                outStr = [outStr, impEqnVarLabelQ, varSfx, ' = ', qStr, ';\n'];
            end
        end

        function contribTree = getImplicitEquationTree(thisContrib)
  
            % Note: we don't want to copy the lhs and rhsNodes here because an
            % implicit equation tree is only used as an input when generating
            % derivative trees. We are not interested in the actual objects of
            % the tree we only want to have its structure.
            % So, we don't use the regular IrNodeNumerical.getDifferenceOfNodes
            % function here.
            minusNode = IrNodeOperation(thisContrib.uniqIdGen, '-');
            rhsNode = thisContrib.getRhsNode();
            lhsNode = thisContrib.getLhsNode();

            if rhsNode.isOnDdtPath() == true
                minusNode.setOnDdtPath();
            end

            minusNode.addChildNoSetParent(rhsNode);
            minusNode.addChildNoSetParent(lhsNode);
            contribTree = minusNode;
        end

        function setNullEqn(thisContrib)
            thisContrib.nullEqn = true;
        end

        function out = isNullEqn(thisContrib)
            out = thisContrib.nullEqn;
        end

        function lhsPf = getLhsPfObj(thisContrib)
            lhsNode = thisContrib.getLhsNode();
            lhsPf = lhsNode.getPfObj();
        end

        function setEqnIdx(thisContrib, idx)
            if idx >= 0
                thisContrib.eqnIdx = idx;
            else
                lhsIo = thisContrib.getLhsIoObj();
                thisContrib.eqnIdx = lhsIo.getOutIdx();
            end
        end

        function idx = getEqnIdx(thisContrib)
            idx = thisContrib.eqnIdx;
        end

        function lhsNode = getLhsNode(thisContrib)
            lhsNode = thisContrib.getChild(1);
        end

        function rhsNode = getRhsNode(thisContrib)
            rhsNode = thisContrib.getChild(2);
        end

        function setRhsDummyNode(thisContrib, rhsDummyNode)
            thisContrib.rhsDummyNode = rhsDummyNode;
        end

        function rhsDummyNode = getRhsDummyNode(thisContrib)
            rhsDummyNode = thisContrib.rhsDummyNode;
        end

        function impLabel = getImplicitEqnVarLabel(thisContrib, fOrQ)
        % GETIMPLICITEQNVARLABEL
            eqnIdx = thisContrib.impContribIdx;
            impLabel = sprintf('%s_implicit_eqn_%d', fOrQ, eqnIdx);
        end

        function derivLabel = getImplicitEqnDerivVarLabel(thisContrib, derivObj, fOrQ)
        % GETIMPLICITEQNDERIVVARLABEL
            impVarLabel = thisContrib.getImplicitEqnVarLabel(fOrQ);
            derivLabel = ['d_', impVarLabel, '_', derivObj.getLabel()];
        end

        function setNodeCollapse(thisContrib)
        % SETNODECOLLAPSE
            thisContrib.nodeCollapse = true;
            lhsPf = thisContrib.getLhsPfObj();
            lhsBranch = lhsPf.getBranch();
            lhsBranch.setToBeCollapsed();
        end

        function [headNode, generateSub] = generateDerivative(thisContrib, derivObj)
            generateSub = false;
            lhsNode = thisContrib.getLhsNode();
            rhsNode = thisContrib.getRhsNode();
            headNode = IrNodeBlock(thisContrib.uniqIdGen);
            headNode.setIndentLevel(0);
            varSfx = thisContrib.VARSFX;
            % is this contribution is an output in its own right or does it
            % contribute to other outputs? The latter case occurs when the
            % lhsIoObj is an extra IO that is not an internalUnk.
            % if the eqnIdx of thisContrib is greater than 0, we have a
            % contribution of the first kind.
            inverse = false;
            if thisContrib.implicit == false
                % get derivative labels for the lhs
                lhsDerivLabelF = thisContrib.getDerivLabel(derivObj, 'f'); 
                lhsDerivLabelQ = thisContrib.getDerivLabel(derivObj, 'q'); 
                lhsDerivLabelF = [lhsDerivLabelF, varSfx];
                lhsDerivLabelQ = [lhsDerivLabelQ, varSfx];

                % create variable nodes for the lhs
                %lhsVarObjF = MsVariable(lhsDerivLabelF);
                %lhsVarObjQ = MsVariable(lhsDerivLabelQ);
                lhsVarNodeF = IrNodeVariable(thisContrib.uniqIdGen, lhsDerivLabelF);
                rhsVarNodeF = IrNodeVariable(thisContrib.uniqIdGen, lhsDerivLabelF);
                lhsVarNodeQ = IrNodeVariable(thisContrib.uniqIdGen, lhsDerivLabelQ);
                rhsVarNodeQ = IrNodeVariable(thisContrib.uniqIdGen, lhsDerivLabelQ);
                if lhsNode.isInverse() == true
                    inverse = true;
                end
            else % contrib is implicit
                lhsDerivLabelF = thisContrib.getImplicitEqnDerivVarLabel(derivObj, 'f'); 
                lhsDerivLabelQ = thisContrib.getImplicitEqnDerivVarLabel(derivObj, 'q'); 
                lhsDerivLabelF = [lhsDerivLabelF, varSfx];
                lhsDerivLabelQ = [lhsDerivLabelQ, varSfx];

                lhsVarNodeF = IrNodeVariable(thisContrib.uniqIdGen, lhsDerivLabelF);
                rhsVarNodeF = IrNodeNumericalNull(thisContrib.uniqIdGen);
                lhsVarNodeQ = IrNodeVariable(thisContrib.uniqIdGen, lhsDerivLabelQ);
                rhsVarNodeQ = IrNodeNumericalNull(thisContrib.uniqIdGen);
                rhsNode = thisContrib.getImplicitEquationTree();
            end

            % copy f and q trees of the rhs node
            rhsTreeF = rhsNode.copyFSubTree();
            rhsTreeQ = rhsNode.copyQSubTree();

            % generate derivatives for the F and Q trees
            rhsDerivTreeF = rhsTreeF.generateDerivativeTree(derivObj);
            rhsDerivTreeQ = rhsTreeQ.generateDerivativeTree(derivObj);


            % end the LHS variable to the RHS if the RHS is not empty
            % Reason: because this is the derivative of a CONTRIBUTION
            if rhsDerivTreeF.isNull() == false
                if inverse == false
                    rhsDerivTreeF = IrNodeNumerical.getSummOfNodes(thisContrib.uniqIdGen, rhsVarNodeF, ...
                                                                 rhsDerivTreeF);
                else
                    rhsDerivTreeF = IrNodeNumerical.getDifferenceOfNodes(thisContrib.uniqIdGen, rhsVarNodeF, ...
                                                                 rhsDerivTreeF);
                end
            % add the derivative trees to the RHSs of assignment nodes
                assignNodeF = IrNodeAssignment(thisContrib.uniqIdGen, lhsVarNodeF, rhsDerivTreeF);

            % add assignment nodes to the derivative block
                headNode.addChild(assignNodeF);
            end

            if rhsDerivTreeQ.isNull() == false
                if inverse == false
                    rhsDerivTreeQ = IrNodeNumerical.getSummOfNodes(thisContrib.uniqIdGen, rhsVarNodeQ, ...
                                                                 rhsDerivTreeQ);
                else
                    rhsDerivTreeQ = IrNodeNumerical.getDifferenceOfNodes(thisContrib.uniqIdGen, rhsVarNodeQ, ...
                                                                 rhsDerivTreeQ);
                end

                assignNodeQ = IrNodeAssignment(thisContrib.uniqIdGen, lhsVarNodeQ, rhsDerivTreeQ);
                headNode.addChild(assignNodeQ);
            end
        end

    % end methods
    end
% end classdef
end
