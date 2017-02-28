function idx = findIdxOfObjInVec(vec, targetObj)
% GETIDXOFOBJINCELLVEC
    idx = 0;

    nObj = numel(vec);
    for i = 1:nObj
        obj = vec(i);
        if obj == targetObj
            idx = i;
            break;
        end
    end
end
