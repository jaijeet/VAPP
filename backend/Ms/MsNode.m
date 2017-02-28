classdef MsNode < MsComparableViaLabel
% MSNODE class for representing nodes (in ModSpec)
%

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Jan 03, 2017  11:14AM
%==============================================================================
    properties (Access = private)
       label = '';
       terminal = false;
       reference = false;
       branchVecC = {}; % vector of branches to/fro this node.
       network = {};
       terminalFlow = {};
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
            if findIdxOfObjInCellVec(thisNode.branchVecC, branchObj) > 0
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
            outBranch = {};
            for branch = thisNode.branchVecC
                branchObj = branch{:};
                if branchObj.getOtherNode(thisNode) == otherNode
                    outBranch = branchObj;
                    break;
                end
            end
        end

        function outBranch = getReferenceBranch(thisNode)
        % GETREFERENCEBRANCH
            outBranch = {};
            if thisNode.reference == false
                for branch = thisNode.branchVecC
                    branchObj = branch{:};
                    if branchObj.isReference() == true
                        outBranch = branchObj;
                        break;
                    end
                end
            end
        end

        function addBranch(thisNode, branchObj)
            otherNode = branchObj.getOtherNode(thisNode);
            if isempty(thisNode.getBranch(otherNode))
                thisNode.branchVecC = [thisNode.branchVecC, {branchObj}];
            else
                error(['Cannot add this branch! ', ...
                       '%s is already connected to %s with another ',...
                       'branch.'], thisNode.getLabel(), otherNode.getLabel());
            end

            if isempty(thisNode.network) == false
                thisNode.network.addBranch(branchObj);
            end
        end

        function branchVecC = getBranchVecC(thisNode)
        % GETBRANCHVEC
            branchVecC = thisNode.branchVecC;
        end

        function twigVecC = getTwigVecC(thisNode)
        % GETTWIGVEC
            twigVecC = {};
            for branch = thisNode.branchVecC
                branchObj = branch{:};
                if branchObj.isTwig() == true
                    twigVecC = [twigVecC, {branchObj}];
                end
            end
        end

        function chordVecC = getChordVecC(thisNode)
        % GETCHORDVEC
            chordVecC = {};
            for branch = thisNode.branchVecC
                branchObj = branch{:};
                if branchObj.isChord() == true
                    chordVecC = [chordVecC, {branchObj}];
                end
            end
        end

        function out = hasTwigWithFlow(thisNode)
        % HASTWIGWITHFLOW check if a node has a branch attached to it that is
        % not zeroFlow.
            out = false;
            for branch = thisNode.branchVecC
                branchObj = branch{:};
                if branchObj.isTwig() == true && branchObj.isZeroFlow() == false
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

            for branch = thisNode.branchVecC
                branchObj = branch{:};
                if branchObj.isTwig() == true && (branchObj ~= twig)
                    out = true;
                    break;
                end
            end
        end

    % end methods
    end

% end classdef
end
