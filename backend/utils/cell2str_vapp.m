function outStr = cell2str(inArr, surroundDelim, splitLen, splitShift)
    if nargin < 2
        surroundDelim = '';
    end

    if isempty(inArr) == false
        outStr = [surroundDelim, inArr{1}, surroundDelim];
        nEl = numel(inArr);

        if nargin < 4
            splitShift = 0;
            if nargin < 3
                splitLen = 0;
            end
        end

        for i=2:nEl
            if mod(i+1,splitLen) == 0
                sepStr = sprintf(',...\n%s', repmat(' ', 1, splitShift));
            else
                sepStr = sprintf(', ');
            end

            inEl = inArr{i};
            if ischar(inEl)
                outStr = [outStr, sepStr, surroundDelim, inArr{i}, surroundDelim];
            else
                outStr = [outStr, sepStr, num2str(inArr{i})];
            end
        end
    else
        outStr = '';
    end
end
