classdef IrNodeDerivativeBlock < IrNode
% IRNODEDERIVATIVEBLOCK is used to organize derivative nodes.
% IrVisitorGenerateDerivative will generate derivatives and add them to a newly
% created IrNodeDerivativeBlock before attaching them to the module.
%
% See also IrVisitorGenerateDerivative

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================
    methods
        function obj = IrNodeDerivativeBlock(uniqIdGen)
        % IRNODEDERIVATIVEBLOCK
            obj = obj@IrNode(uniqIdGen);
        end

        function varObj = addVarToModule(thisNode, varLabel, isDerivative)
        % ADDVARTOMODULE
            varObj = addVarToModule@IrNode(thisNode, varLabel, true);
        end
    % end methods
    end
    
% end classdef
end
