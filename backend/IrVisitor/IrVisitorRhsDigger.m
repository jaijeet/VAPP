classdef IrVisitorRhsDigger < IrVisitor
% IRVISITORRHSDIGGER dig through the RHS of an assignment or a contribution.
%
% The instances of this class is to be used by other visitors when they are
% visiting contribution or assignment nodes. The idea is: create an instance of
% RhsDigger and let it loose on the rhs of the assignment or contribution and
% then collect info from the RhsDigger when it comes back home.
%
% TODO: this class lacks the functionality for discovering implicit equations.
% It can be coppied here from IrVisitorIoVarParmDigger.

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

    properties (Access = private)
        pfVec = MsFlow.empty; % potential-flow vector
        parmVec = MsParameter.empty;
        varVec = MsVariable.empty;
        lhsPfObj = MsPotential.empty;
        matchedPfNode = IrNodePotentialFlow.empty();
        nMatch = 0;
    end

    methods

        function obj = IrVisitorRhsDigger(irTree, lhsPfObj)
            if nargin > 0
                if nargin == 2
                    obj.lhsPfObj = lhsPfObj;
                end
                obj.traverseIr(irTree);
            end
        end

        function traverseSub = visitGeneric(thisVisitor, irNode)
            traverseSub = true;
        end

        function traverseSub = visitIrNodePotentialFlow(thisVisitor, pfNode)
        % VISITIRNODEPOTENTIALFLOW
            traverseSub = false;
            pfObj = pfNode.getPfObj();
            lhsPfObj = thisVisitor.lhsPfObj;
            
            if isempty(lhsPfObj) == false && pfObj == lhsPfObj
                thisVisitor.nMatch = thisVisitor.nMatch + 1;
                thisVisitor.matchedPfNode = pfNode;
            else
                thisVisitor.add2PfVec(pfObj);
            end
        end

        function traverseSub = visitIrNodeVariable(thisVisitor, varNode)
            traverseSub = false;
            varObj = varNode.getVarObj();
            thisVisitor.add2VarVec(varObj);
        end

        function traverseSub = visitIrNodeParameter(thisVisitor, parmNode)
        % VISITIRNODEPARAMETER
            traverseSub = false;
            parmObj = parmNode.getParmObj();
            thisVisitor.add2ParmVec(parmObj);
        end

        function add2PfVec(thisVisitor, pfObj)
            if all(thisVisitor.pfVec ~= pfObj)
                thisVisitor.pfVec = [thisVisitor.pfVec, pfObj];
            end
        end

        function add2VarVec(thisVisitor, varObj)
            if all(thisVisitor.varVec ~= varObj)
                thisVisitor.varVec = [thisVisitor.varVec, varObj];
            end
        end

        function add2ParmVec(thisVisitor, parmObj)
            if all(thisVisitor.parmVec ~= parmObj)
                thisVisitor.parmVec = [thisVisitor.parmVec, parmObj];
            end
        end

        function nMatch = getNMatch(thisDigger)
        % GETNMATCH
            nMatch = thisDigger.nMatch;
        end

        function mNode = getMatchedPfNode(thisDigger)
            mNode = thisDigger.matchedPfNode;
        end

        function pfVec = getPfVec(thisVisitor)
            pfVec = thisVisitor.pfVec;
        end

        function varVec = getVarVec(thisVisitor)
            varVec = thisVisitor.varVec;
        end

        function parmVec = getParmVec(thisVisitor)
        % GETPARMVEC
            parmVec = thisVisitor.parmVec;
        end
    % end methods
    end
    
% end classdef
end
