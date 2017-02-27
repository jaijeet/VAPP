classdef AstVisitorParmValTreeGenerator < AstVisitorIrGenerator
% ASTVISITORPARMVALTREEGENERATOR generates IR trees for default values of
% parameters

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties (Access = private)
        parmVec = MsParameter.empty;
    end

    methods

        function obj = AstVisitorParmValTreeGenerator(module)
            obj.module = module;
        end

        function out = visitVar(thisVisitor, varNode)
            % Here varNode can only be a parameter
            module = thisVisitor.module;
            parmName = varNode.get_name();
            out{1} = false;

            if module.isParm(parmName) == false
                error('The parameter %s was not defined in this module!',...
                                                                parmName);
            elseif module.isParm(parmName)
                parmObj = module.getParm(parmName);
                defValTree = parmObj.getDefValTree();
                out{2} = defValTree.copyDeep();
                thisVisitor.add2ParmVec(parmObj);
            end
        end

        function parmVec = getParmVec(thisVisitor)
        % GETPARMVEC
            parmVec = thisVisitor.parmVec;
        end
    % end methods
    end

    methods (Access = private)

        function add2ParmVec(thisVisitor, parmObj)
        % ADD2PARMVEC 
            if thisVisitor.hasParm(parmObj) == false
                thisVisitor.parmVec = [thisVisitor.parmVec, parmObj];
            end
        end 

        function out = hasParm(thisVisitor, parmObj)
        % HASPARM
            out = any(thisVisitor.parmVec == parmObj);
        end
    end
    
% end classdef
end
