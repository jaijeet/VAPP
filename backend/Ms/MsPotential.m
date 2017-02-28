classdef MsPotential < MsPotentialFlow
% MSPOTENTIAL a potential across a branch (like a voltage)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods

        function obj = MsPotential(branchObj)
        % MSPOTENTIAL
            obj@MsPotentialFlow();
            obj.labelPrefix = 'potential';
            obj.setBranch(branchObj);
        end

        function setBranch(thisPotential, branchObj)
            setBranch@MsPotentialFlow(thisPotential, branchObj);
            nature = branchObj.getPotentialNature();
            thisPotential.nature = nature;
            thisPotential.labelPrefix = lower(nature.access);
        end

        function out = isExpOut(thisPotential)
        % ISEXPOUT
            out = false;
            branchObj = thisPotential.branch;

            if branchObj.isReference() == true
                if thisPotential.isOtherIo() == false
                    out = true;
                end
            end
        end

        function out = isOtherIo(thisPotential)
        % ISOTHERIO
            out = false;
            branchObj = thisPotential.branch;

            if branchObj.isReference() == true && ...
                                branchObj.isTwig() == true
                if thisPotential.isContrib() == false
                    out = true;
                elseif thisPotential.isProbe() == true
                    out = true;
                end
            end
        end

        function out = isIntUnk(thisPotential)
        % ISINTUNK
            out = false;
            branchObj = thisPotential.branch;
            if branchObj.isReference() == false && ...
                               branchObj.isTwig() == true
                if thisPotential.isContrib() == false
                    out = true;
                elseif thisPotential.isProbe() == true
                    out = true;
                end
            end
        end

        function label = getModSpecLabel(thisPotential)
        % GET
            branchLabel = thisPotential.branch.getModSpecLabel();
            label = ['v', branchLabel];
        end

        function out = isIndependent(thisPotential)
        % ISINDEPENDENT
            if thisPotential.branch.isTwig() == true
                out = true;
            else
                out = false;
            end
        end
    % end methods
    end

    methods (Static)
        function out = isPotential()
        % ISPOTENTIAL
            out = true;
        end
    end
    
% end classdef
end
