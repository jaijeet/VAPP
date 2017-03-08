function cktnetlist = psp_csamp_ckt()
%
%
%Examples
%--------
%
% % set up DAE
% DAE = MNA_EqnEngine(psp_csamp_ckt);
% 
% % DC operating point analysis
% DAE = feval(DAE.set_uQSS, 'Vin:::E', 0.0, DAE);
% qss = dot_op(DAE);
% % print DC operating point
% feval(qss.print, qss);
% qssSol = feval(qss.getsolution, qss);
% 
% % DC sweep
% swp = dcsweep(DAE, [], 'Vin:::E', 0:1/40:1);
% % feval(swp.plot, swp); % this will plot all DAE states
%
% % get DC sweep solutions and plot Vout-Vin curve
% [Vins, sols] = swp.getSolution(swp);
% outidx = DAE.unkidx('e_out', DAE);
% plot(Vins, sols(outidx, :), '-r.', 'LineWidth', 2);
% xlabel('Vin'); ylabel('Vout'); title('DC sweep results of MVS inverter');
% grid on; box on;
% 
% % transient
% tstart = 0; tstep = 1e-13; tstop = 0.1e-9;
% TransObj = dot_transient(DAE, qssSol, tstart, tstep, tstop);
%
% % plot seleted state outputs
% souts = StateOutputs(DAE);
% souts = souts.DeleteAll(souts);
% souts = souts.Add({'e_in'  'e_out'}, souts);
% feval(TransObj.plot, TransObj, souts);
%
%See also
%--------
% 
% add_element, supported_ModSpec_devices[TODO], DAEAPI, DAE_concepts,
% dcsweep
%

%
% Author: Tianshi Wang, 2014/01/30



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Type "help MAPPlicense" at the MATLAB/Octave prompt to see the license      %
%% for this software.                                                          %
%% Copyright (C) 2008-2013 Jaijeet Roychowdhury <jr@berkeley.edu>. All rights  %
%% reserved.                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    PSP_model = PSP103VA();

    % ckt name
    cktnetlist.cktname = 'PSP common source circuit';

    % nodes (names)
    cktnetlist.nodenames = {'vdd', 'in', 'out'};
    cktnetlist.groundnodename = 'gnd';

    VddDC = 1;
    VinDC = 0;
	% input function for Vin
	Vinfunc = @(t, args) VddDC*pulse(t, args.td, args.thi, args.tfs, args.tfe); 
	Vinargs.td = 25e-11; Vinargs.thi = 30e-11; Vinargs.tfs = 70e-11; Vinargs.tfe = 75e-11;

    % vddElem
    cktnetlist = add_element(cktnetlist, vsrcModSpec(), 'Vdd', {'vdd', 'gnd'}, {}, {{'E',...
    {'DC', VddDC}}});

    % vinElem
    cktnetlist = add_element(cktnetlist, vsrcModSpec(), 'Vin', {'in', 'gnd'}, {}, {{'E',...
    {'DC', VinDC}, {'TRAN', Vinfunc, Vinargs}}});

    % nmosElem
    cktnetlist = add_element(cktnetlist, PSP_model, 'NMOS', {'out', 'in', 'gnd', 'gnd'}, ...
        {{'parm_TYPE', 1}, {'parm_L', 10e-9}, {'parm_W', 100e-9}});

    % resistor
    cktnetlist = add_element(cktnetlist, resModSpec(), 'Resistor', {'vdd', 'out'}, {{'R', 1e5}});

end

