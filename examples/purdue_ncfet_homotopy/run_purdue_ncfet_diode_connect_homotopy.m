clear;
%va2modspec('mvs_5t_mod_vappmod.va');
%va2modspec('neg_cap_3t_vappmod.va');

cktnetlist.cktname = 'FEFET char curves ckt';

% nodes (names)
cktnetlist.nodenames = {'drain', 'gate', 'qg_as_v'};
cktnetlist.groundnodename = 'gnd';

% vddElem
cktnetlist = add_element(cktnetlist, vsrcModSpec(), 'Vdd',...
                                    {'drain', 'gnd'}, {}, {{'DC', 1}});

neg_cap_dev = neg_cap_3t();
fet_dev = mvs_5t_mod();

cktnetlist = add_element(cktnetlist, neg_cap_dev, 'NegCap', ...
                                            {'drain', 'qg_as_v', 'gate'});
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

StartLambda = 0;
StopLambda = 0.5; % 1;
initDeltaLambda = 1e-3;
initguess = [0,0,0,0,0,0,0,0]'; 
maxLambda = 1;

%lgndprefix = sprintf('VDD=%0.2g', VDD);
homObj = homotopy(DAE, 'Vdd:::E', 'input', initguess, StartLambda, initDeltaLambda, StopLambda, [], maxLambda,[] );
sol = homObj.getsolution(homObj);

feval(homObj.plot, homObj);
