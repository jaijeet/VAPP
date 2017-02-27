clear;
%va2modspec('mvs_5t_mod_vappmod.va');
%va2modspec('neg_cap_3t.va');

neg_cap_dev = neg_cap_3t();
fet_dev = mvs_5t_mod();

cktnetlist.cktname = 'FEFET char curves test ckt';

% nodes (names)
cktnetlist.nodenames = {'in', 'gate', 'qg_as_v', 'drain'};
cktnetlist.groundnodename = 'gnd';

% vddElem
cktnetlist = add_element(cktnetlist, vsrcModSpec(), 'Vdd',...
                                    {'drain', 'gnd'}, {}, {{'DC', 1}});

% vggElem
cktnetlist = add_element(cktnetlist, vsrcModSpec(), 'Vgg', ...
                                                    {'in', 'gnd'});

cktnetlist = add_element(cktnetlist, neg_cap_dev, 'NegCap', ...
                                            {'in', 'qg_as_v', 'gate'});
% mosElem
cktnetlist = add_element(cktnetlist, fet_dev, 'NMOS',...
                    {'drain', 'gate', 'gnd', 'qg_as_v', 'gnd'}, {{'parm_type', +1}});

cktnetlist = add_output(cktnetlist, 'i(Vdd)', -1000);
DAE = MNA_EqnEngine(cktnetlist);
DAE = feval(DAE.setparms, 'NegCap:::parm_tFE', 50e-7, DAE); % nice folds

%contAnal.ArcContObj.ArcContParms

%outs = StateOutputs(DAE);
%outs = feval(outs.DeleteAll, outs);
%outs = feval(outs.Add, {'Vdd:::ipn'}, outs);

VDDs = [0.5, 1, 2, 3, 4];
i = 0; clr = 0;
for VDD = VDDs
    i = i + 1;
    DAE = feval(DAE.set_uQSS, 'Vdd:::E', VDD, DAE);
    inputORparam = 1; % lambda is an input
    contAnal = ArcContAnalysis(DAE, 'Vgg:::E', inputORparam);

    StartLambda = 0;
    StopLambda = VDD; % 1;
    initDeltaLambda = 1e-1;
    initguess = zeros(feval(DAE.nunks, DAE), 1); 

    lgndprefix = sprintf('VDD=%0.2g', VDD);
    contAnal = feval(contAnal.solve, contAnal, initguess, ...
                            StartLambda, StopLambda, initDeltaLambda);

    % arccont plots
    if 1 == i
        [figh, legends, clr] = feval(contAnal.plot, contAnal, ...
                                [], lgndprefix); % vs lambda
    else
        [figh, legends, clr] = feval(contAnal.plot, contAnal, [], ...
                    lgndprefix, '.-', figh, legends, clr); % vs lambda
    end
    drawnow;
    %feval(contAnal.plotVsArcLen, contAnal); % vs arclength

    %sol = feval(contAnal.getsolution, contAnal);
    %spts = sol.spts;
    %yvals = sol.yvals;
    %finalSol = sol.finalSol
end
