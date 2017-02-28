classdef LookupTableVapp < handle
% LOOKUPTABLEVAPP container.Maps replacement for Octave compatibility
% We can't just use structs because we need this data structure to be passed
% between different objects and functions.

    properties
        data = struct();
    end

    methods

        function out = isKey(thisTable, keyName)
        % ISKEY
            out = isfield(thisTable.data, keyName);
        end

        function keyArr = getKeyArr(thisTable)
        % GETKEYS
            keyArr = transpose(fieldnames(thisTable.data));
        end

        function valArr = getValueArr(thisTable)
        % GETVALUES
            valArr = transpose(struct2cell(thisTable.data));
        end

        function val = getValue(thisTable, key)
        % GETVAL
            val = thisTable.data.(key);
        end

        function addValue(thisTable, key, val)
        % ADD
            thisTable.data.(key) = val;
        end

        function cpTable = copy(thisTable)
            cpTable = LookupTableVapp();
            cpTable.data = thisTable.data;
        end
        
    % end methods
    end
% end classdef
end
