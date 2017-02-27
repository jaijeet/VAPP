function out_str = VAPP_file_to_str(infile_path)

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: Aadithya V. Karthik
% Last modified: Tue Feb 14, 2017  03:49PM
%==============================================================================
    fid = fopen(infile_path, 'r');
    out_str = '';

    while true

        % don't use fgets below: with fgets, random things happen with files 
        % that don't have proper UNIX-style line endings; instead, fgetl gets
        % you lines without the trailing newline character, so you can add a
        % proper sprintf('\n') character yourself.
        l = fgetl(fid);

        if l == -1 % end of file reached
            break;
        end

        out_str = [out_str, l, sprintf('\n')];

    end

    fclose(fid);

end

