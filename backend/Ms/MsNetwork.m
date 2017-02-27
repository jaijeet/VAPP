classdef MsNetwork < handle
% MSNETWORK represents the topology (nodes/branches) of a ModSpec device
%
% MsNetwork will implement various ways of mapping Verilog-A contributions onto
% ModSpec IOs. We will use a graph theoretic approach to accomplish this. Since
% nodes and branches of the network are already given to us, there remain two
% important questions in determining the ModSpec IOs:
%
% 1. Which spanning tree do we choose?
% 2. Which IO (explicit output, internal unknown or other IO) do we assign to a
% tree branch or a chord of the spanning tree?
%
% If we see a contribution such as
%
%       I(p,i) <+ f(V(p,i))
%
% There are two canonical ways to go about this.
%
% 1. Because we use vpi as a variable, and need to access its value here, we
%    make it a tree branch and an "internal unknown" or "other IO".
% 2. Because we are producing the value of ipi here and may use it in other
%    equations, we associate the contribution with a chord of the spanning
%    tree. In this case, the value of vpi, that needs to be accessed in this
%    contribution, will be computed from the tree branches. This is always
%    possible since every chord voltage of the spanning tree can be computed as
%    a linear combination of its branches.
%
% There are advantages and disadvantages to each method. The second method will
% in general generate a fewer number of internal unknowns. But because we are
% computing chord flows and branch potentials on the fly, we need to take care
% about when they are accessed. There is nothing to prevent a Verilog-A code to
% access the potential of a tree branch before it is computed.
% (Note that most of the branch potential/chord flow accesses will be to
% generate chord potentials/branch flows).
%
% I will call the first method above the anteBody (variables) method and the
% second method onTheFly (variables) method.
%
% This class has to know which of the above it is to use before it can generate
% the spanning tree of the device network.
%
% Right now, I will only implement the anteBody method.
%
% Terminology:
%   twig: an edge of the network that is in the spanning tree
%   chord: an edge of the network that is not in the spanning tree

