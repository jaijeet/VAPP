%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu, J. Roychowdhury
% Last modified: Mon Feb 20, 2017  01:25PM
%==============================================================================

%va2modspec('bsim3.va');

DAE = bsim3_ringosc_ckt();

% set DC and transient inputs for VDD
DAE = feval(DAE.set_uQSS, 'vdd:::E', 1.2, DAE);
DAE = feval(DAE.set_uQSS, 'iInj1:::I', 0, DAE);
const_func = @(t,args) 1.2;
zero_func = @(t, args) 0;
DAE = feval(DAE.set_utransient, 'vdd:::E', const_func, [], DAE);
DAE = feval(DAE.set_utransient, 'iInj1:::I', zero_func, [], DAE);

% run DC
qss = QSS(DAE);
qss = feval(qss.solve, qss);
feval(qss.print, qss);
DCsol = feval(qss.getsolution, qss);

outs = StateOutputs(DAE);
outs = feval(outs.DeleteAll, outs);
outs = feval(outs.Add, {'e_inv1', 'e_inv2', 'e_inv3'}, outs);

% run transient and plot
%xinit = DCsol;
%xinit = rand(size(DCsol));
xinit = [0.5311; 0.4867; 0.4146; 0.3303; 0.9766; 0.3284; 0.9153; 0.5717; 0.8206;
         0.2007; 0.5388; 0.5668; 0.9754; 0.7336; 0.6981; 0.8569; 0.5925];

tstart = 0; tstep = 6e-9; tstop =  1e-7; % crude, but enough to test
trans = run_transient_GEAR2(DAE, xinit, tstart, tstep, tstop);
[thefig, legends] = feval(trans.plot, trans, outs);
