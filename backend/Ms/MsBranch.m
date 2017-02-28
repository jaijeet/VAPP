classdef MsBranch < MsComparableViaLabel
% MSBRANCH represents a branch in ModSpec
%
% Branches are created by supplying two MsNode objects to its constructor.
% In the process of creating a branch, we attach a potential and a flow object
% to it as well. This way when we are creating *intermediate representation
% tree* nodes, we can directly access these objects through nodes or branches.
% This saves us the trouble of keeping an array for flows and potentials in the
% module.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Tue Jan 31, 2017  11:41AM
%==============================================================================
    properties (Access = private)
        node1 = {};
        node2 = {};
        label = ''; % this will be the concatenation of the two node names. 
        aliasMap = LookupTableVapp();
        potentialObj = {};
        flowObj = {};
        twig = false;
        chord = false;
        discipline = struct([]); % fields: name, potential (nature struct),
                              % flow (nature struct)
        collapsed = false;
        toBeCollapsed = false;
        collapsedWarningDisplayed = false;
    end

    methods

        function obj = MsBranch(nodeObj1, nodeObj2)
        % MSBRANCH

            % NOTE: we will receive an error if the two nodes are already
            % connected
            if nodeObj1.hasCompatibleDiscipline(nodeObj2) == false
                error(['Cannot create branch: node "%s" and node "%s" do',...
                       ' not have the same discipline!'], nodeObj1.getLabel,...
                                                          nodeObj2.getLabel);
            end

            obj.node1 = nodeObj1;
            obj.node2 = nodeObj2;
            nodeObj1.addBranch(obj);
            nodeObj2.addBranch(obj);

            discipline = nodeObj1.getDiscipline();
            obj.discipline = discipline;

            obj.label = strcat(nodeObj1.getLabel(), nodeObj2.getLabel());

            % create flow and potential objects
            obj.flowObj = MsFlow(obj);
            obj.potentialObj = MsPotential(obj);
            obj.aliasMap = LookupTableVapp();
        end

        function [nodeObj1, nodeObj2] = getNodes(thisBranch)
        % GETNODES
            nodeObj1 = thisBranch.node1;
            nodeObj2 = thisBranch.node2;
        end

        function otherNode = getOtherNode(thisBranch, aNode)
        % GETOTHERNODE
            if thisBranch.node1 == aNode
                otherNode = thisBranch.node2;
            elseif thisBranch.node2 == aNode
                otherNode = thisBranch.node1;
            else
                error('Error this branch is not connected to %s!', aNode.getLabel());
            end
        end

        function pfObj = getPotentialOrFlow(thisBranch, accessLabel)
        % GETPOTENTIALORFLOW
            potentialAccess = thisBranch.discipline.potential.access;
            flowAccess = thisBranch.discipline.flow.access;

            if strcmp(accessLabel, potentialAccess)
                pfObj = thisBranch.potentialObj;
            elseif strcmp(accessLabel, flowAccess)
                pfObj = thisBranch.flowObj;
            else
                error(['Access label (%s) does not match neither the flow',...
                       ' (%s) nor the potential (%s) access of this branch!'],...
                                                flowAccess, potentialAccess);
            end
        end

        function pObj = getPotential(thisBranch)
        % GETPOTENTIAL
            pObj = thisBranch.potentialObj;
        end

        function fObj = getFlow(thisBranch)
        % GETFLOW
            fObj = thisBranch.flowObj;
        end

        function discipline = getDiscipline(thisBranch)
        % GETDISCIPLINE
            discipline = thisBranch.discipline;
        end

        function flowNature = getFlowNature(thisBranch)
        % GETFLOWNATURE
            flowNature = thisBranch.discipline.flow;
        end

        function potentialNature = getPotentialNature(thisBranch)
        % GETPOTENTIALNATURE
            potentialNature = thisBranch.discipline.potential;
        end

        function out = isZeroFlow(thisBranch)
        % ISZEROFLOW
            if thisBranch.isInImplicitEqn() == false && ...
                                            thisBranch.hasContrib() == false
                out = true;
            else
                out = false;
            end
        end

        function out = isInImplicitEqn(thisBranch)
        % ISINIMPLICITEQN
            if thisBranch.flowObj.isInImplicitEqn() == true || ...
                        thisBranch.potentialObj.isInImplicitEqn() == true
                out = true;
            else
                out = false;
            end
        end

        function label = getLabel(thisBranch)
        % GETLABEL
            label = thisBranch.label;
        end

        function label = getModSpecLabel(thisBranch)
        % GETMODSPECLABEL returns a label that can be used when marking
        % explicit outputs and internal unks in the ModSpec wrapper.
        % For this, we exchange the order of nodes if the first node is the
        % reference node.

            node1 = thisBranch.node1;
            node2 = thisBranch.node2;

            if node1.isReference() == false
                label = thisBranch.label;
            else
                label = strcat(node2.getLabel(), node1.getLabel());
            end

        end

        function addAlias(thisBranch, aliasStr, nodeOrder)
        % Between two nodes only one branch can exist. If the order of the
        % nodes is reversed, it is still the same branch. Since One alias
        % can point to the regular order of nodes and another alias can
        % point to the reverse order, we keep a list of "alias masks".
        % This is the nodeOrder variable below. It can either be 1 or -1.

            if thisBranch.hasAlias(aliasStr) == false
                thisBranch.aliasMap.addValue(aliasStr, nodeOrder);
            end
        end

        function aList = getAliasList(thisBranch)
            aList = thisBranch.aliasMap.getValueArr();
        end

        function out = hasAlias(thisBranch, aliasStr)
            out = thisBranch.aliasMap.isKey(aliasStr);
        end

        function out = isAliasReversed(thisBranch, aliasStr)
        % ISALIASREVERSED
            if thisBranch.hasAlias(aliasStr)
                out = thisBranch.aliasMap.getValue(aliasStr) == -1;
            else
                error('This branch does not have the alias ''%s''', aliasStr);
            end
        end

        function out = getNodeOrder(thisBranch, nodeObj1, nodeObj2)
        % NAME
            if nodeObj1 == thisBranch.node1 && nodeObj2 == thisBranch.node2
                out = 1;
            elseif nodeObj2 == thisBranch.node1 && nodeObj1 == thisBranch.node2
                out = -1;
            else
                error('The supplied nodes do not match with the nodes of this branch!');
            end
        end

        function bDir = getDirection(thisBranch, nodeObj)
        % GETDIRECTION returns the diretion of the branch with respect to the
        % nodeObj
        % bDir = 1 if branch goes out of nodeObj
        % bDir = -1 if branch goes into nodeObj
            bDir = thisBranch.getIncidenceCoeff(nodeObj);
            if bDir == 0
                error('This branch is not connected to node %s!',...
                                                         nodeObj.getLabel());
            end
        end

        function out = getIncidenceCoeff(thisBranch, nodeObj)
            if thisBranch.node1 == nodeObj
                out = 1;
            elseif thisBranch.node2 == nodeObj
                out = -1;
            else
                out = 0;
            end
        end

        function out = areNodesReversed(thisBranch, nodeObj1, nodeObj2)
        % ARENODESREVERSED
            out = (thisBranch.getNodeOrder(nodeObj1, nodeObj2) == -1);
        end

        function setTwig(thisBranch)
        % SETTWIG
            if thisBranch.chord == true
                error(['Cannot set branch as twig because it is marked as',...
                       ' a chord.']);
            else
                thisBranch.twig = true;
            end
        end

        function setChord(thisBranch)
        %  SETCHORD
            if thisBranch.twig == true
                error(['Cannot set branch as chord because it is marked as',...
                       ' a twig.']);
            else
                thisBranch.chord = true;
            end
        end

        function resetTwigChord(thisBranch)
        % RESETTWIGCHORD
            thisBranch.twig = false;
            thisBranch.chord = false;
        end

        function out = isTwig(thisBranch)
        % ISTWIG
            out = thisBranch.twig;
        end

        function out = isChord(thisBranch)
        % ISCHORD
            out = thisBranch.chord;
        end

        function out = isReference(thisBranch)
            % outer branch -> one terminal node and one reference node
            nodeObj1 = thisBranch.node1;
            nodeObj2 = thisBranch.node2;
            out = (nodeObj1.isTerminal() && nodeObj2.isReference()) || ...
                  (nodeObj2.isTerminal() && nodeObj1.isReference());

        end

        function out = isOuter(thisBranch)
        % ISOUTER
            nodeObj1 = thisBranch.node1;
            nodeObj2 = thisBranch.node2;
            out = (nodeObj1.isTerminal() && nodeObj2.isTerminal());
        end

        function out = isInner(thisBranch)
        % ISINNER
            nodeObj1 = thisBranch.node1;
            nodeObj2 = thisBranch.node2;
            out = (nodeObj1.isInternal() || nodeObj2.isInternal());
        end

        function tNode = getTerminalNode(thisBranch)
            if thisBranch.isReference() == true
                nodeObj1 = thisBranch.node1;
                nodeObj2 = thisBranch.node2;
                if nodeObj1.isTerminal() == true
                    tNode = nodeObj1;
                else
                    tNode = nodeObj2;
                end
            else
                error(['Cannot get terminal node. This branch is not a',...
                       ' reference branch!']);
            end

        end

        function out = hasContrib(thisBranch)
        % HASCONTRIB
            if thisBranch.flowObj.isContrib() == true || ...
                        thisBranch.potentialObj.isContrib() == true
                out = true;
            else
                out = false;
            end
        end

        function out = isCollapsed(thisBranch)
        % ISCOLLAPSED
            out = thisBranch.collapsed;
        end

        function setCollapsed(thisBranch)
        % SETCOLLAPSED
            if thisBranch.isOuter() == false
                thisBranch.collapsed = true;
            elseif thisBranch.collapsedWarningDisplayed == false
                %error(['The branch %s cannot be collapsed because it',...
                %       ' connects two terminal nodes!'], thisBranch.label);
                % We allow the collapse of a branch that connects two external
                % nodes (terminals) because hicum does it but this should
                % really be disallowed.
                nodeLabelArr = thisBranch.getNodeLabels();
                fprintf(2, ['Warning: a branch is collapsed that connects',...
                            ' two terminals: (%s, %s).\n'], nodeLabelArr{1},...
                                                            nodeLabelArr{2});
                thisBranch.collapsedWarningDisplayed = true;
            end
        end

        function unsetCollapsed(thisBranch)
        % UNSETCOLLAPSED
            thisBranch.collapsed = false;
        end

        function out = isToBeCollapsed(thisBranch)
        % ISTOBECOLLAPSED
            out = thisBranch.toBeCollapsed;
        end

        function setToBeCollapsed(thisBranch)
        % SETTOBECOLLAPSED
            thisBranch.toBeCollapsed = true;
        end

        function labelArr = getNodeLabels(thisBranch)
        % GETNODELABELS
            labelArr = {thisBranch.node1.getLabel(), thisBranch.node2.getLabel()};
        end

    % end methods
    end

% end classdef
end
