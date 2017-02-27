classdef IrNodeDifferentiable < IrNodeNumerical
% IRNODEDIFFERENTIABLE

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Sat Dec 10, 2016  06:47PM
%==============================================================================

    properties
        dependPfVec = MsPotential.empty; % list of PotentialFlow objects this
                                         % MsDifferentiable depends on
        dependVarVec = MsVariable.empty; % list of Variables this variables depends on.
        dependParmVec = MsParameter.empty;
    end

    methods (Abstract)
        outStr = sprintNumerical(thisNode, sprintAllFuncHandle);
    end

    methods (Abstract, Access = protected)
        [headNode, generateSub] = generateDerivative(thisNode, derObj);
    end

    methods

        function out = isDependentOnPf(thisDiffable, pfObj)
            if pfObj == thisDiffable
                out = true;
            else
                out = any(thisDiffable.dependPfVec == pfObj);
            end
        end

        function out = isDependentOnVar(thisDiffable, varObj)
            if varObj == thisDiffable
                out = true;
            else
                out = any(thisDiffable.dependVarVec == varObj);
            end
        end

        function setDependVarVec(thisNode, varVec)
        % SETDEPENDVARVEC
            thisNode.dependVarVec = varVec;
        end

        function setDependPfVec(thisNode, pfVec)
        % SETDEPENDPFVEC
            thisNode.dependPfVec = pfVec;
        end
    % end methods
    end
    
% end classdef
end
