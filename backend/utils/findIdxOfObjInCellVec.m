function idx = findIdxOfObjInCellVec(cellVec, targetObj)
% GETIDXOFOBJINCELLVEC
    idx = 0;

    nObj = numel(cellVec);
    for i = 1:nObj
        obj = cellVec{i};
        if obj == targetObj
            idx = i;
            break;
        end
    end
end
