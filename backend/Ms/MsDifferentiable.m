classdef MsDifferentiable < handle
% MSDIFFERENTIABLE abstract class representing a ModSpec object that can be
% differentiated
%
% MsPotentialFlow and MsVariable are subclasses of this class.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Sat Dec 10, 2016  07:23PM
%==============================================================================

    properties (Access = protected)
        dependPfVec = MsPotential.empty; % list of PotentialFlow objects this
                                         % MsDifferentiable depends on
        dependVarVec = MsVariable.empty; % list of Variables this variables depends on.
        dependParmVec = MsParameter.empty;
    end

    methods

        function out = isDependentOnPf(thisDiffable, pfObj)
            if pfObj == thisDiffable
                out = true;
            else
                out = any(thisDiffable.dependPfVec == pfObj);
            end
        end

        function addDependPf(thisDiffable, pfObj)
            thisDiffable.augmentDependPfVec(pfObj);
            thisDiffable.addSubDependency(pfObj);
        end

        function augmentDependPfVec(thisDiffable, pfObj)
        % AUGMENTDEPENDPFVEC
            if thisDiffable.isDependentOnPf(pfObj) == false
                thisDiffable.dependPfVec(end+1) = pfObj;
            end
        end
        
        function out = isDependentOnVar(thisDiffable, varObj)
            if varObj == thisDiffable
                out = true;
            else
                out = any(thisDiffable.dependVarVec == varObj);
            end
        end

        function addDependVar(thisDiffable, varObj)
            thisDiffable.augmentDependVarVec(varObj);
            thisDiffable.addSubDependency(varObj);
        end

        function augmentDependVarVec(thisDiffable, varObj)
        % AUGMENTDEPENDVARVEC
            if thisDiffable.isDependentOnVar(varObj) == false
                thisDiffable.dependVarVec(end+1) = varObj;
            end
        end

        function out = isDependentOnParm(thisDiffable, parmObj)
        % ISDEPENDENTONPARM
            if parmObj == thisDiffable
                out = true;
            else
                out = any(thisDiffable.dependParmVec == parmObj);
            end
        end

        function addDependParm(thisDiffable, parmObj)
        % ADDDEPENDPARM
            thisDiffable.augmentDependParmVec(parmObj);
            for depParmObj = parmObj.getDependParmVec()
                thisDiffable.augmentDependParmVec(depParmObj);
            end
        end

        function augmentDependParmVec(thisDiffable, parmObj)
        % AUGMENTDEPENDPARMVEC
            if thisDiffable.isDependentOnParm(parmObj) == false
                thisDiffable.dependParmVec(end+1) = parmObj;
            end
        end

        function addSubDependency(thisDiffable, otherDiffable)
        % ADDSUBDEPENDEN

            for pfObj = otherDiffable.getDependPfVec()
                thisDiffable.augmentDependPfVec(pfObj);
            end

            for varObj = otherDiffable.getDependVarVec()
                thisDiffable.augmentDependVarVec(varObj);
            end

            for parmObj = otherDiffable.getDependParmVec()
                thisDiffable.augmentDependParmVec(parmObj);
            end
        end


        function out = isDependentOnDerivObj(thisDiffable, derivObj)
        % ISDEPENDENTONDERIVOBJ
            if isa(derivObj, 'MsPotentialFlow')
                out = thisDiffable.isDependentOnPf(derivObj);
            elseif isa(derivObj, 'MsVariable')
                out = thisDiffable.isDependentOnVar(derivObj);
            elseif isa(derivObj, 'MsParameter')
                out = thisDiffable.isDependentOnParm(derivObj);
            else
                error(['The supplied derivObj must be of one of the',...
                       ' following clases: MsPotentialFlow, MsVariable,',...
                       ' MsParameter!']);
            end
        end

        function derivLabel = getDerivLabel(thisDiffable, derivObj)
        % GETDERIVATIVELABEL
            derivLabel = ['d_', thisDiffable.getLabel(), ...
                                         '_d_', derivObj.getLabel()];
        end

        function pfVec = getDependPfVec(thisDiffable)
        % GETDEPENDPFVEC
            pfVec = thisDiffable.dependPfVec;
        end

        function varVec = getDependVarVec(thisDiffable)
        % GETDEPENDVARVEC
            varVec = thisDiffable.dependVarVec;
        end

        function parmVec = getDependParmVec(thisDiffable)
        % GETDEPENDPARMVEC
            parmVec = thisDiffable.dependParmVec;
        end

        function resetDependVec(thisDiffable)
        % RESETDEPENDVEC
            thisDiffable.dependPfVec = MsPotential.empty;
            thisDiffable.dependVarVec = MsVariable.empty;
            thisDiffable.dependParmVec = MsParameter.empty;
        end


    % end methods
    end
    
% end classdef
end
