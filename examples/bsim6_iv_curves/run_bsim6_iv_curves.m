%va2modspec('bsim6.1.1_vappmod.va');
MOD = bsim6();
MEO = model_dc_exerciser(MOD); % create a model exerciser object
                               % NOTE: press enter when prompted by MATLAB
% sweep both Vd and Vg, plot Id
Vd = 0:0.1:1; Vg = 0:0.1:1; Vs = 0; Vb = 0; 
MEO.plot('Id', Vd, Vg, Vs, Vb, MEO);
