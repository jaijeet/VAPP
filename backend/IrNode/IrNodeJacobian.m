classdef IrNodeJacobian < IrNodeNumerical
% IRNODEJACOBIAN represents a Jacobian entry
% IrNodeJacobian instances are created by IrNodeOutput instances as their
% derivatives.
%
% See also IrNodeOutput

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    properties
        eOrI = '';
        outIdx = 0;
        derivPfVecC = {}; % MsPotential.empty;
    end

    methods

        function obj = IrNodeJacobian(uniqIdGen, eOrI, outIdx, derivPfVecC)
        % IRNODEJACOBIAN
            obj = obj@IrNodeNumerical(uniqIdGen);
            if nargin > 1
                obj.eOrI = eOrI;
                obj.outIdx = outIdx;
                obj.derivPfVecC = derivPfVecC;
            end
        end


        function [outStr, printSub] = sprintNumerical(thisJacobian, ~)
        % SPRINTNUMERICAL
            printSub = false;

            fStr = '';
            qStr = '';
            
            varSfx = thisJacobian.VARSFX;
            fqSfx = thisJacobian.eOrI;
            derivPfVecC = thisJacobian.derivPfVecC;

            idxStr = num2str(thisJacobian.outIdx);

            for i=1:numel(derivPfVecC)
                derivPf = derivPfVecC{i};
                idxStr = [idxStr, ',', num2str(derivPf.getInIdx())];
                if derivPf.isOtherIo() == true
                    fqSfx = [fqSfx, '_d_X'];
                elseif derivPf.isIntUnk() == true
                    fqSfx = [fqSfx, '_d_Y'];
                else
                    % added for node collapse case. The Jacobian might have
                    % been created for an IO on a branch which is collapsed by
                    % the time this Jacobian is being printed.
                    outStr = '';
                    return;
                end
            end

            rhsStrF = thisJacobian.getChild(1).sprintAll();
            rhsStrQ = thisJacobian.getChild(2).sprintAll();

            if isempty(rhsStrF) == false
                fStr = ['d_f', fqSfx, varSfx, '(', idxStr, ') = ', rhsStrF, ';\n'];
            end

            if isempty(rhsStrQ) == false
                qStr = ['d_q', fqSfx, varSfx, '(', idxStr, ') = ', rhsStrQ, ';\n'];
            end

            outStr = [fStr, qStr];

        end
        
        function [headNode, generateSub] = generateDerivative(thisJacobian, derivObj)
        % GENERATEDERIVATIVE
            % TODO: currently this method does not get called by
            % IrVisitorGenerateDerivative
        end

    % end methods
    end
    
% end classdef
end
