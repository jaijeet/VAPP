classdef AstVisitorIrGenerator < AstVisitor
% ASTVISITORIRGENERATOR generate and intermediate representation from an AST
%
% AstVisitorIrGenerator will traverse the abstract syntax tree and generate an
% intermediate representation tree from the AST. The nodes of an IR tree is
% derived from the IrNode class and have this prefix, e.g., IrNodeContribution.
%
% See also ASTVISITOR

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Feb 21, 2017  12:15PM
%==============================================================================

% NOTE: out{1}, out{2} expressions below are ugly. The reason I am using
% them is because there is no other way in MATLAB of making the visitor
% pattern generic enough in order to use a variable number of outputs in
% the visit methods. varargout does not work because it's a one time thing:
% We can't pass varargout from function to function.
%
% function varargout = fun1()
%     varargout = fun2();
% end
%
% function varargout = fun2()
%     varargout{1} = 'foo';
%     varargout{2} = 'bar';
% end
%
% does not work.
% This would work if we knew the nargout for fun2 beforehand,
%
% function varargout = fun1()
%     varargout = cell(nargoutFun2,1);
%     [varargout{:}] = fun2();
% end
%
% but this is exactly what we don't know.
%
% If, in the future, we settle down to a fixed number of outputs for the
% visit methods, then we can implement that version and get rid of the cell
% array output.
%
% TODO: The error messages emanating from the semantic checks in this class
% should ideally be done in a separate class with a design that can support a
% sort of a "rule book".
    properties (Access = protected)
        irTree = {};
        module = {}; % for now assume there is only a single module
        accessIdx = 0;
    end

    methods
        function obj = AstVisitorIrGenerator(astRoot)
            if nargin > 0
                obj.generateIrTree(astRoot);
            end
        end

        function out = visitGeneric(thisVisitor, astNode)
            out{1} = true;
            out{2} = IrNode(thisVisitor.uniqIdGen);
            % the warning below should tell the programmer that a specific
            % IrNode for the astNode is missing and a generic one is being
            % created that will do nothing but pass the ball on when it gets
            % visited by an IrVisitor object.
            warning('IrGen: Created generic node for %s: %s!', astNode.get_type())
        end

        function irTree = generateIrTree(thisVisitor, rootNode)
            irTree = thisVisitor.traverseAst(rootNode);
            thisVisitor.irTree = irTree;
        end

        function irTree = traverseAst(thisVisitor, astRoot)
            nChild = astRoot.get_num_children();

            out = thisVisitor.visit(astRoot);
            traverseSub = out{1};
            irTree = out{2};

            if isempty(irTree) == false
                irTree.setPosition(astRoot.get_pos());
            end

            if traverseSub == true
                thisVisitor.traverseChildren(astRoot, irTree);
            end

            if astRoot.has_type('root')
                thisVisitor.endTraversal();
            end
        end

        function traverseChildren(thisVisitor, astNode, irNode)
            nChild = astNode.get_num_children();
            for i=1:nChild
                childTree = thisVisitor.traverseAst(astNode.get_child(i));
                if isempty(childTree) == false
                    irNode.addChild(childTree);
                end
            end
        end

        function out = visitRoot(thisVisitor, rootNode)
            % for now assume that the model has only one module and do nothing
            % here. Just pass the ball on.
            out{1} = false;
            out{2} = thisVisitor.traverseAst(rootNode.get_child(1));
        end

        function out = visitModule(thisVisitor, moduleNode)
            out{1} = true;

            uniqIdGen = UniqueIdGenerator();
            thisVisitor.setUniqIdGen(uniqIdGen);
            name = moduleNode.get_name();
            terminalList = moduleNode.get_attr('terminals');
            module = IrNodeModule(thisVisitor.uniqIdGen, name, terminalList);
            thisVisitor.module = module;
            out{2} = module;
        end

        function out = visitDiscipline(thisVisitor, discipNode)
            % Don't create a tree node. Just import electrical nodes into the
            % module.
            module = thisVisitor.module;
            discipName = discipNode.get_name();
            nodeList = discipNode.get_attr('terminals');
            discip = struct();
            discipline.name = discipName;
            discipline.flow = discipNode.get_attr('flow');
            discipline.potential = discipNode.get_attr('potential');
            module.addDiscipline(discipline);
            % addDiscipline has to be called before addToNodeList
            module.addToNodeList(nodeList, discipName);
            out{1} = false;
            out{2} = {}; % don't add an IrNode to the IR
        end

        function out = visitParm_stmt(thisVisitor, parmStmtNode)
            % create a MsParameter object and add it to the module
            % TODO: print parameter ranges as comments
            module = thisVisitor.module;
            parmNode = parmStmtNode.get_child(1);
            parmName = parmNode.get_name();
            defNode = parmNode.get_child(1);
            defValGen = AstVisitorParmValTreeGenerator(module);
            defValGen.setUniqIdGen(thisVisitor.uniqIdGen);
            % the line below can be a solution to the
            % "paramaeters depending on other parameters" problem
            defValGen.generateIrTree(defNode);
            defValTree = defValGen.getIrTree();

            parmObj = module.addParm(parmName, defValTree);

            % find out if there were any other parameters on the RHS
            rhsParmVecC = defValGen.getParmVecC();
            parmObj.setDependParmVecC(rhsParmVecC);
            if isempty(rhsParmVecC) == false
                % this parameter depends on other parameters
                % We go over its default value tree one more time, this time
                % keeping the parameters on the RHS as they are (as opposed to
                % what we are doing with defValGen above).
                insValGen = AstVisitorIrGenerator();
                insValGen.setUniqIdGen(thisVisitor.uniqIdGen);
                insValGen.module = module;
                insValGen.generateIrTree(defNode);
                insValTree = insValGen.getIrTree();
                parmObj.setDependentOnOtherParm();
                parmObj.setInsValTree(insValTree);
            end

            out{1} = false;
            out{2} = {}; % don't add an IrNode to the IR
        end

        function out = visitBranch(thisVisitor, branchNode)
            % Don't create separate object. Add branch to module's branch list.
            module = thisVisitor.module;
            branchLabel = branchNode.get_name();

            [nodeLabel1, nodeLabel2] = branchNode.get_child_names();
            % does the branch have exactly two children?
            if branchNode.get_num_children() ~= 2
                error(['Error defining brach: %s. A branch must be between ',...
                       'exactly two nodes.\n',...
                       'Needs compatible Verilog-A does not allow ', ...
                       'global ground access from within the model. ',...
                       'If you would like to use a probe with reference ',...
                       'to the global ground, please explicitly define ',...
                       'a ground terminal in your model.'],...
                                                    branchLabel);
            end
            nodeObj1 = module.getNode(nodeLabel1);
            if isempty(nodeObj1) == true
                error(['You have defined the branch %s, but its first node',...
                       ' %s is unknown to me!'], branchLabel, nodeLabel1);
            end

            nodeObj2 = module.getNode(nodeLabel2);
            if isempty(nodeObj2) == true
                error(['You have defined the branch %s, but its second node',...
                       ' %s is unknown to me!'], branchLabel, nodeLabel2);
            end

            % was this branch already defined for this module?
            if module.isBranch(branchLabel)
                exBranch = module.getBranch(branchLabel);
                [exNodeObj1, exNodeObj2] = exBranch.getNodes();
                if nodeObj1 ~= exNodeObj1 || nodeObj2 ~= exNodeObj2
                error(['Error defining branch: the branch %s has been',...
                       ' defined previously between nodes %s and %s.'],...
                        branchLabel, exNodeObj1.getLabel(), exNodeObj2.getLabel());
                end
            end

            % Add the branch to the module.
            branchObj = module.addBranch(branchLabel, nodeLabel1, nodeLabel2);
            % Add also its canonical label to the module
            % This will not create another branch. It will just add the
            % canonical branch label as an alias to the circuit
            module.addBranch([nodeLabel1, nodeLabel2], nodeLabel1, nodeLabel2);
            % add the inverse as well
            module.addBranch([nodeLabel2, nodeLabel1], nodeLabel1, nodeLabel2);
            out{1} = false;
            out{2} = {};
        end

        function out = visitVar_decl_stmt(thisVisitor, declNode)

            out{1} = true;
            out{2} = {};
        end

        function out = visitVar_decl(thisVisitor, varNode)
            % Create MsVariable object and add it to the module.
            varName = varNode.get_name();
            % if the variable has a child, it has been assigned a default value
            if varNode.get_num_children() > 0
                defNode = varNode.get_child(1);
                valGen = AstVisitorParmValTreeGenerator(thisVisitor.module);
                valGen.setUniqIdGen(thisVisitor.uniqIdGen);
                defValTree = valGen.generateIrTree(defNode);
            else % otherwise set it to zero
                defValTree = IrNodeConstant(thisVisitor.uniqIdGen, 'real', 0);
            end

            thisVisitor.module.addVar(varName, defValTree);

            out{1} = false;
            out{2} = {};
        end

        function out = visitVar(thisVisitor, varNode)
            % Here varNode can be a parameter or a variable
            module = thisVisitor.module;
            varOrParmName = varNode.get_name();
            out{1} = true;
            isNodeParm = module.isParm(varOrParmName);
            isNodeVar = module.isVar(varOrParmName);
            if isNodeParm == true && isNodeVar == true
                error('The parameter %s was redeclared as a variable!',...
                                                                varOrParmName);
            elseif isNodeParm == false && isNodeVar == false
                error(['The variable or parameter %s was not defined in ',...
                                                        'this the module %s!'],...
                                                varOrParmName, module.getName());
            elseif module.isParm(varOrParmName)
                parmObj = module.getParm(varOrParmName);
                out{2} = IrNodeParameter(thisVisitor.uniqIdGen, parmObj);
            elseif module.isVar(varOrParmName)
                varObj = module.getVar(varOrParmName);
                out{2} = IrNodeVariable(thisVisitor.uniqIdGen, varObj);
            end
        end

        function out = visitContribution(thisVisitor, contribNode)
            out{1} = true;
            accessIdx = thisVisitor.getNextAccessIdx();
            cIrNode = IrNodeContribution(thisVisitor.uniqIdGen);
            cIrNode.setAccessIdx(accessIdx);
            out{2} = cIrNode;
        end

        function out = visitAnalog(thisVisitor, analogNode)
            out{1} = true;
            analog = IrNodeAnalog(thisVisitor.uniqIdGen);
            analog.setIndentLevel(0);
            thisVisitor.module.setAnalogNode(analog);
            out{2} = analog;
        end

        function out = visitAnalog_func(thisVisitor, afNode)
            % create an IrNodeAnalogFunction node which is a subclass of the
            % IrNodeModule class.
            out{1} = false;
            module = thisVisitor.module;
            funcName = afNode.get_name();
            afunc = IrNodeAnalogFunction(thisVisitor.uniqIdGen, funcName);
            funcGen = AstVisitorIrGenerator();
            funcGen.setUniqIdGen(thisVisitor.uniqIdGen);
            funcGen.module = afunc; % NOTE: this seems a bit ugly
            % we set the function hashtable (funcMap) of afunc below
            % this is because we later check for valid functions (see
            % IrVisitorMark1). This check is performed in user defined
            % functions as well. Hence, a user defined function (afunc below)
            % must be aware of other functions.
            % Note that the map returned by module.getFuncMap is a pointer to
            % the hashtable object. Hence, future changes on this object will
            % be visible within afunc.
            afunc.setFuncMap(module.getFuncMap);
            % Skip the analog_func AST node and traverse its children.
            funcGen.traverseChildren(afNode, afunc);
            module.addFunc(afunc);
            out{2} = afunc;
        end

        function out = visitInput(thisVisitor, inputNode)
            % this will be only used if we  are inside of a function body
            out{1} = true;
            out{2} = {};

            func = thisVisitor.module;
            inputList = inputNode.get_attr('inputs');
            func.setInputList(inputList);
        end

        function out = visitOutput(thisVisitor, outputNode)
            % this will be only used if we  are inside of a function body
            out{1} = true;
            out{1} = true;
            out{2} = {};

            func = thisVisitor.module;
            outputList = outputNode.get_attr('outputs');
            func.setOutputList(outputList);
        end

        function out = visitAssignment(thisVisitor, assignNode)
            % Create assignment node, traverse further down the tree.
            out{1} = true;
            aIrNode = IrNodeAssignment(thisVisitor.uniqIdGen);
            aIrNode.setAccessIdx(thisVisitor.getNextAccessIdx());
            out{2} = aIrNode;

        end

        function out = visitIf(thisVisitor, ifNode)
            % create if/else node, traverse further.
            out{1} = true;
            out{2} = IrNodeIfElse(thisVisitor.uniqIdGen);
        end

        function out = visitBlock(thisVisitor, blockNode)
            out{1} = true;
            block = IrNodeBlock(thisVisitor.uniqIdGen);
            block.setIndentLevel(0);
            out{2} = block;
        end

        function out = visitI(thisVisitor, iNode)
            %out = thisVisitor.visitIorV(iNode);
            out = thisVisitor.visitPotentialOrFlow(iNode, 1);
        end

        function out = visitV(thisVisitor, vNode)
            %out = thisVisitor.visitIorV(vNode);
            out = thisVisitor.visitPotentialOrFlow(vNode, 0);
        end

        function out = visitAccess(thisVisitor, accessNode)
            % here we request the branch from the module and then return its
            % potential or flow object wrapped around an IrNodePotentialFlow
            out{1} = false; % do not traverse further
            module = thisVisitor.module;
            inverseNodeOrder = false;
            accessLabel = accessNode.get_name();

            % accessNode will either have one or two children
            % one child -> branch name supplied
            % two children -> node names supplied
            nChild = accessNode.get_num_children();
            if nChild == 1
                % we are given a branch or a port


                childNode = accessNode.get_child(1);

                if childNode.has_type('var') == true
                    % the argument is a branch label
                    branchLabel = accessNode.get_child_names();
                    branchObj = module.getBranch(branchLabel);
                    if isempty(branchObj)
                        % the branch label used in the VA file was not declared
                        pfLabel = [accessLabel, '(', branchLabel, ')'];
                        errMsg = sprintf(['Error accessing %s. ',...
                               'There is no branch with the label ''%s''!'],...
                                                                    pfLabel,...
                                                                    branchLabel);
                        errorAtAstNode(errMsg, accessNode);
                        error('Exiting IR generator!');
                    end

                    inverseNodeOrder = branchObj.isAliasReversed(branchLabel);
                    pfObj = branchObj.getPotentialOrFlow(accessLabel);
                elseif childNode.has_type('port') == true
                    portLabel = accessNode.get_child_names();
                    portObj = module.getNode(portLabel);
                    if isempty(portObj)
                        % the port was not there
                        pfLabel = [accessLabel, '(<', portLabel, '>)'];
                        errMsg = sprintf(['Error accessing %s. ',...
                               'There is no port with the label ''%s''!'],...
                                                                    pfLabel,...
                                                                    portLabel);
                        errorAtAstNode(errMsg, accessNode);
                        error('Exiting IR generator!');
                    end

                    pfObj = portObj.getTerminalFlow();
                else
                    childLabel = accessNode.get_child_names();
                    pfLabel = [accessLabel, '(', childLabel, ')'];
                    errMsg = sprintf(['Access node ''%s'' has an invalid',...
                                                      ' argument!'], pfLabel);
                    errorAtAstNode(errMsg, accessNode);
                    error('Exiting IR generator!');
                end

            elseif nChild == 2
                [nodeLabel1, nodeLabel2] = accessNode.get_child_names();

                % if the nodes are connected, get the branch object.
                nodeObj1 = module.getNode(nodeLabel1);
                nodeObj2 = module.getNode(nodeLabel2);

                if isempty(nodeObj1) == true
                    errMsg = sprintf('"%s", is not a node identfier!', nodeLabel1);
                    errorAtAstNode(errMsg, accessNode);
                    error('Exiting IR generator!');
                end

                if isempty(nodeObj2) == true
                    errMsg = sprintf('"%s", is not a node identfier!', nodeLabel2);
                    errorAtAstNode(errMsg, accessNode);
                    error('Exiting IR generator!');
                end

                if nodeObj1.isConnectedTo(nodeObj2)
                    branchObj = nodeObj1.getBranch(nodeObj2);
                    inverseNodeOrder = branchObj.areNodesReversed(nodeObj1, nodeObj2);
                else
                    % if not, create a branch.
                    branchLabel = [nodeLabel1, nodeLabel2];
                    inverseBranchLabel = [nodeLabel2, nodeLabel1];
                    branchObj = module.addBranch(branchLabel, nodeLabel1, nodeLabel2);
                    % add the same branch with the inverted label as well
                    module.addBranch(inverseBranchLabel, nodeLabel1, nodeLabel2);
                    inverseNodeOrder = false;
                end

                pfObj = branchObj.getPotentialOrFlow(accessLabel);
            else
                error(['Found a Potential or Flow node with a number of ',...
                       'children that is not equal to ONE or TWO! ',...
                       'Something is wrong.']);
            end

            out{2} = IrNodePotentialFlow(thisVisitor.uniqIdGen, pfObj, inverseNodeOrder);
        end

        function out = visitOp(thisVisitor, opNode)
            out{1} = true;
            opType = opNode.get_attr('op');
            out{2} = IrNodeOperation(thisVisitor.uniqIdGen, opType);
        end

        function out = visitConst(thisVisitor, constNode)
            out{1} = false;
            dataType = constNode.get_attr('dtype');
            value = constNode.get_attr('value');
            out{2} = IrNodeConstant(thisVisitor.uniqIdGen, dataType, value);
        end

        function out = visitFunc(thisVisitor, funcNode)
            out{1} = true;
            funcName = funcNode.get_name();

            % NOTE: the below if condition should be removed when the noise
            % functions are implemented in MAPP.
            if funcNode.has_name('ddx')
                warningAtAstNode('ddx function was ignored.', funcNode);
                out{2} = IrNodeNumericalNull(thisVisitor.uniqIdGen);
            elseif funcNode.has_name({'white_noise', 'flicker_noise'})
                out = thisVisitor.visitSim_func(funcNode);
            else
                out{2} = IrNodeFunction(thisVisitor.uniqIdGen, funcName);

                % the treatment for special functions follows
                % the list below can be augmented with additional functions
                module = thisVisitor.module;
                if funcNode.has_name({'limexp', 'pow'}) == true
                    % check if this function is defined in the module
                    vappFuncName = strcat(funcName, '_vapp');
                    if module.isFunc(vappFuncName) == false
                        funcAst = parseAnalogFunc([vappFuncName, '.va']);
                        temp = thisVisitor.visitAnalog_func(funcAst);
                        aFunc = temp{2};
                        module.addChild(aFunc);
                    end
                end
            end
        end

        function out = visitSim_func(thisVisitor, sfNode)
            out{1} = true;
            name = sfNode.get_name();
            if strcmp(name, 'limexp') == true
                out = thisVisitor.visitFunc(sfNode);
            else
                out{2} = IrNodeSimulatorFunction(thisVisitor.uniqIdGen, name);
            end
        end

        function out = visitSim_stmt(thisVisitor, ssNode)
            out{1} = true;
            out{2} = IrNodeSimulatorStatement(thisVisitor.uniqIdGen);
        end

        function out = visitSim_var(thisVisitor, svNode)
            %error(['Error at: $%s. ',...
            %      'MAPP currently does not support simulator variables!'],...
            %                                                svNode.get_name());
            out = thisVisitor.visitSim_func(svNode);
        end

        function out = visitCase(thisVisitor, caseNode)
            out{1} = true;
            out{2} = IrNodeCase(thisVisitor.uniqIdGen);
        end

        function out = visitCase_item(thisVisitor, ciNode)
            out{1} = true;
            out{2} = IrNodeCaseItem(thisVisitor.uniqIdGen);
        end

        function out = visitCase_candidates(thisVisitor, ccNode)
            out{1} = true;
            irNode = IrNodeCaseCandidates(thisVisitor.uniqIdGen);
            if ccNode.has_attr('is_default', 'True')
                irNode.setDefault();
            end
            out{2} = irNode;
        end

        function out = visitWhile(thisVisitor, whileNode)
            out{1} = true;
            out{2} = IrNodeWhile(thisVisitor.uniqIdGen);
        end

        function out = visitFor(thisVisitor, forNode)
            out{1} = true;
            out{2} = IrNodeFor(thisVisitor.uniqIdGen);
        end

        function out = visitEvent_control(thisVisitor, eventNode)
            if eventNode.has_name('initial_step')
                out{1} = true;
                out{2} = IrNodeBlock(thisVisitor.uniqIdGen, 0);
            else
                fprintf(2, ['Warning: The event control statement @(%s) was',...
                                             ' ignored.\n'], eventNode.get_name());
                out{1} = false;
                out{2} = [];
            end
        end

        function irTree = getIrTree(thisVisitor)
            irTree = thisVisitor.irTree;
        end

        function printModSpec(thisVisitor, outFileId)
            thisVisitor.module.fprintAll(outFileId);
        end

        function module = getModule(thisVisitor)
            module = thisVisitor.module;
        end
    % end methods
    end

    methods (Access = private)
        function naIdx = getNextAccessIdx(thisVisitor)
        % INCREASEACCESSIDX
            thisVisitor.accessIdx = thisVisitor.accessIdx + 1;
            naIdx = thisVisitor.accessIdx;
        end
    % end private methods
    end
% end classdef
end
