classdef MsParameter < handle
% MSPARAMETER represents a parameter in a ModSpec model
%
% Parameter names can be augmented with a prefix. The rationale behind this is
% that we don't want to force the user to check the Verilog-A model for
% reserved MATLAB keywords. "type" is a common example which, if used as a
% parameter, will create problems in ModSpec.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Tue Nov 29, 2016  10:49AM
%==============================================================================

    properties (Access = private)
        name = '';
        defValTree = IrNode.empty;
        % The defValTree defines the default value of this parameter.
        % defValTree is an IR tree. The reason we don't use a simple constant here
        % is that the default value of a parameter can be given with a math
        % expression such as 2*1e-3.
        insValTree = IrNode.empty;
        % insValTree: instance value tree of this parameter. There is a
        % difference with defValTree only if this parameter depends on other
        % another parameter (dependentOnOtherParm == true). If
        % dependentOnOtherParm == true, defValTree will substitute that
        % parameter the default with its numeric value; whereas insValTree will
        % keep the parameter itself in the value tree.
        parmPrefix = 'parm_';
        % this prefix is used wherever a parameter object is encountered in the
        % code.
        range = '';
        dependentOnOtherParm = false;
        dependParmVec = MsParameter.empty;
        inNodeCollapse = false;
        parmIdx = 0;
    end

    methods
        function obj = MsParameter(parmName, defValTree)
            obj.name = parmName;
            obj.defValTree = defValTree;
            obj.insValTree = defValTree;
        end

        function parmName = getName(thisParm)
            parmName = [thisParm.parmPrefix, thisParm.name];
        end

        function label = getLabel(thisParm)
        % GETLABEL
            label = thisParm.getName();
        end

        function parmValStr = getValueStr(thisParm)
            parmValStr = thisParm.defValTree.sprintAll();
        end

        function defValTree = getDefValTree(thisParm)
            defValTree = thisParm.defValTree;
        end

        function out = isDependentOnOtherParm(thisParm)
        % ISDEPENDENTONOTHERPARM
            out = thisParm.dependentOnOtherParm;
        end

        function setDependentOnOtherParm(thisParm)
        % SETDEPENDENTONOTHERPARM
            thisParm.dependentOnOtherParm = true;
        end

        function setDependParmVec(thisParm, parmVec)
        % SETDEPENDPARMVEC
            thisParm.dependParmVec = parmVec;
        end

        function insValTree = getInsValTree(thisParm)
        % GETINSVALTREE
            insValTree = thisParm.insValTree;
        end

        function setInsValTree(thisParm, insValTree)
        % SETINSVALTREE
            thisParm.insValTree = insValTree;
        end

        function setInNodeCollapse(thisParm)
        % SETINNODECOLLAPSE
            thisParm.inNodeCollapse = true;
            for dependParm = thisParm.dependParmVec
                dependParm.setInNodeCollapse();
            end
        end

        function out = isInNodeCollapse(thisParm)
        % ISINNODECOLLAPSE
            out = thisParm.inNodeCollapse;
        end

        function setParmIdx(thisParm, idx)
        % SETPARMIDX
            thisParm.parmIdx = idx;
        end

        function idx = getParmIdx(thisParm)
        % GETPARMIDX
            idx = thisParm.parmIdx;
        end

        function parmVec = getDependParmVec(thisParm)
        % GETDEPENDPARMVEC
            parmVec = thisParm.dependParmVec;
        end

        function outStr = sprintInit(thisParm, parmIdx)
        % INITPARM

            outStr = '';
            parmName = thisParm.getName();
            if thisParm.isDependentOnOtherParm() == false
                outStr = [outStr, parmName, ' = ', ...
                                        sprintf('MOD__.parm_vals{%d};\n', parmIdx)];
            else
                insValTree = thisParm.getInsValTree();
                insValStr = insValTree.sprintAll();
                outStr = [outStr,...
                          sprintf(['if MOD__.parm_given_flag(%d) == true\n',...
                                    '    ', parmName, ' = MOD__.parm_vals{%d};\n',...
                                    'else\n',...
                                    '    ', parmName, ' = ', insValStr, ';\n',...
                                    'end\n'], parmIdx, parmIdx)];
            end

        end
    end

end
