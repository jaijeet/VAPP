classdef MsDifferentiable < handle 
% MSDIFFERENTIABLE abstract class representing a ModSpec object that can be
% differentiated
%
% MsPotentialFlow and MsVariable are subclasses of this class.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Jan 03, 2017  04:47PM
%==============================================================================

    properties (Access = protected)
        dependPfMap; %MsPotential.empty; % list of PotentialFlow objects this
                                         % MsDifferentiable depends on
        dependVarMap; % list of Variables this variables depends on.
        dependParmMap;
    end

    methods

        function obj = MsDifferentiable()
        % MSDIFFERENTIABLE
            obj.dependPfMap = LookupTableVapp();
            obj.dependVarMap = LookupTableVapp();
            obj.dependParmMap = LookupTableVapp();
        end

        function out = isDependentOnPf(thisDiffable, pfObj)
            if pfObj == thisDiffable
                out = true;
            elseif thisDiffable.dependPfMap.isKey(pfObj.getLabel()) == true
                out = true;
            else
                out = false;
            end
        end

        function addDependPf(thisDiffable, pfObj)
            thisDiffable.augmentDependPfVecC(pfObj);
            thisDiffable.addSubDependency(pfObj);
        end

        function augmentDependPfVecC(thisDiffable, pfObj)
        % AUGMENTDEPENDPFVECC
            if thisDiffable.isDependentOnPf(pfObj) == false
                thisDiffable.dependPfMap.addValue(pfObj.getLabel(), pfObj);
            end
        end
        
        function out = isDependentOnVar(thisDiffable, varObj)
            if varObj == thisDiffable
                out = true;
            else
                if thisDiffable.dependVarMap.isKey(varObj.getLabel()) == true
                    out = true;
                else
                    out = false;
                end
            end
        end

        function addDependVar(thisDiffable, varObj)
            thisDiffable.augmentDependVarVecC(varObj);
            thisDiffable.addSubDependency(varObj);
        end

        function augmentDependVarVecC(thisDiffable, varObj)
        % AUGMENTDEPENDVARVECC
            if thisDiffable.isDependentOnVar(varObj) == false
                thisDiffable.dependVarMap.addValue(varObj.getLabel(), varObj);
            end
        end

        function out = isDependentOnParm(thisDiffable, parmObj)
        % ISDEPENDENTONPARM
            if parmObj == thisDiffable
                out = true;
            else
                if thisDiffable.dependParmMap.isKey(parmObj.getLabel()) == true
                    out = true;
                else
                    out = false;
                end
            end
        end

        function addDependParm(thisDiffable, parmObj)
        % ADDDEPENDPARM
            thisDiffable.augmentDependParmVecC(parmObj);
            for depParmObj = parmObj.getDependParmVecC()
                thisDiffable.augmentDependParmVecC(depParmObj{:});
            end
        end

        function augmentDependParmVecC(thisDiffable, parmObj)
        % AUGMENTDEPENDPARMVECC
            if thisDiffable.isDependentOnParm(parmObj) == false
                thisDiffable.dependParmMap.addValue(parmObj.getLabel(), parmObj);
            end
        end

        function addSubDependency(thisDiffable, otherDiffable)
        % ADDSUBDEPENDEN

            for pfObj = otherDiffable.getDependPfVecC()
                thisDiffable.augmentDependPfVecC(pfObj{:});
            end

            for varObj = otherDiffable.getDependVarVecC()
                thisDiffable.augmentDependVarVecC(varObj{:});
            end

            for parmObj = otherDiffable.getDependParmVecC()
                thisDiffable.augmentDependParmVecC(parmObj{:});
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

        function pfVecC = getDependPfVecC(thisDiffable)
        % GETDEPENDPFVECC
            pfVecC = thisDiffable.dependPfMap.getValueArr();
        end

        function varVecC = getDependVarVecC(thisDiffable)
        % GETDEPENDVARVECC
            varVecC = thisDiffable.dependVarMap.getValueArr();
        end

        function parmVecC = getDependParmVecC(thisDiffable)
        % GETDEPENDPARMVECC
            parmVecC = thisDiffable.dependParmMap.getValueArr();
        end

        function resetDependVecC(thisDiffable)
        % RESETDEPENDVECC
            thisDiffable.dependPfMap = LookupTableVapp();
            thisDiffable.dependVarMap = LookupTableVapp();
            thisDiffable.dependParmMap = LookupTableVapp();
        end

        function pfMap = getDependPfMap(thisDiffable)
        % GETDEPENDPFMAP
            pfMap = thisDiffable.dependPfMap;
        end

        function varMap = getDependVarMap(thisDiffable)
        % GETDEPENDVARMAP
            varMap = thisDiffable.dependVarMap;
        end

        function parmMap = getDependParmMap(thisDiffable)
        % GETDEPENDPARMMAP
            parmMap = thisDiffable.dependParmMap;
        end


    % end methods
    end
    
% end classdef
end
