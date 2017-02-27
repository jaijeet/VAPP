classdef MsFlow < MsPotentialFlow
% MSFLOW a flow through a branch (e.g., an electrical current)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods
        
        function obj = MsFlow(branchObj)
        % MSFLOW
            obj.labelPrefix = 'flow';
            obj.setBranch(branchObj);
        end

        function setBranch(thisFlow, branchObj)
            setBranch@MsPotentialFlow(thisFlow, branchObj);
            nature = branchObj.getFlowNature();
            thisFlow.nature = nature;
            thisFlow.labelPrefix = lower(nature.access);
        end

        function out = isExpOut(thisFlow)
        % ISEXPOUT
            % a branch flow is never an explicit out. Only terminal node flows
            % can be explicit outs.
            out = false;
        end

        function out = isOtherIo(thisFlow)
        % ISOTHERIO
            out = false;
        end

        function out = isIntUnk(thisFlow)
        % ISINTUNK
            out = false;
            branchObj = thisFlow.branch;
            if branchObj.isChord() == true && branchObj.isZeroFlow() == false
                if thisFlow.isContrib() == false
                    out = true;
                elseif thisFlow.isProbe() == true
                    out = true;
                end
            end
        end

        function label = getModSpecLabel(thisFlow)
        % GET
            branchLabel = thisFlow.branch.getModSpecLabel();
            label = ['i', branchLabel];
        end

        function out = isIndependent(thisFlow)
        % ISINDEPENDENT
            if thisFlow.branch.isChord() == true
                out = true;
            else
                out = false;
            end
        end

        function fLabel = getFLabel(thisFlow)
        % GETFLABEL
            if thisFlow.branch.isZeroFlow() == true
                fLabel = thisFlow.getLabel();
            else
                fLabel = getFLabel@MsPotentialFlow(thisFlow);
            end
        end

        function qLabel = getQLabel(thisFlow)
        % GETFLABEL
            if thisFlow.branch.isZeroFlow() == true
                qLabel = '';
            else
                qLabel = getQLabel@MsPotentialFlow(thisFlow);
            end
        end
    % end methods
    end

    methods (Static)
        function out = isFlow()
        % ISFLOW
            out = true;
        end
    end
    
% end classdef
end
