%va2modspec('vbic1.2_vappmod.va')
% set up DAE
DAE =  MNA_EqnEngine(vbic_diffpair_ckt());

% set up state outputs "manually"
souts = StateOutputs(DAE);
souts = souts.DeleteAll(souts);
souts = souts.Add({'e_nCL', 'e_nCR', 'e_Vin', 'e_nE'}, souts);

% run a DC operating point analysis
dcop = dot_op(DAE);
% get DC operating point solution vector
qssSol = feval(dcop.getsolution, dcop);

% AC analysis @ DC operating point; plot both DAE-defined and state outputs
sweeptype = 'DEC'; fstart=1; fstop=1e5; nsteps=10;
ltisss = dot_ac(DAE, qssSol, feval(DAE.uQSS, DAE), fstart, fstop,...
nsteps, sweeptype);
% plot frequency sweeps of system outputs
feval(ltisss.plot, ltisss); % plot DAE-defined outputs
feval(ltisss.plot, ltisss, souts); % plot state outputs

% run transient and plot (both DAE-defined and state outputs)
%tstart = 0; tstep = 1e-5; tstop = 2e-3;
%TransObj = dot_transient(DAE, qssSol, tstart, tstep, tstop);
%feval(TransObj.plot, TransObj); % plot DAE-defined outputs 
%feval(TransObj.plot, TransObj, souts); % plot state outputs
