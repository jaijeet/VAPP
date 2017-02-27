clear all;
MOD = neg_cap_3t();
MEO = model_exerciser(MOD);
MEO.plot('vncpncn_fe',-1:0.1:2,0,MEO)
