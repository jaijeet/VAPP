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
%commented out. If you want to translate the models yourself, uncomment the
%call to va2modspec in the 'run_*' file.
%
%More information about each example is provided below.
%
%List of Example Scripts
%=======================
%run_bsim3_ring_oscillator
%run_bsim4_iv_curves
%run_bsim6_iv_curves
%run_mvs1_inverter_transient
%run_psp_csamp_transient
%run_r3_self-heating_transient
%run_vbic_diffpair_ac
%
%BSIM3
%=====
%Version: BSIM3 v3.2.4
%Link to the original model code: http://bsim.berkeley.edu/models/bsim4/bsim3/
%Circuit example in MAPP: a ring oscillator
%Folder: examples/bsim3_ring_oscillator
%Files: bsim3.m, bsim3.va, bsim3_ringosc_ckt.m, run_bsim3_ringosc_transient.m
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
%Although the translated ModSpec file is provided inside the example
%directory, you can uncomment the call to va2modspec (line 7) in
%run_bsim3_ringosc_transient and have VAPP translate the Verilog-A model before
%running the simulation.
%
%BSIM4 and BSIM6
%===============
%
%  BSIM4
%  =====
%  Version: BSIM4.3.0
%  Link to the original model code: http://bsim.berkeley.edu/models/bsim4/
%  Circuit example in MAPP: I-V curves
%  Folder: examples/bsim4_iv_curves
%  Files: bsim4_vappmod.va, bsim4.m, run_bsim4_iv_curves.m
%
%  This example computes the drain current of a transistor using the BSIM4
%  model for different values of gate and drain voltages. The source and the
%  bulk potentials are held at zero.
%  To see the plots run the file 'run_bsim4_iv_curves.m' and press Enter when
%  prompted by the script.
%
%  Original model version:
%       Berkeley BSIM4.3.0 Verilog-A model (UPDATED March 8,19 2004)
%
%  Modifications to the original model for VAPP:
%   1. Changed module name from 'mosfet' to 'bsim4'
%      (only for clarity, not a necessary change)
%      -------------------------------------------
%      Line number: 41
%      -------------------------------------------
%
%   2. Put ifndef __VAPP__ around the @(initial_step) statement.
%      -------------------------------------------
%      Line number: 963
%      -------------------------------------------
%
%   3. Added real keyword to parameter definitions.
%      -------------------------------------------
%      Line number: 56 - 363
%      -------------------------------------------
%
%   4. Set the default value for RGATEMOD parameter to 0.
%      -------------------------------------------
%      Line number: 82
%      -------------------------------------------
%
%   NOTE: The intent of a @(initial_step) step statement is to execute the code
%         inside this block only once when the model is instantiated and ignore
%         it for the consecutive model evaluations.
%         Point 2 above causes the code inside the @(initial_step) block to be
%         added to the regular model body. I.e., the block of code in the
%         @(initial_step) block will be executed every time the model function
%         is called. The usage of simulator directives like @(initial_step),
%         @(cross), @(final_step) are prohibited by NEEDS compatibility rules
%         because these statements might cause the model behavior to be
%         dependent on the type of analysis in which the model is used.
%  
%  BSIM6
%  =====
%  Version: BSIM6 6.1.1
%  Link to the original model code: http://bsim.berkeley.edu/models/bsimbulk/
%  Circuit example in MAPP: I-V curves
%  Folder: examples/bsim6_iv_curves
%  Files: bsim6.1.1_vappmod.va, bsim6.m, run_bsim6_iv_curves.m
%
%  This example performs the same function as the BSIM4 I-V curves example.
%  I.e., it creates an instance of the BSIM6 model and then performs a DC sweep
%  for the gate and drain voltages and produces 3D plots.
%  To see the plots run the file 'run_bsim6_iv_curves.m' and press Enter when
%  prompted by the script.
%
%  NOTE: BSIM6 is especially slow in MAPP until (after some time) Matlab's JIT
%        engine compiles the code.
%  TODO: This example needs better parameter values to produce nicer curves.
%
%  Modifications to the original model for VAPP:
%  1. Replaced access functions (I(),V()) that were referenced to the global
%     ground with a reference to the bulk node.
%     Tip: search for V([^,]*) in vim, i.e., use the following command
%        "/V([^,]*)" without the quotes.
%
%  2. Commented out lines with ddx calls.
%     -------------------------------------------
%     Line number: 4217 - 4365 and 4393 - 4395
%     -------------------------------------------
%
%  3. Initialized the following variables to zero: 
%       local_sca = 0;
%       local_scb = 0;
%       local_scc = 0;
%     --------------------------------------------------
%     Line number: 2013 - 2015 (in bsim6.1.1_vappmod.va)
%     --------------------------------------------------
%     
%  NOTE: Commenting out the ddx() function calls (as indicated in point 2 above)
%        does not affect the performance of the model in simulation. The
%        lines that were commented out are used in calculations for secondary
%        values, e.g., capacitances between various nodes.
%  
%MVS1
%====
%Version: 1 (July 17 2015)
%Link to the original model code: https://nanohub.org/publications/15/4
%Circuit example in MAPP: a CMOS inverter
%Folder: examples/mvs_inverter_transient
%Files: mvs_si_1_1_0.m, mvs_si_1_1_0.va, MVSinverter_ckt.m,
%       run_mvs_inverter_transient.m
%
%This example constructs a CMOS inverter circuit using the MVS transistor model
%and then runs a transient simulation on it.
%
%  Modifications to the original model for VAPP:
%  1. In MVS1, branch voltages are computed using the potential difference 
%     between the two nodes of the branch. I.e., the voltage across nodes 'n1'
%     and 'n2' is computed by
%
%       V(n1) - V(n2).
%
%     NEEDS compatibility requires the conversion of probes and sources of 
%     this fashion to
%
%       V(n1,n2)
% 
%     Tip: in Vim run the following command.
%
%       :%s/V(\(.\{-}\)) - V(\(.\{-}\))/V(\1,\2)/gc
%
%PSP
%===
%Version: 103.3.0, December 2013
%Link to the original model code: http://www.nxp.com/products/software-and-tools/models-and-test-data/compact-models-simkit/mos-models/model-psp:MODELPSP
%Circuit example in MAPP:  A common source amplifier
%Folder: examples/psp_csamp_transient
%Subfolder: psp103 (contains the Verilog-A files)
%Files: PSP103VA.m psp_csamp_ckt.m run_psp_csamp_transient.m
%
%This is a simple common source amplifier circuit (one transistor and one
%resistor). The input to the circuit is a box car pulse. The output is the
%inverted version of the input signal.
%
%  Modifications the original model for VAPP:
%  
%  1. Common103_macrodefs.include:
%       
%       `define CLIP_LOW(val,min)      ((val)>(min)?(val):(min))
%       `define CLIP_HIGH(val,max)     ((val)<(max)?(val):(max))
%       `define CLIP_BOTH(val,min,max) ((val)>(min)?((val)<(max)?(val):(max)):(min))
%  
%     is changed to
%  
%       `define CLIP_LOW(val,min_val)      ((val)>(min_val)?(val):(min_val))
%       `define CLIP_HIGH(val,max_val)     ((val)<(max_val)?(val):(max_val))
%       `define CLIP_BOTH(val,min_val,max_val) ((val)>(min_val)?((val)<(max_val)?(val):(max_val)):(min_val))
%
%     -------------------------------------------
%     Line number: 31-33
%     -------------------------------------------
%
%     NOTE: 'min' and 'max' are reserved keywords in MATLAB.
%
%  2. Also, min_val and max_vals should be added to the list of variable
%     declarations to PSP103_module.include.
%
%  3. PSP103_module.include:
%     Referenced NOI branches and access functions to noise node (NOI2) to the
%     bulk node (B).
%
%       branch (NOI) NOII;
%       branch (NOI) NOIR;
%       branch (NOI) NOIC;
%
%     is changed to
%
%       branch (NOI, B) NOII;
%       branch (NOI, B) NOIR;
%       branch (NOI, B) NOIC;
%
%     -------------------------------------------
%     Line numbers: 45-47
%     -------------------------------------------
%
%  4. psp103.va:
%     Commented out `ifdef OPderiv (VAPP does not support ddx yet).
%
%     -------------------------------------------
%     Line number: 36
%     -------------------------------------------
%
%  NOTE: Commenting out the ddx() function calls (as indicated in point 4 above)
%        does not affect the performance of the model in simulation. The
%        lines that were commented out are used in calculations for secondary
%        values, e.g., capacitances between various nodes.
% 
%R3 Polysilicon Resistor Model
%=============================
%Version: 2.0.0, October 30, 2014
%Link to the original model code: https://nanohub.org/publications/26/1
%Circuit example in MAPP: Demonstration of the resistance increase via self %heating
%Folder: examples/r3_self-heating_transient
%Files: generalMacrosAndDefines.va junctionMacros.va r3.m r3.va r3_vappmod.va
%       r3Macros.va run_r3_transient.m
%
%This simple example runs a transient simulation with R3's self-heating feature
%enabled. The parameters of the model are chosen such that the resistor heats
%up very quickly which increases the resistance value. This behavior can be
%nicely observed in the output voltage graph.
%
%  Modifications to the original model for VAPP:
%   1. Commented out OPinfo calculations on lines 752-762.
%   2. Referenced the dt node to n2 on lines 65-66.
%
%VBIC
%====
%Version: 1.2
%Link to the original model code: http://www.designers-guide.org/VBIC/
%Circuit example in MAPP: a BJT differential pair
%Folder: examples/vbic_diffpair_ac
%Files: run_vbic_diffpair_ac.m vbic.m vbic1.2_vappmod.va vbic_diffpair_ckt.m
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
%      This change has been done for multiple macros at the start of
%      vbic1.2.va.
% 
%See also
%--------
%VAPPquickstart, aboutVAPP, va2modspec

help VAPPexamples
