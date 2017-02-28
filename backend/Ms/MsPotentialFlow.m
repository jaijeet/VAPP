classdef MsPotentialFlow < MsComparableViaLabel & MsDifferentiable
% MSPOTENTIALFLOW superclass for potentials and flows

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Dec 13, 2016  11:22AM
%==============================================================================
    properties (Access = protected)
        node1 = {};
        node2 = {};
        branch = {};
        contrib = false;
        probe = false;
        source = false;
        contribAfterProbe = false;
        inImplicitEqn = false;
        contribIdx = 0; % assinged by an IrVisitorMark001 class.
        probeIdx = Inf;   % these indices are incremented by one,
                        % everytime an access node is encountered
        outIdx = 0; % index (if any) in fe/qe/fi/qi vectors
        inIdx = 0; % input index in vecX, vecY
        labelPrefix = '';
        nature; % struct. fields: access, abstol, name, etc.
        savedState; % used to save the properties of this PF that depend on the
                    % model, i.e., for different configurations of the network
                    % caused by node collapse
    end

    %methods (Abstract)
    %    out = isExpOut(thisPF);
    %    out = isIntUnk(thisPF);
    %    out = isOtherIo(thisPF);
    %    out = isIndependent(thisPF);
    %    msl = getModSpecLabel(thisPF);
    %% end Abstract methods
    %end

    methods

        function obj = MsPotentialFlow()
        % MSPOTENTIALFLOW
            obj@MsDifferentiable();
        end

        function out = isInput(thisPF)
        % ISINPUT
            out = (thisPF.isIntUnk() == true || thisPF.isOtherIo() == true);
        end

        function out = isProbe(thisPF)
        % ISPROBE
            out = thisPF.probe;
        end

        function out = isContrib(thisPF)
        % ISCONTRIB
            out = thisPF.contrib;
        end

        function setProbe(thisPF, pIdx)
        % SETPROBE
            thisPF.probe = true;
            if pIdx < thisPF.probeIdx
                thisPF.setProbeIdx(pIdx);
            end
        end

        function setContrib(thisPF, cIdx)
        % SETCONTRIB
            thisPF.contrib = true;
            if cIdx > thisPF.contribIdx
                thisPF.setContribIdx(cIdx);
            end
        end

        function setInImplicitEqn(thisPF)
        % SETINIMPLICITEQN
            thisPF.inImplicitEqn = true;
        end

        function out = isInImplicitEqn(thisPF)
        % ISINIMPLICITEQN
            out = thisPF.inImplicitEqn;
        end

        function out = getProbeIdx(thisPF)
        % GETPROBEIDX
            out = thisPF.probeIdx;
        end

        function out = getContribIdx(thisPF)
        % GETCONTRIBIDX
            out = thisPF.contribIdx;
        end

        function setOutIdx(thisPF, outIdx)
        % SETOUTIDX
            thisPF.outIdx = outIdx;
        end

        function outIdx = getOutIdx(thisPF)
        % GETOUTIDX
            outIdx = thisPF.outIdx;
        end

        function setInIdx(thisPF, inIdx)
        % SETINIDX
            thisPF.inIdx = inIdx;
        end

        function inIdx = getInIdx(thisPF)
        % GETINIDX
            inIdx = thisPF.inIdx;
        end

        function out = isSource(thisPF)
        % ISSOURCE
            out = thisPF.source;
        end

        function setSource(thisPF)
        % SETSOURCE
            thisPF.source = true;
        end

        function out = needsInit(thisPF)
        % NEEDSINIT
            out = (thisPF.isContrib() == true);
        end

        function dualPF = getDual(thisPF)
        % GETDUAL this method returns the dual quantity of thisPF.
            branch = thisPF.branch;
            if thisPF.isPotential() == true
                dualPF = branch.getFlow();
            elseif thisPF.isFlow() == true
                dualPF = branch.getPotential();
            end
        end

        function setNodes(thisPF, nodeObj1, nodeObj2)
        % SETNODES
            thisPF.node1 = nodeObj1;
            thisPF.node2 = nodeObj2;
            if nodeObj1.isConnectedTo(nodeObj2) == true
                branchObj = nodeObj1.getBranch(nodeObj2);
            else
                branchObj = MsBranch(nodeObj1, nodeObj2);
            end
            thisPF.branch = branchObj;
        end

        function setBranch(thisPF, branchObj)
        % SETBRANCH
            thisPF.branch = branchObj;
            [nodeObj1, nodeObj2] = branchObj.getNodes();
            thisPF.node1 = nodeObj1;
            thisPF.node2 = nodeObj2;
        end

        function [node1, node2] = getNodes(thisPF)
        % GETNODES
            node1 = thisPF.node1;
            node2 = thisPF.node2;
        end

        function branch = getBranch(thisPF)
        % GETBRANCH
            branch = thisPF.branch;
        end

        function labelStr = getLabel(thisPF)
        % GETLABEL
            labelPrefix = thisPF.labelPrefix;
            if isempty(labelPrefix) == true
                labelPrefix = '[empty_label_prefix]:';
            end
            labelStr = [labelPrefix, '_', thisPF.branch.getLabel()];
        end

        function fLabel = getFLabel(thisPF)
        % GETFLABEL
        % The business of F/Q labels is a bit tricky.
        % Inputs will never have f_pflabel type labels. They will always appear
        % with their original labels.
        % On the other hand, non input PFs that are also independent (note that
        % this can only happen if that PF has a contribution and no probe) will
        % have f_ and q_ parts.
        % See also IrNodeOutput.getFLabel
            if thisPF.isIndependent() == true && thisPF.isInput() == false
                fLabel = ['f_', thisPF.getLabel()];
            else
                fLabel = thisPF.getLabel();
            end
        end

        function qLabel = getQLabel(thisPF)
        % GETQLABEL
        % see comments in the getFLabel method above
            if thisPF.isIndependent() == true && thisPF.isInput() == false
                qLabel = ['q_', thisPF.getLabel()];
            else
                qLabel = '';
            end
        end

        function name = name(thisPF)
        % NAME
            name = thisPF.getLabel();
        end

        function setLabelPrefix(thisPF, lpf)
        % SETLABELPREFIX
            thisPF.labelPrefix = lpf;
        end

        function saveState(thisPf)
        % SAVESTATE
            if isempty(thisPf.savedState) == true
                savedState = struct();
                savedState.contrib = thisPf.contrib;
                savedState.probe = thisPf.probe;
                savedState.source= thisPf.source;
                savedState.contribAfterProbe = thisPf.contribAfterProbe;
                savedState.inImplicitEqn = thisPf.inImplicitEqn;
                savedState.contribIdx = thisPf.contribIdx;
                savedState.probeIdx = thisPf.probeIdx;
                savedState.outIdx = thisPf.outIdx;
                savedState.inIdx = thisPf.inIdx;
                thisPf.savedState = savedState;
            else
                error(['Error trying to save the contrib/probe status of',...
                       ' the potential/flow %s. This potential/flow has',...
                       ' already a saved state.'], thisPf.getLabel());
            end
        end

        function resetToSavedState(thisPf)
        % RESETTOSAVEDSTATE
            if isempty(thisPf.savedState)
                error(['Error trying to reset the state of the',...
                       ' potential/flow %s. This potential/flow does not',...
                       ' have a saved state!'], thisPf.getLabel());
            else
                savedState = thisPf.savedState;
                thisPf.contrib           = savedState.contrib;
                thisPf.probe             = savedState.probe;
                thisPf.source            = savedState.source;
                thisPf.contribAfterProbe = savedState.contribAfterProbe;
                thisPf.inImplicitEqn     = savedState.inImplicitEqn;
                thisPf.contribIdx        = savedState.contribIdx;
                thisPf.probeIdx          = savedState.probeIdx;
                thisPf.outIdx            = savedState.outIdx;
                thisPf.inIdx             = savedState.inIdx;
            end
        end

    % end methods
    end

    methods (Access = private)
        function setContribIdx(thisPF, cIdx)
        % SETCONTRIBIDX
            if thisPF.contribIdx > cIdx
                error(['Error setting contribIdx. The new contribIdx',...
                       ' cannot be smaller than the old one!']);
            else
                thisPF.contribIdx = cIdx;
            end
        end

        function setProbeIdx(thisPF, pIdx)
        % SETPROBEIDX
            if thisPF.probeIdx < pIdx
                error(['Error setting probeIdx. The new probeIdx cannot be',...
                       ' greater than the old one!']);
            else
                thisPF.probeIdx = pIdx;
            end
        end
    % end private methods
    end

    methods (Static)
        function out = isPotential()
        % ISPOTENTIAL
            out = false;
        end

        function out = isFlow()
        % ISFLOW
            out = false;
        end

        function out = isInNodeCollapse()
        % ISINNODECOLLAPSE
        % required for IrVisitorPrintNodeCollapseVar. Because the
        % dependent PF assignments right at the beginning at the module return
        % an error otherwise when probed with
        % IrVisitorPrintNodeCollapseVar.
            out = false;
        end
    end
    
% end classdef
end
