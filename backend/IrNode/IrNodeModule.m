classdef IrNodeModule < IrNode
% IRNODEMODULE represents a module in Verilog-A and serves as the main data
% class of a model representation in VAPP.
%
% Modules include five important classes of objects:
% 1. Potentials/Flows (MsPotentialFlow)
% 2. Nodes, Branches (MsNode, MsBranch)
% 3. Variables (MsVariable)
% 4. Parameters (MsParameter)
% 5. Analog functions (IrNodeAnalogFunction)
%
% The Ms prefix for the above objects signifies that they are ModSpec objects
% rather than Verilog-A objects (which are represented in the IR tree).
% Analog functions are an exception to this and are stored in the module
% because they are separated from other parts of the model code. They are
% printed separately at the very end as MATLAB functions.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Tue Feb 21, 2017  12:14PM
%==============================================================================

    properties
        terminalList = {};      % list of terminals (strings)
        nodeList = {};          % list of nodes (strings)
        internalNodeList = {};  % list of nodes that are not terminals (strings)
        branchList = {};        % list of branches (strings)
        refLabel = '';          % label of the reference node (string)
        refNode = {};
        network = {};

        varMap = LookupTableVapp();
        parmMap = LookupTableVapp();
        funcMap = LookupTableVapp();
        nodeMap = LookupTableVapp();
        branchMap = LookupTableVapp();
        disciplineMap = LookupTableVapp();

        parmNameArr = {};
        % note that contrary to vars and parms funcs are not ModSpec objects.
        % They are IrNode objects.
        nTerminal = 0;	    % number of terminals
        nNode = 0;          % number of Nodes
        nFeQe = 0;          %
        nFiQi = 0;   % number of internal equations (includes implicit equations)
        nExpOut = 0;
        nIntUnk = 0;
        nInput = 0;
        nOtherIo = 0;
        derivLevel = 0;

        expOutPotentialVecC  = {};
        expOutFlowVecC       = {};
        intUnkPotentialVecC  = {};
        intUnkFlowVecC       = {};
        otherIoPotentialVecC = {};
        otherIoFlowVecC      = {};
        intUnkPfVecC        = {}; %MsPotential.empty;
        expOutPfVecC        = {}; %MsPotential.empty;
        otherIoPfVecC       = {}; %MsPotential.empty;

        implicitContribVecC = {};
        nImplicitContrib = 0;

        expOutList = {};
        intUnkList = {};

        analogNode = {};
        intEqnIdx = 0; % internal equation index (includes internal nodes, 
                       % otherIO equations and implicit equations).
        intEqnNameList = {};
        nodeCollapseTree = {};
        VARSFX = '__';
        fullModel = {};
        nodeCollapseVarStr = '';
        nodeCollapseParmStr = '';
    end

    methods
        function obj = IrNodeModule(uniqIdGen, name, terminalList)
            obj = obj@IrNode(uniqIdGen);
            obj.varMap = LookupTableVapp();
            obj.parmMap = LookupTableVapp();
            obj.funcMap = LookupTableVapp();
            obj.nodeMap = LookupTableVapp();
            obj.branchMap = LookupTableVapp();
            obj.disciplineMap = LookupTableVapp();
            obj.network = MsNetwork();
            obj.connectedToModule = true;

            if nargin > 1
                obj.name = name;
                obj.setTerminalList(terminalList);
            end
        end

        function setTerminalList(thisModule, terminalList)
            nTerminal = numel(terminalList);

            thisModule.terminalList = terminalList;
            thisModule.nTerminal = nTerminal;
            % reference node is the last terminal
            refLabel = terminalList{nTerminal};
            thisModule.refLabel = refLabel;

            % add reference node
            refNodeObj = thisModule.addNode(refLabel);
            refNodeObj.setReference();
            refNodeObj.setTerminal();
            thisModule.refNode = refNodeObj;

            %terminalList = setdiff(terminalList, thisModule.refLabel, 'stable');
            terminalList = setdiff(terminalList, thisModule.refLabel);

            for i=1:nTerminal-1

                nodeLabel = terminalList{i};
                % add Node
                nodeObj = thisModule.addNode(nodeLabel);
                nodeObj.setTerminal();
            end
        end

        function terminalList = getTerminalList(thisModule)
            terminalList = thisModule.terminalList;
        end

        function addToNodeList(thisModule, nodeList, discipName)
            thisModule.nodeList = nodeList;
            internalNodeList = setdiff(nodeList, thisModule.terminalList);
            terminalList = setdiff(nodeList, internalNodeList);
            thisModule.internalNodeList = internalNodeList;

            discipline = thisModule.disciplineMap.getValue(discipName);

            for nodeLabel = internalNodeList
                thisModule.addNode(nodeLabel{:}, discipline);
            end

            for terminalLabel = terminalList
                terminal = thisModule.getNode(terminalLabel{:});
                terminal.setDiscipline(discipline);
            end

            thisModule.generateTerminalBranches(terminalList);
        end

        function addDiscipline(thisModule, discipline)
        % ADDDISCIPLINE
            discipName = discipline.name;
            if thisModule.disciplineMap.isKey(discipName) == false
                thisModule.disciplineMap.addValue(discipName, discipline);
            end
        end

        function [branchObj] = addBranch(thisModule, branchLabel, nodeLabel1, nodeLabel2)
            % ADDBRANCH create branch if necessary and add alias

            if thisModule.isBranch(branchLabel) == false

                nodeObj1 = thisModule.getNode(nodeLabel1);
                nodeObj2 = thisModule.getNode(nodeLabel2);
                if nodeObj1.isConnectedTo(nodeObj2) == false
                    branchObj = MsBranch(nodeObj1, nodeObj2);
                    nodeOrder = 1;
                else
                    branchObj = nodeObj1.getBranch(nodeObj2);
                    nodeOrder = branchObj.getNodeOrder(nodeObj1, nodeObj2);
                end
                branchObj.addAlias(branchLabel, nodeOrder);
                thisModule.branchMap.addValue(branchLabel, branchObj);

            else
                branchObj = thisModule.getBranch(branchLabel);
            end
        end

        function out = isBranch(thisModule, branchLabel)
            out = thisModule.branchMap.isKey(branchLabel);
        end

        function branchObj = getBranch(thisModule, branchAlias)
            branchObj = {};
            if thisModule.isBranch(branchAlias) == true
                branchObj = thisModule.branchMap.getValue(branchAlias);
            end
        end

        function setAnalogNode(thisModule, analogNode)
        % SETANALOGNODE
            thisModule.analogNode = analogNode;
        end

        function aNode = getAnalogNode(thisModule)
        % GETANALOGNODE
            aNode = thisModule.analogNode;
        end

        function addAsFirstAnalogChild(thisModule, childNode)
        % ADDASFIRSTANALOGCHILD
            thisModule.analogNode.addAsFirstChild(childNode);
        end

        function addAsLastAnalogChild(thisModule, childNode)
        % ADDASLASTANALOGCHILD
            thisModule.analogNode.addChild(childNode);
        end

        function seal(thisModule)
        % SEAL
            
            % save the probe/contrib etc. states of the potentials/flows
            thisModule.network.saveState();

            % add the full model (without node collapse)
            fullModel = thisModule.initModel();
            thisModule.fullModel = fullModel;

            if isempty(thisModule.nodeCollapseTree) == false
                IrVisitorConstructModel(thisModule, thisModule.nodeCollapseTree);
            else
                nodeCollapseTree = IrNodeBlock(thisModule.uniqIdGen, 0);
                nodeCollapseTree.addChild(IrNodeModel(thisModule.uniqIdGen, thisModule.fullModel));
                thisModule.nodeCollapseTree = nodeCollapseTree;
            end
            ioDefTree = thisModule.nodeCollapseTree.copyDeep();
            thisModule.addAsFirstAnalogChild(IrNodeModel(thisModule.uniqIdGen, thisModule.fullModel));
            thisModule.generateModelIoDef(ioDefTree);
            thisModule.addAsFirstAnalogChild(ioDefTree);

            outputTree = thisModule.nodeCollapseTree.copyDeep();
            thisModule.generateModelOutput(outputTree);
            thisModule.addAsLastAnalogChild(outputTree);


            % seal the analog functions in this module
            thisModule.sealAnalogFunctions();

        end

        function sealAnalogFunctions(thisModule)
            funcArr = thisModule.funcMap.getValueArr();
            for funcObj = funcArr
                funcObj{:}.seal();
            end
        end

        function out = isRefLabel(thisModule, nodeLabel)
            out = strcmp(thisModule.refLabel, nodeLabel);
        end

        function n = getNFeQe(thisModule)
            n = thisModule.nFeQe;
        end

        function n = getNFiQi(thisModule)
        % GETNFIQI
            n = thisModule.nFiQi;
        end

        function n = getNIntUnk(thisModule)
            n = thisModule.nIntUnk;
        end

        function n = getNInput(thisModule)
            n = thisModule.nInput;
        end

        function refLabel = getRefLabel(thisModule)
            refLabel = thisModule.refLabel;
        end

        function funcMap = getFuncMap(thisModule)
            funcMap = thisModule.funcMap;
        end

        function [outStr, printSub] = sprintFront(thisModule)
            printSub = true;
            templateFileName = 'module.templ';
            templateText = fileread(templateFileName);
            headerFileName = 'vappHeader.templ';
            vappHeaderText = fileread(headerFileName);

            % try finding out the hash for this VAPP commit and print it as a
            % comment to the output function.

            gitStr = 'no_branch_name:fffffff';
            try
                [statusGitHash, gitHashStr] = system('git rev-parse --short HEAD');
                [statusGitBranch, gitBranchStr] = system('git rev-parse --abbrev-ref HEAD');
                if statusGitHash == 0 && statusGitBranch == 0
                    gitStr = [deblank(gitBranchStr), ':', deblank(gitHashStr)];
                end
            catch
                % we can't access the system, don't do anything.
            end

            dateStr = datestr(now);
            vappHeaderStr = sprintf(vappHeaderText, dateStr, gitStr);

            % populate the parameter list, along with their default values.
            % TODO: print ranges here as comments.
            parmNameArr = thisModule.parmNameArr;
            nParm = numel(parmNameArr);
            parmList = {};
            for i=1:nParm
                parmObj = thisModule.getParm(parmNameArr{i});
                parmList{2*i-1} = ['''', parmObj.getName(), ''''];
                parmList{2*i} = parmObj.getValueStr();
            end

            initParmStr = thisModule.sprintfIndent(thisModule.sprintInitParm());

            % fill in the placeholders in the module template
            templStr = sprintf(templateText, ...
                               thisModule.name, ...
                               vappHeaderStr,...
                               thisModule.name, ...
                               cell2str_vapp(thisModule.terminalList, ''''),...
                               thisModule.refLabel,...
                               cell2str_vapp(parmList, '', 2, 25),...
                               nParm,...
                               initParmStr);


            outStr = '';

            % initialize variables (set them to zero if not initialized in the
            % actual module code)
            outStr = [outStr, thisModule.sprintInitVar()];


            % before the node collapse tree, print variables that lead to node
            % collapse
            thisModule.nodeCollapseParmStr = thisModule.sprintNodeCollapseParm();
            thisModule.nodeCollapseVarStr = thisModule.sprintNodeCollapseVar();

            outStr = [outStr, thisModule.nodeCollapseVarStr];

            % now print the node collapse tree for IO definitions
            nodeCollapseTree = thisModule.nodeCollapseTree;
            thisModule.setModelPrintMode(nodeCollapseTree, 'ioinit');
            outStr = [outStr, nodeCollapseTree.sprintAll()];
            outStr = [outStr, thisModule.sprintInitIos()];

            % print math stuff
            outStr = [outStr, '// module body\n'];
            outStr = [templStr, thisModule.sprintfIndent(outStr)];

        end

        function outStr = sprintBack(thisModule)
            outStr = '';

            outStr = [thisModule.sprintfIndent(outStr), 'end\n\n'];

            % print IO name assignment function
            outStr = [outStr, 'function [eonames, iunames, ienames] =',...
                                                    ' get_oui_names__(MOD__)\n'];
            bodyStr = [thisModule.nodeCollapseParmStr, ...
                                                 thisModule.nodeCollapseVarStr];
            nodeCollapseTree = thisModule.nodeCollapseTree;
            thisModule.setModelPrintMode(nodeCollapseTree, 'iolist');
            bodyStr = [bodyStr, nodeCollapseTree.sprintAll()];
            bodyStr = thisModule.sprintfIndent(bodyStr);
            outStr = [outStr, bodyStr, 'end\n\n'];

            % print IO number print function
            outStr = [outStr, 'function [nFeQe, nFiQi, nOtherIo, nIntUnk] = ',...
                                        'get_nfq__(MOD__)\n'];
            bodyStr = [thisModule.nodeCollapseParmStr, ...
                                                 thisModule.nodeCollapseVarStr];
            nodeCollapseTree = thisModule.nodeCollapseTree;
            thisModule.setModelPrintMode(nodeCollapseTree, 'ionumber');
            bodyStr = [bodyStr, nodeCollapseTree.sprintAll()];
            bodyStr = thisModule.sprintfIndent(bodyStr);
            outStr = [outStr, bodyStr, 'end\n\n'];

            % print helper functions
            ienFuncText = fileread('get_ie_names.templ');
            iunFuncText = fileread('get_iu_names.templ');
            outStr = [outStr, sprintf('%s\n%s\n', iunFuncText, ienFuncText)];

            % print Verilog-A analog functions
            funcArr = thisModule.funcMap.getValueArr();
            nFunc = numel(funcArr);
            for i = 1:nFunc
                outStr = [outStr, '\n', funcArr{i}.sprintAnalogFunction()];
            end
        end

        function outStr = sprintInitParm(thisModule)
            parmNameArr = thisModule.parmNameArr;
            nParm = numel(parmNameArr);

            outStr = '';
            for i=1:nParm
                parmObj = thisModule.getParm(parmNameArr{i});
                outStr = [outStr, parmObj.sprintInit(i)];
            end

        end

        function outStr = sprintInitVar(thisModule)
        % SPRINTINITALLVAR set a variable to zero if it is not initialized
        % by the module at all, i.e., it is used before it is being set.
            varArr = thisModule.varMap.getValueArr();
            nVar = numel(varArr);
            outStr = '';

            for i=1:nVar
                varObj = varArr{i};
                if varObj.isUsedBeforeInit() == true || ...
                                                varObj.isDerivative() == true
                    outStr = [outStr, sprintf('%s = %s;\n', ...
                                                        varObj.getName(),...
                                                        varObj.getValueStr())];
                end
            end

            if isempty(outStr) == false
                outStr = ['// initializing variables\n', outStr];
            end
        end

        function outStr = sprintInitIos(thisModule)
            outStr = '';

            outStr = [outStr, '// Initializing remaining IOs and auxiliary IOs\n'];
            for branch = thisModule.getBranchVecC()
                branchObj = branch{:};
                potentialObj = branchObj.getPotential();
                flowObj = branchObj.getFlow();
                if potentialObj.needsInit() == true
                    potentialNode = IrNodePotentialFlow(thisModule.uniqIdGen, potentialObj);
                    potentialNode.setLhs();
                    outStr = [outStr, potentialNode.sprintInit()];
                end

                if flowObj.needsInit() == true
                    flowNode = IrNodePotentialFlow(thisModule.uniqIdGen, flowObj);
                    flowNode.setLhs();
                    outStr = [outStr, flowNode.sprintInit()];
                end
            end

        end

        function outStr = sprintNodeCollapseParm(thisModule)
            outStr = '';
            parmNameArr = thisModule.parmNameArr;
            nParm = numel(parmNameArr);
            for i = 1:nParm;
                parmObj = thisModule.getParm(parmNameArr{i});
                if parmObj.isInNodeCollapse() == true
                    outStr = [outStr, parmObj.sprintInit(i)];
                end
            end
        end

        function outStr = sprintNodeCollapseVar(thisModule)
            assignVisitor = IrVisitorPrintNodeCollapseVar(thisModule);
            outStr = assignVisitor.getNcStr();
        end

        function msVar = addVar(thisModule, varName, varargin)
            % varargin can be valTree
            msVar = thisModule.getVar(varName);
            if isempty(msVar) == true
                msVar = MsVariable(varName, varargin{:});
                msVar.setModule(thisModule);
                thisModule.varMap.addValue(varName, msVar);
            end
        end

        function msVar = getVar(thisModule, varName)
            msVar = {};
            if thisModule.isVar(varName) == true
                msVar = thisModule.varMap.getValue(varName);
            end
        end

        function varList = getVarList(thisModule)
        % GETVARLIST
            varList = thisModule.varMap.getKeyArr();
        end

        function out = isVar(thisModule,  varName)
            out =  thisModule.varMap.isKey(varName);
        end

        function varObj = addVarToModule(thisModule, varLabel, isDerivative)
        % ADDVARTOMODULE overloaded method from IrNodeModule
        % This method adds a new variable to the module which is defined by its
        % label, varLabel, and returns the MsVariable object that has been
        % created. It can also be that a variable object exists already in
        % the module and we only return that object without creating a new one.
            varObj = thisModule.addVar(varLabel);
            if nargin > 2
                if isDerivative == true
                    varObj.setDerivative();
                end
            end
        end

        function msParm = addParm(thisModule, parmName, defVal)
            msParm = thisModule.getParm(parmName);
            if isempty(msParm) == true
                thisModule.parmNameArr = [thisModule.parmNameArr, {parmName}];
                parmIdx = numel(thisModule.parmNameArr);
                msParm = MsParameter(parmName, defVal);
                msParm.setParmIdx(parmIdx);
                thisModule.parmMap.addValue(parmName, msParm);
            end
        end

        function msParm = getParm(thisModule, parmName)
            msParm = {};
            if thisModule.isParm(parmName)
                msParm = thisModule.parmMap.getValue(parmName);
            end
        end

        function addFunc(thisModule, funcNode)
            funcName = funcNode.getName;
            if thisModule.isFunc(funcName) == false
                thisModule.funcMap.addValue(funcName, funcNode);
            end
        end

        function nodeObj = addNode(thisModule, nodeLabel, discipline)
           if thisModule.hasNode(nodeLabel) == false
               nodeObj = MsNode(nodeLabel);
               thisModule.nodeMap.addValue(nodeLabel, nodeObj);
               thisModule.nNode = thisModule.nNode + 1;
               % add node to the network
               thisModule.network.addNode(nodeObj);

               if nargin > 2
                   nodeObj.setDiscipline(discipline);
               end
           end
        end

        function msNode = getNode(thisModule, nodeLabel)
            msNode = {};
            if thisModule.hasNode(nodeLabel) == true
                msNode = thisModule.nodeMap.getValue(nodeLabel);
            end
        end

        function out = isFunc(thisModule, funcName)
            out = thisModule.funcMap.isKey(funcName);
        end

        function out = isParm(thisModule, parmName)
            out = thisModule.parmMap.isKey(parmName);
        end

        function out = hasNode(thisModule, nodeLabel)
            out = thisModule.nodeMap.isKey(nodeLabel);
        end

        function nIo = getNIo(thisModule)
            nIo = thisModule.nIo;
        end

        function ioVecC = getIoVecC(thisModule)
            ioVecC = thisModule.ioVecC;
        end

        function nodeVecC = getNodeVecC(thisModule)
            nodeVecC = thisModule.network.getNodeVecC();
        end

        function branchVecC = getBranchVecC(thisModule)
            branchVecC = thisModule.network.getBranchVecC();
        end

        function resetCollapsedBranches(thisModule)
        % RESETCOLLAPSEDBRANCHES
            branchVecC = thisModule.network.getBranchVecC();
            for branchObj = branchVecC
                branchObj{:}.unsetCollapsed();
            end
        end

        function setDerivLevel(thisModule, derivLev)
            thisModule.derivLevel = derivLev;
        end

        function dl = getDerivLevel(thisModule)
            dl = thisModule.derivLevel;
        end

        function network = getNetwork(thisModule)
        % GETNETWORK
            network = thisModule.network;
        end

        function expOutList = getExpOutList(thisModule)
        % GETEXPOUTLIST
            expOutList = {};
            refLabel = thisModule.refLabel;

            for expOut = thisModule.expOutPotentialVecC
                expOutList = [expOutList, {expOut{:}.getModSpecLabel()}];
            end

            for expOut = thisModule.expOutFlowVecC
                expOutList = [expOutList, {[expOut{:}.getModSpecLabel(), refLabel]}];
            end
        end

        function otherIoList = getOtherIoList(thisModule)
        % GETOTHERIOLIST
            otherIoList = {};
            for otherIo = thisModule.otherIoPfVecC
                otherIoList = [otherIoList, {otherIo{:}.getModSpecLabel()}];
            end
        end

        function intUnkList = getIntUnkList(thisModule)
        % GETINTUNKLIST
            intUnkList = {};

            for intUnk = thisModule.intUnkPfVecC
                intUnkList = [intUnkList, {intUnk{:}.getLabel()}];
            end
        end
        
        function inPfVecC = getInputPfVecC(thisModule)
        % GETINPUTPFVEC
            inPfVecC = thisModule.fullModel.getInputPfVecC();
        end

        function addImplicitContrib(thisModule, contribNode)
        % ADDIMPLICITCONTRIB
            thisModule.implicitContribVecC = [thisModule.implicitContribVecC, ...
                                                                  {contribNode}];
            thisModule.nImplicitContrib = thisModule.nImplicitContrib + 1;
            contribNode.setImplicit(thisModule.nImplicitContrib);
        end

        function setNodeCollapseTree(thisModule, ifElseTree)
        % SETNODECOLLAPSETREEVEC
            thisModule.nodeCollapseTree = ifElseTree;
        end

        function ncTree = getNodeCollapseTree(thisModule)
        % GETNODECOLLAPSETREEVEC
            ncTree = thisModule.nodeCollapseTree;
        end

        function newModel = initModel(thisModule, collapsedBranchVecC)
        % INITMODE
            if nargin > 1
                newModel = MsModel(thisModule, collapsedBranchVecC);
            else
                newModel = MsModel(thisModule);
            end
        end

    % end methods
    end

    methods (Access = private)

        function generateTerminalBranches(thisModule, terminalList)
            % if a terminal node is not connected to the reference node, create
            % a branch connecting them
            refNode = thisModule.refNode;

            for terminalLabelCell = terminalList
                terminalLabel = terminalLabelCell{:};
                terminalObj = thisModule.getNode(terminalLabel);
                if terminalObj.isTerminal() == true && ...
                                terminalObj ~= refNode && ...
                                    terminalObj.isConnectedTo(refNode) == false
                    branchObj = MsBranch(terminalObj, refNode);
                    % add it to the branch hash
                    branchLabel = branchObj.getLabel();
                    refLabel = refNode.getLabel();
                    thisModule.addBranch(branchLabel, terminalLabel, refLabel);
                end
            end
        end

    % end methods (private)
    end

    methods (Static)
        function setModelPrintMode(nodeCollapseTree, printMode)
        % SETMODELPRINTMODE
            if nodeCollapseTree.hasType('IrNodeModel') == true
                nodeCollapseTree.setPrintMode(printMode);
            else
                nChild = nodeCollapseTree.getNChild();
                for i = 1:nChild
                    childNode = nodeCollapseTree.getChild(i);
                    IrNodeModule.setModelPrintMode(childNode, printMode);
                end
            end
        end

        function generateModelOutput(nodeCollapseTree)
        % GENERATEMODELOUTPUT
            if nodeCollapseTree.hasType('IrNodeModel') == true
                outputTree = nodeCollapseTree.getOutputTree();
                parentNode = nodeCollapseTree.getParent();
                parentNode.addChild(outputTree.copyDeep());
            else
                nChild = nodeCollapseTree.getNChild();
                for i = 1:nChild
                    childNode = nodeCollapseTree.getChild(i);
                    IrNodeModule.generateModelOutput(childNode);
                end
            end
            
        end

        function generateModelIoDef(nodeCollapseTree)
        % GENERATEMODELIODEF
            if nodeCollapseTree.hasType('IrNodeModel') == true
                ioDefTree = nodeCollapseTree.getIoDefTree();
                parentNode = nodeCollapseTree.getParent();
                parentNode.replaceChild(nodeCollapseTree, ioDefTree.copyDeep());
            else
                nChild = nodeCollapseTree.getNChild();
                for i = 1:nChild
                    childNode = nodeCollapseTree.getChild(i);
                    IrNodeModule.generateModelIoDef(childNode);
                end
            end
        end

        function out = isModule(thisNode)
        % ISMODULE
            out = true;
        end

    % end methods (static)
    end
% end classdef
end
