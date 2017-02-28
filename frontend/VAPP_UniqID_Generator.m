classdef VAPP_UniqID_Generator < handle

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================
    properties
        next_uniqID;
    end

    methods

        function self = VAPP_UniqID_Generator()
            % constructor
            self.next_uniqID = 1;
        end

        function out = get_uniqID(self)
            out = self.next_uniqID;
            self.next_uniqID = self.next_uniqID + 1;
        end

    end

end

