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
% Last modified: Thu Jan 05, 2017  10:42AM
%==============================================================================

    properties
        nodeVecC = {};
        branchVecC = {};
        refNode = {};
        collapsedBranchIdxVec = [];
    end

    methods

        function addNode(thisNetwork, nodeObj)
        % ADDNODE
            if thisNetwork.hasNode(nodeObj) == false
                thisNetwork.nodeVecC = [thisNetwork.nodeVecC, {nodeObj}];

                nodeObj.setNetwork(thisNetwork);

                branchVecC = nodeObj.getBranchVecC();

                for branchObj = branchVecC
                    thisNetwork.addBranch(branchObj{:});
                end
            end
        end

        function out = hasNode(thisNetwork, nodeObj)
        % HASNODE
            if findIdxOfObjInCellVec(thisNetwork.nodeVecC, nodeObj) > 0 
                out = true;
            else
                out = false;
            end
        end

        function nodeVecC = getNodeVecC(thisNetwork)
        % GETNODEVECC
            nodeVecC = thisNetwork.nodeVecC;
        end

        function addBranch(thisNetwork, branchObj)
        % ADDBRANCH
            if thisNetwork.hasBranch(branchObj) == false
                thisNetwork.branchVecC = [thisNetwork.branchVecC, {branchObj}];
            end
        end

        function out = hasBranch(thisNetwork, branchObj)
        % HASBRANCH
            if findIdxOfObjInCellVec(thisNetwork.branchVecC, branchObj) > 0
                out = true;
            else
                out = false;
            end
        end

        function branchVecC = getBranchVecC(thisNetwork)
        % GETBRANCHVECC
            branchVecC = thisNetwork.branchVecC;
        end

        function  setRefNode(thisNetwork, nodeObj)
        % SETREFNODE
            thisNetwork.refNode = nodeObj;
        end

        function refNode = getRefNode(thisNetwork)
        % GETREFER
            refNode = thisNetwork.refNode;
        end

        function [defBranchVecC, defSignVec] = getCutDef(thisNetwork, branchObj)
        % GETCUTDEFINITION get the branches and their signs that are required
        % to write a KCL for branchObj

            defBranchVecC = {};
            defSignVec = [];
            if branchObj.isChord() == false
                [twigVecC, chordVecC] = thisNetwork.getTwigChordVecC();
                [B_t, ~] = thisNetwork.getTwigLoopChordCutsetMatrix();
                twigIdx = findIdxOfObjInCellVec(twigVecC, branchObj);
                % get the row twigIdx in transpose(B_t)
                twigRow = transpose(B_t(:, twigIdx));
                chordIdx = (twigRow ~= 0);
                defBranchVecC = chordVecC(chordIdx);
                defSignVec = twigRow(chordIdx);
            else
                error(['You have provided a branch that has an independent',...
                       ' flow. It cannot be expressed in terms of',...
                       ' other flows in the network!']);
            end
        end

        function [defBranchVecC, defSignVec] = getLoopDef(thisNetwork, branchObj)
        % GETLOOPDEFINITION get the branches and their signs that are required
        % to write down a KVL for branchObj
            if branchObj.isTwig() == false
                [twigVecC, chordVecC] = thisNetwork.getTwigChordVecC();
                [~, D_c] = thisNetwork.getTwigLoopChordCutsetMatrix();
                chordIdx = findIdxOfObjInCellVec(chordVecC, branchObj);
                % get the row chordIdx in transpose(D_c)
                chordRow = transpose(D_c(:, chordIdx));
                twigIdx = (chordRow ~= 0);
                defBranchVecC = twigVecC(twigIdx);
                defSignVec = chordRow(twigIdx);
            else
                error(['You have provided a branch that has an independent',...
                       ' potential. It cannot be expressed in terms of',...
                       ' other potentials in the network!']);
            end
        end

        function depBranchVecC = getDependentBranchC(thisNetwork, branchObj)
        % GETDEPENDENTBRANCH get all branches that depend on branchObj
        % another branch's potential depends on the potential of branchObj if
        % branchObj is a twig
        % another branch's flow depends on the flow of branchObj if branchObj
        % is a chord
            [twigVecC, chordVecC] = thisNetwork.getTwigChordVecC();
            [B_t, D_c] = thisNetwork.getTwigLoopChordCutsetMatrix();
            if branchObj.isTwig() == true
                % get the index of the branchObj in the twig vector
                twigIdx = findIdxOfObjInCellVec(twigVecC, branchObj);
                % twigIdx indicates which column of B_t we should look into.
                % A non-zero element there means that we have a chord whose
                % potential value depends on the potential value on the
                % branchObj.
                depChordIdx = find(B_t(:, twigIdx) ~= 0);
                depBranchVecC = chordVecC(depChordIdx);
            elseif branchObj.isChord() == true
                % get the index of the branchObj in the chordVecC
                chordIdx = findIdxOfObjInCellVec(chordVecC, branchObj);
                % chordIdx indicates which column of D_c we should look into.
                % The location of a non-zero element in D_c points to the index
                % of a branch whose flow depends on the flow of branchObj.
                depTwigIdx = find(D_c(:, chordIdx) ~= 0);
                depBranchVecC = twigVecC(depTwigIdx);
            else
                error(['This branch has not been marked either as a twig',...
                       ' or a chord!']);
            end
        end

        function [cutNodeVecC, direction] = getCutNodes(thisNetwork, twigObj)
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

            cutNodeVecC = MsNetwork.traverseTreeComponent(twigNode1, twigObj);
            direction = 1;
            if findIdxOfObjInCellVec(cutNodeVecC, refNode) > 0
                cutNodeVecC = MsNetwork.traverseTreeComponent(twigNode2, twigObj);
                direction = -1;
                % note: this should be cheaper than doing a setdiff
            end
        end

        function [B_t, D_c] = getTwigLoopChordCutsetMatrix(thisNetwork)
        % GETTWIGLOOPCHORDCUTSETMATRIX
            [twigVecC, chordVecC] = thisNetwork.getTwigChordVecC();
            [B, D] = thisNetwork.getLoopCutsetMatrix();

            nTwig = numel(twigVecC);
            nChord = numel(chordVecC);
            nBranch = nTwig + nChord;

            % get the twig part of the loop matrix
            B_t = B(1:nChord, 1:nTwig);
            % get the chord part of the cutset matrix
            D_c = D(1:nTwig, nTwig+1:nBranch);
        end

        function [twigVecC, chordVecC] = getTwigChordVecC(thisNetwork)
        % GETTWIGCHORDVECC
            [twigIdx, chordIdx, branchVecC] = thisNetwork.getTwigChordIdx();
            twigVecC = branchVecC(twigIdx);
            chordVecC = branchVecC(chordIdx);

            % mark branches as twigs or chrods
            % first reset any previous markings
            for branch = twigVecC
                branchObj = branch{:};
                branchObj.resetTwigChord();
                branchObj.setTwig();
            end

            for branch = chordVecC
                branchObj = branch{:};
                branchObj.resetTwigChord();
                branchObj.setChord();
            end
        end

        function [twigLabelList, chordLabelList] = getTwigChordLabelList(thisNetwork)
        % GETTWIGCHORDLABELLIST
            twigLabelList = {};
            chordLabelList = {};

            [twigVecC, chordVecC] = thisNetwork.getTwigChordVecC();

            for twigObj = twigVecC
                twigLabelList = [twigLabelList, {twigObj{:}.getLabel}];
            end

            for chordObj = chordVecC
                chordLabelList = [chordLabelList, {chordObj{:}.getLabel}];
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

        function [twigIdxVec, chordIdxVec, branchVecC] = getTwigChordIdx(thisNetwork)
        % GETSPANNINGTREE =  get the spanning tree of the network
        % twig -> edge in the spanning tree
        % chord -> edge of network not in the spanning tree

            [inciMat, branchVecC] = thisNetwork.getIncidenceMatrix();

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

        function [A, branchVecC] = getIncidenceMatrix(thisNetwork)
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

            branchVecC = thisNetwork.getOrderedBranchVecC();
            nodeVecC = thisNetwork.nodeVecC;
            % remove the reference node
            refNode = thisNetwork.refNode;
            refNodeIdx = findIdxOfObjInCellVec(nodeVecC, refNode);
            nodeVecC(refNodeIdx) = [];

            nNode = numel(nodeVecC); % = thisNetwork.nNode-1
            nBranch = numel(branchVecC);

            A = zeros(nNode, nBranch);

            for j = 1:nBranch
                for i = 1:nNode
                    A(i,j) = branchVecC{j}.getIncidenceCoeff(nodeVecC{i});
                end
            end

            % iterate over all branches and collapse the corresponding column
            % of the incidence matrix if the branch has its collapsed flag set
            columnIdx = 1;
            branchIdx = 1;
            collapsedBranchIdxVec = [];
            while branchIdx <= nBranch
                branchObj = branchVecC{branchIdx};
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
                        firstNode = nodeVecC{firstNodeIdx};
                    end

                    secondNodeIdx = find(A(:, columnIdx) == -1);
                    if isempty(secondNodeIdx)
                        secondNodeIdx = 0;
                        secondNode = refNode;
                    else
                        secondNode = nodeVecC{secondNodeIdx};
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
            branchVecC(collapsedBranchIdxVec) = [];
        end

        function ncBranchIdxVec = getBranchIdxWithNodeCollapse(thisNetwork, branchIdxVec)
        % GETBRANCHIDXWITHNODECOLLAPSE
            ncBranchIdxVec = branchIdxVec;
            for collapsedBranchIdx = thisNetwork.collapsedBranchIdxVec
                geIdx = find(ncBranchIdxVec >= collapsedBranchIdx);
                ncBranchIdxVec(geIdx) = ncBranchIdxVec(geIdx) + 1;
            end
        end

        function branchVecC = getOrderedBranchVecC(thisNetwork)
        % GETORDEREDBRANCHVECC order the branches to generate a spanning tree
        %
        % This method will generate an ordering of the edges of the network.
        % In generating a spanning tree, the edges that come first in this
        % ordering will be preferred as spanning tree branches.
        %
            % NOTE: IrNodeModule produces edges between a terminal and the
            % reference node even if it is not there in the Verilog-A code.

            % oder branches of the network
            branchVecC = thisNetwork.branchVecC;
            collapseBranchVecC = {}; % branches that get collapsed
                                                % eventually, i.e., not
                                                % necessarily collapsed now 
            psBranchVecC = {}; % potential source branches
            refBranchVecC = {}; % reference branches
            indRefBranchVecC = {}; % inductive reference branches
            capRefBranchVecC = {}; % capacitive reference branches
            remRefBranchVecC = {}; % remaining reference branches
            indOuterBranchVecC = {}; % inductive terminal branches branches
            capOuterBranchVecC = {}; % capacitive terminal branches branches
            remOuterBranchVecC = {}; % remaining terminal branches branches
            capBranchVecC = {}; % capacitive branches
            indBranchVecC = {}; % inductive branches
            fsBranchVecC = {}; % flow source branches
            remBranchVecC = {}; % remaining branches (no contrib
                                           % reference branches)

            refNode = thisNetwork.refNode;
            if isempty(refNode)
                error(['Error ordering branch vector: this network does ',...
                       'not have a reference node!']);
            end

            for branch = branchVecC
                branchObj = branch{:};
                potential = branchObj.getPotential();
                flow = branchObj.getFlow();

                %if branchObj.isToBeCollapsed() == true
                %    collapseBranchVec = [collapseBranchVec, branchObj];
                if branchObj.isReference() == true
                    refBranchVecC = [refBranchVecC, {branchObj}];
                    if flow.isContrib() == true
                        capRefBranchVecC = [capRefBranchVecC, {branchObj}];
                    elseif potential.isContrib() == true
                        indRefBranchVecC = [indRefBranchVecC, {branchObj}];
                    else
                        remRefBranchVecC = [remRefBranchVecC, {branchObj}];
                    end
                elseif branchObj.isOuter() == true
                    if flow.isContrib() == true
                        capOuterBranchVecC = [capOuterBranchVecC, {branchObj}];
                    elseif potential.isContrib() == true
                        indOuterBranchVecC = [indOuterBranchVecC, {branchObj}];
                    else
                        remOuterBranchVecC = [remOuterBranchVecC, {branchObj}];
                    end
                elseif potential.isSource() == true
                    psBranchVecC = [psBranchVecC, {branchObj}];
                elseif flow.isContrib() == true
                    capBranchVecC = [capBranchVecC, {branchObj}];
                elseif potential.isContrib() == true
                    indBranchVecC = [indBranchVecC, {branchObj}];
                elseif flow.isSource() == true
                    fsBranchVecC = [fsBranchVecC, {branchObj}];
                else
                    remBranchVecC = [remBranchVecC, {branchObj}];
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
            branchVecC =  [...
                          collapseBranchVecC,...
                          psBranchVecC,...
                          indRefBranchVecC,...
                          capRefBranchVecC,...
                          remRefBranchVecC,...
                          indOuterBranchVecC,...
                          indBranchVecC,...
                          capOuterBranchVecC,...
                          capBranchVecC,...
                          remOuterBranchVecC,...
                          remBranchVecC,...
                          fsBranchVecC,...
                         ];
            % NOTE: in the above ordering, we always prefer inductive branches
            % as twigs. Note that for reference branches, remaining branches
            % come before capacitive branches. This is because we allow
            % reference branches to be zero-flow (i.e., without a
            % contribution).rFor other branches we 
        end

        function obl = getOrderedBranchList(thisNetwork)
        % GETORDEREDBRANCHLIST
            branchVecC = thisNetwork.getOrderedBranchVecC();
            obl = {};
            for branchObj = branchVecC
                obl = [obl, {branchObj{:}.getLabel()}];
            end
        end

        function nll = getNodeLabelList(thisNetwork)
        % GETNODELABELLIST
            nodeVecC = thisNetwork.nodeVecC;
            refNodeIdx = findIdxOfObjInCellVec(nodeVecC, thisNetwork.refNode);
            nodeVecC(refNodeIdx) = [];

            nll = {};
            for nodeObj = nodeVecC
                nll = [nll, {nodeObj{:}.getLabel()}];
            end

        end

        function idxVec = getCollapsedBranchIdxVec(thisNetwork)
        % GETCOLLAPSEDBRANCHIDXVEC
            idxVec = thisNetwork.collapsedBranchIdxVec;
        end

        function saveState(thisNetwork)
        % SAVESTATE
            % save the state of terminalFlows
            for nodeObj = thisNetwork.nodeVecC
                if nodeObj{:}.isTerminal() == true
                    flowObj = nodeObj{:}.getTerminalFlow();
                    flowObj.saveState();
                end
            end

            % save the state of branch potentials/flows
            for branchObj = thisNetwork.branchVecC
                potential = branchObj{:}.getPotential();
                flow = branchObj{:}.getFlow();
                potential.saveState();
                flow.saveState();
            end
        end

        function resetToSavedState(thisNetwork)
        % RESETTOSAVEDSTATE
            
            % reset the state of terminalFlows
            for nodeObj = thisNetwork.nodeVecC
                if nodeObj{:}.isTerminal() == true
                    flowObj = nodeObj{:}.getTerminalFlow();
                    flowObj.resetToSavedState();
                end
            end

            % reset the state of branch potentials/flows
            for branchObj = thisNetwork.branchVecC
                potential = branchObj{:}.getPotential();
                flow = branchObj{:}.getFlow();
                potential.resetToSavedState();
                flow.resetToSavedState();
            end
        end

    % end methods
    end

    methods (Static)
        function compNodeVecC = traverseTreeComponent(nodeObj, noGoTwigObj)
        % TRAVERSETREECOMPONENT traverses two components of a tree starting
        % from nodeObj and ignoring the twigObj.
        % This function separates a tree into two components and returns the
        % component that contains nodeObj.

            % do this recursively
            twigVecC = nodeObj.getTwigVecC();
            compNodeVecC = {nodeObj};

            for twig = twigVecC
                twigObj = twig{:};
                if twigObj ~= noGoTwigObj
                    childNode = twigObj.getOtherNode(nodeObj);
                    childNodeVecC = MsNetwork.traverseTreeComponent(childNode, twigObj);
                    compNodeVecC = [compNodeVecC, childNodeVecC];
                end
            end
        end

    end

% end classdef
end
