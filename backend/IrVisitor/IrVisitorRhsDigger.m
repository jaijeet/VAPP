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
% Last modified: Wed Jan 04, 2017  03:54PM
%==============================================================================

    properties (Access = private)
        pfVecC = {}; %MsFlow.empty; % potential-flow vector
        parmVecC = {};
        varVecC = {};
        lhsPfObj = {};
        matchedPfNode = {};
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
                thisVisitor.add2PfVecC(pfObj);
            end
        end

        function traverseSub = visitIrNodeVariable(thisVisitor, varNode)
            traverseSub = false;
            varObj = varNode.getVarObj();
            thisVisitor.add2VarVecC(varObj);
        end

        function traverseSub = visitIrNodeParameter(thisVisitor, parmNode)
        % VISITIRNODEPARAMETER
            traverseSub = false;
            parmObj = parmNode.getParmObj();
            thisVisitor.add2ParmVecC(parmObj);
        end

        function add2PfVecC(thisVisitor, pfObj)
            %if all(thisVisitor.pfVec ~= pfObj)
            %    thisVisitor.pfVec = [thisVisitor.pfVec, pfObj];
            %end
            if findIdxOfObjInCellVec(thisVisitor.pfVecC, pfObj) == 0
                thisVisitor.pfVecC = [thisVisitor.pfVecC, {pfObj}];
            end
        end

        function add2VarVecC(thisVisitor, varObj)
            if findIdxOfObjInCellVec(thisVisitor.varVecC, varObj) == 0
                thisVisitor.varVecC = [thisVisitor.varVecC, {varObj}];
            end
        end

        function add2ParmVecC(thisVisitor, parmObj)
            if findIdxOfObjInCellVec(thisVisitor.parmVecC, parmObj) == 0
                thisVisitor.parmVecC = [thisVisitor.parmVecC, {parmObj}];
            end
        end

        function nMatch = getNMatch(thisDigger)
        % GETNMATCH
            nMatch = thisDigger.nMatch;
        end

        function mNode = getMatchedPfNode(thisDigger)
            mNode = thisDigger.matchedPfNode;
        end

        function pfVecC = getPfVecC(thisVisitor)
            pfVecC = thisVisitor.pfVecC;
        end

        function varVecC = getVarVecC(thisVisitor)
            varVecC = thisVisitor.varVecC;
        end

        function parmVecC = getParmVecC(thisVisitor)
        % GETPARMVEC
            parmVecC = thisVisitor.parmVecC;
        end
    % end methods
    end
    
% end classdef
end