% NOTE: right now we are unnecessarily recomputing the spanning tree and the
% following steps in every operation. This class should have a sealing function
% and save stuff like the B and D matrices for future use.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Dec 15, 2016  10:26AM
%==============================================================================

    properties
        nodeVec = MsNode.empty;
        branchVec = MsBranch.empty;
        refNode = MsNode.empty;
        collapsedBranchIdxVec = [];
    end

    methods

        function addNode(thisNetwork, nodeObj)
        % ADDNODE
            if thisNetwork.hasNode(nodeObj) == false
                thisNetwork.nodeVec = [thisNetwork.nodeVec, nodeObj];

                nodeObj.setNetwork(thisNetwork);

                branchVec = nodeObj.getBranchVec();

                for branchObj = branchVec
                    thisNetwork.addBranch(branchObj);
                end
            end
        end

        function out = hasNode(thisNetwork, nodeObj)
        % HASNODE
            if any(thisNetwork.nodeVec == nodeObj)
                out = true;
            else
                out = false;
            end
        end

        function nodeVec = getNodeVec(thisNetwork)
        % GETNODEVEC
            nodeVec = thisNetwork.nodeVec();
        end

        function addBranch(thisNetwork, branchObj)
        % ADDBRANCH
            if thisNetwork.hasBranch(branchObj) == false
                thisNetwork.branchVec = [thisNetwork.branchVec, branchObj];
            end
        end

        function out = hasBranch(thisNetwork, branchObj)
        % HASBRANCH
            if any(thisNetwork.branchVec == branchObj)
                out = true;
            else
                out = false;
            end
        end

        function branchVec = getBranchVec(thisNetwork)
        % GETBRANCHVEC
            branchVec = thisNetwork.branchVec;
        end

        function  setRefNode(thisNetwork, nodeObj)
        % SETREFNODE
            thisNetwork.refNode = nodeObj;
        end

        function refNode = getRefNode(thisNetwork)
        % GETREFER
            refNode = thisNetwork.refNode;
        end

        function [defBranchVec, defSignVec] = getCutDef(thisNetwork, branchObj)
        % GETCUTDEFINITION get the branches and their signs that are required
        % to write a KCL for branchObj

            defBranchVec = MsBranch.empty;
            defSignVec = [];
            if branchObj.isChord() == false
                [twigVec, chordVec] = thisNetwork.getTwigChordVec();
                [B_t, ~] = thisNetwork.getTwigLoopChordCutsetMatrix();
                twigIdx = find(twigVec == branchObj);
                % get the row twigIdx in transpose(B_t)
                twigRow = transpose(B_t(:, twigIdx));
                chordIdx = (twigRow ~= 0);
                defBranchVec = chordVec(chordIdx);
                defSignVec = twigRow(chordIdx);
            else
                error(['You have provided a branch that has an independent',...
                       ' flow. It cannot be expressed in terms of',...
                       ' other flows in the network!']);
            end
        end

        function [defBranchVec, defSignVec] = getLoopDef(thisNetwork, branchObj)
        % GETLOOPDEFINITION get the branches and their signs that are required
        % to write down a KVL for branchObj
            defBranchVec = MsBranch.empty;
            defSignVec = [];
            if branchObj.isTwig() == false
                [twigVec, chordVec] = thisNetwork.getTwigChordVec();
                [~, D_c] = thisNetwork.getTwigLoopChordCutsetMatrix();
                chordIdx = find(chordVec == branchObj);
                % get the row chordIdx in transpose(D_c)
                chordRow = transpose(D_c(:, chordIdx));
                twigIdx = (chordRow ~= 0);
                defBranchVec = twigVec(twigIdx);
                defSignVec = chordRow(twigIdx);
            else
                error(['You have provided a branch that has an independent',...
                       ' potential. It cannot be expressed in terms of',...
                       ' other potentials in the network!']);
            end
        end

        function depBranchVec = getDependentBranch(thisNetwork, branchObj)
        % GETDEPENDENTBRANCH get all branches that depend on branchObj
        % another branch's potential depends on the potential of branchObj if
        % branchObj is a twig
        % another branch's flow depends on the flow of branchObj if branchObj
        % is a chord
            [twigVec, chordVec] = thisNetwork.getTwigChordVec();
            [B_t, D_c] = thisNetwork.getTwigLoopChordCutsetMatrix();
            if branchObj.isTwig() == true
                % get the index of the branchObj in the twig vector
                twigIdx = find(twigVec == branchObj);
                % twigIdx indicates which column of B_t we should look into.
                % A non-zero element there means that we have a chord whose
                % potential value depends on the potential value on the
                % branchObj.
                depChordIdx = find(B_t(:, twigIdx) ~= 0);
                depBranchVec = chordVec(depChordIdx);
            elseif branchObj.isChord() == true
                % get the index of the branchObj in the chordVec
                chordIdx = find(chordVec == branchObj);
                % chordIdx indicates which column of D_c we should look into.
                % The location of a non-zero element in D_c points to the index
                % of a branch whose flow depends on the flow of branchObj.
                depTwigIdx = find(D_c(:, chordIdx) ~= 0);
                depBranchVec = twigVec(depTwigIdx);
            else
                error(['This branch has not been marked either as a twig',...
                       ' or a chord!']);
            end
        end

        function [cutNodeVec, direction] = getCutNodes(thisNetwork, twigObj)
        % GETCUTNODES returns the node objects that are inside of a given cut
        % The cut is described by the twigObj (since every twig corresponds to
        % a cut).
            if twigObj.isTwig() == false
                error(['The argument to this function must be a branch',...
                       ' object which has been marked as a twig!']);
            end

            % A cut separates a network into two unconnected components.
            % One of these components will inlcude the reference node.
            % Because we don't have access to the flow into the reference
            % node (unless we sum all the other flows into the remaining
            % terminals), we will always use the set of nodes that don't
            % include the reference node.

            [twigNode1, twigNode2] = twigObj.getNodes();
            refNode = thisNetwork.getRefNode();

            cutNodeVec = MsNetwork.traverseTreeComponent(twigNode1, twigObj);
            direction = 1;
            if any(cutNodeVec == refNode) == true
                cutNodeVec = MsNetwork.traverseTreeComponent(twigNode2, twigObj);
                direction = -1;
                % note: this should be cheaper than doing a setdiff
            end
        end

        function [B_t, D_c] = getTwigLoopChordCutsetMatrix(thisNetwork)
        % GETTWIGLOOPCHORDCUTSETMATRIX
            [twigVec, chordVec] = thisNetwork.getTwigChordVec();
            [B, D] = thisNetwork.getLoopCutsetMatrix();

            nTwig = numel(twigVec);
            nChord = numel(chordVec);
            nBranch = nTwig + nChord;

            % get the twig part of the loop matrix
            B_t = B(1:nChord, 1:nTwig);
            % get the chord part of the cutset matrix
            D_c = D(1:nTwig, nTwig+1:nBranch);
        end

        function [twigVec, chordVec] = getTwigChordVec(thisNetwork)
        % GETTWIGCHORDVEC
            %branchVec = thisNetwork.getOrderedBranchVec();
            [twigIdx, chordIdx, branchVec] = thisNetwork.getTwigChordIdx();
            twigVec = branchVec(twigIdx);
            chordVec = branchVec(chordIdx);

            % mark branches as twigs or chrods
            % first reset any previous markings
            for branchObj = twigVec
                branchObj.resetTwigChord();
                branchObj.setTwig();
            end

            for branchObj = chordVec
                branchObj.resetTwigChord();
                branchObj.setChord();
            end
        end

        function [twigLabelList, chordLabelList] = getTwigChordLabelList(thisNetwork)
        % GETTWIGCHORDLABELLIST
            twigLabelList = {};
            chordLabelList = {};

            [twigVec, chordVec] = thisNetwork.getTwigChordVec();

            for twigObj = twigVec
                twigLabelList = [twigLabelList, {twigObj.getLabel}];
            end

            for chordObj = chordVec
                chordLabelList = [chordLabelList, {chordObj.getLabel}];
            end
        end

        function [loopMat, cutMat] = getLoopCutsetMatrix(thisNetwork)
        % GETLOOPMATRIX

            inciMat = thisNetwork.getIncidenceMatrix();
            [twigIdxVec, chordIdxVec] = thisNetwork.getTwigChordIdx();
            inciMatTreeOrder = inciMat(:, [twigIdxVec, chordIdxVec]);

            cutMat = rref(inciMatTreeOrder);

            [nNode, nBranch] = size(cutMat);

            cutMat_t = cutMat(:, 1:nNode);
            cutMat_l = cutMat(:, nNode+1:nBranch);

            loopMat = [-transpose(cutMat_l), eye(nBranch-nNode)];
        end

        function [twigIdxVec, chordIdxVec, branchVec] = getTwigChordIdx(thisNetwork)
        % GETSPANNINGTREE =  get the spanning tree of the network
        % twig -> edge in the spanning tree
        % chord -> edge of network not in the spanning tree

            [inciMat, branchVec] = thisNetwork.getIncidenceMatrix();

            % get the row echolon form of the incidence matrix
            inciMatEch = rref(inciMat);
            % procedure to select branches for the spanning tree
            % reference: L. O. Chua and P.-M. Lin, Computer-aided analysis
            % of electronic circuits: algorithms and computational techniques.
            % Prentice-Hall, 1975.
            % Chapter 3-6-1

            twigIdxVec = [];
            [nNode, nBranch] = size(inciMatEch);

            i = 1;
            j = 1;
            while i <= nNode
                while j <= nBranch
                    if inciMatEch(i,j) == 1
                        twigIdxVec = [twigIdxVec, j];
                        i = i + 1;
                        j = j + 1;
                        break;
                    else
                        j = j + 1;
                    end
                end
            end

            chordIdxVec = setdiff(1:nBranch, twigIdxVec);
        end

        function [A, branchVec] = getIncidenceMatrix(thisNetwork)
        % INCIDENCEMATRIX generates the incidence matrix for this network
        %
        % This function has a single input argument: the reference node.
        %
        % The incidence matrix of a network is a rectangular matrix of size NxM
        % where N is the number of nodes and M is the number of branches.
        %
        % A(i,j) = 1 if branch j goes out of node i
        % A(i,j) = -1 if branch j goes into node i
        % A(i,j) = 0 if branch j is not connected to node i
        %
        % When generating A, the order of the branches are important because
        % the tree generation algorithms in which we will use A as a parameter
        % will generate different trees for different orderings of branches in
        % the network.
        %
        % The default ordering of branches for this function will be the
        % following:
        % 1. branches of the reference node
        % 2. branches with potential sources
        % 3. branches with flow contributions (capacitive-resistive branches)
        % 4. branches with potential contributions (inductive-resistive branches)
        % 5. branches with flow sources

            branchVec = thisNetwork.getOrderedBranchVec();
            nodeVec = thisNetwork.nodeVec;
            % remove the reference node
            refNode = thisNetwork.refNode;
            nodeVec(nodeVec == refNode) = [];

            nNode = numel(nodeVec); % = thisNetwork.nNode-1
            nBranch = numel(branchVec);

            A = zeros(nNode, nBranch);

            for j = 1:nBranch
                for i = 1:nNode
                    A(i,j) = branchVec(j).getIncidenceCoeff(nodeVec(i));
                end
            end

            % iterate over all branches and collapse the corresponding column
            % of the incidence matrix if the branch has its collapsed flag set
            columnIdx = 1;
            branchIdx = 1;
            collapsedBranchIdxVec = [];
            while branchIdx <= nBranch
                branchObj = branchVec(branchIdx);
                if branchObj.isCollapsed() == true
                    % Now we want to delete one of the rows that correspond to
                    % the nodes that were collapsed together.
                    % Here the information in A is not enough; we need one
                    % additional piece of information: is one of the nodes a
                    % terminal. If one of the nodes is a terminal, we want to
                    % delete the other node.
                    % First, find the node indices
                    firstNodeIdx = find(A(:, columnIdx) == 1);
                    if isempty(firstNodeIdx)
                        firstNodeIdx = 0;
                        firstNode = refNode;
                    else
                        firstNode = nodeVec(firstNodeIdx);
                    end

                    secondNodeIdx = find(A(:, columnIdx) == -1);
                    if isempty(secondNodeIdx)
                        secondNodeIdx = 0;
                        secondNode = refNode;
                    else
                        secondNode = nodeVec(secondNodeIdx);
                    end

                    % sort the nodes (the first node will be the remaining
                    % node, the second node will be deleted).
                    if secondNodeIdx < firstNodeIdx
                        tempIdx = firstNodeIdx;
                        tempNode = firstNode;
                        firstNodeIdx = secondNodeIdx;
                        firstNode = secondNode;
                        secondNodeIdx = tempIdx;
                        secondNode = tempNode;
                    end
                    % At this stage, secondNode cannot be the reference node.

                    % Now we want to "collapse" the incidence matrix:
                    % If firstNode is the reference node, all we have to do is
                    % to delete the second row. If not, we add the second row
                    % to the first one and then delete it.
                    % Here is the different situations that can occur:
                    % 1. firstNode == secondNode: possible if other branches
                    %    have been collapsed earlier that led to the collapse
                    %    of the current branchObj, i.e., collapse by proxy. In
                    %    this case we don't do anything.

                    if firstNodeIdx ~= secondNodeIdx
                        if firstNodeIdx == 0
                            % 2. firstNode is the ground node. Because of the
                            %    collapse, the second node becomes ground as
                            %    well -> simply delete the row with the
                            %    secondNodeIdx.
                            A(secondNodeIdx, :) = [];
                        else
                            % 3. none of the nodes is the reference node. check
                            %    if one of them is a terminal or not (both
                            %    cannot be terminals at the same time because
                            %    we don't allow collapsing a branch with two
                            %    terminal nodes).
                            if firstNode.isTerminal() == true
                                % add the second row to the first and delete the
                                % second row
                                A(firstNodeIdx, :) = A(firstNodeIdx, :) + ...
                                                            A(secondNodeIdx, :);
                                A(secondNodeIdx, :) = [];
                            else
                                % do the opposite
                                A(secondNodeIdx, :) = A(secondNodeIdx, :) + ...
                                                            A(firstNodeIdx, :);
                                A(firstNodeIdx, :) = [];
                            end

                        end
                    end
                    % delete the column corresponding to the collapsed branch
                    A(:, columnIdx) = [];
                    collapsedBranchIdxVec = [collapsedBranchIdxVec, branchIdx];
                else
                    columnIdx = columnIdx + 1;
                end
                branchIdx = branchIdx + 1;
            end

            thisNetwork.collapsedBranchIdxVec = collapsedBranchIdxVec;
            branchVec(collapsedBranchIdxVec) = [];
        end

        function ncBranchIdxVec = getBranchIdxWithNodeCollapse(thisNetwork, branchIdxVec)
        % GETBRANCHIDXWITHNODECOLLAPSE
            ncBranchIdxVec = branchIdxVec;
            for collapsedBranchIdx = thisNetwork.collapsedBranchIdxVec
                geIdx = find(ncBranchIdxVec >= collapsedBranchIdx);
                ncBranchIdxVec(geIdx) = ncBranchIdxVec(geIdx) + 1;
            end
        end

        function branchVec = getOrderedBranchVec(thisNetwork)
        % GETORDEREDBRANCHVEC order the branches to generate a spanning tree
        %
        % This method will generate an ordering of the edges of the network.
        % In generating a spanning tree, the edges that come first in this
        % ordering will be preferred as spanning tree branches.
        %
            % NOTE: IrNodeModule produces edges between a terminal and the
            % reference node even if it is not there in the Verilog-A code.

            % oder branches of the network
            branchVec = thisNetwork.branchVec;
            collapseBranchVec = MsBranch.empty; % branches that get collapsed
                                                % eventually, i.e., not
                                                % necessarily collapsed now 
            psBranchVec = MsBranch.empty; % potential source branches
            refBranchVec = MsBranch.empty; % reference branches
            indRefBranchVec = MsBranch.empty; % inductive reference branches
            capRefBranchVec = MsBranch.empty; % capacitive reference branches
            remRefBranchVec = MsBranch.empty; % remaining reference branches
            indOuterBranchVec = MsBranch.empty; % inductive terminal branches branches
            capOuterBranchVec = MsBranch.empty; % capacitive terminal branches branches
            remOuterBranchVec = MsBranch.empty; % remaining terminal branches branches
            capBranchVec = MsBranch.empty; % capacitive branches
            indBranchVec = MsBranch.empty; % inductive branches
            fsBranchVec = MsBranch.empty; % flow source branches
            remBranchVec = MsBranch.empty; % remaining branches (no contrib
                                           % reference branches)

            refNode = thisNetwork.refNode;
            if isempty(refNode)
                error(['Error ordering branch vector: this network does ',...
                       'not have a reference node!']);
            end

            for branchObj = branchVec
                potential = branchObj.getPotential();
                flow = branchObj.getFlow();

                %if branchObj.isToBeCollapsed() == true
                %    collapseBranchVec = [collapseBranchVec, branchObj];
                if branchObj.isReference() == true
                    refBranchVec = [refBranchVec, branchObj];
                    if flow.isContrib() == true
                        capRefBranchVec = [capRefBranchVec, branchObj];
                    elseif potential.isContrib() == true
                        indRefBranchVec = [indRefBranchVec, branchObj];
                    else
                        remRefBranchVec = [remRefBranchVec, branchObj];
                    end
                elseif branchObj.isOuter() == true
                    if flow.isContrib() == true
                        capOuterBranchVec = [capOuterBranchVec, branchObj];
                    elseif potential.isContrib() == true
                        indOuterBranchVec = [indOuterBranchVec, branchObj];
                    else
                        remOuterBranchVec = [remOuterBranchVec, branchObj];
                    end
                elseif potential.isSource() == true
                    psBranchVec = [psBranchVec, branchObj];
                elseif flow.isContrib() == true
                    capBranchVec = [capBranchVec, branchObj];
                elseif potential.isContrib() == true
                    indBranchVec = [indBranchVec, branchObj];
                elseif flow.isSource() == true
                    fsBranchVec = [fsBranchVec, branchObj];
                else
                    remBranchVec = [remBranchVec, branchObj];
                end
            end

            % More ordering rules: 
            % 1. twigs should be ordered from earlier potential contrib to
            %    later. And from latest flow probe to earliest.
            % 2. chords should be ordered from earliest flow contrib to latest.
            %    And from latest potential probe to earliest

            % this ordering determines which branches will be preferred in
            % assigning twigs/chords.
            % our choice here should vary the number of internal unks that is
            % produced at the end but shouldn't interfere with the fundamental
            % algorithm. I.e., it shouldn't crash anything.
            branchVec =  [...
                          collapseBranchVec,...
                          psBranchVec,...
                          indRefBranchVec,...
                          capRefBranchVec,...
                          remRefBranchVec,...
                          indOuterBranchVec,...
                          indBranchVec,...
                          capOuterBranchVec,...
                          capBranchVec,...
                          remOuterBranchVec,...
                          remBranchVec,...
                          fsBranchVec,...
                         ];
            % NOTE: in the above ordering, we always prefer inductive branches
            % as twigs. Note that for reference branches, remaining branches
            % come before capacitive branches. This is because we allow
            % reference branches to be zero-flow (i.e., without a
            % contribution).rFor other branches we 
        end

        function obl = getOrderedBranchList(thisNetwork)
        % GETORDEREDBRANCHLIST
            branchVec = thisNetwork.getOrderedBranchVec();
            obl = {};
            for branchObj = branchVec
                obl = [obl, {branchObj.getLabel()}];
            end
        end

        function nll = getNodeLabelList(thisNetwork)
        % GETNODELABELLIST
            nodeVec = thisNetwork.nodeVec;
            nodeVec(nodeVec == thisNetwork.refNode) = [];

            nll = {};
            for nodeObj = nodeVec
                nll = [nll, {nodeObj.getLabel()}];
            end

        end

        function idxVec = getCollapsedBranchIdxVec(thisNetwork)
        % GETCOLLAPSEDBRANCHIDXVEC
            idxVec = thisNetwork.collapsedBranchIdxVec;
        end

        function saveState(thisNetwork)
        % SAVESTATE
            % save the state of terminalFlows
            for nodeObj = thisNetwork.nodeVec
                if nodeObj.isTerminal() == true
                    flowObj = nodeObj.getTerminalFlow();
                    flowObj.saveState();
                end
            end

            % save the state of branch potentials/flows
            for branchObj = thisNetwork.branchVec
                potential = branchObj.getPotential();
                flow = branchObj.getFlow();
                potential.saveState();
                flow.saveState();
            end
        end

        function resetToSavedState(thisNetwork)
        % RESETTOSAVEDSTATE
            
            % reset the state of terminalFlows
            for nodeObj = thisNetwork.nodeVec
                if nodeObj.isTerminal() == true
                    flowObj = nodeObj.getTerminalFlow();
                    flowObj.resetToSavedState();
                end
            end

            % reset the state of branch potentials/flows
            for branchObj = thisNetwork.branchVec
                potential = branchObj.getPotential();
                flow = branchObj.getFlow();
                potential.resetToSavedState();
                flow.resetToSavedState();
            end
        end

    % end methods
    end

    methods (Static)
        function compNodeVec = traverseTreeComponent(nodeObj, noGoTwigObj)
        % TRAVERSETREECOMPONENT traverses two components of a tree starting
        % from nodeObj and ignoring the twigObj.
        % This function separates a tree into two components and returns the
        % component that contains nodeObj.

            % do this recursively
            twigVec = nodeObj.getTwigVec();
            compNodeVec = nodeObj;

            for twigObj = twigVec
                if twigObj ~= noGoTwigObj
                    childNode = twigObj.getOtherNode(nodeObj);
                    childNodeVec = MsNetwork.traverseTreeComponent(childNode, twigObj);
                    compNodeVec = [compNodeVec, childNodeVec];
                end
            end
        end

    end

% end classdef
end
