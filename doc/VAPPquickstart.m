% Quick User's guide to Berkeley Verilog-A Parser and Processor (VAPP)
%
%**************************** FIRST QUICK RUN *********************************
% 
% Copy and paste the following commands at a MATLAB prompt to
%
% 1. create a file that contains a simple Verilog-A nonlinear resistor model
% 2. translate it into ModSpec format using VAPP's va2modspec function 
%       
%-------------------------START COPY AND PASTE---------------------------------
%
%fid = fopen('nonlinear_resistor.va', 'w');
%fprintf(fid,[...
%  '`include "disciplines.vams"\n',...
%  'module nonlinear_resistor(p,n);\n',...
%  '  inout p,n;\n',...
%  '  electrical p,n;\n',...
%  '  parameter real R=1e3 from [0:inf);\n\n',...
%  '  analog function real nonlinearity;\n',...
%  '  	input x;\n',...
%  '      output y;\n',...
%  '  	real x, y;\n',...
%  '  	begin\n',...
%  '          y = x*x*x;\n',...; 
%  '  	end\n',...
%  '  endfunction\n\n',...
%  ...
%  '  analog\n',...
%  '     I(p,n) <+ nonlinearity(V(p,n))/R;\n',...
%  'endmodule'...
%]);
%fclose(fid);
%
%va2modspec('nonlinear_resistor.va');
%
%-------------------------END COPY AND PASTE-----------------------------------
%
%************************* USING THE MODEL IN MAPP ****************************
%
% (Note: the following example requires MAPP to be installed on your system and
%        that MAPP has been setup using start_MAPP.m)
%
% Copy and paste the following commands at a MATLAB prompt to plot the I-V
% curves of the model above using MAPP's model_exerciser.
%
% (Note: press Enter twice when prompted by the model exerciser script.)
%
%-------------------------START COPY AND PASTE---------------------------------
%
%MOD = nonlinear_resistor();
%MEO = model_dc_exerciser(MOD);
%Vp = -1:0.1:1; Vn = 0; 
%MEO.plot('Ip', Vp, Vn, MEO);
%
%-------------------------END COPY AND PASTE-----------------------------------
%
%**************************** USER INTERFACE **********************************
% 
% va2modspec function constitutes the main user interface for VAPP.
%
% For help on input options for va2modspec
%
%   help va2modspec
%
%**************************** MORE EXAMPLES ***********************************
%
% For more examples type
%
%   help VAPPexamples
%
%See also va2modspec VAPPexamples 
