clear

% translate the model
%va2modspec('r3_vappmod.va');
% set up DAE
cktnetlist.cktname = 'r3_test_circuit';
% nodes (names)
cktnetlist.nodenames = {'n1', 'n2'}; % non-ground nodes
cktnetlist.groundnodename = 'gnd';

vM = vsrcModSpec();
vM2 = vsrcModSpec();
res = r3();
res = res.setparms({{'parm_c1',   1},...
              {'parm_c2',   1},...
              {'parm_rc',   1.0},...
              {'parm_tc1',  1.0e-03},...
              {'parm_tc2',  1.0e-03},...
              {'parm_gth0', 1.0e-04},...
              {'parm_cth0', 1.0e-07},...
            }, res);

DCval = 1;
tranfunc = @(t, args) (args.offset + ...
                    args.A * pulse(t, args.td, args.thi, args.tfs, args.tfe));

tranfuncargs.A = 2; tranfuncargs.td = 0.2e-3;  tranfuncargs.thi = 0.21e-3;
tranfuncargs.tfs = 0.6e-3; tranfuncargs.tfe = 0.61e-3; tranfuncargs.offset = 0;

cktnetlist = add_element(cktnetlist, vM, 'vsrc1', {'n1', 'gnd'}, {},...
                    {{'E', {'dc', DCval}, {'tran', tranfunc, tranfuncargs}}});

cktnetlist = add_element(cktnetlist, vM2, 'vsrc2', {'n2', 'gnd'}, {},...
                    {{'E', {'dc', DCval}}});

cktnetlist = add_element(cktnetlist, res, 'r1', {'n1', 'n2', 'gnd'},...
                        {
                         {'parm_c1',   1},...
                         {'parm_c2',   1},...
                         {'parm_rc',   1.0},...
                         {'parm_tc1',  1.0e-03},...
                         {'parm_tc2',  1.0e-03},...
                         {'parm_gth0', 1.0e-04},...
                         {'parm_cth0', 1.0e-07},...
                        }, {});

%cktnetlist = add_output(cktnetlist, 'n1'); % node voltage of 'n1'
%cktnetlist = add_output(cktnetlist, 'n2'); % node voltage of 'n1'
%
%cktnetlist = add_output(cktnetlist, 'i(vsrc1)', 1000);
%cktnetlist = add_output(cktnetlist, 'i(vsrc2)', 1000);

DAE = MNA_EqnEngine(cktnetlist);

outs = StateOutputs(DAE);
outs = feval(outs.DeleteAll, outs);
outs1 = feval(outs.Add, {'vsrc1:::ipn'}, outs);
outs2 = feval(outs.Add, {'r1:::temp_dtn2'}, outs);

% DC analysis
dcop = dot_op(DAE);
feval(dcop.print, dcop);

% run transient simulation
xinit = feval(dcop.getsolution, dcop);
tstart = 0; tstep = 0.5e-6; tstop = 1e-3;
LMSobj = dot_transient(DAE, xinit, tstart, tstep, tstop);

feval(LMSobj.plot, LMSobj, outs1);
feval(LMSobj.plot, LMSobj, outs2);
