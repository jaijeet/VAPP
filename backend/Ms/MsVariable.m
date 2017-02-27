classdef MsVariable < MsDifferentiable
% MSVARIABLE represents a variable in a ModSpec model.
%
% Variables keep track of their states in the model, and initialize themselves
% to zero at the beginning of the analog block if they are used before they are
% set.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Dec 08, 2016  09:39PM
%==============================================================================

    properties (Access = private)
        name = '';
        used = false;
        init = false; % is this var initialized?
        usedBeforeInit = false;
        valTree = IrNode.empty;
        module = IrNodeModule.empty;
        derivative = false;
        inNodeCollapse = false;
    end

    methods
        function obj = MsVariable(varName, valTree)
            obj.name = varName;
            if nargin > 1
                obj.valTree = valTree;
            else
                obj.valTree = IrNodeNumerical.getConstantNode(0);
            end
        end

        function varName = getName(thisVar)
            varName = thisVar.name;
        end

        function label = getLabel(thisVar)
        % GETLABEL
            label = thisVar.getName();
        end

        function setInit(thisVar)
            if thisVar.init == false
                thisVar.init = true;
                if thisVar.used == true
                    thisVar.usedBeforeInit = true;
                else
                    thisVar.usedBeforeInit = false;
                end
            end
        end

        function setUsed(thisVar)
            if thisVar.used == false
                thisVar.used = true;
                if thisVar.init == true
                    thisVar.usedBeforeInit = false;
                else
                    thisVar.usedBeforeInit = true;
                end
            end
        end

        function out = isUsedBeforeInit(thisVar)
            out = thisVar.usedBeforeInit;
        end

        function varValStr = getValueStr(thisVar)
            varValStr = thisVar.valTree.sprintAll();
        end

        function module = getModule(thisVar)
        % GETMODULE
            module = thisVar.module;
        end

        function setModule(thisVar, module)
            thisVar.module = module;
        end

        function out = isDerivative(thisVar)
            out = thisVar.derivative;
        end

        function setDerivative(thisVar)
            thisVar.derivative = true;
        end

        function setInNodeCollapse(thisVar)
        % SETINNODECOLLAPSE
            if isempty(thisVar.dependPfVec) == false
                varLabel = thisVar.getLabel();
                errorStr = sprintf(['A node collapse statement depends on',...
                                    ' the variable %s whose value is bias',...
                                    ' dependent!\n%s depends on:\n'],...
                                                         varLabel, varLabel);
                for pfObj = thisVar.dependPfVec
                    errorStr = sprintf([errorStr, pfObj.getLabel(), '\n']);
                end
                error(errorStr);
            else
                thisVar.inNodeCollapse = true;
            end
        end

        function out = isInNodeCollapse(thisVar)
        % ISINNODECOLLAPSE
            out = thisVar.inNodeCollapse;
        end

        function addDependPf(thisVar, pfObj)
        % ADDDEPENDPF
            if thisVar.inNodeCollapse == true
                error(['A node collapse statement depends on the variable',...
                       ' "%s" whose value depends on the potential/flow',...
                       ' "%s". Bias dependent node collapse statements are',...
                       ' not allowed!'], thisVar.getLabel(), pfObj.getLabel());
            end
            addDependPf@MsDifferentiable(thisVar, pfObj);
        end

        function addDependVar(thisVar, varObj)
            addDependVar@MsDifferentiable(thisVar, varObj);
            if thisVar.inNodeCollapse == true
                varObj.setInNodeCollapse();
            end
        end

        function addDependParm(thisVar, parmObj)
            addDependParm@MsDifferentiable(thisVar, parmObj);
            if thisVar.inNodeCollapse == true
                parmObj.setInNodeCollapse();
            end
        end

        function augmentDependVarVec(thisVar, varObj)
            augmentDependVarVec@MsDifferentiable(thisVar, varObj);
            if thisVar.inNodeCollapse == true
                varObj.setInNodeCollapse();
            end
        end

        function augmentDependParmVec(thisVar, parmObj)
            augmentDependParmVec@MsDifferentiable(thisVar, parmObj);
            if thisVar.inNodeCollapse == true
                parmObj.setInNodeCollapse();
            end
        end

    %end methods
    end
% end classdef
end
