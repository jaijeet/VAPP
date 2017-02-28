classdef MsModel < handle
% MSMODEL

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Wed Jan 04, 2017  03:13PM
%==============================================================================

    properties
        refNode = {};

        % note that contrary to vars and parms funcs are not ModSpec objects.
        % They are IrNode objects.
        nFeQe = 0;          %
        nFiQi = 0;   % number of internal equations (includes implicit equations)

        implicitContribVecC = {};
        nImplicitContrib = 0;

        expOutList = {};
        intUnkList = {};

        analogNode = {};
        intEqnIdx = 0; % internal equation index (includes internal nodes, 
                       % otherIO equations and implicit equations).
        intEqnNameList = {};
        nodeCollapseTree = {};

        % prev
        module = {};
        network = {};
        parmMap = {};
        expOutPotentialVecC  = {};
        expOutFlowVecC       = {};
        intUnkPotentialVecC  = {};
        intUnkFlowVecC       = {};
        otherIoPotentialVecC = {};
        otherIoFlowVecC      = {};
        expOutPfVecC         = {};
        intUnkPfVecC         = {};
        otherIoPfVecC        = {};

        nExpOut  = 0;
        nIntUnk  = 0;
        nOtherIo = 0;
        
        ioDefTree = {};
        outputTree = {};
        collapsedBranchVecC = {};
        uniqIdGen = {};
        VARSFX = '__';
    end

    methods

        function obj = MsModel(module, collapsedBranchVecC)
        % MSMODEL
            obj.module = module;
            obj.uniqIdGen = module.getUniqIdGen;
            network = module.getNetwork();
            obj.network = network;
            obj.refNode = network.getRefNode();
            obj.parmMap = LookupTableVapp();
            if nargin > 1
                obj.collapsedBranchVecC = collapsedBranchVecC;
            end
            obj.seal();
        end

        function seal(thisModel)
        % SEAL

            thisModel.computeCoreModel();

            ioDefTree = IrNodeBlock(thisModel.uniqIdGen, 0);
            thisModel.ioDefTree = ioDefTree;
            % generate loop and cutset definition equations for dependent flows
            % and potentials and add them to the beginning of the module.
            [loopEqnBlock, cutEqnBlock, collapsedBlock] = thisModel.generateIoDef();
            ioDefTree.addChild(collapsedBlock);
            ioDefTree.addChild(cutEqnBlock);
            ioDefTree.addChild(loopEqnBlock);


            outputTree = IrNodeBlock(thisModel.uniqIdGen, 0);
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
            nodeVecC = thisModel.getNodeVecC();
            branchVecC = thisModel.getBranchVecC();
            refNodeLabel = thisModel.refNode.getLabel();

            expOutPotentialVecC = {};
            expOutFlowVecC = {}; % flows of terminals can be exp outs
            intUnkPotentialVecC = {};
            intUnkFlowVecC = {};
            otherIoPotentialVecC = {};
            otherIoFlowVecC = {};


            % we want the expOutPfVecC to contain explicit outputs and other IOs
            % in a sorted manner. 
            % The sorting is based on the node order given to the module in
            % setTerminalList
            for node = nodeVecC
                nodeObj = node{:};
                if nodeObj.isTerminal() == true && nodeObj.isReference() == false
                    % get the branch from terminal node to the ref node
                    branchLabel = [nodeObj.getLabel(), refNodeLabel];
                    branch = thisModel.getBranch(branchLabel);
                    potential = branch.getPotential();
                    if potential.isExpOut() == true
                        expOutPotentialVecC = [expOutPotentialVecC, {potential}];
                    else
                        otherIoPotentialVecC = [otherIoPotentialVecC, {potential}];
                    end

                    flow = branch.getFlow();

                    % note that the flow on a terminal-to-reference branch
                    % cannot be an explicit output or an other IO.
                    if flow.isIntUnk() == true
                        intUnkFlowVecC = [intUnkFlowVecC, {flow}];
                    end

                    % determine which of the external flows to terminals are
                    % explicit outs
                    terminalFlow = nodeObj.getTerminalFlow();
                    if terminalFlow.isExpOut() == true
                        expOutFlowVecC = [expOutFlowVecC, {terminalFlow}];
                    else
                        otherIoFlowVecC = [otherIoFlowVecC, {terminalFlow}];
                    end
                end
            end

            for branchC = branchVecC
                % NOTE: here we loop over reference branches as well but the
                % potentials on those branches cannot be internalUnks. See
                % MsPoetential.isIntUnk.
                branchObj = branchC{:};
                if branchObj.isTwig() == true
                    potential = branchObj.getPotential();
                    if potential.isIntUnk() == true
                        intUnkPotentialVecC = [intUnkPotentialVecC, {potential}];
                    end
                else
                    % branchObj is a chord
                    flow = branchObj.getFlow();
                    if flow.isIntUnk() == true
                        intUnkFlowVecC = [intUnkFlowVecC, {flow}];
                    end
                end
            end

            thisModel.expOutPotentialVecC = expOutPotentialVecC;
            thisModel.expOutFlowVecC = expOutFlowVecC;
            thisModel.intUnkPotentialVecC = intUnkPotentialVecC;
            thisModel.intUnkFlowVecC = intUnkFlowVecC;
            thisModel.otherIoPotentialVecC = otherIoPotentialVecC;
            thisModel.otherIoFlowVecC = otherIoFlowVecC;
            thisModel.expOutPfVecC = [expOutPotentialVecC, expOutFlowVecC];
            thisModel.intUnkPfVecC = [intUnkPotentialVecC, intUnkFlowVecC];
            thisModel.otherIoPfVecC = [otherIoPotentialVecC, otherIoFlowVecC];

            
            thisModel.nExpOut = numel(thisModel.expOutPfVecC);
            thisModel.nIntUnk = numel(thisModel.intUnkPfVecC);
            thisModel.nOtherIo = numel(thisModel.otherIoPfVecC);
            % nFiQi has to be determined after implicit equations are factored
            % in.
        end

        function generatePotentialFlowDependencies(thisModel)
        % CREATEPOTENTIALFLOWDEPENDENCIES
            
            network = thisModel.network;
            % get twig and chords.
            % NOTE: MsNetwork sets the appropriate flags.
            [twigVecC, chordVecC] = network.getTwigChordVecC();

            % mark potentials and flows as probed according to the probing
            % status of their dependent quantities.
            % For twig potentials, we will look at chord potentials that depend
            % on them and update the twig potential's probe index.
            for twig = twigVecC
                twigObj = twig{:};
                twigPotential = twigObj.getPotential();
                depChordVecC = network.getDependentBranchC(twigObj);
                probeIdx = Inf;
                for depChord = depChordVecC
                    depChordPotential = depChord{:}.getPotential();
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
            for chord = chordVecC
                chordObj = chord{:};
                chordFlow = chordObj.getFlow();
                depTwigVecC = network.getDependentBranchC(chordObj);
                probeIdx = Inf;
                for depTwig = depTwigVecC
                    depTwigFlow = depTwig{:}.getFlow();
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
            nodeVecC = thisModel.getNodeVecC();
            refTermFlow = refNode.getTerminalFlow();
            if refTermFlow.isProbe() == true
                % this will be computed with the sum of all other terminal
                % currents. So we set them as probes.
                probeIdx = refTermFlow.getProbeIdx();
                for nodeObjC = nodeVecC
                    nodeObj = nodeObjC{:};
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
                thisModel.otherIoPfVecC{i}.setInIdx(i);
            end

            for i = 1:thisModel.nIntUnk
                thisModel.intUnkPfVecC{i}.setInIdx(i);
            end

            for i = 1:thisModel.nExpOut
                thisModel.expOutPfVecC{i}.setOutIdx(i);
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

            loopEqnBlock = IrNodeBlock(thisModel.uniqIdGen, 0);
            cutEqnBlock = IrNodeBlock(thisModel.uniqIdGen, 0);
            collapsedBlock = IrNodeBlock(thisModel.uniqIdGen, 0);

            % set collapsed branch potentials/flows to zero
            for branchObj = thisModel.collapsedBranchVecC
                lhsPotentialNode = IrNodePotentialFlow(thisModel.uniqIdGen, branchObj{:}.getPotential());
                lhsFlowNode = IrNodePotentialFlow(thisModel.uniqIdGen, branchObj{:}.getFlow());

                zeroNodePotential = IrNodeNumerical.getConstantNode(thisModel.uniqIdGen, 0);
                zeroNodeFlow = IrNodeNumerical.getConstantNode(thisModel.uniqIdGen, 0);

                assignNodePotential = IrNodeAssignment(thisModel.uniqIdGen, ...
                                                       lhsPotentialNode, ...
                                                       zeroNodePotential);
                assignNodeFlow = IrNodeAssignment(thisModel.uniqIdGen, ...
                                                lhsFlowNode, zeroNodeFlow);

                collapsedBlock.addChild(assignNodePotential);
                collapsedBlock.addChild(assignNodeFlow);
            end

            % loop definitions for potentials
            branchVecC = thisModel.getBranchVecC();
            for branchC = branchVecC
                branchObj = branchC{:};
                if branchObj.isChord() == true
                    potentialObj = branchObj.getPotential();
                    if potentialObj.isProbe() == true
                        lhsPotentialNode = IrNodePotentialFlow(thisModel.uniqIdGen, potentialObj);
                        % call the loop equation generation method of thisModel
                        rhsNode = thisModel.generateLoopEqnRhs(branchObj);
                        assignNode = IrNodeAssignment(thisModel.uniqIdGen, lhsPotentialNode, rhsNode);
                        loopEqnBlock.addChild(assignNode);
                    end

                    if branchObj.isZeroFlow() == true
                        flowObj = branchObj.getFlow();
                        lhsFlowNode = IrNodePotentialFlow(thisModel.uniqIdGen, flowObj);
                        zeroNode = IrNodeNumerical.getConstantNode(thisModel.uniqIdGen, 0);
                        assignNode = IrNodeAssignment(thisModel.uniqIdGen, lhsFlowNode, zeroNode);
                        cutEqnBlock.addChild(assignNode);
                    end
                end
            end

            % cut definitions for flows
            for branchC = branchVecC
                branchObj = branchC{:};
                if branchObj.isTwig() == true
                    flowObj = branchObj.getFlow();
                    if flowObj.isProbe() == true
                        % call the cut equation generation method of thisModel
                        lhsFlowNode = IrNodePotentialFlow(thisModel.uniqIdGen, flowObj);
                        rhsNode = thisModel.generateCutEqnRhsWithTerminalFlows(branchObj);
                        assignNode = IrNodeAssignment(thisModel.uniqIdGen, lhsFlowNode, rhsNode);
                        cutEqnBlock.addChild(assignNode);
                    end
                end
            end

            % KCL for the reference node terminalFlow
            refNode = thisModel.refNode;
            refTermFlowObj = refNode.getTerminalFlow();
            if refTermFlowObj.isProbe() == true
                lhsFlowNode = IrNodePotentialFlow(thisModel.uniqIdGen, refTermFlowObj);
                termFlowNodeVecC = {};
                signVec = [];
                nodeVecC = thisModel.getNodeVecC();
                refNodeDiscip = refNode.getDisciplineName();
                for nodeObjC = nodeVecC
                    nodeObj = nodeObjC{:};
                    if nodeObj.isTerminal() == true && (nodeObj ~= refNode) && ...
                            strcmp(nodeObj.getDisciplineName(), refNodeDiscip) == true
                        termFlowObj = nodeObj.getTerminalFlow();
                        termFlowNodeVecC{end+1} = IrNodePotentialFlow(thisModel.uniqIdGen, termFlowObj);
                        signVec(end+1) = -1;
                    end
                end
                rhsNode = IrNodeNumerical.getLinearCombination(...
                                                    termFlowNodeVecC, signVec);
                assignNode = IrNodeAssignment(thisModel.uniqIdGen, lhsFlowNode, rhsNode);
                cutEqnBlock.addChild(assignNode);
            end
            
        end

        function [expOutPotentialEqnBlock, expOutFlowEqnBlock] = generateExpOutEqn(thisModel)
        % GENERATEEXPOUTEQN
            expOutPotentialEqnBlock = IrNodeBlock(thisModel.uniqIdGen);
            expOutPotentialEqnBlock.setIndentLevel(0);
            expOutFlowEqnBlock = IrNodeBlock(thisModel.uniqIdGen);
            expOutFlowEqnBlock.setIndentLevel(0);
            expOutIdx = 0;

            for potentialC = thisModel.expOutPotentialVecC
                potentialObj = potentialC{:};
                outNode = IrNodeOutput(thisModel.uniqIdGen, potentialObj);
                expOutIdx = expOutIdx + 1;
                outNode.setOutIdx(expOutIdx);
                lhsNode = IrNodeNumericalNull(thisModel.uniqIdGen);

                if potentialObj.isContrib() == true
                    rhsPfVecC = {potentialObj};
                    signVec = 1;
                else
                    chord = potentialObj.getBranch();
                    [rhsPfVecC, signVec] = thisModel.generateLoopEqnPfVecC(chord);
                end

                outNode.addChild(lhsNode);
                outNode.setRhsPfVecC(rhsPfVecC);
                outNode.setRhsSignVec(signVec);
                expOutPotentialEqnBlock.addChild(outNode);
                thisModel.nFeQe = thisModel.nFeQe + 1;
            end

            for flowC = thisModel.expOutFlowVecC
                % a terminal flow cannot have a contribution
                flowObj = flowC{:};
                terminal = flowObj.getTerminal();
                twig = terminal.getBranch(thisModel.refNode);
                outNode = IrNodeOutput(thisModel.uniqIdGen, flowObj);
                expOutIdx = expOutIdx + 1;
                outNode.setOutIdx(expOutIdx);

                [rhsPfVecC, signVec] = thisModel.generateCutEqnPfVecCWithTerminalFlows(twig);
                if twig.isZeroFlow() == true
                    lhsNode = IrNodeNumericalNull(thisModel.uniqIdGen);
                else
                    lhsNode = IrNodePotentialFlow(thisModel.uniqIdGen, twig.getFlow());
                    lhsNode.setInverse();
                    lhsNode.setLhs();
                end
                selfIdx = findIdxOfObjInCellVec(rhsPfVecC, flowObj);
                rhsPfVecC(selfIdx) = [];
                signVec(selfIdx) = [];
                % because in ModSpec terminal flows are going into the terminal
                % get the negative of signVec;
                signVec = -signVec;
                outNode.addChild(lhsNode);
                outNode.setRhsPfVecC(rhsPfVecC);
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
            potentialEqnBlock = IrNodeBlock(thisModel.uniqIdGen);
            flowEqnBlock = IrNodeBlock(thisModel.uniqIdGen);
            potentialEqnBlock.setIndentLevel(0); 
            flowEqnBlock.setIndentLevel(0); 
            intEqnNameList = {};

            for potentialC = thisModel.intUnkPotentialVecC
                potentialObj = potentialC{:};
                twig = potentialObj.getBranch();
                flow = twig.getFlow();

                % branch has to be a twig.
                if potentialObj.isContrib() == true || flow.isContrib() == true

                    % set outIdx of the potential internal unk
                    intUnkIdx = intUnkIdx + 1;
                    potentialObj.setOutIdx(intUnkIdx);
                    outNode = IrNodeOutput(thisModel.uniqIdGen, potentialObj);
                    outNode.setOutIdx(intUnkIdx);
                    if potentialObj.isContrib() == true 
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
                                                        potentialObj.getLabel()];
                        lhsNode = IrNodePotentialFlow(thisModel.uniqIdGen, potentialObj);
                        rhsPfVecC = {potentialObj};
                        signVec = 1;
                        % the line below is no typo. We really set the rhsNode as
                        % lhs. For an explanation see the comment immediately
                        % above.
                    else % flow.isContrib() == true
                        % use the cutset equation for this twig's flow
                        intEqnName = ['KCL for ', flow.getLabel()];
                        lhsNode = IrNodePotentialFlow(thisModel.uniqIdGen, flow);
                        [rhsPfVecC, signVec] = ...
                            thisModel.generateCutEqnPfVecCWithTerminalFlows(twig);
                    end

                    lhsNode.setLhs();
                    outNode.addChild(lhsNode);
                    outNode.setRhsPfVecC(rhsPfVecC);
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


            for flowC = thisModel.intUnkFlowVecC
                flowObj = flowC{:};
                chord = flowObj.getBranch();
                potential = chord.getPotential();

                if flowObj.isContrib() == true || potential.isContrib() == true
                    % set outIdx of the flowObj internal unk
                    intUnkIdx = intUnkIdx + 1;
                    flowObj.setOutIdx(intUnkIdx);
                    outNode = IrNodeOutput(thisModel.uniqIdGen, flowObj);
                    outNode.setOutIdx(intUnkIdx);
                    if flowObj.isContrib() == true
                        % use the constitutive equation
                        intEqnName = ['constitutive equation for ', ...
                                                             flowObj.getLabel()];
                        lhsNode = IrNodePotentialFlow(thisModel.uniqIdGen, flowObj);
                        rhsPfVecC = {flowObj};
                        signVec = 1;
                        % the below line is no typo. See comment in the first half
                        % of this method.
                    else % potential.isContrib() == true
                        % use the loop equation for this chord's potential
                        intEqnName = ['KVL for ', potential.getLabel()];
                        lhsNode = IrNodePotentialFlow(thisModel.uniqIdGen, potential);
                        [rhsPfVecC, signVec] = thisModel.generateLoopEqnPfVecC(chord);
                    end

                    lhsNode.setLhs();
                    outNode.addChild(lhsNode);
                    outNode.setRhsPfVecC(rhsPfVecC);
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
            otherIoEqnBlock = IrNodeBlock(thisModel.uniqIdGen);
            otherIoEqnBlock.setIndentLevel(0); 

            for pfObj = thisModel.otherIoPotentialVecC
                potential = pfObj{:};
                branch = potential.getBranch();
                flow = branch.getFlow();
                % here we get the terminal flow that is associated with this
                % outer potential
                terminal = branch.getTerminalNode();
                terminalFlow = terminal.getTerminalFlow();

                if terminalFlow.isOtherIo() == true
                    outNode = IrNodeOutput(thisModel.uniqIdGen, terminalFlow);
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
                        lhsNode = IrNodePotentialFlow(thisModel.uniqIdGen, potential);
                        lhsNode.setLhs();
                        rhsPfVecC = {potential};
                        signVec = 1;
                        % the line below is no typo. We really set the rhsNode as
                        % lhs. For an explanation see the comment immediately
                        % above.
                    elseif flow.isContrib()
                        % write down cutset equation for twig flow
                        intEqnName = ['KCL for ', flow.getLabel()];
                        lhsNode = IrNodePotentialFlow(thisModel.uniqIdGen, flow);
                        lhsNode.setLhs();
                        [rhsPfVecC, signVec] = ...
                        thisModel.generateCutEqnPfVecCWithTerminalFlows(branch);
                    else
                        intEqnName = ['KCL for ', flow.getLabel()];
                        lhsNode = IrNodeNumericalNull(thisModel.uniqIdGen);
                        [rhsPfVecC, signVec] = ...
                        thisModel.generateCutEqnPfVecCWithTerminalFlows(branch);
                    end

                    outNode.addChild(lhsNode);
                    outNode.setRhsPfVecC(rhsPfVecC);
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
            implicitEqnBlock = IrNodeBlock(thisModel.uniqIdGen);
            implicitEqnBlock.setIndentLevel(0);
            nImplicitContrib = thisModel.nImplicitContrib;

            for i = 1:thisModel.nImplicitContrib
                contrib = thisModel.implicitContribVecC{i};
                outNode = IrNodeOutput(thisModel.uniqIdGen);
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

        function [defPotentialVecC, signVec] = generateLoopEqnPfVecC(thisModel, branchObj)
            
            network = thisModel.network;
            [defBranchVecC, signVec] = network.getLoopDef(branchObj);
            defPotentialVecC = {}; %MsPotential.empty;
            for defBranch = defBranchVecC
                defPotentialVecC = [defPotentialVecC, {defBranch{:}.getPotential()}];
            end
        end

        function [defFlowVecC, signVec] = generateCutEqnPfVecC(thisModel, branchObj)
            network = thisModel.network;
            [defBranchVecC, signVec] = network.getCutDef(branchObj);
            defFlowVecC = {}; % MsFlow.empty;
            for defBranch = defBranchVecC
                defFlowVecC = [defFlowVecC, {defBranch{:}.getFlow()}];
            end
        end

        function [defFlowVecC, signVec] = generateCutEqnPfVecCWithTerminalFlows(...
                                                                thisModel, ...
                                                                branchObj)
            network = thisModel.network;
            [defFlowVecC, signVec] = thisModel.generateCutEqnPfVecC(branchObj);
            % add the terminal currents to the equation
            [cutNodeVecC, direction] = network.getCutNodes(branchObj);
            termFlowVecC = {}; %MsTerminalFlow.empty;
            for nodeC = cutNodeVecC
                nodeObj = nodeC{:};
                if nodeObj.isTerminal() == true
                    termFlowVecC = [termFlowVecC, {nodeObj.getTerminalFlow()}];
                    signVec = [signVec, direction];
                end
            end

            defFlowVecC = [defFlowVecC, termFlowVecC];
        end

        function rhsNode = generateLoopEqnRhs(thisModel, branchObj)
        % GENERATELOOPEQNRHS
            
            [defPotentialVecC, signVec] = ...
                                    thisModel.generateLoopEqnPfVecC(branchObj);
            defPotentialNodeVecC = {}; %IrNodePotentialFlow.empty;
            for defPotential = defPotentialVecC
                potentialNode = IrNodePotentialFlow(thisModel.uniqIdGen, defPotential{:});
                defPotentialNodeVecC = [defPotentialNodeVecC, {potentialNode}];
            end
            % defPotentialNodeVec can be empty: this happens if a branch is
            % collapsed by proxy, i.e. collapse a_b and b_c => a_c is collapsed
            % by proxy
            if isempty(defPotentialNodeVecC)
                rhsNode = IrNodeNumerical.getConstantNode(thisModel.uniqIdGen, 0);
            else
                rhsNode = IrNodeNumerical.getLinearCombination(thisModel.uniqIdGen, ...
                                                        defPotentialNodeVecC,...
                                                        signVec);
            end
        end

        function rhsNode = generateCutEqnRhs(thisModel, branchObj)
        % GENERATECUTEQNRHS
            [defFlowVecC, signVec] = thisModel.generateCutEqnPfVecC(branchObj);
            defFlowNodeVecC = {}; %IrNodePotentialFlow.empty;
            for defFlow = defFlowVecC
                flowNode = IrNodePotentialFlow(thisModel.uniqIdGen, defFlow{:});
                defFlowNodeVecC = [defFlowNodeVecC, {flowNode}];
            end

            % defFlowNodeVec can be empty: this happens if a branch is
            % collapsed by proxy, i.e. collapse a_b and b_c => a_c is collapsed
            % by proxy
            if isempty(defFlowNodeVecC)
                rhsNode = IrNodeNumerical.getConstantNode(thisModel.uniqIdGen, 0);
            else
                rhsNode = IrNodeNumerical.getLinearCombination(thisModel.uniqIdGen, ...
                                                            defFlowNodeVecC,...
                                                            signVec);
            end
        end

        function rhsNode = generateCutEqnRhsWithTerminalFlows(thisModel, ...
                                                              branchObj)
        % GENERATECUTEQNRHSWITHTERMINALFLOWS
            [defFlowVecC, signVec] = ...
                    thisModel.generateCutEqnPfVecCWithTerminalFlows(branchObj);
            defFlowNodeVecC = {}; %IrNodePotentialFlow.empty;
            for defFlow = defFlowVecC
                flowNode = IrNodePotentialFlow(thisModel.uniqIdGen, defFlow{:});
                defFlowNodeVecC = [defFlowNodeVecC, {flowNode}];
            end

            % defFlowNodeVec can be empty: this happens if a branch is
            % collapsed by proxy, i.e. collapse a_b and b_c => a_c is collapsed
            % by proxy
            if isempty(defFlowNodeVecC)
                rhsNode = IrNodeNumerical.getConstantNode(thisModel.uniqIdGen, 0);
            else
                rhsNode = IrNodeNumerical.getLinearCombination(thisModel.uniqIdGen, ...
                                                            defFlowNodeVecC,...
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
                pfObj = thisModel.otherIoPfVecC{i};
                outStr = [outStr, pfObj.getLabel(), varSfx, ' = ',...
                                        sprintf('vecX%s(%d);\n', varSfx, i)];
            end

            for i = 1:nI
                pfObj = thisModel.intUnkPfVecC{i};
                outStr = [outStr, pfObj.getLabel(), varSfx ' = ',...
                                        sprintf('vecY%s(%d);\n', varSfx, i)];
            end

        end

        function resetTwigChord(thisModel)
        % RESETTWIGCHORD
            branchVecC = thisModel.network.getBranchVecC();
            for branchObj = branchVecC
                branchObj{:}.resetTwigChord();
            end
        end

        function nodeVecC = getNodeVecC(thisModel)
            nodeVecC = thisModel.network.getNodeVecC();
        end

        function branchVecC = getBranchVecC(thisModel)
            branchVecC = thisModel.network.getBranchVecC();
        end

        function branchObj = getBranch(thisModel, branchAlias)
            branchObj = thisModel.module.getBranch(branchAlias);
        end

        function intUnkList = getIntUnkList(thisModel)
        % GETINTUNKLIST
            intUnkList = {};

            for intUnk = thisModel.intUnkPfVecC
                intUnkList = [intUnkList, {intUnk{:}.getLabel()}];
            end
        end

        function expOutList = getExpOutList(thisModel)
        % GETEXPOUTLIST
            expOutList = {};
            refLabel = thisModel.refNode.getLabel();

            for expOut = thisModel.expOutPotentialVecC
                expOutList = [expOutList, {expOut{:}.getModSpecLabel()}];
            end

            for expOut = thisModel.expOutFlowVecC
                expOutList = [expOutList, {[expOut{:}.getModSpecLabel(), refLabel]}];
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

        function inPfVecC = getInputPfVecC(thisModel)
        % GETINPUTPFVECC
            inPfVecC = [thisModel.otherIoPfVecC, thisModel.intUnkPfVecC];
        end

        function setCollapsedBranchVecC(thisModel, branchVecC)
        % SETCOLLAPSEDBRANCHVECC
            thisModel.collapsedBranchVecC = branchVecC;
        end

        function collapseBranches(thisModel)
        % COLLAPSEBRANCHES
            for branchObj = thisModel.collapsedBranchVecC
                branchObj{:}.setCollapsed();
            end
        end

        function uncollapseBranches(thisModel)
        % UNCOLLAPSEBRANCHES
            for branchObj = thisModel.collapsedBranchVecC
                branchObj{:}.unsetCollapsed();
            end
        end

    % end methods
    end

% end classdef
end
