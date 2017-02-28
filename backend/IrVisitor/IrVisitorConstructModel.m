classdef IrVisitorConstructModel < IrVisitor
% IRVISITORCONSTRUCTMODEL finds node collapse nodes and adds a IrNodeModel
% object there.
%
% The purpose of a IrNodeModel node is to set appropriate values for the
% properties of flows/potentials of branches.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Thu Feb 16, 2017  05:18PM
%==============================================================================
    properties (Access = private)
        module = {}; %IrNodeModule.empty;
        collapsedBranchVecC = {}; %MsBranch.empty;
        foundNestedIfElse = false;
        modelVecC = {}; %MsModel.empty;
    end

    methods
        
        function obj = IrVisitorConstructModel(module, irTree, collapsedBranchVecC)
            if nargin > 0
                obj.module = module;
                obj.uniqIdGen = module.getUniqIdGen();

                if nargin > 2
                    obj.collapsedBranchVecC = collapsedBranchVecC;
                end

                obj.traverseIr(irTree);
            end
        end

        function traverseSub = visitGeneric(thisVisitor, irNode)
            traverseSub = true;
        end

        function traverseSub = visitIrNodeCollapseBranch(thisVisitor, cbNode)
        % VISITIRNODECOLLAPSEBRANCH
            traverseSub = false;

            thisVisitor.collapsedBranchVecC = [thisVisitor.collapsedBranchVecC, ...
                                                            {cbNode.getBranch()}];
        end

        function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
        % VISITIRNODEIFELSE
            traverseSub = false;
            module = thisVisitor.module;
            thisVisitor.foundNestedIfElse = true;

            thenNode = ifElseNode.getChild(2);
            thenVisitor = IrVisitorConstructModel(module, thenNode, ...
                                                thisVisitor.collapsedBranchVecC);

            if thenVisitor.foundNestedIfElse == false
                % construct model
                module.resetCollapsedBranches();
                for branchObj = thenVisitor.collapsedBranchVecC
                    branchObj{:}.setCollapsed();
                end
                model = module.initModel(thenVisitor.collapsedBranchVecC);
                %model.setCollapsedBranchVecC(thenVisitor.collapsedBranchVecC);
                modelNode = IrNodeModel(thisVisitor.uniqIdGen, model);
                thenNode.addChild(modelNode);
            end

            if ifElseNode.getNChild() > 2
                elseNode = ifElseNode.getChild(3);
                elseVisitor = IrVisitorConstructModel(module, elseNode, ...
                                                thisVisitor.collapsedBranchVecC);

                if elseVisitor.foundNestedIfElse == false
                    % construct model
                    module.resetCollapsedBranches();
                    for branchObj = elseVisitor.collapsedBranchVecC
                        branchObj{:}.setCollapsed();
                    end
                    model = module.initModel(elseVisitor.collapsedBranchVecC);
                    %model.setCollapsedBranchVecC(elseVisitor.collapsedBranchVecC);
                    modelNode = IrNodeModel(thisVisitor.uniqIdGen, model);
                    elseNode.addChild(modelNode);
                end
            end
        end


    % end methods
    end
    
% end classdef
end
