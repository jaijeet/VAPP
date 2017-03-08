clear all;
%va2modspec('mvs_5t_mod_vappmod.va');
%va2modspec('neg_cap_3t.va');
MOD = neg_cap_3t();
MEO = model_exerciser(MOD);
MEO.plot('vncpncn_fe',-1:0.1:2,0,MEO);
