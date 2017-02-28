classdef IrNodeDifferentiable < IrNodeNumerical
% IRNODEDIFFERENTIABLE

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Jan 05, 2017  11:30AM
%==============================================================================

    properties
        dependPfMap; % list of PotentialFlow objects this
                                         % MsDifferentiable depends on
        dependVarMap; % list of Variables this variables depends on.
    end

    methods

        function obj = IrNodeDifferentiable(uniqIdGen)
        % IRNODEDIFFERENTIABLE
            obj = obj@IrNodeNumerical(uniqIdGen);
            obj.dependPfMap = LookupTableVapp();
            obj.dependVarMap = LookupTableVapp();
        end

        function out = isDependentOnPf(thisDiffable, pfObj)
            if thisDiffable.dependPfMap.isKey(pfObj.getLabel()) == true
                out = true;
            else
                out = false;
            end
        end

        function out = isDependentOnVar(thisDiffable, varObj)
            if thisDiffable.dependVarMap.isKey(varObj.getLabel()) == true
                out = true;
            else
                out = false;
            end
        end

        function setDependVarMap(thisNode, varMap)
        % SETDEPENDVARVECC
            thisNode.dependVarMap = varMap.copy();
        end

        function setDependPfMap(thisNode, pfMap)
        % SETDEPENDPFVECC
            thisNode.dependPfMap = pfMap.copy();
        end
    % end methods
    end
    
% end classdef
end
