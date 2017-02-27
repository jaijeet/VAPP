classdef MsNode < handle
% MSNODE class for representing nodes (in ModSpec)
%

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties (Access = private)
       label = '';
       terminal = false;
       reference = false;
       branchVec = MsBranch.empty; % vector of branches to/fro this node.
       network = MsNetwork.empty;
       terminalFlow = MsTerminalFlow.empty;
       discipline = struct([]); % fields: name, potential (nature struct),
                              % flow (nature struct)
    end

    methods

        function obj = MsNode(label)
            obj.label = label;
        end

        function label = getLabel(thisNode)
        % GETLABEL
            label = thisNode.label;
        end

        function setTerminal(thisNode)
        % SETTERMINAL
            thisNode.terminal = true;
            thisNode.terminalFlow = MsTerminalFlow(thisNode);
        end

        function tflow = getTerminalFlow(thisNode)
        % GETTERMINALFLOW
            tflow = thisNode.terminalFlow;
        end

        function out = isInternal(thisNode)
            out = (thisNode.terminal == false);
        end

        function out = isTerminal(thisNode)
        % ISTERMINAL
            out = thisNode.terminal;
        end

        function setReference(thisNode)
            thisNode.reference = true;
            thisNode.network.setRefNode(thisNode);
        end

        function out = isReference(thisNode)
            out = thisNode.reference;
        end

        function setNetwork(thisNode, networkObj)
        % SETNETWORK
            if isempty(thisNode.network) == true
                thisNode.network = networkObj;
            else
                error(['Cannot set network of node %s because it already ',...
                      'belongs to a network!'], thisNode.label);
            end
        end

        function networkObj = getNetwork(thisNode)
        % NETWORKOBJ = getNetwork
            networkObj = thisNode.network;
        end

        function setDiscipline(thisNode, discipStruct)
        % SETDISCIPLINE
            thisNode.discipline = discipStruct;
        end

        function discipStruct = getDiscipline(thisNode)
        % GETDISCIPLINE
            if isempty(thisNode.discipline) == false
                discipStruct = thisNode.discipline;
            else
                error(['The node %s has no discipline set for it.',...
                       ' Discipline statements have to come before, e.g.,',...
                       ' branch declarations.'], thisNode.label);
            end
        end

        function discipName = getDisciplineName(thisNode)
        % GETDISCIPLINENAME
            if isempty(thisNode.discipline) == false
                discipName = thisNode.discipline.name;
            else
                error(['The node %s has no discipline set for it.',...
                       ' Discipline statements have to come before, e.g.,',...
                       ' branch declarations.'], thisNode.label);
            end
        end

        function out = hasCompatibleDiscipline(thisNode, otherNode)
        % HASCOMPATIBLEDISCIPLINE
            % ground node is compatible with every discipline
            if thisNode.isReference() == true || otherNode.isReference() == true
                out = true;
            else
                out = strcmp(thisNode.getDisciplineName(),...
                             otherNode.getDisciplineName());
            end
        end

        function out = hasBranch(thisNode, branchObj)
        % HASBRANCH
            if any(thisNode.branchVec == branchObj) == true
                out = true;
            else
                out = false;
            end
        end

        function out = isConnectedTo(thisNode, aNode)
        % ISCONNECTEDTO

            if aNode == thisNode
                error('You are probing if this node is connected to itself!');
            end

            branch = thisNode.getBranch(aNode);
            if isempty(branch) == false
                out = true;
            else
                out = false;
            end
        end

        function outBranch = getBranch(thisNode, otherNode)
        % GETBRANCH

            % return empty object if not connected to otherNode
            outBranch = MsBranch.empty;
            for branch = thisNode.branchVec
                if branch.getOtherNode(thisNode) == otherNode
                    outBranch = branch;
                    break;
                end
            end
        end

        function outBranch = getReferenceBranch(thisNode)
        % GETREFERENCEBRANCH
            outBranch = MsBranch.empty;
            if thisNode.reference == false
                for branch = thisNode.branchVec
                    if branch.isReference() == true
                        outBranch = branch;
                        break;
                    end
                end
            end
        end

        function addBranch(thisNode, branchObj)
            otherNode = branchObj.getOtherNode(thisNode);
            if isempty(thisNode.getBranch(otherNode))
                thisNode.branchVec = [thisNode.branchVec, branchObj];
            else
                error(['Cannot add this branch! ', ...
                       '%s is already connected to %s with another ',...
                       'branch.'], thisNode.getLabel(), otherNode.getLabel());
            end

            if isempty(thisNode.network) == false
                thisNode.network.addBranch(branchObj);
            end
        end

        function branchVec = getBranchVec(thisNode)
        % GETBRANCHVEC
            branchVec = thisNode.branchVec;
        end

        function twigVec = getTwigVec(thisNode)
        % GETTWIGVEC
            twigVec = MsBranch.empty();
            for branchObj = thisNode.branchVec
                if branchObj.isTwig() == true
                    twigVec = [twigVec, branchObj];
                end
            end
        end

        function chordVec = getChordVec(thisNode)
        % GETCHORDVEC
            chordVec = MsBranch.empty();
            for branchObj = thisNode.branchVec
                if branchObj.isChord() == true
                    chordVec = [chordVec, branchObj];
                end
            end
        end

        function out = hasTwigWithFlow(thisNode)
        % HASTWIGWITHFLOW check if a node has a branch attached to it that is
        % not zeroFlow.
            out = false;
            for branch = thisNode.branchVec
                if branch.isTwig() == true && branch.isZeroFlow() == false
                    out = true;
                    break;
                end
            end
        end

        function out = hasTwigOtherThan(thisNode, twig)
        % HASTWIGOTHERTHAN
            out = false;
            if thisNode.hasBranch(twig) == false
                error('This node does not have this twig (%s)!', twig.getLabel());
            end

            for branch = thisNode.branchVec
                if branch.isTwig() == true && (branch ~= twig)
                    out = true;
                    break;
                end
            end
        end

    % end methods
    end

% end classdef
end
