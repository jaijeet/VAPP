classdef MsComparableViaLabel < handle
% MSCOMPARABLEVIALABEL Abstract class for classes that have unique labels
%
% This class is here because Octave does not allow comparing handle objects,
% e.g.,
%
% v1 = MsVariable(); v2 = MsVariable(); (v1 == v2)
%
% For IrNode and ite child classes we overcome this by using a
% UniqueIdGenerator class.
% For ModSpec base classes, i.e., classes that start with the Ms prefix, we do
% this by simply comparing their labels. If an object has the same label with
% another object, we assume they are the same object.

    methods (Sealed)
        function out = eq(thisComparable, otherComparable)
        % EQ
            out = false;
            className = class(thisComparable);
            if isa(otherComparable, className) && ...
                    strcmp(thisComparable.getLabel(), otherComparable.getLabel) == true
                out = true;
            end
        end

        function out = ne(thisComparable, otherComparable)
        % NE
            out = false;
            className = class(thisComparable);
            if isa(otherComparable, className) == false || ...
                    strcmp(thisComparable.getLabel(), otherComparable.getLabel) == false
                out = true;
            end
            
        end
    end
    
    
% end classdef
end
