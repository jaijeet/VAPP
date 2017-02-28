%The 'examples' directory under the VAPP root directory contains several
%examples demonstrating how to run MAPP analyses on various common device
%models. These VAPP/MAPP examples assume that you have a working VAPP and MAPP
%setup. If this is not the case, please refer to the README file in the root
% VAPP directory and the README file in the root MAPP repository
%(https://github.com/jaijeet/MAPP).
%
%Most of the examples are adapted from MAPP examples (try 'help MAPPexamples'
%for more information). These examples are meant to demonstrate the usage of
%ModSpec models with various analysis tools in MAPP. The Verilog-A files for
%the models are included within each example directory. Moreover, the
%corresponding ModSpec files translated by VAPP are included for convenience.
%
%Some examples are composed of multiple m-files. The main script file for each
%example has the name format
%
%    run_modelName_analysisName.m
%
%where modelName is the name of the device model and analysisName is the name
%of the MAPP analysis/simulation used in the demonstration.
%Each 'run' script contains a call to va2modspec that translates the Verilog-A
%model in the example to ModSpec. By default these calls to va2modspec are
%commented out. If you want to translate the models yourself, uncomment this
%line.
%
%More information about each example is provided below.
%
%List of Examples
%================
%bsim3_ring_oscillator
%bsim4_iv_curves
%bsim6_iv_curves
%mvs1_inverter_transient
%psp_csamp_transient
%r3_self-heating_transient
%vbic_diffpair_ac
%
%BSIM3 Ring Oscillator
%=====================
% folder: examples/bsim3_ring_oscillator
% files: bsim3.m, bsim3.va, bsim3_ringosc_ckt.m, run_bsim3_ringosc_transient.m
% link: http://bsim.berkeley.edu/models/bsim4/bsim3/
%
%This example demonstrates how to construct a 3-stage ring oscillator circuit
%in MAPP and perform a transient analysis on it.
%The file bsim3_ringosc_ckt.m sets the parameters for the transistors in the
%ring oscillator and afterwards constructs the entire circuit using MAPP's
%netlist format. This circuit is then converted to a DAE using MAPP's DAEAPI.
%The main script, run_bsim3_ringosc_transient, calls bsim3_ringosc_ckt to
%create the circuit and then performs a transient simulation on it.
%
%To see the plot of the node voltages simply run the main script
%run_bsim3_ringosc_transient.
%
%Although the translated ModSpec file is provided in within the example
%directory, you can uncomment the call to va2modspec (line 7) in
%run_bsim3_ringosc_transient and have VAPP translate the Verilog-A model before
%running the simulation.
%
%BSIM4 and BSIM6 I-V Curves
%==========================
%
%  BSIM4
%  =====
%  folder: examples/bsim4_iv_curves
%  files: bsim4_vappmod.va, bsim4.m, run_bsim4_iv_curves.m
%  link: http://bsim.berkeley.edu/models/bsim4/
%
%  This example computes the drain current of a transistor using the BSIM4
%  model for different values of gate and drain voltages. The source and the
%  bulk potentials are held at zero.
%  To see the plots run the file 'run_bsim4_iv_curves.m' and press Enter when
%  prompted by the script.
%
%  modifications to the original model for VAPP:
%   1. changed module name from 'mosfet' to 'bsim4'
%      (only for clarity, not a necessary change)
%   2. put ifndef __VAPP__ around the @(initial_step) statement.
%   3. added real keyword to parameter definitions.
%   4. set the default value for RGATEMOD parameter to 0.
%  
%  BSIM6
%  =====
%  folder: examples/bsim6_iv_curves
%  files: bsim6.1.1_vappmod.va, bsim6.m, run_bsim6_iv_curves.m
%  link: http://bsim.berkeley.edu/models/bsim4/
%
%  This example performs the same function as the BSIM4 I-V curves example.
%  I.e, it creates an instance of the BSIM6 model and then performs a DC sweep
%  for the gate and drain voltages and produces 3D plots.
%  To see the plots run the file 'run_bsim6_iv_curves.m' and press Enter when
%  prompted by the script.
%
%  NOTE: BSIM6 is especially slow in MAPP until (after some time) Matlab's JIT
%        engine compiles the code.
%  TODO: This example needs better parameter values to produce nicer curves.
%
%  modifications to the original model for VAPP:
%  1. Replaced access functions (I(),V()) that were referenced to the global
%     ground with a reference to the bulk node.
%     Tip: search for V([^,]*) in vim.
%  2. Commented out lines with ddx calls.
%  3. Initialized the following variables to zero: 
%       local_sca = 0;
%       local_scb = 0;
%       local_scc = 0;
%  
%MVS1 Inverter
%============
%folder: examples/mvs_inverter_transient
%files: mvs_si_1_1_0.m, mvs_si_1_1_0.va, MVSinverter_ckt.m,
%       run_mvs_inverter_transient.m
%link: https://nanohub.org/publications/15/4
%
%This example constructs a CMOS inverter circuit using the MVS transistor model
%and then runs a transient simulation on it.
%
%  modifications to the original model for VAPP
%  1. convert probes and sources of the following fashion
%       V(n1) - V(n2)
%    to
%       V(n1,n2)
% 
%    tip: in vim run: :%s/V(\(.\{-}\)) - V(\(.\{-}\))/V(\1,\2)/g
%
%PSP Common Source Amplifier
%==========================
%folder: examples/psp_csamp_transient
%subfolder: psp103 (contains the Verilog-A files)
%files: PSP103VA.m psp_csamp_ckt.m run_psp_csamp_transient.m
%link: http://www.nxp.com/products/software-and-tools/models-and-test-data/compact-models-simkit/mos-models/model-psp:MODELPSP
%
%This is a simple common source amplifier circuit (one transistor and one
%resistor). The input to the circuit is a box car pulse. The output is the
%inverted version of the input signal.
%
%  Modifications the original model for VAPP
%  
%  1. Common103_macrodefs.include:
%         
%         `define CLIP_LOW(val,min)      ((val)>(min)?(val):(min))
%         `define CLIP_HIGH(val,max)     ((val)<(max)?(val):(max))
%         `define CLIP_BOTH(val,min,max) ((val)>(min)?((val)<(max)?(val):(max)):(min))
%  
%         changed to
%  
%         `define CLIP_LOW(val,min_val)      ((val)>(min_val)?(val):(min_val))
%         `define CLIP_HIGH(val,max_val)     ((val)<(max_val)?(val):(max_val))
%         `define CLIP_BOTH(val,min_val,max_val) ((val)>(min_val)?((val)<(max_val)?(val):(max_val)):(min_val))
%
%         Reason: min and max are reserved keywords.
%  2. Also added min_val and max_vals to PSP103_module.include
%  3. PSP103_module.include:
%         Referenced access functions to noise node (NOI2) to the bulk node (B).
%  4. psp103.va:
%         Commented out `ifdef OPderiv (VAPP does not support ddx yet).
% 
%R3 Polysilicon Resistor Model (https://nanohub.org/publications/26/1)
%=====================================================================
%folder: examples/r3_self-heating_transient
%files: generalMacrosAndDefines.va junctionMacros.va r3.m r3.va r3_vappmod.va
%       r3Macros.va run_r3_transient.m
%link: https://nanohub.org/publications/26/1
%
%This simple example runs a transient simulation with R3's self-heating feature
%enabled. The parameters of the model are chosen such that the resistor heats
%up very quickly which increases the resistance value. This behavior can be
%nicely observed in the output voltage graph.
%
%  Modifications to the original model for VAPP:
%   1. Commented out OPinfo calculations 
%   2. Referenced the dt node to n2
%
%VBIC BJT Diffpair
%=================
%folder: examples/vbic_diffpair_ac
%files: run_vbic_diffpair_ac.m vbic.m vbic1.2_vappmod.va vbic_diffpair_ckt.m
%link: http://www.designers-guide.org/VBIC/
%
%This example uses the VBIC bipolar transistor model to construct a
%differential pair and performs an AC analysis on this circuit.
%
%  Modifications to the original model for VAPP:
%   1. Vbic uses macros in the following form
%        `define psibi(P,Ea,Vtv,rT) \
%                psiio = 2.0*(Vtv/rT)*log(exp(0.5*P*rT/Vtv)-exp(-0.5*P*rT/Vtv)); \
%                psiin = psiio*rT-3.0*Vtv*log(rT)-Ea*(rT-1.0); \
%                psibi = psiin+2.0*Vtv*log(0.5*(1.0+sqrt(1.0+4.0*exp(-psiin/Vtv))));
%
%      and calls them like this
%       
%   	PEatT	=  `psibi(PE,EAIE,Vtv,rT);
%
%      These macro definitions have been changed to the following form
%
%     `define psibi(out,P,Ea,Vtv,rT) \
%     	   psiio = 2.0*(Vtv/rT)*log(exp(0.5*P*rT/Vtv)-exp(-0.5*P*rT/Vtv)); \
%     	   psiin = psiio*rT-3.0*Vtv*log(rT)-Ea*(rT-1.0); \
%     	   out = psiin+2.0*Vtv*log(0.5*(1.0+sqrt(1.0+4.0*exp(-psiin/Vtv))));
%
%      by adding an output variable.
