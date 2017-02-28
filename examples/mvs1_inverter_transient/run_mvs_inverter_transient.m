% Adapted from the MAPP example
%
% translate the model
%va2modspec('mvs_si_1_1_0_vappmod.va');
% set up DAE
DAE = MNA_EqnEngine(mvs_inverter_ckt());

% DC operating point analysis
DAE = feval(DAE.set_uQSS, 'Vin:::E', 0.0, DAE);
qss = op(DAE, [1,0,1,0,0,1,0,0,0]');
qssSol = feval(qss.getsolution, qss);

% transient
tstart = 0; tstep = 1e-13; tstop = 0.1e-9;
TransObj = dot_transient(DAE, qssSol, tstart, tstep, tstop);

% plot seleted state outputs
souts = StateOutputs(DAE);
souts = souts.DeleteAll(souts);
souts = souts.Add({'e_in'  'e_out'}, souts);
feval(TransObj.plot, TransObj, souts);
