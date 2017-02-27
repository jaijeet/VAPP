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
        module = IrNodeModule.empty;
        collapsedBranchVec = MsBranch.empty;
        foundNestedIfElse = false;
        modelVec = MsModel.empty;
    end

    methods
        
        function obj = IrVisitorConstructModel(module, irTree, collapsedBranchVec)
            if nargin > 0
                obj.module = module;

                if nargin > 2
                    obj.collapsedBranchVec = collapsedBranchVec;
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

            thisVisitor.collapsedBranchVec = [thisVisitor.collapsedBranchVec, ...
                                                            cbNode.getBranch()];
        end

        function traverseSub = visitIrNodeIfElse(thisVisitor, ifElseNode)
        % VISITIRNODEIFELSE
            traverseSub = false;
            module = thisVisitor.module;
            thisVisitor.foundNestedIfElse = true;

            thenNode = ifElseNode.getChild(2);
            thenVisitor = IrVisitorConstructModel(module, thenNode, ...
                                                thisVisitor.collapsedBranchVec);

            if thenVisitor.foundNestedIfElse == false
                % construct model
                module.resetCollapsedBranches();
                for branchObj = thenVisitor.collapsedBranchVec
                    branchObj.setCollapsed();
                end
                model = module.initModel(thenVisitor.collapsedBranchVec);
                %model.setCollapsedBranchVec(thenVisitor.collapsedBranchVec);
                modelNode = IrNodeModel(model);
                thenNode.addChild(modelNode);
            end

            if ifElseNode.getNChild() > 2
                elseNode = ifElseNode.getChild(3);
                elseVisitor = IrVisitorConstructModel(module, elseNode, ...
                                                thisVisitor.collapsedBranchVec);

                if elseVisitor.foundNestedIfElse == false
                    % construct model
                    module.resetCollapsedBranches();
                    for branchObj = elseVisitor.collapsedBranchVec
                        branchObj.setCollapsed();
                    end
                    model = module.initModel(elseVisitor.collapsedBranchVec);
                    %model.setCollapsedBranchVec(elseVisitor.collapsedBranchVec);
                    modelNode = IrNodeModel(model);
                    elseNode.addChild(modelNode);
                end
            end
        end


    % end methods
    end
    
% end classdef
end
