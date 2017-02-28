classdef UniqueIdGenerator < handle
% UNIQUEIDGENERATOR

    properties (Access = private)
        lastId = 0;
    end

    methods
       
        function uniqId = generateId(thisGen)
        % GENERATEUNIQID
            uniqId = thisGen.lastId + 1;
            thisGen.lastId = uniqId;
        end 
    % end methods
    end
    
% end classdef
end
