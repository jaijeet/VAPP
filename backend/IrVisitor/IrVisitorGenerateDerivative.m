classdef IrVisitorGenerateDerivative < IrVisitor
% IRVISITORGENERATEDERIVATIVE crawls the IR tree and augments it with
% derivatives.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Sat Dec 10, 2016  07:34PM
%==============================================================================
    properties (Constant)
        VARSFX = '__';
    end

    properties (Access = private)
        generatePfDeriv = false;
        generateVarDeriv = false;
        derivVarVec = MsVariable.empty;
        derivPfVec = MsPotential.empty;
    end

    methods

        function obj = IrVisitorGenerateDerivative(derivPfVec, derivVarVec, irTree)

            obj.derivPfVec = derivPfVec;
            obj.derivVarVec = derivVarVec;
            obj.generatePfDeriv = (isempty(derivPfVec) == false);
            obj.generateVarDeriv = (isempty(derivVarVec) == false);

            if nargin > 2
                obj.traverseIr(irTree);
            end
        end

        function setDerivVarVec(thisVisitor, varVec)
            if isempty(varVec) == false
                thisVisitor.derivVarVec = varVec;
                thisVisitor.generateVarDeriv = true;
            end
        end

        function traverseSub = visitGeneric(thisVisitor, irNode)
            traverseSub = true;
        end
        
        function traverseSub = visitIrNodeModule(thisVisitor, moduleNode)
            traverseSub = true;
            moduleNode.setDerivLevel(1);
        end

        function traverseSub = visitIrNodeAssignment(thisVisitor, assignNode)
            traverseSub = false;

            lhsNode = assignNode.getLhsNode();
            lhsVarObj = lhsNode.getVarObj();

            % now generate derivatives
            % we generate one block to hold the actual assignment node and the
            % derivatives.
            % The derivatives themselves are put into a separate block.
            parentNode = assignNode.getParent();
            joinNode = IrNodeBlock();
            joinNode.setIndentLevel(0);
            parentNode.replaceChild(assignNode, joinNode);

            derBlock = IrNodeDerivativeBlock();
            joinNode.addChild(derBlock);
            % NOTE: we must add assignNode after we have added the derBlock.
            % Otherwise we would use the new value of the variable in the
            % derivatives and they will not be correct.
            joinNode.addChild(assignNode);
            if thisVisitor.generatePfDeriv == true

                % depPfVec contains IOs that the RHS depends on.
                % This includes dependencies through other IOs and variables.
                for depPfObj = thisVisitor.derivPfVec
                    derivObj = depPfObj;
                    if lhsNode.isDependentOnPf(derivObj)
                        derAssignNode = assignNode.generateDerivativeTree(derivObj);
                        derBlock.addChild(derAssignNode);
                    elseif lhsVarObj.isDependentOnPf(derivObj)
                        derAssignNode = lhsNode.resetDerivativeToZero(derivObj);
                        derBlock.addChild(derAssignNode);
                    end
                end

                % Remember: we are generating derivatives for a variable. We
                % can encounter all kinds of nasty things like bias dependent
                % if-else statements.
                % one example
                % var1 = V(s,b) + V(g,b);
                % ...do something with var1 here...
                % if Vgs < A
                %   var1 = V(s,b);
                % else
                %   var1 = V(g,b);
                % end
                % ...do something else with var1...
                % 
                % In the example above, we have to generate derivatives in the
                % if-else block. We have to generate derivatives with respect
                % to both V(s,b) and V(g,b) in both lines even though the
                % assignment itself depends only on one IO. Otherwise those
                % derivatives will retain their values from the previous
                % assignment and won't be set to zero.
                %
                % This is the reason why the above code does not only generate
                % derivatives for the IOs on the RHS of the assignment. It
                % implements a resetDerivativeToZero functionality as well!

            end

            % do we generate derivatives with respect to a variable?
            % That is, do we consider a variable to be an "independent
            % variable"?
            if thisVisitor.generateVarDeriv == true

                for depVarObj = thisVisitor.derivVarVec
                    derivObj = depVarObj;
                    if lhsVarObj ~= depVarObj
                        if lhsNode.isDependentOnVar(depVarObj)
                            derAssignNode = assignNode.generateDerivativeTree(derivObj);
                            derBlock.addChild(derAssignNode);
                        elseif lhsVarObj.isDependentOnPf(derivObj)
                            derAssignNode = lhsNode.resetDerivativeToZero(derivObj);
                            derBlock.addChild(derAssignNode);
                        end
                    end
                end
            end
        end

        function traverseSub = visitIrNodeContribution(thisVisitor, contribNode)
            % NOTE
            % constructing derivatives for contributions is different in
            % some important respects than constructing derivatives for
            % variables (assignments).
            % The object on the LHS of a contribution might not always be
            % relevant to the derivatives. This is for instance the case with
            % implicit contributions with dummy IOs. But there are other, more
            % subtle cases. An extra IO that is on the LHS on a contribution
            % but not on a RHS anywhere in the model... The contribution to
            % this IO will be delegated to its two "defPf"s.
            % So, we change the derivative structure here. By this I mean how
            % the dependencies are decided. I.e., do we compute the derivative
            % of this contribution with respect to some particular quantity
            % (variable or IO)?
            % For this, we don't rely on the isDependentOn method of the LHS
            % object (as it is the case for computing assignment derivatives)
            % but we keep a separate dependency array here.
            traverseSub = false;

            lhsNode = contribNode.getLhsNode();
            lhsPfObj = lhsNode.getPfObj();

            % now generate derivatives
            % we generate one block to hold the actual contribution node and the
            % derivatives.
            % The derivatives themselves are put into a separate block.
            parentNode = contribNode.getParent();
            joinNode = IrNodeBlock();
            joinNode.setIndentLevel(0);
            parentNode.replaceChild(contribNode, joinNode);

            derBlock = IrNodeDerivativeBlock();
            joinNode.addChild(derBlock);
            % Again, we have to add contribNode after we have added derBlock
            joinNode.addChild(contribNode);

            if thisVisitor.generatePfDeriv == true

                for depPfObj = thisVisitor.derivPfVec
                    if lhsNode.isDependentOnPf(depPfObj)
                        derivObj = depPfObj;
                        derContribNode = contribNode.generateDerivativeTree(derivObj);
                        derBlock.addChild(derContribNode);
                    end
                end

            end

            if thisVisitor.generateVarDeriv == true

                for depVarObj = thisVisitor.derivVarVec
                    if lhsNode.isDependentOnVar(depVarObj)
                        derivObj = depVarObj;
                        derContribNode = contribNode.generateDerivativeTree(derivObj);
                        derBlock.addChild(derContribNode);
                    end
                end
            end
        end

        function traverseSub = visitIrNodeOutput(thisVisitor, outNode)
        % VISITIRNODEOUTPUT
        % As opposed to contributions and assigments, IrNodeOutputs can only
        % have IrNodePotentialFlows on their RHS
            traverseSub = false;

            if outNode.isImplicit() == false
                dependPfVec = MsPotential.empty;
                lhsPfNode = outNode.getLhsNode();
                if lhsPfNode.isNull() == false
                    dependPfVec = lhsPfNode.getPfObj();
                end
                dependPfVec = [dependPfVec, outNode.getRhsPfVec()];
            else
                contribNode = outNode.getImplicitContrib();
                dependPfVec = contribNode.getImplicitEqnDependPfVec;
            end

            parentNode = outNode.getParent();
            joinNode = IrNodeBlock();
            joinNode.setIndentLevel(0);
            parentNode.replaceChild(outNode, joinNode);

            derBlock = IrNodeDerivativeBlock();
            joinNode.addChild(derBlock);
            % Again, we have to add outNode after we have added derBlock
            joinNode.addChild(outNode);

            if thisVisitor.generatePfDeriv == true

                depPfVec = MsPotential.empty;
                for depPfObj = thisVisitor.derivPfVec
                    for pfObj = dependPfVec
                        if pfObj.isDependentOnPf(depPfObj)
                            depPfVec = [depPfVec, depPfObj];
                            break;
                        end
                    end
                end

                for depPfObj = depPfVec
                    derivObj = depPfObj;
                    derContribNode = outNode.generateDerivativeTree(derivObj);
                    derBlock.addChild(derContribNode);
                end
            end

            if thisVisitor.generateVarDeriv == true

                depVarVec = MsVariable.empty;
                for depVarObj = thisVisitor.derivVarVec
                    for pfObj = dependPfVec
                        if pfObj.isDependentOnVar(depVarObj)
                            depVarVec = [depVarVec, depVarObj];
                            break;
                        end
                    end
                end

                for depVarObj = depVarVec
                    derivObj = depVarObj;
                    derContribNode = outNode.generateDerivativeTree(derivObj);
                    derBlock.addChild(derContribNode);
                end
            end
            
        end

        function traverseSub = visitIrNodeAnalogFunction(thisVisitor, afNode)
            traverseSub = false;

            inList = afNode.getInputList();
            outList = afNode.getOutputList();
            funcName = afNode.getName();
            varSfx = thisVisitor.VARSFX;

            derivOutList = {};

            joinNode = IrNodeBlock();
            afParent = afNode.getParent();
            afParent.replaceChild(afNode, joinNode);
            afNode.removeParent();
            joinNode.addChild(afNode);
            
            derivVis = IrVisitorGenerateDerivative([],[]);

            for i = 1:afNode.getNOutput()
                outputName = outList{i};
                for j = 1:afNode.getNInput()
                    inputName = inList{j};

                    derivOutputName = ['d_', outputName, '_d_' inputName, varSfx];
                    derivFuncName = ['d_', funcName, '_d_arg', num2str(j), varSfx];

                    derivFuncNode = afNode.copyDeep();
                    derivFuncNode.setName(derivFuncName);
                    derivFuncNode.setOutputList({derivOutputName});
                    % line below will add derivFuncNode to the list of known
                    % functions in afNode. But afNode shares this list with the
                    % top module. So it will be added there as well.
                    afNode.addFunc(derivFuncNode);

                    joinNode.addChild(derivFuncNode);
                    afParent.addFunc(derivFuncNode);

                    derivVis.setDerivVarVec(afNode.getVar(inputName));
                    derivVis.traverseChildren(derivFuncNode);

                    % here we want to add assignment nodes for the outputs
                    % (derivatives in this case). This is necessary because
                    % VAPP does not print derivatives that are 0 (in order to
                    % save computation time). If a derivative is zero and we do
                    % not print it anywhere in the fuction, it will be an
                    % unassigned output variable and will cause an error in
                    % matlab. This is usually the case for functions that have
                    % if/else statements in them.
                    outputVar = derivFuncNode.addVar(derivOutputName,...
                                                     IrNodeConstant('real', 0));
                    outputVarNode = IrNodeVariable(outputVar);

                    outputInitNode = IrNodeAssignment();
                    outputInitNode.addChild(outputVarNode);
                    outputInitNode.addChild(IrNodeConstant('real', 0));

                    % now add this assignment to a block
                    outputInitJoinNode = IrNodeBlock();
                    outputInitJoinNode.setIndentLevel(0);
                    outputInitJoinNode.addChild(outputInitNode);
                    derivFuncBlockNode = derivFuncNode.getChild(1);
                    derivFuncNode.replaceChild(derivFuncBlockNode, outputInitJoinNode);
                    outputInitJoinNode.addChild(derivFuncBlockNode);

                end
            end
        end

        function traverseSub = visitIrNodeFor(thisVisitor, forNode)
            traverseSub = false;
            blockNode = forNode.getChild(4);
            IrVisitorGenerateDerivative(thisVisitor.derivPfVec,...
                                         thisVisitor.derivVarVec,...
                                         blockNode);
        end

       
    % end methods
    end
    
% end classdef
end
