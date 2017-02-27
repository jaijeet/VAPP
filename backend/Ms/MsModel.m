classdef MsModel < handle
% MSMODEL

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Dec 06, 2016  12:52PM
%==============================================================================
    properties (Constant)
        VARSFX = '__';
    end

    properties
        refNode = MsNode.empty;

        % note that contrary to vars and parms funcs are not ModSpec objects.
        % They are IrNode objects.
        nFeQe = 0;          %
        nFiQi = 0;   % number of internal equations (includes implicit equations)

        implicitContribVec = IrNodeContribution.empty;
        nImplicitContrib = 0;

        expOutList = {};
        intUnkList = {};

        analogNode = IrNodeAnalog.empty;
        intEqnIdx = 0; % internal equation index (includes internal nodes, 
                       % otherIO equations and implicit equations).
        intEqnNameList = {};
        nodeCollapseTree = IrNode.empty;

        % prev
        module = IrNodeModule.empty;
        network = MsNetwork.empty;
        parmMap = containers.Map();
        expOutPotentialVec  = MsPotential.empty
        expOutFlowVec       = MsFlow.empty;
        intUnkPotentialVec  = MsPotential.empty;
        intUnkFlowVec       = MsFlow.empty;
        otherIoPotentialVec = MsPotential.empty;
        otherIoFlowVec      = MsFlow.empty;
        expOutPfVec         = MsPotential.empty;
        intUnkPfVec         = MsPotential.empty;
        otherIoPfVec        = MsPotential.empty;

        nExpOut  = 0;
        nIntUnk  = 0;
        nOtherIo = 0;
        
        ioDefTree = IrNode.empty;
        outputTree = IrNode.empty;
        collapsedBranchVec = MsBranch.empty;
    end

    methods

        function obj = MsModel(module, collapsedBranchVec)
        % MSMODEL
            obj.module = module;
            network = module.getNetwork();
            obj.network = network;
            obj.refNode = network.getRefNode();
            obj.parmMap = containers.Map();
            if nargin > 1
                obj.collapsedBranchVec = collapsedBranchVec;
            end
            obj.seal();
        end

        function seal(thisModel)
        % SEAL

            thisModel.computeCoreModel();

            ioDefTree = IrNodeBlock(0);
            thisModel.ioDefTree = ioDefTree;
            % generate loop and cutset definition equations for dependent flows
            % and potentials and add them to the beginning of the module.
            [loopEqnBlock, cutEqnBlock, collapsedBlock] = thisModel.generateIoDef();
            ioDefTree.addChild(collapsedBlock);
            ioDefTree.addChild(cutEqnBlock);
            ioDefTree.addChild(loopEqnBlock);


            outputTree = IrNodeBlock(0);
            thisModel.outputTree = outputTree;
            % generate explicit outputs
            [expOutPotentialEqnBlock, expOutFlowEqnBlock] = thisModel.generateExpOutEqn();
            outputTree.addChild(expOutPotentialEqnBlock);
            outputTree.addChild(expOutFlowEqnBlock);

            % generate equations for internal unknowns
            [potentialEqnBlock, flowEqnBlock] = thisModel.generateIntUnkEqn();
            outputTree.addChild(potentialEqnBlock);
            outputTree.addChild(flowEqnBlock);

            % generate equations for otherIOs
            otherIoEqnBlock = thisModel.generateOtherIoEqn();
            outputTree.addChild(otherIoEqnBlock);

            % generate outputs for implicit equations
            implicitEqnBlock = thisModel.generateImplicitEqn();
            outputTree.addChild(implicitEqnBlock);
        end

        function computeCoreModel(thisModel)
        % COMPUTECOREMODEL
            thisModel.network.resetToSavedState();
            thisModel.resetTwigChord();
            thisModel.generatePotentialFlowDependencies();
            thisModel.determineExpOutIntUnk();
            thisModel.assignInOutIdx();
        end

        function determineExpOutIntUnk(thisModel)
            % determine explicit outputs and internal unknowns
            nodeVec = thisModel.getNodeVec();
            branchVec = thisModel.getBranchVec();
            refNodeLabel = thisModel.refNode.getLabel();

            expOutPotentialVec = MsPotential.empty;
            expOutFlowVec = MsTerminalFlow.empty; % flows of terminals can be exp outs
            intUnkPotentialVec = MsPotential.empty;
            intUnkFlowVec = MsFlow.empty;
            otherIoPotentialVec = MsPotential.empty;
            otherIoFlowVec = MsTerminalFlow.empty;


            % we want the expOutPfVec to contain explicit outputs and other IOs
            % in a sorted manner. 
            % The sorting is based on the node order given to the module in
            % setTerminalList
            for node = nodeVec
                if node.isTerminal() == true && node.isReference() == false
                    % get the branch from terminal node to the ref node
                    branchLabel = [node.getLabel(), refNodeLabel];
                    branch = thisModel.getBranch(branchLabel);
                    potential = branch.getPotential();
                    if potential.isExpOut() == true
                        expOutPotentialVec = [expOutPotentialVec, potential];
                    else
                        otherIoPotentialVec = [otherIoPotentialVec, potential];
                    end

                    flow = branch.getFlow();

                    % note that the flow on a terminal-to-reference branch
                    % cannot be an explicit output or an other IO.
                    if flow.isIntUnk() == true
                        intUnkFlowVec = [intUnkFlowVec, flow];
                    end

                    % determine which of the external flows to terminals are
                    % explicit outs
                    terminalFlow = node.getTerminalFlow();
                    if terminalFlow.isExpOut() == true
                        expOutFlowVec = [expOutFlowVec, terminalFlow];
                    else
                        otherIoFlowVec = [otherIoFlowVec, terminalFlow];
                    end
                end
            end

            for branch = branchVec
                % NOTE: here we loop over reference branches as well but the
                % potentials on those branches cannot be internalUnks. See
                % MsPoetential.isIntUnk.
                if branch.isTwig() == true
                    potential = branch.getPotential();
                    if potential.isIntUnk() == true
                        intUnkPotentialVec = [intUnkPotentialVec, potential];
                    end
                else
                    % branch is a chord
                    flow = branch.getFlow();
                    if flow.isIntUnk() == true
                        intUnkFlowVec = [intUnkFlowVec, flow];
                    end
                end
            end

            thisModel.expOutPotentialVec = expOutPotentialVec;
            thisModel.expOutFlowVec = expOutFlowVec;
            thisModel.intUnkPotentialVec = intUnkPotentialVec;
            thisModel.intUnkFlowVec = intUnkFlowVec;
            thisModel.otherIoPotentialVec = otherIoPotentialVec;
            thisModel.otherIoFlowVec = otherIoFlowVec;
            thisModel.expOutPfVec = [expOutPotentialVec, expOutFlowVec];
            thisModel.intUnkPfVec = [intUnkPotentialVec, intUnkFlowVec];
            thisModel.otherIoPfVec = [otherIoPotentialVec, otherIoFlowVec];

            
            thisModel.nExpOut = numel(thisModel.expOutPfVec);
            thisModel.nIntUnk = numel(thisModel.intUnkPfVec);
            thisModel.nOtherIo = numel(thisModel.otherIoPfVec);
            % nFiQi has to be determined after implicit equations are factored
            % in.
        end

        function generatePotentialFlowDependencies(thisModel)
        % CREATEPOTENTIALFLOWDEPENDENCIES
            
            network = thisModel.network;
            % get twig and chords.
            % NOTE: MsNetwork sets the appropriate flags.
            [twigVec, chordVec] = network.getTwigChordVec();

            % mark potentials and flows as probed according to the probing
            % status of their dependent quantities.
            % For twig potentials, we will look at chord potentials that depend
            % on them and update the twig potential's probe index.
            for twig = twigVec
                twigPotential = twig.getPotential();
                depChordVec = network.getDependentBranch(twig);
                probeIdx = Inf;
                for depChord = depChordVec
                    depChordPotential = depChord.getPotential();
                    % don't consider this branch if it does not have a probe
                    if depChordPotential.isProbe() == true
                        newProbeIdx = depChordPotential.getProbeIdx();
                        if newProbeIdx < probeIdx
                            probeIdx = newProbeIdx;
                        end
                    end
                end

                if probeIdx < twigPotential.getProbeIdx()
                    twigPotential.setProbe(probeIdx);
                end
            end

            % do the same thing with chords and their flows
            % For chords flows, we will look at twig flows that depend on them
            % and update the chord flow's probe index
            for chord = chordVec
                chordFlow = chord.getFlow();
                depTwigVec = network.getDependentBranch(chord);
                probeIdx = Inf;
                for depTwig = depTwigVec
                    depTwigFlow = depTwig.getFlow();
                    % don't consider this branch if it does not have a probe
                    if depTwigFlow.isProbe() == true
                        newProbeIdx = depTwigFlow.getProbeIdx();
                        if newProbeIdx < probeIdx
                            probeIdx = newProbeIdx;
                        end
                    end
                end

                if probeIdx < chordFlow.getProbeIdx()
                    chordFlow.setProbe(probeIdx);
                end

            end

            % check if the terminal flow of the reference node is a probe. This
            % can only occur if this flow is explicitely probed.
            refNode = thisModel.refNode;
            refNodeDiscip = refNode.getDisciplineName();
            nodeVec = thisModel.getNodeVec();
            refTermFlow = refNode.getTerminalFlow();
            if refTermFlow.isProbe() == true
                % this will be computed with the sum of all other terminal
                % currents. So we set them as probes.
                probeIdx = refTermFlow.getProbeIdx();
                for nodeObj = nodeVec
                    if nodeObj.isTerminal() == true && (nodeObj ~= refNode) && ...
                            strcmp(nodeObj.getDisciplineName(), refNodeDiscip) == true
                        termFlowObj = nodeObj.getTerminalFlow();
                        termFlowObj.setProbe(probeIdx);
                    end
                end
            end
        end

        function assignInOutIdx(thisModel)
        % ASSIGNINOUTIDX assigns input/output indices to potential/flow objects
        % to be used in fe/qe/fi/qi vectors. 
        % TODO: do this for implicit equations as well
            
            for i = 1:thisModel.nOtherIo
                thisModel.otherIoPfVec(i).setInIdx(i);
            end

            for i = 1:thisModel.nIntUnk
                thisModel.intUnkPfVec(i).setInIdx(i);
            end

            for i = 1:thisModel.nExpOut
                thisModel.expOutPfVec(i).setOutIdx(i);
            end

        end

        function [loopEqnBlock, cutEqnBlock, collapsedBlock] = generateIoDef(thisModel)
        % GENERATEIODEF generates definition equations for chord potentials and
        % twig flows.
        % A chord potential/twig flow is a dependent variable in the network.
        % It can be written as a linear combination of twig potentials/chord
        % flows. The elements of these linear combinations are determined by
        % the loop/cutset equations of the network.
        % NOTE: In general, lhs nodes of assignments are variables and lhs
        % nodes of contributions are potential/flow nodes. This case is the
        % only exception in VAPP. Here we use an assignment to define a
        % potential/flow because conceptually this is really an assignment and
        % not a contribution. Why? Because we know that all the quantities on
        % the RHS of the assignment are inputs, i.e., internal unknowns or
        % other IOs. They won't have any ddt type contributions. This is a
        % plainly an assignment---not a contribution.

            collapsedBlock = IrNodeBlock(0);
            loopEqnBlock = IrNodeBlock(0);
            cutEqnBlock = IrNodeBlock(0);

            % set collapsed branch potentials/flows to zero
            for branchObj = thisModel.collapsedBranchVec
                lhsPotentialNode = IrNodePotentialFlow(branchObj.getPotential());
                lhsFlowNode = IrNodePotentialFlow(branchObj.getFlow());

                zeroNodePotential = IrNodeNumerical.getConstantNode(0);
                zeroNodeFlow = IrNodeNumerical.getConstantNode(0);

                assignNodePotential = IrNodeAssignment(lhsPotentialNode, ...
                                                            zeroNodePotential);
                assignNodeFlow = IrNodeAssignment(lhsFlowNode, zeroNodeFlow);

                collapsedBlock.addChild(assignNodePotential);
                collapsedBlock.addChild(assignNodeFlow);
            end

            % loop definitions for potentials
            branchVec = thisModel.getBranchVec();
            for branchObj = branchVec
                if branchObj.isChord() == true
                    potentialObj = branchObj.getPotential();
                    if potentialObj.isProbe() == true
                        lhsPotentialNode = IrNodePotentialFlow(potentialObj);
                        % call the loop equation generation method of thisModel
                        rhsNode = thisModel.generateLoopEqnRhs(branchObj);
                        assignNode = IrNodeAssignment(lhsPotentialNode, rhsNode);
                        loopEqnBlock.addChild(assignNode);
                    end

                    if branchObj.isZeroFlow() == true
                        flowObj = branchObj.getFlow();
                        lhsFlowNode = IrNodePotentialFlow(flowObj);
                        zeroNode = IrNodeNumerical.getConstantNode(0);
                        assignNode = IrNodeAssignment(lhsFlowNode, zeroNode);
                        cutEqnBlock.addChild(assignNode);
                    end
                end
            end

            % cut definitions for flows
            for branchObj = branchVec
                if branchObj.isTwig() == true
                    flowObj = branchObj.getFlow();
                    if flowObj.isProbe() == true
                        % call the cut equation generation method of thisModel
                        lhsFlowNode = IrNodePotentialFlow(flowObj);
                        rhsNode = thisModel.generateCutEqnRhsWithTerminalFlows(branchObj);
                        assignNode = IrNodeAssignment(lhsFlowNode, rhsNode);
                        cutEqnBlock.addChild(assignNode);
                    end
                end
            end

            % KCL for the reference node terminalFlow
            refNode = thisModel.refNode;
            refTermFlowObj = refNode.getTerminalFlow();
            if refTermFlowObj.isProbe() == true
                lhsFlowNode = IrNodePotentialFlow(refTermFlowObj);
                termFlowNodeVec = IrNodePotentialFlow.empty;
                signVec = [];
                nodeVec = thisModel.getNodeVec();
                refNodeDiscip = refNode.getDisciplineName();
                for nodeObj = nodeVec
                    if nodeObj.isTerminal() == true && (nodeObj ~= refNode) && ...
                            strcmp(nodeObj.getDisciplineName(), refNodeDiscip) == true
                        termFlowObj = nodeObj.getTerminalFlow();
                        termFlowNodeVec(end+1) = IrNodePotentialFlow(termFlowObj);
                        signVec(end+1) = -1;
                    end
                end
                rhsNode = IrNodeNumerical.getLinearCombination(...
                                                    termFlowNodeVec, signVec);
                assignNode = IrNodeAssignment(lhsFlowNode, rhsNode);
                cutEqnBlock.addChild(assignNode);
            end
            
        end

        function [expOutPotentialEqnBlock, expOutFlowEqnBlock] = generateExpOutEqn(thisModel)
        % GENERATEEXPOUTEQN
            expOutPotentialEqnBlock = IrNodeBlock();
            expOutPotentialEqnBlock.setIndentLevel(0);
            expOutFlowEqnBlock = IrNodeBlock();
            expOutFlowEqnBlock.setIndentLevel(0);
            expOutIdx = 0;

            for potential = thisModel.expOutPotentialVec
                outNode = IrNodeOutput(potential);
                expOutIdx = expOutIdx + 1;
                outNode.setOutIdx(expOutIdx);
                lhsNode = IrNodeNumericalNull();

                if potential.isContrib() == true
                    rhsPfVec = potential;
                    signVec = 1;
                else
                    chord = potential.getBranch();
                    [rhsPfVec, signVec] = thisModel.generateLoopEqnPfVec(chord);
                end

                outNode.addChild(lhsNode);
                outNode.setRhsPfVec(rhsPfVec);
                outNode.setRhsSignVec(signVec);
                expOutPotentialEqnBlock.addChild(outNode);
                thisModel.nFeQe = thisModel.nFeQe + 1;
            end

            for flow = thisModel.expOutFlowVec
                % a terminal flow cannot have a contribution
                terminal = flow.getTerminal();
                twig = terminal.getBranch(thisModel.refNode);
                outNode = IrNodeOutput(flow);
                expOutIdx = expOutIdx + 1;
                outNode.setOutIdx(expOutIdx);

                [rhsPfVec, signVec] = thisModel.generateCutEqnPfVecWithTerminalFlows(twig);
                if twig.isZeroFlow() == true
                    lhsNode = IrNodeNumericalNull();
                else
                    lhsNode = IrNodePotentialFlow(twig.getFlow());
                    lhsNode.setInverse();
                    lhsNode.setLhs();
                end
                selfIdx = (rhsPfVec == flow);
                rhsPfVec(selfIdx) = [];
                signVec(selfIdx) = [];
                % because in ModSpec terminal flows are going into the terminal
                % get the negative of signVec;
                signVec = -signVec;
                outNode.addChild(lhsNode);
                outNode.setRhsPfVec(rhsPfVec);
                outNode.setRhsSignVec(signVec);

                expOutFlowEqnBlock.addChild(outNode);
                thisModel.nFeQe = thisModel.nFeQe + 1;
            end
        end

        function [potentialEqnBlock, flowEqnBlock] = generateIntUnkEqn(thisModel)
        % GENERATEINTERNALEQUATIONS generates loop and cutset (kvl, kcl) and
        % constitutive equations for internal unknowns.
        % These equations will appear at the end of the module and will be
        % assigned to the entries of the fi and qi vectors.
        % Possible cases:
        % First look at if a branch is a twig or a chord.
        % 1. A branch is a twig
        %   1.1 A twig can only have a potential as an internal unk.
        %   Does it have one?
        %   If yes, there are two more possibilities:
        %       1.1.1 twig has a POTENTIAL contribution
        %
        %           constitutive equation
        %               e.g.,
        %                   V(p,n) <+ fnc(I(p,i))
        %               then
        %                   fi(idx) = potential_pi - fnc(flow_pi);
        %       1.1.2 twig has a FLOW contribution
        %
        %           cutset equation:
        %               e.g.,
        %                   I(p,i) <+ fnc(V(p,i));
        %               then
        %                   fi(idx) = flow_pi - (cutset flow definition of flow_pi)
        %
        % 2. A branch is a chord
        %   2.1 A chord can only have a flow as an internal unk.
        %   Does it have one?
        %       2.1.1 chord has FLOW contrib
        %           constitutive equation
        %           I(p,i) <+ fnc(V(p,i))
        %           => fi(idx) = flow_pi - fnc(potential_pi);
        %       2.1.2 chord has POTENTIAL contrib
        %           loop equation
        %           => fi(idx) = potential_pi - (loop potential definition for
        %                                        potential_pi)

            % we get the lists from module properties:
            % intlUnkPotentialVec
            % intlUnkFlowVec
            intUnkIdx = 0;
            potentialEqnBlock = IrNodeBlock();
            flowEqnBlock = IrNodeBlock();
            potentialEqnBlock.setIndentLevel(0); 
            flowEqnBlock.setIndentLevel(0); 
            intEqnNameList = {};

            for potential = thisModel.intUnkPotentialVec
                twig = potential.getBranch();
                flow = twig.getFlow();

                % branch has to be a twig.
                if potential.isContrib() == true || flow.isContrib() == true

                    % set outIdx of the potential internal unk
                    intUnkIdx = intUnkIdx + 1;
                    potential.setOutIdx(intUnkIdx);
                    outNode = IrNodeOutput(potential);
                    outNode.setOutIdx(intUnkIdx);
                    if potential.isContrib() == true 
                        % use the constitutive equation for this potential
                        % the lhs is an output.
                        % below we are going to subtract two nodes. This will be of
                        % the form 
                        % (potentail_pi_int_unk) - (potential_pi_from_contributions)
                        % potential_pi is the variable we will use during
                        % computations in the module body. And
                        % potential_pi_from_contributions is the variable we will
                        % assign all the contributions for this potential. For
                        % those contributions potential_pi_from_contributions will
                        % be on the LHS of the contribution assignment. Although in
                        % the equation we are constructing here
                        % potential_pi_from_contributions is on the RHS, we will
                        % set it as LHS so that the right variable name gets
                        % printed.
                        intEqnName = ['constitutive equation for ', ...
                                                        potential.getLabel()];
                        lhsNode = IrNodePotentialFlow(potential);
                        rhsPfVec = potential;
                        signVec = 1;
                        % the line below is no typo. We really set the rhsNode as
                        % lhs. For an explanation see the comment immediately
                        % above.
                    else % flow.isContrib() == true
                        % use the cutset equation for this twig's flow
                        intEqnName = ['KCL for ', flow.getLabel()];
                        lhsNode = IrNodePotentialFlow(flow);
                        [rhsPfVec, signVec] = ...
                            thisModel.generateCutEqnPfVecWithTerminalFlows(twig);
                    end

                    lhsNode.setLhs();
                    outNode.addChild(lhsNode);
                    outNode.setRhsPfVec(rhsPfVec);
                    outNode.setRhsSignVec(signVec);
                    potentialEqnBlock.addChild(outNode);

                    intEqnNameList = [intEqnNameList, {intEqnName}];
                    thisModel.nFiQi = thisModel.nFiQi + 1;

                else
                    % I don't know if this situation can occur.
                    % TODO: do a formal analysis for this situation
                    % UPDATE: this situation can occur when twig is an outer
                    % banch
                    % this situation can occur when there is an implicit
                    % equation for this potential
                end

            end


            for flow = thisModel.intUnkFlowVec
                chord = flow.getBranch();
                potential = chord.getPotential();

                if flow.isContrib() == true || potential.isContrib() == true
                    % set outIdx of the flow internal unk
                    intUnkIdx = intUnkIdx + 1;
                    flow.setOutIdx(intUnkIdx);
                    outNode = IrNodeOutput(flow);
                    outNode.setOutIdx(intUnkIdx);
                    if flow.isContrib() == true
                        % use the constitutive equation
                        intEqnName = ['constitutive equation for ', ...
                                                             flow.getLabel()];
                        lhsNode = IrNodePotentialFlow(flow);
                        rhsPfVec = flow;
                        signVec = 1;
                        % the below line is no typo. See comment in the first half
                        % of this method.
                    else % potential.isContrib() == true
                        % use the loop equation for this chord's potential
                        intEqnName = ['KVL for ', potential.getLabel()];
                        lhsNode = IrNodePotentialFlow(potential);
                        [rhsPfVec, signVec] = thisModel.generateLoopEqnPfVec(chord);
                    end

                    lhsNode.setLhs();
                    outNode.addChild(lhsNode);
                    outNode.setRhsPfVec(rhsPfVec);
                    outNode.setRhsSignVec(signVec);
                    flowEqnBlock.addChild(outNode);

                    intEqnNameList = [intEqnNameList, {intEqnName}];
                    thisModel.nFiQi = thisModel.nFiQi + 1;
                else
                    % this situation can occur when there is an implicit
                    % equation for this flow
                    %continue;
                end

            end

            thisModel.intEqnIdx = intUnkIdx;
            thisModel.intEqnNameList = [thisModel.intEqnNameList, intEqnNameList];

        % end generateIntUnkEqn
        end

        function otherIoEqnBlock = generateOtherIoEqn(thisModel)
        % GENERATEOTHERIOEQN
            % below we generate fi/qi outputs for otherIOs.
            % There is only one scenario where we have to supply an extra
            % equation for otherIOs: if a branch voltage is an otherIO AND the
            % terminalFlow to the non-reference node (terminal) of that branch
            % is an otherIO as well.
            % In cases where only one of them is an otherIO (i.e., the other
            % one is an explicit output), the required equation is supplied by
            % the explicit output.
            %
            % Now, for a potential to be an otherIO, it has to be a twig (see
            % the MsPotential.isOtherIO method). There are three possible cases
            % after this.
            %
            % 1. The twig has no potential contribution
            %    1.1. twig has flow contribution
            %    1.2. twig has no flow contribution either
            % 2. twig has potential contribution + potential probe
            %
            % These cases are handle in the following manner:
            % 1.1 -> write down constitutive equation for twig flow.
            % 1.2 -> not applicable because in this case the terminal flow is
            %        not an otherIO. It is an explicitOut.
            % 2.  -> write down constitutive equation for twig potential

            intEqnIdx = thisModel.intEqnIdx;
            intEqnNameList = {};
            otherIoEqnBlock = IrNodeBlock();
            otherIoEqnBlock.setIndentLevel(0); 

            for pfObj = thisModel.otherIoPotentialVec
                potential = pfObj;
                branch = potential.getBranch();
                flow = branch.getFlow();
                % here we get the terminal flow that is associated with this
                % outer potential
                terminal = branch.getTerminalNode();
                terminalFlow = terminal.getTerminalFlow();

                if terminalFlow.isOtherIo() == true
                    outNode = IrNodeOutput(terminalFlow);
                    intEqnIdx = intEqnIdx + 1;
                    outNode.setOutIdx(intEqnIdx);
                    % if the terminalFlow is an otherIO that means that
                    % branch here is not a nullFlow branch. That means we
                    % either have a potential contribution for it or a flow
                    % contribution. If this is not the case we will receive an
                    % ERROR below.
                    if potential.isContrib()
                        % write down constitutive equation for twig potential
                        intEqnName = ['constitutive equation for ', ...
                                                        potential.getLabel()];
                        lhsNode = IrNodePotentialFlow(potential);
                        lhsNode.setLhs();
                        rhsPfVec = potential;
                        signVec = 1;
                        % the line below is no typo. We really set the rhsNode as
                        % lhs. For an explanation see the comment immediately
                        % above.
                    elseif flow.isContrib()
                        % write down cutset equation for twig flow
                        intEqnName = ['KCL for ', flow.getLabel()];
                        lhsNode = IrNodePotentialFlow(flow);
                        lhsNode.setLhs();
                        [rhsPfVec, signVec] = ...
                        thisModel.generateCutEqnPfVecWithTerminalFlows(branch);
                    else
                        intEqnName = ['KCL for ', flow.getLabel()];
                        lhsNode = IrNodeNumericalNull();
                        [rhsPfVec, signVec] = ...
                        thisModel.generateCutEqnPfVecWithTerminalFlows(branch);
                    end

                    outNode.addChild(lhsNode);
                    outNode.setRhsPfVec(rhsPfVec);
                    outNode.setRhsSignVec(signVec);
                    otherIoEqnBlock.addChild(outNode);

                    intEqnNameList = [intEqnNameList, {intEqnName}];
                    thisModel.nFiQi = thisModel.nFiQi + 1;
                end
            end

            thisModel.intEqnIdx = intEqnIdx;
            thisModel.intEqnNameList = [thisModel.intEqnNameList, intEqnNameList];
        end

        function implicitEqnBlock = generateImplicitEqn(thisModel)
        % GENERATEIMPLICITEQN
            intEqnIdx = thisModel.intEqnIdx;
            intEqnNameList = {};
            implicitEqnBlock = IrNodeBlock();
            implicitEqnBlock.setIndentLevel(0);
            nImplicitContrib = thisModel.nImplicitContrib;

            for i = 1:thisModel.nImplicitContrib
                contrib = thisModel.implicitContribVec(i);
                outNode = IrNodeOutput();
                outNode.setImplicit(contrib);
                outNode.setOutIdx(intEqnIdx + i);
                %outNode.addChild(IrNodeNumericalNull());
                % outNode is to be set implicit and it has to create a dummy
                % pfObj for printing purposes.
                implicitEqnBlock.addChild(outNode);
                intEqnName = ['implicit equation ', num2str(i)];
                intEqnNameList = [intEqnNameList, {intEqnName}];
                thisModel.nFiQi = thisModel.nFiQi + 1;
            end

            thisModel.intEqnIdx = intEqnIdx + thisModel.nImplicitContrib;
            thisModel.intEqnNameList = [thisModel.intEqnNameList, intEqnNameList];
        end

        function [defPotentialVec, signVec] = generateLoopEqnPfVec(thisModel, branchObj)
            
            network = thisModel.network;
            [defBranchVec, signVec] = network.getLoopDef(branchObj);
            defPotentialVec = MsPotential.empty;
            for defBranch = defBranchVec
                defPotentialVec = [defPotentialVec, defBranch.getPotential()];
            end
        end

        function [defFlowVec, signVec] = generateCutEqnPfVec(thisModel, branchObj)
            network = thisModel.network;
            [defBranchVec, signVec] = network.getCutDef(branchObj);
            defFlowVec = MsFlow.empty;
            for defBranch = defBranchVec
                defFlowVec = [defFlowVec, defBranch.getFlow()];
            end
        end

        function [defFlowVec, signVec] = generateCutEqnPfVecWithTerminalFlows(...
                                                                thisModel, ...
                                                                branchObj)
            network = thisModel.network;
            [defFlowVec, signVec] = thisModel.generateCutEqnPfVec(branchObj);
            % add the terminal currents to the equation
            [cutNodeVec, direction] = network.getCutNodes(branchObj);
            termFlowVec = MsTerminalFlow.empty;
            for nodeObj = cutNodeVec
                if nodeObj.isTerminal() == true
                    termFlowVec = [termFlowVec, nodeObj.getTerminalFlow()];
                    signVec = [signVec, direction];
                end
            end

            defFlowVec = [defFlowVec, termFlowVec];
        end

        function rhsNode = generateLoopEqnRhs(thisModel, branchObj)
        % GENERATELOOPEQNRHS
            
            [defPotentialVec, signVec] = ...
                                    thisModel.generateLoopEqnPfVec(branchObj);
            defPotentialNodeVec = IrNodePotentialFlow.empty;
            for defPotential = defPotentialVec
                potentialNode = IrNodePotentialFlow(defPotential);
                defPotentialNodeVec = [defPotentialNodeVec, potentialNode];
            end
            % defPotentialNodeVec can be empty: this happens if a branch is
            % collapsed by proxy, i.e. collapse a_b and b_c => a_c is collapsed
            % by proxy
            if isempty(defPotentialNodeVec)
                rhsNode = IrNodeNumerical.getConstantNode(0);
            else
                rhsNode = IrNodeNumerical.getLinearCombination(...
                                                        defPotentialNodeVec,...
                                                        signVec);
            end
        end

        function rhsNode = generateCutEqnRhs(thisModel, branchObj)
        % GENERATECUTEQNRHS
            [defFlowVec, signVec] = thisModel.generateCutEqnPfVec(branchObj);
            defFlowNodeVec = IrNodePotentialFlow.empty;
            for defFlow = defFlowVec
                flowNode = IrNodePotentialFlow(defFlow);
                defFlowNodeVec = [defFlowNodeVec, flowNode];
            end

            % defFlowNodeVec can be empty: this happens if a branch is
            % collapsed by proxy, i.e. collapse a_b and b_c => a_c is collapsed
            % by proxy
            if isempty(defFlowNodeVec)
                rhsNode = IrNodeNumerical.getConstantNode(0);
            else
                rhsNode = IrNodeNumerical.getLinearCombination(...
                                                            defFlowNodeVec,...
                                                            signVec);
            end
        end

        function rhsNode = generateCutEqnRhsWithTerminalFlows(thisModel, ...
                                                              branchObj)
        % GENERATECUTEQNRHSWITHTERMINALFLOWS
            [defFlowVec, signVec] = ...
                    thisModel.generateCutEqnPfVecWithTerminalFlows(branchObj);
            defFlowNodeVec = IrNodePotentialFlow.empty;
            for defFlow = defFlowVec
                flowNode = IrNodePotentialFlow(defFlow);
                defFlowNodeVec = [defFlowNodeVec, flowNode];
            end

            % defFlowNodeVec can be empty: this happens if a branch is
            % collapsed by proxy, i.e. collapse a_b and b_c => a_c is collapsed
            % by proxy
            if isempty(defFlowNodeVec)
                rhsNode = IrNodeNumerical.getConstantNode(0);
            else
                rhsNode = IrNodeNumerical.getLinearCombination(...
                                                            defFlowNodeVec,...
                                                            signVec);
            end
        end

        function outStr = sprintInitIos(thisModel)
            outStr = '';
            varSfx = thisModel.VARSFX;
            nI = thisModel.nIntUnk;
            nO = thisModel.nOtherIo;

            % assign IO values
            outStr = [outStr, '// Initializing inputs\n'];
            for i = 1:nO
                pfObj = thisModel.otherIoPfVec(i);
                outStr = [outStr, pfObj.getLabel(), varSfx, ' = ',...
                                        sprintf('vecX%s(%d);\n', varSfx, i)];
            end

            for i = 1:nI
                pfObj = thisModel.intUnkPfVec(i);
                outStr = [outStr, pfObj.getLabel(), varSfx ' = ',...
                                        sprintf('vecY%s(%d);\n', varSfx, i)];
            end

        end

        function resetTwigChord(thisModel)
        % RESETTWIGCHORD
            branchVec = thisModel.network.getBranchVec();
            for branchObj = branchVec
                branchObj.resetTwigChord();
            end
        end

        function nodeVec = getNodeVec(thisModel)
            nodeVec = thisModel.network.getNodeVec();
        end

        function branchVec = getBranchVec(thisModel)
            branchVec = thisModel.network.getBranchVec();
        end

        function branchObj = getBranch(thisModel, branchAlias)
            branchObj = thisModel.module.getBranch(branchAlias);
        end

        function intUnkList = getIntUnkList(thisModel)
        % GETINTUNKLIST
            intUnkList = {};

            for intUnk = thisModel.intUnkPfVec
                intUnkList = [intUnkList, {intUnk.getLabel()}];
            end
        end

        function expOutList = getExpOutList(thisModel)
        % GETEXPOUTLIST
            expOutList = {};
            refLabel = thisModel.refNode.getLabel();

            for expOut = thisModel.expOutPotentialVec
                expOutList = [expOutList, {expOut.getModSpecLabel()}];
            end

            for expOut = thisModel.expOutFlowVec
                expOutList = [expOutList, {[expOut.getModSpecLabel(), refLabel]}];
            end
        end

        function out = getIntEqnNameList(thisModel)
        % GETINTEQNNAMELIST
            out = thisModel.intEqnNameList;
        end

        function ioDef = getIoDefTree(thisModel)
        % GETIODEFTREE
            ioDef = thisModel.ioDefTree;
        end

        function out = getOutputTree(thisModel)
        % GETOUTPUTTREE
            out = thisModel.outputTree;
        end

        function n = getNFeQe(thisModel)
            n = thisModel.nFeQe;
        end

        function n = getNFiQi(thisModel)
        % GETNFIQI
            n = thisModel.nFiQi;
        end

        function n = getNOtherIo(thisModel)
        % GETNO
            n = thisModel.nOtherIo;
        end

        function n = getNIntUnk(thisModel)
        % GETNINTUNK
            n = thisModel.nIntUnk;
        end

        function inPfVec = getInputPfVec(thisModel)
        % GETINPUTPFVEC
            inPfVec = [thisModel.otherIoPfVec, thisModel.intUnkPfVec];
        end

        function setCollapsedBranchVec(thisModel, branchVec)
        % SETCOLLAPSEDBRANCHVEC
            thisModel.collapsedBranchVec = branchVec;
        end

        function collapseBranches(thisModel)
        % COLLAPSEBRANCHES
            for branchObj = thisModel.collapsedBranchVec
                branchObj.setCollapsed();
            end
        end

        function uncollapseBranches(thisModel)
        % UNCOLLAPSEBRANCHES
            for branchObj = thisModel.collapsedBranchVec
                branchObj.unsetCollapsed();
            end
        end

    % end methods
    end

% end classdef
end
