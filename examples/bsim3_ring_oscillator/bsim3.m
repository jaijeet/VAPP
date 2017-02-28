function MOD = bsim3(uniqID)

%===============================================================================
% This file was created using VAPP, the Berkeley Verilog-A Parser and Processor.   
% Last modified: 23-Feb-2017 10:45:53
% VAPP version: master:22070d7
%===============================================================================

    MOD = ModSpec_common_skeleton();

    MOD.parm_types = {};
    MOD.u_names = {};
    MOD.IO_names = {};
    MOD.OtherIO_names = {};
    MOD.NIL.io_types = {};
    MOD.NIL.io_nodenames = {};
    MOD.limited_var_names = {};
    MOD.vecXY_to_limitedvars_matrix = [];
    MOD.uniqID = [];

    MOD.support_initlimiting = 1;

    if nargin > 0
        MOD.uniqID = uniqID;
    end

    MOD.model_name = 'bsim3';
    MOD.NIL.node_names = {'vd', 'vg', 'vs', 'vb'};
    MOD.NIL.refnode_name = 'vb';

    parmNameDefValArr = {'parm_l', 1e-05,...
                         'parm_w', 5e-06,...
                         'parm_ad', 1e-10,...
                         'parm_as', 1e-10,...
                         'parm_pd', 4e-05,...
                         'parm_ps', 4e-05,...
                         'parm_nrd', 1,...
                         'parm_nrs', 1,...
                         'parm_nqsmod', 0,...
                         'parm_capmod', 0,...
                         'parm_mobmod', 1,...
                         'parm_noimod', 1,...
                         'parm_binunit', 1,...
                         'parm_version', 3.24,...
                         'parm_tox', 1.5e-08,...
                         'parm_toxm', 1.5e-08,...
                         'parm_cdsc', 0.00024,...
                         'parm_cdscb', 0,...
                         'parm_cdscd', 0,...
                         'parm_cit', 0,...
                         'parm_nfactor', 1,...
                         'parm_xj', 1.5e-07,...
                         'parm_vsat', 80000,...
                         'parm_at', 33000,...
                         'parm_a0', 1,...
                         'parm_ags', 0,...
                         'parm_a1', 0,...
                         'parm_a2', 1,...
                         'parm_keta', -0.047,...
                         'parm_nsub', 6e-16,...
                         'parm_nch', 1.7e+17,...
                         'parm_ngate', 0,...
                         'parm_gamma1', 0,...
                         'parm_gamma2', 0,...
                         'parm_vbx', 0,...
                         'parm_vbm', -3,...
                         'parm_xt', 1.55e-07,...
                         'parm_k1', -9999.9999,...
                         'parm_kt1', -0.11,...
                         'parm_kt1l', 0,...
                         'parm_kt2', 0.022,...
                         'parm_k2', -9999.9999,...
                         'parm_k3', 80,...
                         'parm_k3b', 0,...
                         'parm_w0', 2.5e-06,...
                         'parm_nlx', 1.74e-07,...
                         'parm_dvt0', 2.2,...
                         'parm_dvt1', 0.53,...
                         'parm_dvt2', -0.032,...
                         'parm_dvt0w', 0,...
                         'parm_dvt1w', 5300000,...
                         'parm_dvt2w', -0.032,...
                         'parm_drout', 0.56,...
                         'parm_dsub', 0.56,...
                         'parm_vth0', -9999.9999,...
                         'parm_ua', 2.25e-09,...
                         'parm_ua1', 4.31e-09,...
                         'parm_ub', 5.87e-19,...
                         'parm_ub1', -7.61e-18,...
                         'parm_uc', -9999.9999,...
                         'parm_uc1', -9999.9999,...
                         'parm_u0', -9999.9999,...
                         'parm_ute', -1.5,...
                         'parm_voff', -0.08,...
                         'parm_tnom', 0,...
                         'parm_cgso', -9999.9999,...
                         'parm_cgdo', -9999.9999,...
                         'parm_cgbo', -9999.9999,...
                         'parm_xpart', 0,...
                         'parm_elm', 5,...
                         'parm_delta', 0.01,...
                         'parm_rsh', 0,...
                         'parm_rdsw', 0,...
                         'parm_prwg', 0,...
                         'parm_prwb', 0,...
                         'parm_prt', 0,...
                         'parm_eta0', 0.08,...
                         'parm_etab', -0.07,...
                         'parm_pclm', 1.3,...
                         'parm_pdiblc1', 0.39,...
                         'parm_pdiblc2', 0.0086,...
                         'parm_pdiblcb', 0,...
                         'parm_pscbe1', 424000000,...
                         'parm_pscbe2', 1e-05,...
                         'parm_pvag', 0,...
                         'parm_js', 0.0001,...
                         'parm_jsw', 0,...
                         'parm_pb', 1,...
                         'parm_nj', 1,...
                         'parm_xti', 3,...
                         'parm_mj', 0.5,...
                         'parm_pbsw', 1,...
                         'parm_mjsw', 0.33,...
                         'parm_pbswg', 1,...
                         'parm_mjswg', 0.33,...
                         'parm_cj', 0.0005,...
                         'parm_vfbcv', -1,...
                         'parm_vfb', -1,...
                         'parm_cjsw', 5e-10,...
                         'parm_cjswg', 5e-10,...
                         'parm_tpb', 0,...
                         'parm_tcj', 0,...
                         'parm_tpbsw', 0,...
                         'parm_tcjsw', 0,...
                         'parm_tpbswg', 0,...
                         'parm_tcjswg', 0,...
                         'parm_acde1', 1,...
                         'parm_moin', 15,...
                         'parm_noff', 1,...
                         'parm_voffcv', 0,...
                         'parm_lint', 0,...
                         'parm_ll', 0,...
                         'parm_llc', 0,...
                         'parm_lln', 1,...
                         'parm_lw', 0,...
                         'parm_lwc', 0,...
                         'parm_lwn', 1,...
                         'parm_lwl', 0,...
                         'parm_lwlc', 0,...
                         'parm_lmin', 0,...
                         'parm_lmax', 1,...
                         'parm_wr', 1,...
                         'parm_wint', 0,...
                         'parm_dwg', 0,...
                         'parm_dwb', 0,...
                         'parm_wl', 0,...
                         'parm_wlc', 0,...
                         'parm_wln', 1,...
                         'parm_ww', 0,...
                         'parm_wwc', 0,...
                         'parm_wwn', 1,...
                         'parm_wwl', 0,...
                         'parm_wwlc', 0,...
                         'parm_wmin', 0,...
                         'parm_wmax', 1,...
                         'parm_b0', 0,...
                         'parm_b1', 0,...
                         'parm_cgsl', 0,...
                         'parm_cgdl', 0,...
                         'parm_ckappa', 0.6,...
                         'parm_cf', -9999.9999,...
                         'parm_clc1', 1e-07,...
                         'parm_cle', 0.6,...
                         'parm_dwc', 0,...
                         'parm_dlc', -9999.9999,...
                         'parm_alpha0', 0,...
                         'parm_alpha1', 0,...
                         'parm_beta0', 30,...
                         'parm_ijth', 0.1,...
                         'parm_lcdsc', 0,...
                         'parm_lcdscb', 0,...
                         'parm_lcdscd', 0,...
                         'parm_lcit', 0,...
                         'parm_lnfactor', 0,...
                         'parm_lxj', 0,...
                         'parm_lvsat', 0,...
                         'parm_lat', 0,...
                         'parm_la0', 0,...
                         'parm_lags', 0,...
                         'parm_la1', 0,...
                         'parm_la2', 0,...
                         'parm_lketa', 0,...
                         'parm_lnsub', 0,...
                         'parm_lnch', 0,...
                         'parm_lngate', 0,...
                         'parm_lgamma1', 0,...
                         'parm_lgamma2', 0,...
                         'parm_lvbx', 0,...
                         'parm_lvbm', 0,...
                         'parm_lxt', 0,...
                         'parm_lk1', 0,...
                         'parm_lkt1', 0,...
                         'parm_lkt1l', 0,...
                         'parm_lkt2', 0,...
                         'parm_lk2', 0,...
                         'parm_lk3', 0,...
                         'parm_lk3b', 0,...
                         'parm_lw0', 0,...
                         'parm_lnlx', 0,...
                         'parm_ldvt0', 0,...
                         'parm_ldvt1', 0,...
                         'parm_ldvt2', 0,...
                         'parm_ldvt0w', 0,...
                         'parm_ldvt1w', 0,...
                         'parm_ldvt2w', 0,...
                         'parm_ldrout', 0,...
                         'parm_ldsub', 0,...
                         'parm_lvth0', 0,...
                         'parm_lua', 0,...
                         'parm_lua1', 0,...
                         'parm_lub', 0,...
                         'parm_lub1', 0,...
                         'parm_luc', 0,...
                         'parm_luc1', 0,...
                         'parm_lu0', 0,...
                         'parm_lute', 0,...
                         'parm_lvoff', 0,...
                         'parm_lelm', 0,...
                         'parm_ldelta', 0,...
                         'parm_lrdsw', 0,...
                         'parm_lprwg', 0,...
                         'parm_lprwb', 0,...
                         'parm_lprt', 0,...
                         'parm_leta0', 0,...
                         'parm_letab', 0,...
                         'parm_lpclm', 0,...
                         'parm_lpdiblc1', 0,...
                         'parm_lpdiblc2', 0,...
                         'parm_lpdiblcb', 0,...
                         'parm_lpscbe1', 0,...
                         'parm_lpscbe2', 0,...
                         'parm_lpvag', 0,...
                         'parm_lwr', 0,...
                         'parm_ldwg', 0,...
                         'parm_ldwb', 0,...
                         'parm_lb0', 0,...
                         'parm_lb1', 0,...
                         'parm_lcgsl', 0,...
                         'parm_lcgdl', 0,...
                         'parm_lckappa', 0,...
                         'parm_lcf', 0,...
                         'parm_lclc', 0,...
                         'parm_lcle', 0,...
                         'parm_lalpha0', 0,...
                         'parm_lalpha1', 0,...
                         'parm_lbeta0', 0,...
                         'parm_lvfbcv', 0,...
                         'parm_lvfb', 0,...
                         'parm_lacde', 0,...
                         'parm_lmoin', 0,...
                         'parm_lnoff', 0,...
                         'parm_lvoffcv', 0,...
                         'parm_wcdsc', 0,...
                         'parm_wcdscb', 0,...
                         'parm_wcdscd', 0,...
                         'parm_wcit', 0,...
                         'parm_wnfactor', 0,...
                         'parm_wxj', 0,...
                         'parm_wvsat', 0,...
                         'parm_wat', 0,...
                         'parm_wa0', 0,...
                         'parm_wags', 0,...
                         'parm_wa1', 0,...
                         'parm_wa2', 0,...
                         'parm_wketa', 0,...
                         'parm_wnsub', 0,...
                         'parm_wnch', 0,...
                         'parm_wngate', 0,...
                         'parm_wgamma1', 0,...
                         'parm_wgamma2', 0,...
                         'parm_wvbx', 0,...
                         'parm_wvbm', 0,...
                         'parm_wxt', 0,...
                         'parm_wk1', 0,...
                         'parm_wkt1', 0,...
                         'parm_wkt1l', 0,...
                         'parm_wkt2', 0,...
                         'parm_wk2', 0,...
                         'parm_wk3', 0,...
                         'parm_wk3b', 0,...
                         'parm_ww0', 0,...
                         'parm_wnlx', 0,...
                         'parm_wdvt0', 0,...
                         'parm_wdvt1', 0,...
                         'parm_wdvt2', 0,...
                         'parm_wdvt0w', 0,...
                         'parm_wdvt1w', 0,...
                         'parm_wdvt2w', 0,...
                         'parm_wdrout', 0,...
                         'parm_wdsub', 0,...
                         'parm_wvth0', 0,...
                         'parm_wua', 0,...
                         'parm_wua1', 0,...
                         'parm_wub', 0,...
                         'parm_wub1', 0,...
                         'parm_wuc', 0,...
                         'parm_wuc1', 0,...
                         'parm_wu0', 0,...
                         'parm_wute', 0,...
                         'parm_wvoff', 0,...
                         'parm_welm', 0,...
                         'parm_wdelta', 0,...
                         'parm_wrdsw', 0,...
                         'parm_wprwg', 0,...
                         'parm_wprwb', 0,...
                         'parm_wprt', 0,...
                         'parm_weta0', 0,...
                         'parm_wetab', 0,...
                         'parm_wpclm', 0,...
                         'parm_wpdiblc1', 0,...
                         'parm_wpdiblc2', 0,...
                         'parm_wpdiblcb', 0,...
                         'parm_wpscbe1', 0,...
                         'parm_wpscbe2', 0,...
                         'parm_wpvag', 0,...
                         'parm_wwr', 0,...
                         'parm_wdwg', 0,...
                         'parm_wdwb', 0,...
                         'parm_wb0', 0,...
                         'parm_wb1', 0,...
                         'parm_wcgsl', 0,...
                         'parm_wcgdl', 0,...
                         'parm_wckappa', 0,...
                         'parm_wcf', 0,...
                         'parm_wclc', 0,...
                         'parm_wcle', 0,...
                         'parm_walpha0', 0,...
                         'parm_walpha1', 0,...
                         'parm_wbeta0', 0,...
                         'parm_wvfbcv', 0,...
                         'parm_wvfb', 0,...
                         'parm_wacde', 0,...
                         'parm_wmoin', 0,...
                         'parm_wnoff', 0,...
                         'parm_wvoffcv', 0,...
                         'parm_pcdsc', 0,...
                         'parm_pcdscb', 0,...
                         'parm_pcdscd', 0,...
                         'parm_pcit', 0,...
                         'parm_pnfactor', 0,...
                         'parm_pxj', 0,...
                         'parm_pvsat', 0,...
                         'parm_pat', 0,...
                         'parm_pa0', 0,...
                         'parm_pags', 0,...
                         'parm_pa1', 0,...
                         'parm_pa2', 0,...
                         'parm_pketa', 0,...
                         'parm_pnsub', 0,...
                         'parm_pnch', 0,...
                         'parm_pngate', 0,...
                         'parm_pgamma1', 0,...
                         'parm_pgamma2', 0,...
                         'parm_pvbx', 0,...
                         'parm_pvbm', 0,...
                         'parm_pxt', 0,...
                         'parm_pk1', 0,...
                         'parm_pkt1', 0,...
                         'parm_pkt1l', 0,...
                         'parm_pkt2', 0,...
                         'parm_pk2', 0,...
                         'parm_pk3', 0,...
                         'parm_pk3b', 0,...
                         'parm_pw0', 0,...
                         'parm_pnlx', 0,...
                         'parm_pdvt0', 0,...
                         'parm_pdvt1', 0,...
                         'parm_pdvt2', 0,...
                         'parm_pdvt0w', 0,...
                         'parm_pdvt1w', 0,...
                         'parm_pdvt2w', 0,...
                         'parm_pdrout', 0,...
                         'parm_pdsub', 0,...
                         'parm_pvth0', 0,...
                         'parm_pua', 0,...
                         'parm_pua1', 0,...
                         'parm_pub', 0,...
                         'parm_pub1', 0,...
                         'parm_puc', 0,...
                         'parm_puc1', 0,...
                         'parm_pu0', 0,...
                         'parm_pute', 0,...
                         'parm_pvoff', 0,...
                         'parm_pelm', 0,...
                         'parm_pdelta', 0,...
                         'parm_prdsw', 0,...
                         'parm_pprwg', 0,...
                         'parm_pprwb', 0,...
                         'parm_pprt', 0,...
                         'parm_peta0', 0,...
                         'parm_petab', 0,...
                         'parm_ppclm', 0,...
                         'parm_ppdiblc1', 0,...
                         'parm_ppdiblc2', 0,...
                         'parm_ppdiblcb', 0,...
                         'parm_ppscbe1', 0,...
                         'parm_ppscbe2', 0,...
                         'parm_ppvag', 0,...
                         'parm_pwr', 0,...
                         'parm_pdwg', 0,...
                         'parm_pdwb', 0,...
                         'parm_pb0', 0,...
                         'parm_pb1', 0,...
                         'parm_pcgsl', 0,...
                         'parm_pcgdl', 0,...
                         'parm_pckappa', 0,...
                         'parm_pcf', 0,...
                         'parm_pclc', 0,...
                         'parm_pcle', 0,...
                         'parm_palpha0', 0,...
                         'parm_palpha1', 0,...
                         'parm_pbeta0', 0,...
                         'parm_pvfbcv', 0,...
                         'parm_pvfb', 0,...
                         'parm_pacde', 0,...
                         'parm_pmoin', 0,...
                         'parm_pnoff', 0,...
                         'parm_pvoffcv', 0,...
                         'parm_noia', 1e+20,...
                         'parm_noib', 50000,...
                         'parm_noic', -1.4e-12,...
                         'parm_em', 41000000,...
                         'parm_ef', 1,...
                         'parm_af', 1,...
                         'parm_kf', 0,...
                         'parm_Type', 0};

    nParm = 406;
    MOD.parm_names = {};
    MOD.parm_defaultvals = {};
    MOD.parm_vals = {};
    MOD.parm_given_flag = zeros(1, nParm);
    for parmIdx = 1:nParm
        MOD.parm_names{parmIdx} = parmNameDefValArr{2*parmIdx-1};
        MOD.parm_defaultvals{parmIdx} = parmNameDefValArr{2*parmIdx};
        MOD.parm_vals{parmIdx} = parmNameDefValArr{2*parmIdx};
    end

    [eonames, iunames, ienames] = get_oui_names__(MOD);
    MOD.explicit_output_names = eonames;
    MOD.internal_unk_names = iunames;
    MOD.implicit_equation_names = ienames;
    MOD.InternalUnkNames = @get_iu_names__;
    MOD.ImplicitEquationNames = @get_ie_names__;

    MOD = setup_IOnames_OtherIOnames_IOtypes_IOnodenames(MOD);

    MOD.fqeiJ = @fqeiJ;
    MOD.fe = @fe_from_fqeiJ_ModSpec;
    MOD.qe = @qe_from_fqeiJ_ModSpec;
    MOD.fi = @fi_from_fqeiJ_ModSpec;
    MOD.qi = @qi_from_fqeiJ_ModSpec;
    MOD.fqei = @fqei_from_fqeiJ_ModSpec;
    MOD.fqeiJ = @fqeiJ;

    MOD.dfe_dvecX = @dfe_dvecX_from_fqeiJ_ModSpec;
    MOD.dfe_dvecY = @dfe_dvecY_from_fqeiJ_ModSpec;
    MOD.dfe_dvecLim = @dfe_dvecLim_from_fqeiJ_ModSpec;
    MOD.dfe_dvecU = @dfe_dvecU_from_fqeiJ_ModSpec;

    MOD.dqe_dvecX = @dqe_dvecX_from_fqeiJ_ModSpec;
    MOD.dqe_dvecY = @dqe_dvecY_from_fqeiJ_ModSpec;
    MOD.dqe_dvecLim = @dqe_dvecLim_from_fqeiJ_ModSpec;

    MOD.dfi_dvecX = @dfi_dvecX_from_fqeiJ_ModSpec;
    MOD.dfi_dvecY = @dfi_dvecY_from_fqeiJ_ModSpec;
    MOD.dfi_dvecLim = @dfi_dvecLim_from_fqeiJ_ModSpec;
    MOD.dfi_dvecU = @dfi_dvecU_from_fqeiJ_ModSpec;

    MOD.dqi_dvecX = @dqi_dvecX_from_fqeiJ_ModSpec;
    MOD.dqi_dvecY = @dqi_dvecY_from_fqeiJ_ModSpec;
    MOD.dqi_dvecLim = @dqi_dvecLim_from_fqeiJ_ModSpec;
end

function [fqei_out, J_out] = fqeiJ(vecX, vecY, vecLim, vecU, flag, MOD)
    if nargin < 6
        MOD = flag;
        flag = vecU;
        vecU = vecLim;
    end

    [fe, qe, fi, qi, d_fe_d_X, d_qe_d_X, d_fi_d_X, d_qi_d_X,...
    d_fe_d_Y, d_qe_d_Y, d_fi_d_Y, d_qi_d_Y] = fqei_dfqeidXYU(vecX, vecY, MOD);

    fqei_out.fe = fe;
    fqei_out.qe = qe;
    fqei_out.fi = fi;
    fqei_out.qi = qi;

    [nFeQe, nFiQi] = get_nfq__(MOD);

    J_out.Jfe.dfe_dvecX = d_fe_d_X;
    J_out.Jqe.dqe_dvecX = d_qe_d_X;
    J_out.Jfi.dfi_dvecX = d_fi_d_X;
    J_out.Jqi.dqi_dvecX = d_qi_d_X;
    J_out.Jfe.dfe_dvecY = d_fe_d_Y;
    J_out.Jqe.dqe_dvecY = d_qe_d_Y;
    J_out.Jfi.dfi_dvecY = d_fi_d_Y;
    J_out.Jqi.dqi_dvecY = d_qi_d_Y;
    J_out.Jfe.dfe_dvecU = zeros(nFeQe,0);
    J_out.Jfi.dfi_dvecU = zeros(nFiQi,0);
    J_out.Jfe.dfe_dvecLim = zeros(nFeQe, 0);
    J_out.Jqe.dqe_dvecLim = zeros(nFeQe, 0);
    J_out.Jfi.dfi_dvecLim = zeros(nFiQi, 0);
    J_out.Jqi.dqi_dvecLim = zeros(nFiQi, 0);
end

function [fe__, qe__, fi__, qi__,...
          d_fe_d_X__, d_qe_d_X__, d_fi_d_X__, d_qi_d_X__,...
          d_fe_d_Y__, d_qe_d_Y__, d_fi_d_Y__, d_qi_d_Y__] = ...
         fqei_dfqeidXYU(vecX__, vecY__, MOD__)

    % initializing parameters
    parm_l = MOD__.parm_vals{1};
    parm_w = MOD__.parm_vals{2};
    parm_ad = MOD__.parm_vals{3};
    parm_as = MOD__.parm_vals{4};
    parm_pd = MOD__.parm_vals{5};
    parm_ps = MOD__.parm_vals{6};
    parm_nrd = MOD__.parm_vals{7};
    parm_nrs = MOD__.parm_vals{8};
    parm_nqsmod = MOD__.parm_vals{9};
    parm_capmod = MOD__.parm_vals{10};
    parm_mobmod = MOD__.parm_vals{11};
    parm_noimod = MOD__.parm_vals{12};
    parm_binunit = MOD__.parm_vals{13};
    parm_version = MOD__.parm_vals{14};
    parm_tox = MOD__.parm_vals{15};
    parm_toxm = MOD__.parm_vals{16};
    parm_cdsc = MOD__.parm_vals{17};
    parm_cdscb = MOD__.parm_vals{18};
    parm_cdscd = MOD__.parm_vals{19};
    parm_cit = MOD__.parm_vals{20};
    parm_nfactor = MOD__.parm_vals{21};
    parm_xj = MOD__.parm_vals{22};
    parm_vsat = MOD__.parm_vals{23};
    parm_at = MOD__.parm_vals{24};
    parm_a0 = MOD__.parm_vals{25};
    parm_ags = MOD__.parm_vals{26};
    parm_a1 = MOD__.parm_vals{27};
    parm_a2 = MOD__.parm_vals{28};
    parm_keta = MOD__.parm_vals{29};
    parm_nsub = MOD__.parm_vals{30};
    parm_nch = MOD__.parm_vals{31};
    parm_ngate = MOD__.parm_vals{32};
    parm_gamma1 = MOD__.parm_vals{33};
    parm_gamma2 = MOD__.parm_vals{34};
    parm_vbx = MOD__.parm_vals{35};
    parm_vbm = MOD__.parm_vals{36};
    parm_xt = MOD__.parm_vals{37};
    parm_k1 = MOD__.parm_vals{38};
    parm_kt1 = MOD__.parm_vals{39};
    parm_kt1l = MOD__.parm_vals{40};
    parm_kt2 = MOD__.parm_vals{41};
    parm_k2 = MOD__.parm_vals{42};
    parm_k3 = MOD__.parm_vals{43};
    parm_k3b = MOD__.parm_vals{44};
    parm_w0 = MOD__.parm_vals{45};
    parm_nlx = MOD__.parm_vals{46};
    parm_dvt0 = MOD__.parm_vals{47};
    parm_dvt1 = MOD__.parm_vals{48};
    parm_dvt2 = MOD__.parm_vals{49};
    parm_dvt0w = MOD__.parm_vals{50};
    parm_dvt1w = MOD__.parm_vals{51};
    parm_dvt2w = MOD__.parm_vals{52};
    parm_drout = MOD__.parm_vals{53};
    parm_dsub = MOD__.parm_vals{54};
    parm_vth0 = MOD__.parm_vals{55};
    parm_ua = MOD__.parm_vals{56};
    parm_ua1 = MOD__.parm_vals{57};
    parm_ub = MOD__.parm_vals{58};
    parm_ub1 = MOD__.parm_vals{59};
    parm_uc = MOD__.parm_vals{60};
    parm_uc1 = MOD__.parm_vals{61};
    parm_u0 = MOD__.parm_vals{62};
    parm_ute = MOD__.parm_vals{63};
    parm_voff = MOD__.parm_vals{64};
    parm_tnom = MOD__.parm_vals{65};
    parm_cgso = MOD__.parm_vals{66};
    parm_cgdo = MOD__.parm_vals{67};
    parm_cgbo = MOD__.parm_vals{68};
    parm_xpart = MOD__.parm_vals{69};
    parm_elm = MOD__.parm_vals{70};
    parm_delta = MOD__.parm_vals{71};
    parm_rsh = MOD__.parm_vals{72};
    parm_rdsw = MOD__.parm_vals{73};
    parm_prwg = MOD__.parm_vals{74};
    parm_prwb = MOD__.parm_vals{75};
    parm_prt = MOD__.parm_vals{76};
    parm_eta0 = MOD__.parm_vals{77};
    parm_etab = MOD__.parm_vals{78};
    parm_pclm = MOD__.parm_vals{79};
    parm_pdiblc1 = MOD__.parm_vals{80};
    parm_pdiblc2 = MOD__.parm_vals{81};
    parm_pdiblcb = MOD__.parm_vals{82};
    parm_pscbe1 = MOD__.parm_vals{83};
    parm_pscbe2 = MOD__.parm_vals{84};
    parm_pvag = MOD__.parm_vals{85};
    parm_js = MOD__.parm_vals{86};
    parm_jsw = MOD__.parm_vals{87};
    parm_pb = MOD__.parm_vals{88};
    parm_nj = MOD__.parm_vals{89};
    parm_xti = MOD__.parm_vals{90};
    parm_mj = MOD__.parm_vals{91};
    parm_pbsw = MOD__.parm_vals{92};
    parm_mjsw = MOD__.parm_vals{93};
    parm_pbswg = MOD__.parm_vals{94};
    parm_mjswg = MOD__.parm_vals{95};
    parm_cj = MOD__.parm_vals{96};
    parm_vfbcv = MOD__.parm_vals{97};
    parm_vfb = MOD__.parm_vals{98};
    parm_cjsw = MOD__.parm_vals{99};
    parm_cjswg = MOD__.parm_vals{100};
    parm_tpb = MOD__.parm_vals{101};
    parm_tcj = MOD__.parm_vals{102};
    parm_tpbsw = MOD__.parm_vals{103};
    parm_tcjsw = MOD__.parm_vals{104};
    parm_tpbswg = MOD__.parm_vals{105};
    parm_tcjswg = MOD__.parm_vals{106};
    parm_acde1 = MOD__.parm_vals{107};
    parm_moin = MOD__.parm_vals{108};
    parm_noff = MOD__.parm_vals{109};
    parm_voffcv = MOD__.parm_vals{110};
    parm_lint = MOD__.parm_vals{111};
    parm_ll = MOD__.parm_vals{112};
    parm_llc = MOD__.parm_vals{113};
    parm_lln = MOD__.parm_vals{114};
    parm_lw = MOD__.parm_vals{115};
    parm_lwc = MOD__.parm_vals{116};
    parm_lwn = MOD__.parm_vals{117};
    parm_lwl = MOD__.parm_vals{118};
    parm_lwlc = MOD__.parm_vals{119};
    parm_lmin = MOD__.parm_vals{120};
    parm_lmax = MOD__.parm_vals{121};
    parm_wr = MOD__.parm_vals{122};
    parm_wint = MOD__.parm_vals{123};
    parm_dwg = MOD__.parm_vals{124};
    parm_dwb = MOD__.parm_vals{125};
    parm_wl = MOD__.parm_vals{126};
    parm_wlc = MOD__.parm_vals{127};
    parm_wln = MOD__.parm_vals{128};
    parm_ww = MOD__.parm_vals{129};
    parm_wwc = MOD__.parm_vals{130};
    parm_wwn = MOD__.parm_vals{131};
    parm_wwl = MOD__.parm_vals{132};
    parm_wwlc = MOD__.parm_vals{133};
    parm_wmin = MOD__.parm_vals{134};
    parm_wmax = MOD__.parm_vals{135};
    parm_b0 = MOD__.parm_vals{136};
    parm_b1 = MOD__.parm_vals{137};
    parm_cgsl = MOD__.parm_vals{138};
    parm_cgdl = MOD__.parm_vals{139};
    parm_ckappa = MOD__.parm_vals{140};
    parm_cf = MOD__.parm_vals{141};
    parm_clc1 = MOD__.parm_vals{142};
    parm_cle = MOD__.parm_vals{143};
    parm_dwc = MOD__.parm_vals{144};
    parm_dlc = MOD__.parm_vals{145};
    parm_alpha0 = MOD__.parm_vals{146};
    parm_alpha1 = MOD__.parm_vals{147};
    parm_beta0 = MOD__.parm_vals{148};
    parm_ijth = MOD__.parm_vals{149};
    parm_lcdsc = MOD__.parm_vals{150};
    parm_lcdscb = MOD__.parm_vals{151};
    parm_lcdscd = MOD__.parm_vals{152};
    parm_lcit = MOD__.parm_vals{153};
    parm_lnfactor = MOD__.parm_vals{154};
    parm_lxj = MOD__.parm_vals{155};
    parm_lvsat = MOD__.parm_vals{156};
    parm_lat = MOD__.parm_vals{157};
    parm_la0 = MOD__.parm_vals{158};
    parm_lags = MOD__.parm_vals{159};
    parm_la1 = MOD__.parm_vals{160};
    parm_la2 = MOD__.parm_vals{161};
    parm_lketa = MOD__.parm_vals{162};
    parm_lnsub = MOD__.parm_vals{163};
    parm_lnch = MOD__.parm_vals{164};
    parm_lngate = MOD__.parm_vals{165};
    parm_lgamma1 = MOD__.parm_vals{166};
    parm_lgamma2 = MOD__.parm_vals{167};
    parm_lvbx = MOD__.parm_vals{168};
    parm_lvbm = MOD__.parm_vals{169};
    parm_lxt = MOD__.parm_vals{170};
    parm_lk1 = MOD__.parm_vals{171};
    parm_lkt1 = MOD__.parm_vals{172};
    parm_lkt1l = MOD__.parm_vals{173};
    parm_lkt2 = MOD__.parm_vals{174};
    parm_lk2 = MOD__.parm_vals{175};
    parm_lk3 = MOD__.parm_vals{176};
    parm_lk3b = MOD__.parm_vals{177};
    parm_lw0 = MOD__.parm_vals{178};
    parm_lnlx = MOD__.parm_vals{179};
    parm_ldvt0 = MOD__.parm_vals{180};
    parm_ldvt1 = MOD__.parm_vals{181};
    parm_ldvt2 = MOD__.parm_vals{182};
    parm_ldvt0w = MOD__.parm_vals{183};
    parm_ldvt1w = MOD__.parm_vals{184};
    parm_ldvt2w = MOD__.parm_vals{185};
    parm_ldrout = MOD__.parm_vals{186};
    parm_ldsub = MOD__.parm_vals{187};
    parm_lvth0 = MOD__.parm_vals{188};
    parm_lua = MOD__.parm_vals{189};
    parm_lua1 = MOD__.parm_vals{190};
    parm_lub = MOD__.parm_vals{191};
    parm_lub1 = MOD__.parm_vals{192};
    parm_luc = MOD__.parm_vals{193};
    parm_luc1 = MOD__.parm_vals{194};
    parm_lu0 = MOD__.parm_vals{195};
    parm_lute = MOD__.parm_vals{196};
    parm_lvoff = MOD__.parm_vals{197};
    parm_lelm = MOD__.parm_vals{198};
    parm_ldelta = MOD__.parm_vals{199};
    parm_lrdsw = MOD__.parm_vals{200};
    parm_lprwg = MOD__.parm_vals{201};
    parm_lprwb = MOD__.parm_vals{202};
    parm_lprt = MOD__.parm_vals{203};
    parm_leta0 = MOD__.parm_vals{204};
    parm_letab = MOD__.parm_vals{205};
    parm_lpclm = MOD__.parm_vals{206};
    parm_lpdiblc1 = MOD__.parm_vals{207};
    parm_lpdiblc2 = MOD__.parm_vals{208};
    parm_lpdiblcb = MOD__.parm_vals{209};
    parm_lpscbe1 = MOD__.parm_vals{210};
    parm_lpscbe2 = MOD__.parm_vals{211};
    parm_lpvag = MOD__.parm_vals{212};
    parm_lwr = MOD__.parm_vals{213};
    parm_ldwg = MOD__.parm_vals{214};
    parm_ldwb = MOD__.parm_vals{215};
    parm_lb0 = MOD__.parm_vals{216};
    parm_lb1 = MOD__.parm_vals{217};
    parm_lcgsl = MOD__.parm_vals{218};
    parm_lcgdl = MOD__.parm_vals{219};
    parm_lckappa = MOD__.parm_vals{220};
    parm_lcf = MOD__.parm_vals{221};
    parm_lclc = MOD__.parm_vals{222};
    parm_lcle = MOD__.parm_vals{223};
    parm_lalpha0 = MOD__.parm_vals{224};
    parm_lalpha1 = MOD__.parm_vals{225};
    parm_lbeta0 = MOD__.parm_vals{226};
    parm_lvfbcv = MOD__.parm_vals{227};
    parm_lvfb = MOD__.parm_vals{228};
    parm_lacde = MOD__.parm_vals{229};
    parm_lmoin = MOD__.parm_vals{230};
    parm_lnoff = MOD__.parm_vals{231};
    parm_lvoffcv = MOD__.parm_vals{232};
    parm_wcdsc = MOD__.parm_vals{233};
    parm_wcdscb = MOD__.parm_vals{234};
    parm_wcdscd = MOD__.parm_vals{235};
    parm_wcit = MOD__.parm_vals{236};
    parm_wnfactor = MOD__.parm_vals{237};
    parm_wxj = MOD__.parm_vals{238};
    parm_wvsat = MOD__.parm_vals{239};
    parm_wat = MOD__.parm_vals{240};
    parm_wa0 = MOD__.parm_vals{241};
    parm_wags = MOD__.parm_vals{242};
    parm_wa1 = MOD__.parm_vals{243};
    parm_wa2 = MOD__.parm_vals{244};
    parm_wketa = MOD__.parm_vals{245};
    parm_wnsub = MOD__.parm_vals{246};
    parm_wnch = MOD__.parm_vals{247};
    parm_wngate = MOD__.parm_vals{248};
    parm_wgamma1 = MOD__.parm_vals{249};
    parm_wgamma2 = MOD__.parm_vals{250};
    parm_wvbx = MOD__.parm_vals{251};
    parm_wvbm = MOD__.parm_vals{252};
    parm_wxt = MOD__.parm_vals{253};
    parm_wk1 = MOD__.parm_vals{254};
    parm_wkt1 = MOD__.parm_vals{255};
    parm_wkt1l = MOD__.parm_vals{256};
    parm_wkt2 = MOD__.parm_vals{257};
    parm_wk2 = MOD__.parm_vals{258};
    parm_wk3 = MOD__.parm_vals{259};
    parm_wk3b = MOD__.parm_vals{260};
    parm_ww0 = MOD__.parm_vals{261};
    parm_wnlx = MOD__.parm_vals{262};
    parm_wdvt0 = MOD__.parm_vals{263};
    parm_wdvt1 = MOD__.parm_vals{264};
    parm_wdvt2 = MOD__.parm_vals{265};
    parm_wdvt0w = MOD__.parm_vals{266};
    parm_wdvt1w = MOD__.parm_vals{267};
    parm_wdvt2w = MOD__.parm_vals{268};
    parm_wdrout = MOD__.parm_vals{269};
    parm_wdsub = MOD__.parm_vals{270};
    parm_wvth0 = MOD__.parm_vals{271};
    parm_wua = MOD__.parm_vals{272};
    parm_wua1 = MOD__.parm_vals{273};
    parm_wub = MOD__.parm_vals{274};
    parm_wub1 = MOD__.parm_vals{275};
    parm_wuc = MOD__.parm_vals{276};
    parm_wuc1 = MOD__.parm_vals{277};
    parm_wu0 = MOD__.parm_vals{278};
    parm_wute = MOD__.parm_vals{279};
    parm_wvoff = MOD__.parm_vals{280};
    parm_welm = MOD__.parm_vals{281};
    parm_wdelta = MOD__.parm_vals{282};
    parm_wrdsw = MOD__.parm_vals{283};
    parm_wprwg = MOD__.parm_vals{284};
    parm_wprwb = MOD__.parm_vals{285};
    parm_wprt = MOD__.parm_vals{286};
    parm_weta0 = MOD__.parm_vals{287};
    parm_wetab = MOD__.parm_vals{288};
    parm_wpclm = MOD__.parm_vals{289};
    parm_wpdiblc1 = MOD__.parm_vals{290};
    parm_wpdiblc2 = MOD__.parm_vals{291};
    parm_wpdiblcb = MOD__.parm_vals{292};
    parm_wpscbe1 = MOD__.parm_vals{293};
    parm_wpscbe2 = MOD__.parm_vals{294};
    parm_wpvag = MOD__.parm_vals{295};
    parm_wwr = MOD__.parm_vals{296};
    parm_wdwg = MOD__.parm_vals{297};
    parm_wdwb = MOD__.parm_vals{298};
    parm_wb0 = MOD__.parm_vals{299};
    parm_wb1 = MOD__.parm_vals{300};
    parm_wcgsl = MOD__.parm_vals{301};
    parm_wcgdl = MOD__.parm_vals{302};
    parm_wckappa = MOD__.parm_vals{303};
    parm_wcf = MOD__.parm_vals{304};
    parm_wclc = MOD__.parm_vals{305};
    parm_wcle = MOD__.parm_vals{306};
    parm_walpha0 = MOD__.parm_vals{307};
    parm_walpha1 = MOD__.parm_vals{308};
    parm_wbeta0 = MOD__.parm_vals{309};
    parm_wvfbcv = MOD__.parm_vals{310};
    parm_wvfb = MOD__.parm_vals{311};
    parm_wacde = MOD__.parm_vals{312};
    parm_wmoin = MOD__.parm_vals{313};
    parm_wnoff = MOD__.parm_vals{314};
    parm_wvoffcv = MOD__.parm_vals{315};
    parm_pcdsc = MOD__.parm_vals{316};
    parm_pcdscb = MOD__.parm_vals{317};
    parm_pcdscd = MOD__.parm_vals{318};
    parm_pcit = MOD__.parm_vals{319};
    parm_pnfactor = MOD__.parm_vals{320};
    parm_pxj = MOD__.parm_vals{321};
    parm_pvsat = MOD__.parm_vals{322};
    parm_pat = MOD__.parm_vals{323};
    parm_pa0 = MOD__.parm_vals{324};
    parm_pags = MOD__.parm_vals{325};
    parm_pa1 = MOD__.parm_vals{326};
    parm_pa2 = MOD__.parm_vals{327};
    parm_pketa = MOD__.parm_vals{328};
    parm_pnsub = MOD__.parm_vals{329};
    parm_pnch = MOD__.parm_vals{330};
    parm_pngate = MOD__.parm_vals{331};
    parm_pgamma1 = MOD__.parm_vals{332};
    parm_pgamma2 = MOD__.parm_vals{333};
    parm_pvbx = MOD__.parm_vals{334};
    parm_pvbm = MOD__.parm_vals{335};
    parm_pxt = MOD__.parm_vals{336};
    parm_pk1 = MOD__.parm_vals{337};
    parm_pkt1 = MOD__.parm_vals{338};
    parm_pkt1l = MOD__.parm_vals{339};
    parm_pkt2 = MOD__.parm_vals{340};
    parm_pk2 = MOD__.parm_vals{341};
    parm_pk3 = MOD__.parm_vals{342};
    parm_pk3b = MOD__.parm_vals{343};
    parm_pw0 = MOD__.parm_vals{344};
    parm_pnlx = MOD__.parm_vals{345};
    parm_pdvt0 = MOD__.parm_vals{346};
    parm_pdvt1 = MOD__.parm_vals{347};
    parm_pdvt2 = MOD__.parm_vals{348};
    parm_pdvt0w = MOD__.parm_vals{349};
    parm_pdvt1w = MOD__.parm_vals{350};
    parm_pdvt2w = MOD__.parm_vals{351};
    parm_pdrout = MOD__.parm_vals{352};
    parm_pdsub = MOD__.parm_vals{353};
    parm_pvth0 = MOD__.parm_vals{354};
    parm_pua = MOD__.parm_vals{355};
    parm_pua1 = MOD__.parm_vals{356};
    parm_pub = MOD__.parm_vals{357};
    parm_pub1 = MOD__.parm_vals{358};
    parm_puc = MOD__.parm_vals{359};
    parm_puc1 = MOD__.parm_vals{360};
    parm_pu0 = MOD__.parm_vals{361};
    parm_pute = MOD__.parm_vals{362};
    parm_pvoff = MOD__.parm_vals{363};
    parm_pelm = MOD__.parm_vals{364};
    parm_pdelta = MOD__.parm_vals{365};
    parm_prdsw = MOD__.parm_vals{366};
    parm_pprwg = MOD__.parm_vals{367};
    parm_pprwb = MOD__.parm_vals{368};
    parm_pprt = MOD__.parm_vals{369};
    parm_peta0 = MOD__.parm_vals{370};
    parm_petab = MOD__.parm_vals{371};
    parm_ppclm = MOD__.parm_vals{372};
    parm_ppdiblc1 = MOD__.parm_vals{373};
    parm_ppdiblc2 = MOD__.parm_vals{374};
    parm_ppdiblcb = MOD__.parm_vals{375};
    parm_ppscbe1 = MOD__.parm_vals{376};
    parm_ppscbe2 = MOD__.parm_vals{377};
    parm_ppvag = MOD__.parm_vals{378};
    parm_pwr = MOD__.parm_vals{379};
    parm_pdwg = MOD__.parm_vals{380};
    parm_pdwb = MOD__.parm_vals{381};
    parm_pb0 = MOD__.parm_vals{382};
    parm_pb1 = MOD__.parm_vals{383};
    parm_pcgsl = MOD__.parm_vals{384};
    parm_pcgdl = MOD__.parm_vals{385};
    parm_pckappa = MOD__.parm_vals{386};
    parm_pcf = MOD__.parm_vals{387};
    parm_pclc = MOD__.parm_vals{388};
    parm_pcle = MOD__.parm_vals{389};
    parm_palpha0 = MOD__.parm_vals{390};
    parm_palpha1 = MOD__.parm_vals{391};
    parm_pbeta0 = MOD__.parm_vals{392};
    parm_pvfbcv = MOD__.parm_vals{393};
    parm_pvfb = MOD__.parm_vals{394};
    parm_pacde = MOD__.parm_vals{395};
    parm_pmoin = MOD__.parm_vals{396};
    parm_pnoff = MOD__.parm_vals{397};
    parm_pvoffcv = MOD__.parm_vals{398};
    parm_noia = MOD__.parm_vals{399};
    parm_noib = MOD__.parm_vals{400};
    parm_noic = MOD__.parm_vals{401};
    parm_em = MOD__.parm_vals{402};
    parm_ef = MOD__.parm_vals{403};
    parm_af = MOD__.parm_vals{404};
    parm_kf = MOD__.parm_vals{405};
    parm_Type = MOD__.parm_vals{406};

    [nFeQe__, nFiQi__, nOtherIo__, nIntUnk__] = get_nfq__(MOD__);

    % Initializing outputs
    fe__ = zeros(nFeQe__,1);
    qe__ = zeros(nFeQe__,1);
    fi__ = zeros(nFiQi__,1);
    qi__ = zeros(nFiQi__,1);
    % Initializing derivatives
    d_fe_d_X__ = zeros(nFeQe__,nOtherIo__);
    d_qe_d_X__ = zeros(nFeQe__,nOtherIo__);
    d_fi_d_X__ = zeros(nFiQi__,nOtherIo__);
    d_qi_d_X__ = zeros(nFiQi__,nOtherIo__);
    d_fe_d_Y__ = zeros(nFeQe__,nIntUnk__);
    d_qe_d_Y__ = zeros(nFeQe__,nIntUnk__);
    d_fi_d_Y__ = zeros(nFiQi__,nIntUnk__);
    d_qi_d_Y__ = zeros(nFiQi__,nIntUnk__);
    % initializing variables
    BSIM3gamma1Given = 0;
    BSIM3gamma2Given = 0;
    BSIM3nqsMod = 0;
    BSIM3nsubGiven = 0;
    BSIM3vbxGiven = 0;
    BSIM3vfbGiven = 0;
    BSIM3xtGiven = 0;
    d_Abulk0_d_v_vbvsp__ = 0;
    d_Abulk0_d_v_vdpvsp__ = 0;
    d_Abulk0_d_v_vgvb__ = 0;
    d_AbulkCV_d_v_vbvsp__ = 0;
    d_AbulkCV_d_v_vdpvsp__ = 0;
    d_AbulkCV_d_v_vgvb__ = 0;
    d_Abulk_d_v_vbvsp__ = 0;
    d_Abulk_d_v_vdpvsp__ = 0;
    d_Abulk_d_v_vgvb__ = 0;
    d_Alphaz_d_v_vbvsp__ = 0;
    d_Alphaz_d_v_vdpvsp__ = 0;
    d_Alphaz_d_v_vgvb__ = 0;
    d_Arg1_d_v_vbvsp__ = 0;
    d_Arg1_d_v_vdpvsp__ = 0;
    d_Arg1_d_v_vgvb__ = 0;
    d_BSIM3AbovVgst2Vtm_d_v_vbvsp__ = 0;
    d_BSIM3AbovVgst2Vtm_d_v_vdpvsp__ = 0;
    d_BSIM3AbovVgst2Vtm_d_v_vgvb__ = 0;
    d_BSIM3Abulk_d_v_vbvsp__ = 0;
    d_BSIM3Abulk_d_v_vdpvsp__ = 0;
    d_BSIM3Abulk_d_v_vgvb__ = 0;
    d_BSIM3Vdseff_d_v_vbvsp__ = 0;
    d_BSIM3Vdseff_d_v_vdpvsp__ = 0;
    d_BSIM3Vdseff_d_v_vgvb__ = 0;
    d_BSIM3Vgsteff_d_v_vbvsp__ = 0;
    d_BSIM3Vgsteff_d_v_vdpvsp__ = 0;
    d_BSIM3Vgsteff_d_v_vgvb__ = 0;
    d_BSIM3cbd_d_v_vbvsp__ = 0;
    d_BSIM3cbd_d_v_vdpvsp__ = 0;
    d_BSIM3cbs_d_v_vbvsp__ = 0;
    d_BSIM3cgdo_d_v_vbvsp__ = 0;
    d_BSIM3cgdo_d_v_vdpvsp__ = 0;
    d_BSIM3cgdo_d_v_vgvb__ = 0;
    d_BSIM3cgso_d_v_vbvsp__ = 0;
    d_BSIM3cgso_d_v_vdpvsp__ = 0;
    d_BSIM3cgso_d_v_vgvb__ = 0;
    d_BSIM3mode_d_v_vdpvsp__ = 0;
    d_BSIM3qbd_d_v_vbvsp__ = 0;
    d_BSIM3qbd_d_v_vdpvsp__ = 0;
    d_BSIM3qbd_d_v_vgvb__ = 0;
    d_BSIM3qbs_d_v_vbvsp__ = 0;
    d_BSIM3qbs_d_v_vdpvsp__ = 0;
    d_BSIM3qbs_d_v_vgvb__ = 0;
    d_BSIM3qinv_d_v_vbvsp__ = 0;
    d_BSIM3qinv_d_v_vdpvsp__ = 0;
    d_BSIM3qinv_d_v_vgvb__ = 0;
    d_BSIM3rds_d_v_vbvsp__ = 0;
    d_BSIM3rds_d_v_vdpvsp__ = 0;
    d_BSIM3rds_d_v_vgvb__ = 0;
    d_BSIM3thetavth_d_v_vbvsp__ = 0;
    d_BSIM3thetavth_d_v_vdpvsp__ = 0;
    d_BSIM3ueff_d_v_vbvsp__ = 0;
    d_BSIM3ueff_d_v_vdpvsp__ = 0;
    d_BSIM3ueff_d_v_vgvb__ = 0;
    d_BSIM3vdsat_d_v_vbvsp__ = 0;
    d_BSIM3vdsat_d_v_vdpvsp__ = 0;
    d_BSIM3vdsat_d_v_vgvb__ = 0;
    d_BSIM3von_d_v_vbvsp__ = 0;
    d_BSIM3von_d_v_vdpvsp__ = 0;
    d_Ccen_d_v_vbvsp__ = 0;
    d_Ccen_d_v_vdpvsp__ = 0;
    d_Ccen_d_v_vgvb__ = 0;
    d_CoxWLcen_d_v_vbvsp__ = 0;
    d_CoxWLcen_d_v_vdpvsp__ = 0;
    d_CoxWLcen_d_v_vgvb__ = 0;
    d_CoxWovL_d_v_vbvsp__ = 0;
    d_CoxWovL_d_v_vdpvsp__ = 0;
    d_CoxWovL_d_v_vgvb__ = 0;
    d_Coxeff_d_v_vbvsp__ = 0;
    d_Coxeff_d_v_vdpvsp__ = 0;
    d_Coxeff_d_v_vgvb__ = 0;
    d_DIBL_Sft_d_v_vbvsp__ = 0;
    d_DIBL_Sft_d_v_vdpvsp__ = 0;
    d_Delt_vth_d_v_vbvsp__ = 0;
    d_Delt_vth_d_v_vdpvsp__ = 0;
    d_DeltaPhi_d_v_vbvsp__ = 0;
    d_DeltaPhi_d_v_vdpvsp__ = 0;
    d_DeltaPhi_d_v_vgvb__ = 0;
    d_Denomi_d_v_vbvsp__ = 0;
    d_Denomi_d_v_vdpvsp__ = 0;
    d_Denomi_d_v_vgvb__ = 0;
    d_EsatL_d_v_vbvsp__ = 0;
    d_EsatL_d_v_vdpvsp__ = 0;
    d_EsatL_d_v_vgvb__ = 0;
    d_Esat_d_v_vbvsp__ = 0;
    d_Esat_d_v_vdpvsp__ = 0;
    d_Esat_d_v_vgvb__ = 0;
    d_ExpArg_d_v_vbvsp__ = 0;
    d_ExpArg_d_v_vdpvsp__ = 0;
    d_ExpArg_d_v_vgvb__ = 0;
    d_ExpVgst_d_v_vbvsp__ = 0;
    d_ExpVgst_d_v_vdpvsp__ = 0;
    d_ExpVgst_d_v_vgvb__ = 0;
    d_Idl_d_v_vbvsp__ = 0;
    d_Idl_d_v_vdpvsp__ = 0;
    d_Idl_d_v_vgvb__ = 0;
    d_Ids_d_v_vbvsp__ = 0;
    d_Ids_d_v_vdpvsp__ = 0;
    d_Ids_d_v_vgvb__ = 0;
    d_Idsa_d_v_vbvsp__ = 0;
    d_Idsa_d_v_vdpvsp__ = 0;
    d_Idsa_d_v_vgvb__ = 0;
    d_Isub_d_v_vbvsp__ = 0;
    d_Isub_d_v_vdpvsp__ = 0;
    d_Isub_d_v_vgvb__ = 0;
    d_LOCAL_cgdo_d_v_vbvsp__ = 0;
    d_LOCAL_cgdo_d_v_vdpvsp__ = 0;
    d_LOCAL_cgdo_d_v_vgvb__ = 0;
    d_LOCAL_cgso_d_v_vbvsp__ = 0;
    d_LOCAL_cgso_d_v_vdpvsp__ = 0;
    d_LOCAL_cgso_d_v_vgvb__ = 0;
    d_LOCAL_noff_d_v_vbvsp__ = 0;
    d_LOCAL_noff_d_v_vdpvsp__ = 0;
    d_Lambda_d_v_vbvsp__ = 0;
    d_Lambda_d_v_vdpvsp__ = 0;
    d_Lambda_d_v_vgvb__ = 0;
    d_One_Third_CoxWL_d_v_vbvsp__ = 0;
    d_One_Third_CoxWL_d_v_vdpvsp__ = 0;
    d_One_Third_CoxWL_d_v_vgvb__ = 0;
    d_Phis_d_v_vbvsp__ = 0;
    d_Phis_d_v_vdpvsp__ = 0;
    d_Qac0_d_v_vbvsp__ = 0;
    d_Qac0_d_v_vdpvsp__ = 0;
    d_Qac0_d_v_vgvb__ = 0;
    d_Qsub0_d_v_vbvsp__ = 0;
    d_Qsub0_d_v_vdpvsp__ = 0;
    d_Qsub0_d_v_vgvb__ = 0;
    d_Rds_d_v_vbvsp__ = 0;
    d_Rds_d_v_vdpvsp__ = 0;
    d_Rds_d_v_vgvb__ = 0;
    d_T0_d_v_vbvsp__ = 0;
    d_T0_d_v_vdpvsp__ = 0;
    d_T0_d_v_vgvb__ = 0;
    d_T10_d_v_vbvsp__ = 0;
    d_T10_d_v_vdpvsp__ = 0;
    d_T10_d_v_vgvb__ = 0;
    d_T1_d_v_vbvsp__ = 0;
    d_T1_d_v_vdpvsp__ = 0;
    d_T1_d_v_vgvb__ = 0;
    d_T2_d_v_vbvsp__ = 0;
    d_T2_d_v_vdpvsp__ = 0;
    d_T2_d_v_vgvb__ = 0;
    d_T3_d_v_vbvsp__ = 0;
    d_T3_d_v_vdpvsp__ = 0;
    d_T3_d_v_vgvb__ = 0;
    d_T4_d_v_vbvsp__ = 0;
    d_T4_d_v_vdpvsp__ = 0;
    d_T4_d_v_vgvb__ = 0;
    d_T5_d_v_vbvsp__ = 0;
    d_T5_d_v_vdpvsp__ = 0;
    d_T5_d_v_vgvb__ = 0;
    d_T6_d_v_vbvsp__ = 0;
    d_T6_d_v_vdpvsp__ = 0;
    d_T6_d_v_vgvb__ = 0;
    d_T7_d_v_vbvsp__ = 0;
    d_T7_d_v_vdpvsp__ = 0;
    d_T7_d_v_vgvb__ = 0;
    d_T8_d_v_vbvsp__ = 0;
    d_T8_d_v_vdpvsp__ = 0;
    d_T8_d_v_vgvb__ = 0;
    d_T9_d_v_vbvsp__ = 0;
    d_T9_d_v_vdpvsp__ = 0;
    d_T9_d_v_vgvb__ = 0;
    d_Tcen_d_v_vbvsp__ = 0;
    d_Tcen_d_v_vdpvsp__ = 0;
    d_Tcen_d_v_vgvb__ = 0;
    d_Theta0_d_v_vbvsp__ = 0;
    d_Theta0_d_v_vdpvsp__ = 0;
    d_Two_Third_CoxWL_d_v_vbvsp__ = 0;
    d_Two_Third_CoxWL_d_v_vdpvsp__ = 0;
    d_Two_Third_CoxWL_d_v_vgvb__ = 0;
    d_V3_d_v_vbvsp__ = 0;
    d_V3_d_v_vdpvsp__ = 0;
    d_V3_d_v_vgvb__ = 0;
    d_V4_d_v_vbvsp__ = 0;
    d_V4_d_v_vdpvsp__ = 0;
    d_V4_d_v_vgvb__ = 0;
    d_VACLM_d_v_vbvsp__ = 0;
    d_VACLM_d_v_vdpvsp__ = 0;
    d_VACLM_d_v_vgvb__ = 0;
    d_VADIBL_d_v_vbvsp__ = 0;
    d_VADIBL_d_v_vdpvsp__ = 0;
    d_VADIBL_d_v_vgvb__ = 0;
    d_VASCBE_d_v_vbvsp__ = 0;
    d_VASCBE_d_v_vdpvsp__ = 0;
    d_VASCBE_d_v_vgvb__ = 0;
    d_Va_d_v_vbvsp__ = 0;
    d_Va_d_v_vdpvsp__ = 0;
    d_Va_d_v_vgvb__ = 0;
    d_Vasat_d_v_vbvsp__ = 0;
    d_Vasat_d_v_vdpvsp__ = 0;
    d_Vasat_d_v_vgvb__ = 0;
    d_Vbs_d_v_vbvsp__ = 0;
    d_Vbs_d_v_vdpvsp__ = 0;
    d_VbseffCV_d_v_vbvsp__ = 0;
    d_VbseffCV_d_v_vdpvsp__ = 0;
    d_Vbseff_d_v_vbvsp__ = 0;
    d_Vbseff_d_v_vdpvsp__ = 0;
    d_Vds_d_v_vdpvsp__ = 0;
    d_VdsatCV_d_v_vbvsp__ = 0;
    d_VdsatCV_d_v_vdpvsp__ = 0;
    d_VdsatCV_d_v_vgvb__ = 0;
    d_Vdsat_d_v_vbvsp__ = 0;
    d_Vdsat_d_v_vdpvsp__ = 0;
    d_Vdsat_d_v_vgvb__ = 0;
    d_VdseffCV_d_v_vbvsp__ = 0;
    d_VdseffCV_d_v_vdpvsp__ = 0;
    d_VdseffCV_d_v_vgvb__ = 0;
    d_Vdseff_d_v_vbvsp__ = 0;
    d_Vdseff_d_v_vdpvsp__ = 0;
    d_Vdseff_d_v_vgvb__ = 0;
    d_Vfbeff_d_v_vbvsp__ = 0;
    d_Vfbeff_d_v_vdpvsp__ = 0;
    d_Vfbeff_d_v_vgvb__ = 0;
    d_Vgs_d_v_vbvsp__ = 0;
    d_Vgs_d_v_vdpvsp__ = 0;
    d_Vgs_d_v_vgvb__ = 0;
    d_Vgs_eff_d_v_vbvsp__ = 0;
    d_Vgs_eff_d_v_vdpvsp__ = 0;
    d_Vgs_eff_d_v_vgvb__ = 0;
    d_Vgst2Vtm_d_v_vbvsp__ = 0;
    d_Vgst2Vtm_d_v_vdpvsp__ = 0;
    d_Vgst2Vtm_d_v_vgvb__ = 0;
    d_VgstNVt_d_v_vbvsp__ = 0;
    d_VgstNVt_d_v_vdpvsp__ = 0;
    d_VgstNVt_d_v_vgvb__ = 0;
    d_Vgst_d_v_vbvsp__ = 0;
    d_Vgst_d_v_vdpvsp__ = 0;
    d_Vgst_d_v_vgvb__ = 0;
    d_Vgsteff_d_v_vbvsp__ = 0;
    d_Vgsteff_d_v_vdpvsp__ = 0;
    d_Vgsteff_d_v_vgvb__ = 0;
    d_Vth_d_v_vbvsp__ = 0;
    d_Vth_d_v_vdpvsp__ = 0;
    d_WVCoxRds_d_v_vbvsp__ = 0;
    d_WVCoxRds_d_v_vdpvsp__ = 0;
    d_WVCoxRds_d_v_vgvb__ = 0;
    d_WVCox_d_v_vbvsp__ = 0;
    d_WVCox_d_v_vdpvsp__ = 0;
    d_WVCox_d_v_vgvb__ = 0;
    d_Weff_d_v_vbvsp__ = 0;
    d_Weff_d_v_vdpvsp__ = 0;
    d_Weff_d_v_vgvb__ = 0;
    d_Xdep_d_v_vbvsp__ = 0;
    d_Xdep_d_v_vdpvsp__ = 0;
    d_arg_d_v_vbvsp__ = 0;
    d_arg_d_v_vdpvsp__ = 0;
    d_beta_d_v_vbvsp__ = 0;
    d_beta_d_v_vdpvsp__ = 0;
    d_beta_d_v_vgvb__ = 0;
    d_cdreq_d_v_vbvsp__ = 0;
    d_cdreq_d_v_vdpvsp__ = 0;
    d_cdreq_d_v_vgvb__ = 0;
    d_ceqbd_d_v_vbvsp__ = 0;
    d_ceqbd_d_v_vdpvsp__ = 0;
    d_ceqbd_d_v_vgvb__ = 0;
    d_ceqbs_d_v_vbvsp__ = 0;
    d_ceqbs_d_v_vdpvsp__ = 0;
    d_ceqbs_d_v_vgvb__ = 0;
    d_dAbulk_dVg_d_v_vbvsp__ = 0;
    d_dAbulk_dVg_d_v_vdpvsp__ = 0;
    d_dAbulk_dVg_d_v_vgvb__ = 0;
    d_dDIBL_Sft_dVd_d_v_vbvsp__ = 0;
    d_dDIBL_Sft_dVd_d_v_vdpvsp__ = 0;
    d_dT1_dVb_d_v_vbvsp__ = 0;
    d_dT1_dVb_d_v_vdpvsp__ = 0;
    d_dT1_dVb_d_v_vgvb__ = 0;
    d_dT2_dVg_d_v_vbvsp__ = 0;
    d_dT2_dVg_d_v_vdpvsp__ = 0;
    d_dT2_dVg_d_v_vgvb__ = 0;
    d_diffVds_d_v_vbvsp__ = 0;
    d_diffVds_d_v_vdpvsp__ = 0;
    d_diffVds_d_v_vgvb__ = 0;
    d_evbd_d_v_vbvsp__ = 0;
    d_evbd_d_v_vdpvsp__ = 0;
    d_evbs_d_v_vbvsp__ = 0;
    d_f_i_vbvdp_d_v_vbvsp__ = 0;
    d_f_i_vbvdp_d_v_vdpvsp__ = 0;
    d_f_i_vbvdp_d_v_vgvb__ = 0;
    d_f_i_vbvsp_d_v_vbvsp__ = 0;
    d_f_i_vbvsp_d_v_vdpvsp__ = 0;
    d_f_i_vbvsp_d_v_vgvb__ = 0;
    d_f_i_vdpvsp_d_v_vbvsp__ = 0;
    d_f_i_vdpvsp_d_v_vdpvsp__ = 0;
    d_f_i_vdpvsp_d_v_vgvb__ = 0;
    d_f_i_vdvdp_d_v_vbvsp__ = 0;
    d_f_i_vdvdp_d_v_vdpvsp__ = 0;
    d_f_i_vdvdp_d_v_vdvb__ = 0;
    d_f_i_vgvsp_d_v_vbvsp__ = 0;
    d_f_i_vgvsp_d_v_vdpvsp__ = 0;
    d_f_i_vgvsp_d_v_vgvb__ = 0;
    d_f_i_vsvsp_d_v_vbvsp__ = 0;
    d_f_i_vsvsp_d_v_vsvb__ = 0;
    d_fgche1_d_v_vbvsp__ = 0;
    d_fgche1_d_v_vdpvsp__ = 0;
    d_fgche1_d_v_vgvb__ = 0;
    d_fgche2_d_v_vbvsp__ = 0;
    d_fgche2_d_v_vdpvsp__ = 0;
    d_fgche2_d_v_vgvb__ = 0;
    d_gche_d_v_vbvsp__ = 0;
    d_gche_d_v_vdpvsp__ = 0;
    d_gche_d_v_vgvb__ = 0;
    d_lt1_d_v_vbvsp__ = 0;
    d_lt1_d_v_vdpvsp__ = 0;
    d_ltw_d_v_vbvsp__ = 0;
    d_ltw_d_v_vdpvsp__ = 0;
    d_n_d_v_vbvsp__ = 0;
    d_n_d_v_vdpvsp__ = 0;
    d_q_i_vbvdp_d_v_vbvsp__ = 0;
    d_q_i_vbvdp_d_v_vdpvsp__ = 0;
    d_q_i_vbvdp_d_v_vgvb__ = 0;
    d_q_i_vbvsp_d_v_vbvsp__ = 0;
    d_q_i_vbvsp_d_v_vdpvsp__ = 0;
    d_q_i_vbvsp_d_v_vgvb__ = 0;
    d_q_i_vdpvsp_d_v_vbvsp__ = 0;
    d_q_i_vdpvsp_d_v_vdpvsp__ = 0;
    d_q_i_vdpvsp_d_v_vgvb__ = 0;
    d_q_i_vdvdp_d_v_vbvsp__ = 0;
    d_q_i_vdvdp_d_v_vdpvsp__ = 0;
    d_q_i_vdvdp_d_v_vdvb__ = 0;
    d_q_i_vgvsp_d_v_vbvsp__ = 0;
    d_q_i_vgvsp_d_v_vdpvsp__ = 0;
    d_q_i_vgvsp_d_v_vgvb__ = 0;
    d_q_i_vsvsp_d_v_vbvsp__ = 0;
    d_q_i_vsvsp_d_v_vsvb__ = 0;
    d_qbulk_d_v_vbvsp__ = 0;
    d_qbulk_d_v_vdpvsp__ = 0;
    d_qbulk_d_v_vgvb__ = 0;
    d_qdrn_d_v_vbvsp__ = 0;
    d_qdrn_d_v_vdpvsp__ = 0;
    d_qdrn_d_v_vgvb__ = 0;
    d_qgate_d_v_vbvsp__ = 0;
    d_qgate_d_v_vdpvsp__ = 0;
    d_qgate_d_v_vgvb__ = 0;
    d_qgb_d_v_vbvsp__ = 0;
    d_qgb_d_v_vdpvsp__ = 0;
    d_qgb_d_v_vgvb__ = 0;
    d_qgd_d_v_vbvsp__ = 0;
    d_qgd_d_v_vdpvsp__ = 0;
    d_qgd_d_v_vgvb__ = 0;
    d_qgdo_d_v_vbvsp__ = 0;
    d_qgdo_d_v_vdpvsp__ = 0;
    d_qgdo_d_v_vgvb__ = 0;
    d_qgs_d_v_vbvsp__ = 0;
    d_qgs_d_v_vdpvsp__ = 0;
    d_qgs_d_v_vgvb__ = 0;
    d_qgso_d_v_vbvsp__ = 0;
    d_qgso_d_v_vdpvsp__ = 0;
    d_qgso_d_v_vgvb__ = 0;
    d_qinoi_d_v_vbvsp__ = 0;
    d_qinoi_d_v_vdpvsp__ = 0;
    d_qinoi_d_v_vgvb__ = 0;
    d_qsrc_d_v_vbvsp__ = 0;
    d_qsrc_d_v_vdpvsp__ = 0;
    d_qsrc_d_v_vgvb__ = 0;
    d_sarg_d_v_vbvsp__ = 0;
    d_sarg_d_v_vdpvsp__ = 0;
    d_sqrtPhis_d_v_vbvsp__ = 0;
    d_sqrtPhis_d_v_vdpvsp__ = 0;
    d_tmp1_d_v_vbvsp__ = 0;
    d_tmp1_d_v_vdpvsp__ = 0;
    d_tmp2_d_v_vbvsp__ = 0;
    d_tmp2_d_v_vdpvsp__ = 0;
    d_tmp2_d_v_vgvb__ = 0;
    d_tmp3_d_v_vbvsp__ = 0;
    d_tmp3_d_v_vdpvsp__ = 0;
    d_tmp3_d_v_vgvb__ = 0;
    d_tmp4_d_v_vbvsp__ = 0;
    d_tmp4_d_v_vdpvsp__ = 0;
    d_tmp4_d_v_vgvb__ = 0;
    d_tmp_d_v_vbvsp__ = 0;
    d_tmp_d_v_vdpvsp__ = 0;
    d_tmp_d_v_vgvb__ = 0;
    d_ueff_d_v_vbvsp__ = 0;
    d_ueff_d_v_vdpvsp__ = 0;
    d_ueff_d_v_vgvb__ = 0;
    d_v_vdvdp_d_v_vbvsp__ = 0;
    d_v_vdvdp_d_v_vdpvsp__ = 0;
    d_v_vdvdp_d_v_vdvb__ = 0;
    d_v_vgvsp_d_v_vbvsp__ = 0;
    d_v_vgvsp_d_v_vgvb__ = 0;
    d_v_vsvsp_d_v_vbvsp__ = 0;
    d_v_vsvsp_d_v_vsvb__ = 0;
    d_vbd_d_v_vbvsp__ = 0;
    d_vbd_d_v_vdpvsp__ = 0;
    d_vbs_d_v_vbvsp__ = 0;
    d_vd_vdp_d_v_vbvsp__ = 0;
    d_vd_vdp_d_v_vdpvsp__ = 0;
    d_vd_vdp_d_v_vdvb__ = 0;
    d_vds_d_v_vdpvsp__ = 0;
    d_vgb_d_v_vbvsp__ = 0;
    d_vgb_d_v_vgvb__ = 0;
    d_vgd_d_v_vbvsp__ = 0;
    d_vgd_d_v_vdpvsp__ = 0;
    d_vgd_d_v_vgvb__ = 0;
    d_vgs_d_v_vbvsp__ = 0;
    d_vgs_d_v_vgvb__ = 0;
    d_vs_vsp_d_v_vbvsp__ = 0;
    d_vs_vsp_d_v_vsvb__ = 0;
    dsqrtPhis_dVb = 0;
    % Initializing inputs
    v_vdvb__ = vecX__(1);
    v_vgvb__ = vecX__(2);
    v_vsvb__ = vecX__(3);
    v_vdpvsp__ = vecY__(1);
    v_vbvsp__ = vecY__(2);
    % Initializing remaining IOs and auxiliary IOs
    f_i_vdpvsp__ = 0;
    q_i_vdpvsp__ = 0;
    f_i_vbvsp__ = 0;
    q_i_vbvsp__ = 0;
    f_i_vgvsp__ = 0;
    q_i_vgvsp__ = 0;
    f_i_vdvdp__ = 0;
    q_i_vdvdp__ = 0;
    f_i_vsvsp__ = 0;
    q_i_vsvsp__ = 0;
    f_i_vbvdp__ = 0;
    q_i_vbvdp__ = 0;
    % module body
        d_v_vgvsp_d_v_vgvb__ = 1;
        d_v_vgvsp_d_v_vbvsp__ = 1;
    v_vgvsp__ = v_vgvb__+v_vbvsp__;
        d_v_vdvdp_d_v_vdvb__ = (1);
        d_v_vdvdp_d_v_vdpvsp__ = (-1);
        d_v_vdvdp_d_v_vbvsp__ = 1;
    v_vdvdp__ = (v_vdvb__-v_vdpvsp__)+v_vbvsp__;
        d_v_vsvsp_d_v_vsvb__ = 1;
        d_v_vsvsp_d_v_vbvsp__ = 1;
    v_vsvsp__ = v_vsvb__+v_vbvsp__;
    BSIM3drainArea = parm_ad;
    BSIM3sourceArea = parm_as;
    BSIM3drainSquares = parm_nrd;
    BSIM3sourceSquares = parm_nrs;
    BSIM3drainPerimeter = parm_pd;
    BSIM3sourcePerimeter = parm_ps;
    BSIM3mobMod = parm_mobmod;
    BSIM3binUnit = parm_binunit;
    BSIM3capMod = parm_capmod;
    BSIM3noiMod = parm_noimod;
    BSIM3version = parm_version;
    BSIM3tox = parm_tox;
    BSIM3toxm = parm_toxm;
    BSIM3cdsc = parm_cdsc;
    BSIM3cdscb = parm_cdscb;
    BSIM3cdscd = parm_cdscd;
    BSIM3cit = parm_cit;
    BSIM3nfactor = parm_nfactor;
    BSIM3xj = parm_xj;
    BSIM3vsat = parm_vsat;
    BSIM3a0 = parm_a0;
    BSIM3ags = parm_ags;
    BSIM3a1 = parm_a1;
    BSIM3a2 = parm_a2;
    BSIM3at = parm_at;
    BSIM3keta = parm_keta;
    BSIM3nsub = parm_nsub;
    BSIM3npeak = parm_nch;
    BSIM3ngate = parm_ngate;
    BSIM3gamma1 = parm_gamma1;
    BSIM3gamma2 = parm_gamma2;
    BSIM3vbx = parm_vbx;
    BSIM3vbm = parm_vbm;
    BSIM3xt = parm_xt;
    BSIM3k1 = parm_k1;
    BSIM3kt1 = parm_kt1;
    BSIM3kt1l = parm_kt1l;
    BSIM3kt2 = parm_kt2;
    BSIM3k2 = parm_k2;
    BSIM3k3 = parm_k3;
    BSIM3k3b = parm_k3b;
    BSIM3nlx = parm_nlx;
    BSIM3w0 = parm_w0;
    BSIM3dvt0 = parm_dvt0;
    BSIM3dvt1 = parm_dvt1;
    BSIM3dvt2 = parm_dvt2;
    BSIM3dvt0w = parm_dvt0w;
    BSIM3dvt1w = parm_dvt1w;
    BSIM3dvt2w = parm_dvt2w;
    BSIM3drout = parm_drout;
    BSIM3dsub = parm_dsub;
    BSIM3vth0 = parm_vth0;
    BSIM3ua = parm_ua;
    BSIM3ua1 = parm_ua1;
    BSIM3ub = parm_ub;
    BSIM3ub1 = parm_ub1;
    BSIM3uc = parm_uc;
    BSIM3uc1 = parm_uc1;
    BSIM3u0 = parm_u0;
    BSIM3ute = parm_ute;
    BSIM3voff = parm_voff;
    BSIM3delta = parm_delta;
    BSIM3rdsw = parm_rdsw;
    BSIM3prwg = parm_prwg;
    BSIM3prwb = parm_prwb;
    BSIM3prt = parm_prt;
    BSIM3eta0 = parm_eta0;
    BSIM3etab = parm_etab;
    BSIM3pclm = parm_pclm;
    BSIM3pdibl1 = parm_pdiblc1;
    BSIM3pdibl2 = parm_pdiblc2;
    BSIM3pdiblb = parm_pdiblcb;
    BSIM3pscbe1 = parm_pscbe1;
    BSIM3pscbe2 = parm_pscbe2;
    BSIM3pvag = parm_pvag;
    BSIM3wr = parm_wr;
    BSIM3dwg = parm_dwg;
    BSIM3dwb = parm_dwb;
    BSIM3b0 = parm_b0;
    BSIM3b1 = parm_b1;
    BSIM3alpha0 = parm_alpha0;
    BSIM3alpha1 = parm_alpha1;
    BSIM3beta0 = parm_beta0;
    BSIM3ijth = parm_ijth;
    BSIM3vfb = parm_vfb;
    BSIM3elm = parm_elm;
    BSIM3cgsl = parm_cgsl;
    BSIM3cgdl = parm_cgdl;
    BSIM3ckappa = parm_ckappa;
    BSIM3cf = parm_cf;
    BSIM3clc = parm_clc1;
    BSIM3cle = parm_cle;
    BSIM3dwc = parm_dwc;
    BSIM3dlc = parm_dlc;
    BSIM3vfbcv = parm_vfbcv;
    BSIM3acde = parm_acde1;
    BSIM3moin = parm_moin;
    BSIM3noff = parm_noff;
    BSIM3voffcv = parm_voffcv;
    BSIM3tcj = parm_tcj;
    BSIM3tpb = parm_tpb;
    BSIM3tcjsw = parm_tcjsw;
    BSIM3tpbsw = parm_tpbsw;
    BSIM3tcjswg = parm_tcjswg;
    BSIM3tpbswg = parm_tpbswg;
    BSIM3lcdsc = parm_lcdsc;
    BSIM3lcdscb = parm_lcdscb;
    BSIM3lcdscd = parm_lcdscd;
    BSIM3lcit = parm_lcit;
    BSIM3lnfactor = parm_lnfactor;
    BSIM3lxj = parm_lxj;
    BSIM3lvsat = parm_lvsat;
    BSIM3la0 = parm_la0;
    BSIM3lags = parm_lags;
    BSIM3la1 = parm_la1;
    BSIM3la2 = parm_la2;
    BSIM3lat = parm_lat;
    BSIM3lketa = parm_lketa;
    BSIM3lnsub = parm_lnsub;
    BSIM3lnpeak = parm_lnch;
    BSIM3lngate = parm_lngate;
    BSIM3lgamma1 = parm_lgamma1;
    BSIM3lgamma2 = parm_lgamma2;
    BSIM3lvbx = parm_lvbx;
    BSIM3lvbm = parm_lvbm;
    BSIM3lxt = parm_lxt;
    BSIM3lk1 = parm_lk1;
    BSIM3lkt1 = parm_lkt1;
    BSIM3lkt1l = parm_lkt1l;
    BSIM3lkt2 = parm_lkt2;
    BSIM3lk2 = parm_lk2;
    BSIM3lk3 = parm_lk3;
    BSIM3lk3b = parm_lk3b;
    BSIM3lnlx = parm_lnlx;
    BSIM3lw0 = parm_lw0;
    BSIM3ldvt0 = parm_ldvt0;
    BSIM3ldvt1 = parm_ldvt1;
    BSIM3ldvt2 = parm_ldvt2;
    BSIM3ldvt0w = parm_ldvt0w;
    BSIM3ldvt1w = parm_ldvt1w;
    BSIM3ldvt2w = parm_ldvt2w;
    BSIM3ldrout = parm_ldrout;
    BSIM3ldsub = parm_ldsub;
    BSIM3lvth0 = parm_lvth0;
    BSIM3lua = parm_lua;
    BSIM3lua1 = parm_lua1;
    BSIM3lub = parm_lub;
    BSIM3lub1 = parm_lub1;
    BSIM3luc = parm_luc;
    BSIM3luc1 = parm_luc1;
    BSIM3lu0 = parm_lu0;
    BSIM3lute = parm_lute;
    BSIM3lvoff = parm_lvoff;
    BSIM3ldelta = parm_ldelta;
    BSIM3lrdsw = parm_lrdsw;
    BSIM3lprwb = parm_lprwb;
    BSIM3lprwg = parm_lprwg;
    BSIM3lprt = parm_lprt;
    BSIM3leta0 = parm_leta0;
    BSIM3letab = parm_letab;
    BSIM3lpclm = parm_lpclm;
    BSIM3lpdibl1 = parm_lpdiblc1;
    BSIM3lpdibl2 = parm_lpdiblc2;
    BSIM3lpdiblb = parm_lpdiblcb;
    BSIM3lpscbe1 = parm_lpscbe1;
    BSIM3lpscbe2 = parm_lpscbe2;
    BSIM3lpvag = parm_lpvag;
    BSIM3lwr = parm_lwr;
    BSIM3ldwg = parm_ldwg;
    BSIM3ldwb = parm_ldwb;
    BSIM3lb0 = parm_lb0;
    BSIM3lb1 = parm_lb1;
    BSIM3lalpha0 = parm_lalpha0;
    BSIM3lalpha1 = parm_lalpha1;
    BSIM3lbeta0 = parm_lbeta0;
    BSIM3lvfb = parm_lvfb;
    BSIM3lelm = parm_lelm;
    BSIM3lcgsl = parm_lcgsl;
    BSIM3lcgdl = parm_lcgdl;
    BSIM3lckappa = parm_lckappa;
    BSIM3lcf = parm_lcf;
    BSIM3lclc = parm_lclc;
    BSIM3lcle = parm_lcle;
    BSIM3lvfbcv = parm_lvfbcv;
    BSIM3lacde = parm_lacde;
    BSIM3lmoin = parm_lmoin;
    BSIM3lnoff = parm_lnoff;
    BSIM3lvoffcv = parm_lvoffcv;
    BSIM3wcdsc = parm_wcdsc;
    BSIM3wcdscb = parm_wcdscb;
    BSIM3wcdscd = parm_wcdscd;
    BSIM3wcit = parm_wcit;
    BSIM3wnfactor = parm_wnfactor;
    BSIM3wxj = parm_wxj;
    BSIM3wvsat = parm_wvsat;
    BSIM3wa0 = parm_wa0;
    BSIM3wags = parm_wags;
    BSIM3wa1 = parm_wa1;
    BSIM3wa2 = parm_wa2;
    BSIM3wat = parm_wat;
    BSIM3wketa = parm_wketa;
    BSIM3wnsub = parm_wnsub;
    BSIM3wnpeak = parm_wnch;
    BSIM3wngate = parm_wngate;
    BSIM3wgamma1 = parm_wgamma1;
    BSIM3wgamma2 = parm_wgamma2;
    BSIM3wvbx = parm_wvbx;
    BSIM3wvbm = parm_wvbm;
    BSIM3wxt = parm_wxt;
    BSIM3wk1 = parm_wk1;
    BSIM3wkt1 = parm_wkt1;
    BSIM3wkt1l = parm_wkt1l;
    BSIM3wkt2 = parm_wkt2;
    BSIM3wk2 = parm_wk2;
    BSIM3wk3 = parm_wk3;
    BSIM3wk3b = parm_wk3b;
    BSIM3wnlx = parm_wnlx;
    BSIM3ww0 = parm_ww0;
    BSIM3wdvt0 = parm_wdvt0;
    BSIM3wdvt1 = parm_wdvt1;
    BSIM3wdvt2 = parm_wdvt2;
    BSIM3wdvt0w = parm_wdvt0w;
    BSIM3wdvt1w = parm_wdvt1w;
    BSIM3wdvt2w = parm_wdvt2w;
    BSIM3wdrout = parm_wdrout;
    BSIM3wdsub = parm_wdsub;
    BSIM3wvth0 = parm_wvth0;
    BSIM3wua = parm_wua;
    BSIM3wua1 = parm_wua1;
    BSIM3wub = parm_wub;
    BSIM3wub1 = parm_wub1;
    BSIM3wuc = parm_wuc;
    BSIM3wuc1 = parm_wuc1;
    BSIM3wu0 = parm_wu0;
    BSIM3wute = parm_wute;
    BSIM3wvoff = parm_wvoff;
    BSIM3wdelta = parm_wdelta;
    BSIM3wrdsw = parm_wrdsw;
    BSIM3wprwb = parm_wprwb;
    BSIM3wprwg = parm_wprwg;
    BSIM3wprt = parm_wprt;
    BSIM3weta0 = parm_weta0;
    BSIM3wetab = parm_wetab;
    BSIM3wpclm = parm_wpclm;
    BSIM3wpdibl1 = parm_wpdiblc1;
    BSIM3wpdibl2 = parm_wpdiblc2;
    BSIM3wpdiblb = parm_wpdiblcb;
    BSIM3wpscbe1 = parm_wpscbe1;
    BSIM3wpscbe2 = parm_wpscbe2;
    BSIM3wpvag = parm_wpvag;
    BSIM3wwr = parm_wwr;
    BSIM3wdwg = parm_wdwg;
    BSIM3wdwb = parm_wdwb;
    BSIM3wb0 = parm_wb0;
    BSIM3wb1 = parm_wb1;
    BSIM3walpha0 = parm_walpha0;
    BSIM3walpha1 = parm_walpha1;
    BSIM3wbeta0 = parm_wbeta0;
    BSIM3wvfb = parm_wvfb;
    BSIM3welm = parm_welm;
    BSIM3wcgsl = parm_wcgsl;
    BSIM3wcgdl = parm_wcgdl;
    BSIM3wckappa = parm_wckappa;
    BSIM3wcf = parm_wcf;
    BSIM3wclc = parm_wclc;
    BSIM3wcle = parm_wcle;
    BSIM3wvfbcv = parm_wvfbcv;
    BSIM3wacde = parm_wacde;
    BSIM3wmoin = parm_wmoin;
    BSIM3wnoff = parm_wnoff;
    BSIM3wvoffcv = parm_wvoffcv;
    BSIM3pcdsc = parm_pcdsc;
    BSIM3pcdscb = parm_pcdscb;
    BSIM3pcdscd = parm_pcdscd;
    BSIM3pcit = parm_pcit;
    BSIM3pnfactor = parm_pnfactor;
    BSIM3pxj = parm_pxj;
    BSIM3pvsat = parm_pvsat;
    BSIM3pa0 = parm_pa0;
    BSIM3pags = parm_pags;
    BSIM3pa1 = parm_pa1;
    BSIM3pa2 = parm_pa2;
    BSIM3pat = parm_pat;
    BSIM3pketa = parm_pketa;
    BSIM3pnsub = parm_pnsub;
    BSIM3pnpeak = parm_pnch;
    BSIM3pngate = parm_pngate;
    BSIM3pgamma1 = parm_pgamma1;
    BSIM3pgamma2 = parm_pgamma2;
    BSIM3pvbx = parm_pvbx;
    BSIM3pvbm = parm_pvbm;
    BSIM3pxt = parm_pxt;
    BSIM3pk1 = parm_pk1;
    BSIM3pkt1 = parm_pkt1;
    BSIM3pkt1l = parm_pkt1l;
    BSIM3pkt2 = parm_pkt2;
    BSIM3pk2 = parm_pk2;
    BSIM3pk3 = parm_pk3;
    BSIM3pk3b = parm_pk3b;
    BSIM3pnlx = parm_pnlx;
    BSIM3pw0 = parm_pw0;
    BSIM3pdvt0 = parm_pdvt0;
    BSIM3pdvt1 = parm_pdvt1;
    BSIM3pdvt2 = parm_pdvt2;
    BSIM3pdvt0w = parm_pdvt0w;
    BSIM3pdvt1w = parm_pdvt1w;
    BSIM3pdvt2w = parm_pdvt2w;
    BSIM3pdrout = parm_pdrout;
    BSIM3pdsub = parm_pdsub;
    BSIM3pvth0 = parm_pvth0;
    BSIM3pua = parm_pua;
    BSIM3pua1 = parm_pua1;
    BSIM3pub = parm_pub;
    BSIM3pub1 = parm_pub1;
    BSIM3puc = parm_puc;
    BSIM3puc1 = parm_puc1;
    BSIM3pu0 = parm_pu0;
    BSIM3pute = parm_pute;
    BSIM3pvoff = parm_pvoff;
    BSIM3pdelta = parm_pdelta;
    BSIM3prdsw = parm_prdsw;
    BSIM3pprwb = parm_pprwb;
    BSIM3pprwg = parm_pprwg;
    BSIM3pprt = parm_pprt;
    BSIM3peta0 = parm_peta0;
    BSIM3petab = parm_petab;
    BSIM3ppclm = parm_ppclm;
    BSIM3ppdibl1 = parm_ppdiblc1;
    BSIM3ppdibl2 = parm_ppdiblc2;
    BSIM3ppdiblb = parm_ppdiblcb;
    BSIM3ppscbe1 = parm_ppscbe1;
    BSIM3ppscbe2 = parm_ppscbe2;
    BSIM3ppvag = parm_ppvag;
    BSIM3pwr = parm_pwr;
    BSIM3pdwg = parm_pdwg;
    BSIM3pdwb = parm_pdwb;
    BSIM3pb0 = parm_pb0;
    BSIM3pb1 = parm_pb1;
    BSIM3palpha0 = parm_palpha0;
    BSIM3palpha1 = parm_palpha1;
    BSIM3pbeta0 = parm_pbeta0;
    BSIM3pvfb = parm_pvfb;
    BSIM3pelm = parm_pelm;
    BSIM3pcgsl = parm_pcgsl;
    BSIM3pcgdl = parm_pcgdl;
    BSIM3pckappa = parm_pckappa;
    BSIM3pcf = parm_pcf;
    BSIM3pclc = parm_pclc;
    BSIM3pcle = parm_pcle;
    BSIM3pvfbcv = parm_pvfbcv;
    BSIM3pacde = parm_pacde;
    BSIM3pmoin = parm_pmoin;
    BSIM3pnoff = parm_pnoff;
    BSIM3pvoffcv = parm_pvoffcv;
    BSIM3tnom = parm_tnom+273.15;
        d_BSIM3cgso_d_v_vgvb__ = 0;
        d_BSIM3cgso_d_v_vdpvsp__ = 0;
        d_BSIM3cgso_d_v_vbvsp__ = 0;
    BSIM3cgso = parm_cgso;
        d_BSIM3cgdo_d_v_vgvb__ = 0;
        d_BSIM3cgdo_d_v_vdpvsp__ = 0;
        d_BSIM3cgdo_d_v_vbvsp__ = 0;
    BSIM3cgdo = parm_cgdo;
    BSIM3cgbo = parm_cgbo;
    BSIM3xpart = parm_xpart;
    BSIM3sheetResistance = parm_rsh;
    BSIM3jctSatCurDensity = parm_js;
    BSIM3jctSidewallSatCurDensity = parm_jsw;
    BSIM3bulkJctPotential = parm_pb;
    BSIM3bulkJctBotGradingCoeff = parm_mj;
    BSIM3sidewallJctPotential = parm_pbsw;
    BSIM3bulkJctSideGradingCoeff = parm_mjsw;
    BSIM3unitAreaJctCap = parm_cj;
    BSIM3unitLengthSidewallJctCap = parm_cjsw;
    BSIM3jctEmissionCoeff = parm_nj;
    BSIM3GatesidewallJctPotential = parm_pbswg;
    BSIM3bulkJctGateSideGradingCoeff = parm_mjswg;
    BSIM3unitLengthGateSidewallJctCap = parm_cjswg;
    BSIM3jctTempExponent = parm_xti;
    BSIM3Lint = parm_lint;
    BSIM3Ll = parm_ll;
    BSIM3Llc = parm_llc;
    BSIM3Lln = parm_lln;
    BSIM3Lw = parm_lw;
    BSIM3Lwc = parm_lwc;
    BSIM3Lwn = parm_lwn;
    BSIM3Lwl = parm_lwl;
    BSIM3Lwlc = parm_lwlc;
    BSIM3Lmin = parm_lmin;
    BSIM3Lmax = parm_lmax;
    BSIM3Wint = parm_wint;
    BSIM3Wl = parm_wl;
    BSIM3Wlc = parm_wlc;
    BSIM3Wln = parm_wln;
    BSIM3Ww = parm_ww;
    BSIM3Wwc = parm_wwc;
    BSIM3Wwn = parm_wwn;
    BSIM3Wwl = parm_wwl;
    BSIM3Wwlc = parm_wwlc;
    BSIM3Wmin = parm_wmin;
    BSIM3Wmax = parm_wmax;
    BSIM3oxideTrapDensityA = parm_noia;
    BSIM3oxideTrapDensityB = parm_noib;
    BSIM3oxideTrapDensityC = parm_noic;
    BSIM3em = parm_em;
    BSIM3ef = parm_ef;
    BSIM3af = parm_af;
    BSIM3kf = parm_kf;
    BSIM3l = parm_l;
    BSIM3w = parm_w;
    BSIM3type = parm_Type;
    if parm_vth0==-9999.9999
        BSIM3vth0Given = 0;
        BSIM3vth0 = qmcol_vapp(BSIM3type==1, 0.7, -0.7);
    else
        BSIM3vth0Given = 1;
    end
    if parm_k1==-9999.9999
        BSIM3k1Given = 0;
        BSIM3k1 = 0.53;
    else
        BSIM3k1Given = 1;
    end
    if parm_k2==-9999.9999
        BSIM3k2Given = 0;
        BSIM3k2 = -0.0186;
    else
        BSIM3k2Given = 1;
    end
    if parm_ijth==-9999.9999
        BSIM3ijth = 0.1;
    end
    if parm_uc==-9999.9999
        BSIM3uc = qmcol_vapp(BSIM3mobMod==3, -0.0465, -4.65e-11);
    end
    if parm_uc1==-9999.9999
        BSIM3uc1 = qmcol_vapp(BSIM3mobMod==3, -0.056, -5.6e-11);
    end
    if parm_u0==-9999.9999
        BSIM3u0 = qmcol_vapp(BSIM3type==1, 0.067, 0.025);
    end
    if parm_cf==-9999.9999
        BSIM3cf = ((2*3.4531e-11)/3.1416)*log10(1+4e-07/BSIM3tox);
    end
    if BSIM3dlc==-9999.9999
        BSIM3dlcGiven = 0;
        BSIM3dlc = BSIM3Lint;
    else
        BSIM3dlcGiven = 1;
    end
    BSIM3cox = 3.4531e-11/BSIM3tox;
    Cox = BSIM3cox;
    if parm_cgdo==-9999.9999
        if BSIM3dlc>0
                d_BSIM3cgdo_d_v_vgvb__ = 0;
                d_BSIM3cgdo_d_v_vdpvsp__ = 0;
                d_BSIM3cgdo_d_v_vbvsp__ = 0;
            BSIM3cgdo = BSIM3dlc*BSIM3cox-BSIM3cgdl;
        else
                d_BSIM3cgdo_d_v_vgvb__ = 0;
                d_BSIM3cgdo_d_v_vdpvsp__ = 0;
                d_BSIM3cgdo_d_v_vbvsp__ = 0;
            BSIM3cgdo = (0.6*BSIM3xj)*BSIM3cox;
        end
    end
    if BSIM3cgso==-9999.9999
        if BSIM3dlc>0
                d_BSIM3cgso_d_v_vgvb__ = 0;
                d_BSIM3cgso_d_v_vdpvsp__ = 0;
                d_BSIM3cgso_d_v_vbvsp__ = 0;
            BSIM3cgso = BSIM3dlc*BSIM3cox-BSIM3cgsl;
        else
                d_BSIM3cgso_d_v_vgvb__ = 0;
                d_BSIM3cgso_d_v_vdpvsp__ = 0;
                d_BSIM3cgso_d_v_vbvsp__ = 0;
            BSIM3cgso = (0.6*BSIM3xj)*BSIM3cox;
        end
    end
    if BSIM3cgbo==-9999.9999
        BSIM3cgbo = (2*BSIM3dwc)*BSIM3cox;
    end
    Tnom = BSIM3tnom;
    Temp = Tnom;
    TRatio = Temp/Tnom;
    BSIM3vcrit = 0.025864*log(0.025864/(sqrt(2)*1e-14));
    BSIM3factor1 = sqrt((1.0359e-10/3.4531e-11)*BSIM3tox);
    Vtm0 = 8.6171e-05*Tnom;
    Eg0 = 1.16-((0.000702*Tnom)*Tnom)/(Tnom+1108);
    ni = ((14500000000*(Tnom/300.15))*sqrt(Tnom/300.15))*exp(21.5566-Eg0/(2*Vtm0));
    BSIM3vtm = 8.6171e-05*Temp;
    Eg = 1.16-((0.000702*Temp)*Temp)/(Temp+1108);
    if Temp~=Tnom
            d_T0_d_v_vgvb__ = 0;
            d_T0_d_v_vdpvsp__ = 0;
            d_T0_d_v_vbvsp__ = 0;
        T0 = (Eg0/Vtm0-Eg/BSIM3vtm)+BSIM3jctTempExponent*log10(Temp/Tnom);
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = exp(T0/BSIM3jctEmissionCoeff);
        BSIM3jctTempSatCurDensity = BSIM3jctSatCurDensity*T1;
        BSIM3jctSidewallTempSatCurDensity = BSIM3jctSidewallSatCurDensity*T1;
    else
        BSIM3jctTempSatCurDensity = BSIM3jctSatCurDensity;
        BSIM3jctSidewallTempSatCurDensity = BSIM3jctSidewallSatCurDensity;
    end
    if BSIM3jctTempSatCurDensity<0
        BSIM3jctTempSatCurDensity = 0;
    end
    if BSIM3jctSidewallTempSatCurDensity<0
        BSIM3jctSidewallTempSatCurDensity = 0;
    end
    delTemp = (27+273.15)-BSIM3tnom;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = BSIM3tcj*delTemp;
    if T0>=-1
        BSIM3unitAreaTempJctCap = BSIM3unitAreaJctCap*(1+T0);
    else
        if BSIM3unitAreaJctCap>0
            BSIM3unitAreaTempJctCap = 0;
            sim_strobe_vapp('Temperature effect has caused cj to be negative. Cj is clamped to zero.\n');

        end
    end
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = BSIM3tcjsw*delTemp;
    if T0>=-1
        BSIM3unitLengthSidewallTempJctCap = BSIM3unitLengthSidewallJctCap*(1+T0);
    else
        if BSIM3unitLengthSidewallJctCap>0
            BSIM3unitLengthSidewallTempJctCap = 0;
            sim_strobe_vapp('Temperature effect has caused cjsw to be negative. Cjsw is clamped to zero.\n');

        end
    end
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = BSIM3tcjswg*delTemp;
    if T0>=-1
        BSIM3unitLengthGateSidewallTempJctCap = BSIM3unitLengthGateSidewallJctCap*(1+T0);
    else
        if BSIM3unitLengthGateSidewallJctCap>0
            BSIM3unitLengthGateSidewallTempJctCap = 0;
            sim_strobe_vapp('Temperature effect has caused cjswg to be negative. Cjswg is clamped to zero.\n');

        end
    end
    BSIM3PhiB = BSIM3bulkJctPotential-BSIM3tpb*delTemp;
    if BSIM3PhiB<0.01
        BSIM3PhiB = 0.01;
        sim_strobe_vapp('Temperature effect has caused pb to be less than 0.01. Pb is clamped to 0.01.\n');

    end
    BSIM3PhiBSW = BSIM3sidewallJctPotential-BSIM3tpbsw*delTemp;
    if BSIM3PhiBSW<=0.01
        BSIM3PhiBSW = 0.01;
        sim_strobe_vapp('Temperature effect has caused pbsw to be less than 0.01. Pbsw is clamped to 0.01.\n');

    end
    BSIM3PhiBSWG = BSIM3GatesidewallJctPotential-BSIM3tpbswg*delTemp;
    if BSIM3PhiBSWG<=0.01
        BSIM3PhiBSWG = 0.01;
        sim_strobe_vapp('Temperature effect has caused pbswg to be less than 0.01. Pbswg is clamped to 0.01.\n');

    end
    Ldrn = parm_l;
    Wdrn = parm_w;
    Length = Ldrn;
    Width = Wdrn;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = pow_vapp(Ldrn, BSIM3Lln);
        d_T1_d_v_vgvb__ = 0;
        d_T1_d_v_vdpvsp__ = 0;
        d_T1_d_v_vbvsp__ = 0;
    T1 = pow_vapp(Wdrn, BSIM3Lwn);
        d_tmp1_d_v_vdpvsp__ = 0;
        d_tmp1_d_v_vbvsp__ = 0;
    tmp1 = (BSIM3Ll/T0+BSIM3Lw/T1)+BSIM3Lwl/(T0*T1);
    BSIM3dl = BSIM3Lint+tmp1;
        d_tmp2_d_v_vgvb__ = 0;
        d_tmp2_d_v_vdpvsp__ = 0;
        d_tmp2_d_v_vbvsp__ = 0;
    tmp2 = (BSIM3Llc/T0+BSIM3Lwc/T1)+BSIM3Lwlc/(T0*T1);
    BSIM3dlc = BSIM3dlc+tmp2;
        d_T2_d_v_vgvb__ = 0;
        d_T2_d_v_vdpvsp__ = 0;
        d_T2_d_v_vbvsp__ = 0;
    T2 = pow_vapp(Ldrn, BSIM3Wln);
        d_T3_d_v_vgvb__ = 0;
        d_T3_d_v_vdpvsp__ = 0;
        d_T3_d_v_vbvsp__ = 0;
    T3 = pow_vapp(Wdrn, BSIM3Wwn);
        d_tmp1_d_v_vdpvsp__ = 0;
        d_tmp1_d_v_vbvsp__ = 0;
    tmp1 = (BSIM3Wl/T2+BSIM3Ww/T3)+BSIM3Wwl/(T2*T3);
    BSIM3dw = BSIM3Wint+tmp1;
        d_tmp2_d_v_vgvb__ = 0;
        d_tmp2_d_v_vdpvsp__ = 0;
        d_tmp2_d_v_vbvsp__ = 0;
    tmp2 = (BSIM3Wlc/T2+BSIM3Wwc/T3)+BSIM3Wwlc/(T2*T3);
    BSIM3dwc = BSIM3dwc+tmp2;
    BSIM3leff = BSIM3l-2*BSIM3dl;
    if BSIM3leff<=0
        sim_strobe_vapp('BSIM3: Effective channel length <= 0\n');

        sim_finish_vapp(-1)
    end
    BSIM3weff = BSIM3w-2*BSIM3dw;
    if BSIM3weff<=0
        sim_strobe_vapp('BSIM3: Effective channel width <= 0\n');

        sim_finish_vapp(-1)
    end
    BSIM3leffCV = BSIM3l-2*BSIM3dlc;
    if BSIM3leffCV<=0
        sim_strobe_vapp('BSIM3: Effective channel length for C-V <= 0\n');

        sim_finish_vapp(-1)
    end
    BSIM3weffCV = BSIM3w-2*BSIM3dwc;
    if BSIM3weffCV<=0
        sim_strobe_vapp('BSIM3: Effective channel width for C-V <= 0\n');

        sim_finish_vapp(-1)
    end
    if BSIM3binUnit==1
        Inv_L = 1e-06/BSIM3leff;
        Inv_W = 1e-06/BSIM3weff;
        Inv_LW = 1e-12/(BSIM3leff*BSIM3weff);
    else
        Inv_L = 1/BSIM3leff;
        Inv_W = 1/BSIM3weff;
        Inv_LW = 1/(BSIM3leff*BSIM3weff);
    end
    BSIM3cdsc = ((BSIM3cdsc+BSIM3lcdsc*Inv_L)+BSIM3wcdsc*Inv_W)+BSIM3pcdsc*Inv_LW;
    BSIM3cdscb = ((BSIM3cdscb+BSIM3lcdscb*Inv_L)+BSIM3wcdscb*Inv_W)+BSIM3pcdscb*Inv_LW;
    BSIM3cdscd = ((BSIM3cdscd+BSIM3lcdscd*Inv_L)+BSIM3wcdscd*Inv_W)+BSIM3pcdscd*Inv_LW;
    BSIM3cit = ((BSIM3cit+BSIM3lcit*Inv_L)+BSIM3wcit*Inv_W)+BSIM3pcit*Inv_LW;
    BSIM3nfactor = ((BSIM3nfactor+BSIM3lnfactor*Inv_L)+BSIM3wnfactor*Inv_W)+BSIM3pnfactor*Inv_LW;
    BSIM3xj = ((BSIM3xj+BSIM3lxj*Inv_L)+BSIM3wxj*Inv_W)+BSIM3pxj*Inv_LW;
    BSIM3vsat = ((BSIM3vsat+BSIM3lvsat*Inv_L)+BSIM3wvsat*Inv_W)+BSIM3pvsat*Inv_LW;
    BSIM3at = ((BSIM3at+BSIM3lat*Inv_L)+BSIM3wat*Inv_W)+BSIM3pat*Inv_LW;
    BSIM3a0 = ((BSIM3a0+BSIM3la0*Inv_L)+BSIM3wa0*Inv_W)+BSIM3pa0*Inv_LW;
    BSIM3ags = ((BSIM3ags+BSIM3lags*Inv_L)+BSIM3wags*Inv_W)+BSIM3pags*Inv_LW;
    BSIM3a1 = ((BSIM3a1+BSIM3la1*Inv_L)+BSIM3wa1*Inv_W)+BSIM3pa1*Inv_LW;
    BSIM3a2 = ((BSIM3a2+BSIM3la2*Inv_L)+BSIM3wa2*Inv_W)+BSIM3pa2*Inv_LW;
    BSIM3keta = ((BSIM3keta+BSIM3lketa*Inv_L)+BSIM3wketa*Inv_W)+BSIM3pketa*Inv_LW;
    BSIM3nsub = ((BSIM3nsub+BSIM3lnsub*Inv_L)+BSIM3wnsub*Inv_W)+BSIM3pnsub*Inv_LW;
    BSIM3npeak = ((BSIM3npeak+BSIM3lnpeak*Inv_L)+BSIM3wnpeak*Inv_W)+BSIM3pnpeak*Inv_LW;
    BSIM3ngate = ((BSIM3ngate+BSIM3lngate*Inv_L)+BSIM3wngate*Inv_W)+BSIM3pngate*Inv_LW;
    BSIM3gamma1 = ((BSIM3gamma1+BSIM3lgamma1*Inv_L)+BSIM3wgamma1*Inv_W)+BSIM3pgamma1*Inv_LW;
    BSIM3gamma2 = ((BSIM3gamma2+BSIM3lgamma2*Inv_L)+BSIM3wgamma2*Inv_W)+BSIM3pgamma2*Inv_LW;
    BSIM3vbx = ((BSIM3vbx+BSIM3lvbx*Inv_L)+BSIM3wvbx*Inv_W)+BSIM3pvbx*Inv_LW;
    BSIM3vbm = ((BSIM3vbm+BSIM3lvbm*Inv_L)+BSIM3wvbm*Inv_W)+BSIM3pvbm*Inv_LW;
    BSIM3xt = ((BSIM3xt+BSIM3lxt*Inv_L)+BSIM3wxt*Inv_W)+BSIM3pxt*Inv_LW;
    BSIM3vfb = ((BSIM3vfb+BSIM3lvfb*Inv_L)+BSIM3wvfb*Inv_W)+BSIM3pvfb*Inv_LW;
    BSIM3k1 = ((BSIM3k1+BSIM3lk1*Inv_L)+BSIM3wk1*Inv_W)+BSIM3pk1*Inv_LW;
    BSIM3kt1 = ((BSIM3kt1+BSIM3lkt1*Inv_L)+BSIM3wkt1*Inv_W)+BSIM3pkt1*Inv_LW;
    BSIM3kt1l = ((BSIM3kt1l+BSIM3lkt1l*Inv_L)+BSIM3wkt1l*Inv_W)+BSIM3pkt1l*Inv_LW;
    BSIM3k2 = ((BSIM3k2+BSIM3lk2*Inv_L)+BSIM3wk2*Inv_W)+BSIM3pk2*Inv_LW;
    BSIM3kt2 = ((BSIM3kt2+BSIM3lkt2*Inv_L)+BSIM3wkt2*Inv_W)+BSIM3pkt2*Inv_LW;
    BSIM3k3 = ((BSIM3k3+BSIM3lk3*Inv_L)+BSIM3wk3*Inv_W)+BSIM3pk3*Inv_LW;
    BSIM3k3b = ((BSIM3k3b+BSIM3lk3b*Inv_L)+BSIM3wk3b*Inv_W)+BSIM3pk3b*Inv_LW;
    BSIM3w0 = ((BSIM3w0+BSIM3lw0*Inv_L)+BSIM3ww0*Inv_W)+BSIM3pw0*Inv_LW;
    BSIM3nlx = ((BSIM3nlx+BSIM3lnlx*Inv_L)+BSIM3wnlx*Inv_W)+BSIM3pnlx*Inv_LW;
    BSIM3dvt0 = ((BSIM3dvt0+BSIM3ldvt0*Inv_L)+BSIM3wdvt0*Inv_W)+BSIM3pdvt0*Inv_LW;
    BSIM3dvt1 = ((BSIM3dvt1+BSIM3ldvt1*Inv_L)+BSIM3wdvt1*Inv_W)+BSIM3pdvt1*Inv_LW;
    BSIM3dvt2 = ((BSIM3dvt2+BSIM3ldvt2*Inv_L)+BSIM3wdvt2*Inv_W)+BSIM3pdvt2*Inv_LW;
    BSIM3dvt0w = ((BSIM3dvt0w+BSIM3ldvt0w*Inv_L)+BSIM3wdvt0w*Inv_W)+BSIM3pdvt0w*Inv_LW;
    BSIM3dvt1w = ((BSIM3dvt1w+BSIM3ldvt1w*Inv_L)+BSIM3wdvt1w*Inv_W)+BSIM3pdvt1w*Inv_LW;
    BSIM3dvt2w = ((BSIM3dvt2w+BSIM3ldvt2w*Inv_L)+BSIM3wdvt2w*Inv_W)+BSIM3pdvt2w*Inv_LW;
    BSIM3drout = ((BSIM3drout+BSIM3ldrout*Inv_L)+BSIM3wdrout*Inv_W)+BSIM3pdrout*Inv_LW;
    BSIM3dsub = ((BSIM3dsub+BSIM3ldsub*Inv_L)+BSIM3wdsub*Inv_W)+BSIM3pdsub*Inv_LW;
    BSIM3vth0 = ((BSIM3vth0+BSIM3lvth0*Inv_L)+BSIM3wvth0*Inv_W)+BSIM3pvth0*Inv_LW;
    BSIM3ua = ((BSIM3ua+BSIM3lua*Inv_L)+BSIM3wua*Inv_W)+BSIM3pua*Inv_LW;
    BSIM3ua1 = ((BSIM3ua1+BSIM3lua1*Inv_L)+BSIM3wua1*Inv_W)+BSIM3pua1*Inv_LW;
    BSIM3ub = ((BSIM3ub+BSIM3lub*Inv_L)+BSIM3wub*Inv_W)+BSIM3pub*Inv_LW;
    BSIM3ub1 = ((BSIM3ub1+BSIM3lub1*Inv_L)+BSIM3wub1*Inv_W)+BSIM3pub1*Inv_LW;
    BSIM3uc = ((BSIM3uc+BSIM3luc*Inv_L)+BSIM3wuc*Inv_W)+BSIM3puc*Inv_LW;
    BSIM3uc1 = ((BSIM3uc1+BSIM3luc1*Inv_L)+BSIM3wuc1*Inv_W)+BSIM3puc1*Inv_LW;
    BSIM3u0 = ((BSIM3u0+BSIM3lu0*Inv_L)+BSIM3wu0*Inv_W)+BSIM3pu0*Inv_LW;
    BSIM3ute = ((BSIM3ute+BSIM3lute*Inv_L)+BSIM3wute*Inv_W)+BSIM3pute*Inv_LW;
    BSIM3voff = ((BSIM3voff+BSIM3lvoff*Inv_L)+BSIM3wvoff*Inv_W)+BSIM3pvoff*Inv_LW;
    BSIM3delta = ((BSIM3delta+BSIM3ldelta*Inv_L)+BSIM3wdelta*Inv_W)+BSIM3pdelta*Inv_LW;
    BSIM3rdsw = ((BSIM3rdsw+BSIM3lrdsw*Inv_L)+BSIM3wrdsw*Inv_W)+BSIM3prdsw*Inv_LW;
    BSIM3prwg = ((BSIM3prwg+BSIM3lprwg*Inv_L)+BSIM3wprwg*Inv_W)+BSIM3pprwg*Inv_LW;
    BSIM3prwb = ((BSIM3prwb+BSIM3lprwb*Inv_L)+BSIM3wprwb*Inv_W)+BSIM3pprwb*Inv_LW;
    BSIM3prt = ((BSIM3prt+BSIM3lprt*Inv_L)+BSIM3wprt*Inv_W)+BSIM3pprt*Inv_LW;
    BSIM3eta0 = ((BSIM3eta0+BSIM3leta0*Inv_L)+BSIM3weta0*Inv_W)+BSIM3peta0*Inv_LW;
    BSIM3etab = ((BSIM3etab+BSIM3letab*Inv_L)+BSIM3wetab*Inv_W)+BSIM3petab*Inv_LW;
    BSIM3pclm = ((BSIM3pclm+BSIM3lpclm*Inv_L)+BSIM3wpclm*Inv_W)+BSIM3ppclm*Inv_LW;
    BSIM3pdibl1 = ((BSIM3pdibl1+BSIM3lpdibl1*Inv_L)+BSIM3wpdibl1*Inv_W)+BSIM3ppdibl1*Inv_LW;
    BSIM3pdibl2 = ((BSIM3pdibl2+BSIM3lpdibl2*Inv_L)+BSIM3wpdibl2*Inv_W)+BSIM3ppdibl2*Inv_LW;
    BSIM3pdiblb = ((BSIM3pdiblb+BSIM3lpdiblb*Inv_L)+BSIM3wpdiblb*Inv_W)+BSIM3ppdiblb*Inv_LW;
    BSIM3pscbe1 = ((BSIM3pscbe1+BSIM3lpscbe1*Inv_L)+BSIM3wpscbe1*Inv_W)+BSIM3ppscbe1*Inv_LW;
    BSIM3pscbe2 = ((BSIM3pscbe2+BSIM3lpscbe2*Inv_L)+BSIM3wpscbe2*Inv_W)+BSIM3ppscbe2*Inv_LW;
    BSIM3pvag = ((BSIM3pvag+BSIM3lpvag*Inv_L)+BSIM3wpvag*Inv_W)+BSIM3ppvag*Inv_LW;
    BSIM3wr = ((BSIM3wr+BSIM3lwr*Inv_L)+BSIM3wwr*Inv_W)+BSIM3pwr*Inv_LW;
    BSIM3dwg = ((BSIM3dwg+BSIM3ldwg*Inv_L)+BSIM3wdwg*Inv_W)+BSIM3pdwg*Inv_LW;
    BSIM3dwb = ((BSIM3dwb+BSIM3ldwb*Inv_L)+BSIM3wdwb*Inv_W)+BSIM3pdwb*Inv_LW;
    BSIM3b0 = ((BSIM3b0+BSIM3lb0*Inv_L)+BSIM3wb0*Inv_W)+BSIM3pb0*Inv_LW;
    BSIM3b1 = ((BSIM3b1+BSIM3lb1*Inv_L)+BSIM3wb1*Inv_W)+BSIM3pb1*Inv_LW;
    BSIM3alpha0 = ((BSIM3alpha0+BSIM3lalpha0*Inv_L)+BSIM3walpha0*Inv_W)+BSIM3palpha0*Inv_LW;
    BSIM3alpha1 = ((BSIM3alpha1+BSIM3lalpha1*Inv_L)+BSIM3walpha1*Inv_W)+BSIM3palpha1*Inv_LW;
    BSIM3beta0 = ((BSIM3beta0+BSIM3lbeta0*Inv_L)+BSIM3wbeta0*Inv_W)+BSIM3pbeta0*Inv_LW;
    BSIM3elm = ((BSIM3elm+BSIM3lelm*Inv_L)+BSIM3welm*Inv_W)+BSIM3pelm*Inv_LW;
    BSIM3cgsl = ((BSIM3cgsl+BSIM3lcgsl*Inv_L)+BSIM3wcgsl*Inv_W)+BSIM3pcgsl*Inv_LW;
    BSIM3cgdl = ((BSIM3cgdl+BSIM3lcgdl*Inv_L)+BSIM3wcgdl*Inv_W)+BSIM3pcgdl*Inv_LW;
    BSIM3ckappa = ((BSIM3ckappa+BSIM3lckappa*Inv_L)+BSIM3wckappa*Inv_W)+BSIM3pckappa*Inv_LW;
    BSIM3cf = ((BSIM3cf+BSIM3lcf*Inv_L)+BSIM3wcf*Inv_W)+BSIM3pcf*Inv_LW;
    BSIM3clc = ((BSIM3clc+BSIM3lclc*Inv_L)+BSIM3wclc*Inv_W)+BSIM3pclc*Inv_LW;
    BSIM3cle = ((BSIM3cle+BSIM3lcle*Inv_L)+BSIM3wcle*Inv_W)+BSIM3pcle*Inv_LW;
    BSIM3vfbcv = ((BSIM3vfbcv+BSIM3lvfbcv*Inv_L)+BSIM3wvfbcv*Inv_W)+BSIM3pvfbcv*Inv_LW;
    BSIM3acde = ((BSIM3acde+BSIM3lacde*Inv_L)+BSIM3wacde*Inv_W)+BSIM3pacde*Inv_LW;
    BSIM3moin = ((BSIM3moin+BSIM3lmoin*Inv_L)+BSIM3wmoin*Inv_W)+BSIM3pmoin*Inv_LW;
    BSIM3noff = ((BSIM3noff+BSIM3lnoff*Inv_L)+BSIM3wnoff*Inv_W)+BSIM3pnoff*Inv_LW;
    BSIM3voffcv = ((BSIM3voffcv+BSIM3lvoffcv*Inv_L)+BSIM3wvoffcv*Inv_W)+BSIM3pvoffcv*Inv_LW;
    BSIM3abulkCVfactor = 1+pow_vapp(BSIM3clc/BSIM3leffCV, BSIM3cle);
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = TRatio-1;
    BSIM3ua = BSIM3ua+BSIM3ua1*T0;
    BSIM3ub = BSIM3ub+BSIM3ub1*T0;
    BSIM3uc = BSIM3uc+BSIM3uc1*T0;
    if BSIM3u0>1
        BSIM3u0 = BSIM3u0/10000;
    end
    BSIM3u0temp = BSIM3u0*pow_vapp(TRatio, BSIM3ute);
    BSIM3vsattemp = BSIM3vsat-BSIM3at*T0;
    BSIM3rds0 = (BSIM3rdsw+BSIM3prt*T0)/pow_vapp(BSIM3weff*1000000, BSIM3wr);
        d_BSIM3cgdo_d_v_vgvb__ = 0;
        d_BSIM3cgdo_d_v_vdpvsp__ = 0;
        d_BSIM3cgdo_d_v_vbvsp__ = 0;
    BSIM3cgdo = (BSIM3cgdo+BSIM3cf)*BSIM3weffCV;
        d_BSIM3cgso_d_v_vgvb__ = 0;
        d_BSIM3cgso_d_v_vdpvsp__ = 0;
        d_BSIM3cgso_d_v_vbvsp__ = 0;
    BSIM3cgso = (BSIM3cgso+BSIM3cf)*BSIM3weffCV;
    BSIM3cgbo = BSIM3cgbo*BSIM3leffCV;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = BSIM3leffCV*BSIM3leffCV;
    BSIM3tconst = (BSIM3u0temp*BSIM3elm)/(((BSIM3cox*BSIM3weffCV)*BSIM3leffCV)*T0);
    if BSIM3npeak==-9999.9999&&BSIM3gamma1~=-9999.9999
            d_T0_d_v_vgvb__ = 0;
            d_T0_d_v_vdpvsp__ = 0;
            d_T0_d_v_vbvsp__ = 0;
        T0 = BSIM3gamma1*BSIM3cox;
        BSIM3npeak = (3.021e+22*T0)*T0;
    end
    BSIM3phi = (2*Vtm0)*log10(BSIM3npeak/ni);
    BSIM3sqrtPhi = sqrt(BSIM3phi);
    BSIM3phis3 = BSIM3sqrtPhi*BSIM3phi;
    BSIM3Xdep0 = sqrt((2*1.0359e-10)/((1.6022e-19*BSIM3npeak)*1000000))*BSIM3sqrtPhi;
    BSIM3sqrtXdep0 = sqrt(BSIM3Xdep0);
    BSIM3litl = sqrt((3*BSIM3xj)*BSIM3tox);
    BSIM3vbi = Vtm0*log10((1e+20*BSIM3npeak)/(ni*ni));
    BSIM3cdep0 = sqrt(((((1.6022e-19*1.0359e-10)*BSIM3npeak)*1000000)/2)/BSIM3phi);
    BSIM3ldeb = sqrt((1.0359e-10*Vtm0)/((1.6022e-19*BSIM3npeak)*1000000))/3;
    BSIM3acde = BSIM3acde*pow_vapp(BSIM3npeak/2e+16, -0.25);
    if BSIM3k1Given||BSIM3k2Given
        if ~BSIM3k1Given
            sim_strobe_vapp('Warning: k1 should be specified with k2.\n');

            BSIM3k1 = 0.53;
        end
        if ~BSIM3k2Given
            sim_strobe_vapp('Warning: k2 should be specified with k1.\n');

            BSIM3k2 = -0.0186;
        end
        if BSIM3nsubGiven
            sim_strobe_vapp('Warning: nsub is ignored because k1 or k2 is given.\n');

        end
        if BSIM3xtGiven
            sim_strobe_vapp('Warning: xt is ignored because k1 or k2 is given.\n');

        end
        if BSIM3vbxGiven
            sim_strobe_vapp('Warning: vbx is ignored because k1 or k2 is given.\n');

        end
        if BSIM3gamma1Given
            sim_strobe_vapp('Warning: gamma1 is ignored because k1 or k2 is given.\n');

        end
        if BSIM3gamma2Given
            sim_strobe_vapp('Warning: gamma2 is ignored because k1 or k2 is given.\n');

        end
    else
        if ~BSIM3vbxGiven
            BSIM3vbx = BSIM3phi-((0.00077348*BSIM3npeak)*BSIM3xt)*BSIM3xt;
        end
        if BSIM3vbx>0
            BSIM3vbx = -BSIM3vbx;
        end
        if BSIM3vbm>0
            BSIM3vbm = -BSIM3vbm;
        end
        if BSIM3gamma1==-9999.9999
            BSIM3gamma1 = (5.753e-12*sqrt(BSIM3npeak))/BSIM3cox;
        end
        if BSIM3gamma2==-9999.9999
            BSIM3gamma2 = (5.753e-12*sqrt(BSIM3nsub))/BSIM3cox;
        end
            d_T0_d_v_vgvb__ = 0;
            d_T0_d_v_vdpvsp__ = 0;
            d_T0_d_v_vbvsp__ = 0;
        T0 = BSIM3gamma1-BSIM3gamma2;
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = sqrt(BSIM3phi-BSIM3vbx)-BSIM3sqrtPhi;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = 0;
            d_T2_d_v_vbvsp__ = 0;
        T2 = sqrt(BSIM3phi*(BSIM3phi-BSIM3vbm))-BSIM3phi;
        BSIM3k2 = (T0*T1)/(2*T2+BSIM3vbm);
        BSIM3k1 = BSIM3gamma2-(2*BSIM3k2)*sqrt(BSIM3phi-BSIM3vbm);
    end
    if BSIM3k2<0
            d_T0_d_v_vgvb__ = 0;
            d_T0_d_v_vdpvsp__ = 0;
            d_T0_d_v_vbvsp__ = 0;
        T0 = (0.5*BSIM3k1)/BSIM3k2;
        BSIM3vbsc = 0.9*(BSIM3phi-T0*T0);
        if BSIM3vbsc>-3
            BSIM3vbsc = -3;
        else
            if BSIM3vbsc<-30
                BSIM3vbsc = -30;
            end
        end
    else
        BSIM3vbsc = -30;
    end
    if BSIM3vbsc>BSIM3vbm
        BSIM3vbsc = BSIM3vbm;
    end
    if ~BSIM3vfbGiven
        if BSIM3vth0Given
            BSIM3vfb = (BSIM3type*BSIM3vth0-BSIM3phi)-BSIM3k1*BSIM3sqrtPhi;
        else
            BSIM3vfb = -1;
        end
    end
    if ~BSIM3vth0Given
        BSIM3vth0 = BSIM3type*((BSIM3vfb+BSIM3phi)+BSIM3k1*BSIM3sqrtPhi);
    end
    BSIM3k1ox = (BSIM3k1*BSIM3tox)/BSIM3toxm;
    BSIM3k2ox = (BSIM3k2*BSIM3tox)/BSIM3toxm;
        d_T1_d_v_vgvb__ = 0;
        d_T1_d_v_vdpvsp__ = 0;
        d_T1_d_v_vbvsp__ = 0;
    T1 = sqrt(((1.0359e-10/3.4531e-11)*BSIM3tox)*BSIM3Xdep0);
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = exp(((-0.5*BSIM3dsub)*BSIM3leff)/T1);
    BSIM3theta0vb0 = T0+(2*T0)*T0;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = exp(((-0.5*BSIM3drout)*BSIM3leff)/T1);
        d_T2_d_v_vgvb__ = 0;
        d_T2_d_v_vdpvsp__ = 0;
        d_T2_d_v_vbvsp__ = 0;
    T2 = T0+(2*T0)*T0;
    BSIM3thetaRout = BSIM3pdibl1*T2+BSIM3pdibl2;
        d_tmp_d_v_vgvb__ = 0;
        d_tmp_d_v_vdpvsp__ = 0;
        d_tmp_d_v_vbvsp__ = 0;
    tmp = sqrt(BSIM3Xdep0);
        d_tmp1_d_v_vdpvsp__ = 0;
        d_tmp1_d_v_vbvsp__ = 0;
    tmp1 = BSIM3vbi-BSIM3phi;
        d_tmp2_d_v_vgvb__ = 0;
        d_tmp2_d_v_vdpvsp__ = 0;
        d_tmp2_d_v_vbvsp__ = 0;
    tmp2 = BSIM3factor1*tmp;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = (((-0.5*BSIM3dvt1w)*BSIM3weff)*BSIM3leff)/tmp2;
    if T0>-34
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = exp(T0);
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = 0;
            d_T2_d_v_vbvsp__ = 0;
        T2 = T1*(1+2*T1);
    else
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = 1.7139e-15;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = 0;
            d_T2_d_v_vbvsp__ = 0;
        T2 = T1*(1+2*T1);
    end
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = BSIM3dvt0w*T2;
        d_T2_d_v_vgvb__ = 0;
        d_T2_d_v_vdpvsp__ = 0;
        d_T2_d_v_vbvsp__ = 0;
    T2 = T0*tmp1;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = ((-0.5*BSIM3dvt1)*BSIM3leff)/tmp2;
    if T0>-34
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = exp(T0);
            d_T3_d_v_vgvb__ = 0;
            d_T3_d_v_vdpvsp__ = 0;
            d_T3_d_v_vbvsp__ = 0;
        T3 = T1*(1+2*T1);
    else
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = 1.7139e-15;
            d_T3_d_v_vgvb__ = 0;
            d_T3_d_v_vdpvsp__ = 0;
            d_T3_d_v_vbvsp__ = 0;
        T3 = T1*(1+2*T1);
    end
        d_T3_d_v_vgvb__ = 0;
        d_T3_d_v_vdpvsp__ = 0;
        d_T3_d_v_vbvsp__ = 0;
    T3 = (BSIM3dvt0*T3)*tmp1;
        d_T4_d_v_vgvb__ = 0;
        d_T4_d_v_vdpvsp__ = 0;
        d_T4_d_v_vbvsp__ = 0;
    T4 = (BSIM3tox*BSIM3phi)/(BSIM3weff+BSIM3w0);
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = sqrt(1+BSIM3nlx/BSIM3leff);
        d_T5_d_v_vgvb__ = 0;
        d_T5_d_v_vdpvsp__ = 0;
        d_T5_d_v_vbvsp__ = 0;
    T5 = (BSIM3k1ox*(T0-1))*BSIM3sqrtPhi+(BSIM3kt1+BSIM3kt1l/BSIM3leff)*(TRatio-1);
        d_tmp3_d_v_vgvb__ = 0;
        d_tmp3_d_v_vdpvsp__ = 0;
        d_tmp3_d_v_vbvsp__ = 0;
    tmp3 = (((BSIM3type*BSIM3vth0-T2)-T3)+BSIM3k3*T4)+T5;
    BSIM3vfbzb = (tmp3-BSIM3phi)-BSIM3k1*BSIM3sqrtPhi;
    BSIM3drainConductance = BSIM3sheetResistance*BSIM3drainSquares;
    if BSIM3drainConductance>0
        BSIM3drainConductance = 1/BSIM3drainConductance;
    else
        BSIM3drainConductance = 0;
    end
    BSIM3sourceConductance = BSIM3sheetResistance*BSIM3sourceSquares;
    if BSIM3sourceConductance>0
        BSIM3sourceConductance = 1/BSIM3sourceConductance;
    else
        BSIM3sourceConductance = 0;
    end
    Nvtm = BSIM3vtm*BSIM3jctEmissionCoeff;
    if BSIM3sourceArea<=0&&BSIM3sourcePerimeter<=0
        SourceSatCurrent = 1e-14;
    else
        SourceSatCurrent = BSIM3sourceArea*BSIM3jctTempSatCurDensity+BSIM3sourcePerimeter*BSIM3jctSidewallTempSatCurDensity;
    end
    if SourceSatCurrent>0&&BSIM3ijth>0
        BSIM3vjsm = Nvtm*log10(BSIM3ijth/SourceSatCurrent+1);
        BSIM3IsEvjsm = SourceSatCurrent*exp(BSIM3vjsm/Nvtm);
    end
    if BSIM3drainArea<=0&&BSIM3drainPerimeter<=0
        DrainSatCurrent = 1e-14;
    else
        DrainSatCurrent = BSIM3drainArea*BSIM3jctTempSatCurDensity+BSIM3drainPerimeter*BSIM3jctSidewallTempSatCurDensity;
    end
    if DrainSatCurrent>0&&BSIM3ijth>0
        BSIM3vjdm = Nvtm*log10(BSIM3ijth/DrainSatCurrent+1);
        BSIM3IsEvjdm = DrainSatCurrent*exp(BSIM3vjdm/Nvtm);
    end
        d_vds_d_v_vdpvsp__ = BSIM3type*1;
    vds = BSIM3type*v_vdpvsp__;
        d_vbs_d_v_vbvsp__ = BSIM3type*1;
    vbs = BSIM3type*v_vbvsp__;
        d_vgs_d_v_vgvb__ = BSIM3type*d_v_vgvsp_d_v_vgvb__;
        d_vgs_d_v_vbvsp__ = BSIM3type*d_v_vgvsp_d_v_vbvsp__;
    vgs = BSIM3type*v_vgvsp__;
        d_vbd_d_v_vdpvsp__ = -d_vds_d_v_vdpvsp__;
        d_vbd_d_v_vbvsp__ = d_vbs_d_v_vbvsp__;
    vbd = vbs-vds;
        d_vgd_d_v_vgvb__ = d_vgs_d_v_vgvb__;
        d_vgd_d_v_vdpvsp__ = -d_vds_d_v_vdpvsp__;
        d_vgd_d_v_vbvsp__ = d_vgs_d_v_vbvsp__;
    vgd = vgs-vds;
        d_vgb_d_v_vgvb__ = d_vgs_d_v_vgvb__;
        d_vgb_d_v_vbvsp__ = d_vgs_d_v_vbvsp__-d_vbs_d_v_vbvsp__;
    vgb = vgs-vbs;
    Nvtm = BSIM3vtm*BSIM3jctEmissionCoeff;
    if BSIM3sourceArea<=0&&BSIM3sourcePerimeter<=0
        SourceSatCurrent = 1e-14;
    else
        SourceSatCurrent = BSIM3sourceArea*BSIM3jctTempSatCurDensity+BSIM3sourcePerimeter*BSIM3jctSidewallTempSatCurDensity;
    end
    if SourceSatCurrent<=0
            d_BSIM3cbs_d_v_vbvsp__ = 1e-12*d_vbs_d_v_vbvsp__;
        BSIM3cbs = 1e-12*vbs;
    else
        if BSIM3ijth==0
                d_evbs_d_v_vbvsp__ = exp(vbs/Nvtm)*(d_vbs_d_v_vbvsp__/Nvtm);
            evbs = exp(vbs/Nvtm);
                d_BSIM3cbs_d_v_vbvsp__ = (SourceSatCurrent*(d_evbs_d_v_vbvsp__))+(1e-12*d_vbs_d_v_vbvsp__);
            BSIM3cbs = SourceSatCurrent*(evbs-1)+1e-12*vbs;
        else
            if vbs<BSIM3vjsm
                    d_evbs_d_v_vbvsp__ = exp(vbs/Nvtm)*(d_vbs_d_v_vbvsp__/Nvtm);
                evbs = exp(vbs/Nvtm);
                    d_BSIM3cbs_d_v_vbvsp__ = (SourceSatCurrent*(d_evbs_d_v_vbvsp__))+(1e-12*d_vbs_d_v_vbvsp__);
                BSIM3cbs = SourceSatCurrent*(evbs-1)+1e-12*vbs;
            else
                    d_T0_d_v_vgvb__ = 0;
                    d_T0_d_v_vdpvsp__ = 0;
                    d_T0_d_v_vbvsp__ = 0;
                T0 = BSIM3IsEvjsm/Nvtm;
                    d_BSIM3cbs_d_v_vbvsp__ = ((T0*(d_vbs_d_v_vbvsp__)+d_T0_d_v_vbvsp__*(vbs-BSIM3vjsm)))+(1e-12*d_vbs_d_v_vbvsp__);
                BSIM3cbs = ((BSIM3IsEvjsm-SourceSatCurrent)+T0*(vbs-BSIM3vjsm))+1e-12*vbs;
            end
        end
    end
    if BSIM3drainArea<=0&&BSIM3drainPerimeter<=0
        DrainSatCurrent = 1e-14;
    else
        DrainSatCurrent = BSIM3drainArea*BSIM3jctTempSatCurDensity+BSIM3drainPerimeter*BSIM3jctSidewallTempSatCurDensity;
    end
    if DrainSatCurrent<=0
        BSIM3gbd = 1e-12;
            d_BSIM3cbd_d_v_vdpvsp__ = BSIM3gbd*d_vbd_d_v_vdpvsp__;
            d_BSIM3cbd_d_v_vbvsp__ = BSIM3gbd*d_vbd_d_v_vbvsp__;
        BSIM3cbd = BSIM3gbd*vbd;
    else
        if BSIM3ijth==0
                d_evbd_d_v_vdpvsp__ = exp(vbd/Nvtm)*(d_vbd_d_v_vdpvsp__/Nvtm);
                d_evbd_d_v_vbvsp__ = exp(vbd/Nvtm)*(d_vbd_d_v_vbvsp__/Nvtm);
            evbd = exp(vbd/Nvtm);
                d_BSIM3cbd_d_v_vdpvsp__ = (DrainSatCurrent*(d_evbd_d_v_vdpvsp__))+(1e-12*d_vbd_d_v_vdpvsp__);
                d_BSIM3cbd_d_v_vbvsp__ = (DrainSatCurrent*(d_evbd_d_v_vbvsp__))+(1e-12*d_vbd_d_v_vbvsp__);
            BSIM3cbd = DrainSatCurrent*(evbd-1)+1e-12*vbd;
        else
            if vbd<BSIM3vjdm
                    d_evbd_d_v_vdpvsp__ = exp(vbd/Nvtm)*(d_vbd_d_v_vdpvsp__/Nvtm);
                    d_evbd_d_v_vbvsp__ = exp(vbd/Nvtm)*(d_vbd_d_v_vbvsp__/Nvtm);
                evbd = exp(vbd/Nvtm);
                    d_BSIM3cbd_d_v_vdpvsp__ = (DrainSatCurrent*(d_evbd_d_v_vdpvsp__))+(1e-12*d_vbd_d_v_vdpvsp__);
                    d_BSIM3cbd_d_v_vbvsp__ = (DrainSatCurrent*(d_evbd_d_v_vbvsp__))+(1e-12*d_vbd_d_v_vbvsp__);
                BSIM3cbd = DrainSatCurrent*(evbd-1)+1e-12*vbd;
            else
                    d_T0_d_v_vgvb__ = 0;
                    d_T0_d_v_vdpvsp__ = 0;
                    d_T0_d_v_vbvsp__ = 0;
                T0 = BSIM3IsEvjdm/Nvtm;
                    d_BSIM3cbd_d_v_vdpvsp__ = ((T0*(d_vbd_d_v_vdpvsp__)+d_T0_d_v_vdpvsp__*(vbd-BSIM3vjdm)))+(1e-12*d_vbd_d_v_vdpvsp__);
                    d_BSIM3cbd_d_v_vbvsp__ = ((T0*(d_vbd_d_v_vbvsp__)+d_T0_d_v_vbvsp__*(vbd-BSIM3vjdm)))+(1e-12*d_vbd_d_v_vbvsp__);
                BSIM3cbd = ((BSIM3IsEvjdm-DrainSatCurrent)+T0*(vbd-BSIM3vjdm))+1e-12*vbd;
            end
        end
    end
    if vds>=0
            d_BSIM3mode_d_v_vdpvsp__ = 0;
        BSIM3mode = 1;
            d_Vds_d_v_vdpvsp__ = d_vds_d_v_vdpvsp__;
        Vds = vds;
            d_Vgs_d_v_vgvb__ = d_vgs_d_v_vgvb__;
            d_Vgs_d_v_vdpvsp__ = 0;
            d_Vgs_d_v_vbvsp__ = d_vgs_d_v_vbvsp__;
        Vgs = vgs;
            d_Vbs_d_v_vdpvsp__ = 0;
            d_Vbs_d_v_vbvsp__ = d_vbs_d_v_vbvsp__;
        Vbs = vbs;
    else
            d_BSIM3mode_d_v_vdpvsp__ = 0;
        BSIM3mode = -1;
            d_Vds_d_v_vdpvsp__ = -d_vds_d_v_vdpvsp__;
        Vds = -vds;
            d_Vgs_d_v_vgvb__ = d_vgd_d_v_vgvb__;
            d_Vgs_d_v_vdpvsp__ = d_vgd_d_v_vdpvsp__;
            d_Vgs_d_v_vbvsp__ = d_vgd_d_v_vbvsp__;
        Vgs = vgd;
            d_Vbs_d_v_vdpvsp__ = d_vbd_d_v_vdpvsp__;
            d_Vbs_d_v_vbvsp__ = d_vbd_d_v_vbvsp__;
        Vbs = vbd;
    end
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = (d_Vbs_d_v_vdpvsp__);
        d_T0_d_v_vbvsp__ = (d_Vbs_d_v_vbvsp__);
    T0 = (Vbs-BSIM3vbsc)-0.001;
        d_T1_d_v_vgvb__ = 0;
        d_T1_d_v_vdpvsp__ = (1/(2*sqrt(T0*T0-0.004*BSIM3vbsc)))*((T0*d_T0_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T0));
        d_T1_d_v_vbvsp__ = (1/(2*sqrt(T0*T0-0.004*BSIM3vbsc)))*((T0*d_T0_d_v_vbvsp__+d_T0_d_v_vbvsp__*T0));
    T1 = sqrt(T0*T0-0.004*BSIM3vbsc);
        d_Vbseff_d_v_vdpvsp__ = (0.5*(d_T0_d_v_vdpvsp__+d_T1_d_v_vdpvsp__));
        d_Vbseff_d_v_vbvsp__ = (0.5*(d_T0_d_v_vbvsp__+d_T1_d_v_vbvsp__));
    Vbseff = BSIM3vbsc+0.5*(T0+T1);
    if Vbseff<Vbs
            d_Vbseff_d_v_vdpvsp__ = d_Vbs_d_v_vdpvsp__;
            d_Vbseff_d_v_vbvsp__ = d_Vbs_d_v_vbvsp__;
        Vbseff = Vbs;
    end
    if Vbseff>0
            d_T0_d_v_vgvb__ = 0;
            d_T0_d_v_vdpvsp__ = -(BSIM3phi*(d_Vbseff_d_v_vdpvsp__))/(BSIM3phi+Vbseff)^2;
            d_T0_d_v_vbvsp__ = -(BSIM3phi*(d_Vbseff_d_v_vbvsp__))/(BSIM3phi+Vbseff)^2;
        T0 = BSIM3phi/(BSIM3phi+Vbseff);
            d_Phis_d_v_vdpvsp__ = BSIM3phi*d_T0_d_v_vdpvsp__;
            d_Phis_d_v_vbvsp__ = BSIM3phi*d_T0_d_v_vbvsp__;
        Phis = BSIM3phi*T0;
            d_sqrtPhis_d_v_vdpvsp__ = -(BSIM3phis3*((0.5*d_Vbseff_d_v_vdpvsp__)))/(BSIM3phi+0.5*Vbseff)^2;
            d_sqrtPhis_d_v_vbvsp__ = -(BSIM3phis3*((0.5*d_Vbseff_d_v_vbvsp__)))/(BSIM3phi+0.5*Vbseff)^2;
        sqrtPhis = BSIM3phis3/(BSIM3phi+0.5*Vbseff);
    else
            d_Phis_d_v_vdpvsp__ = -d_Vbseff_d_v_vdpvsp__;
            d_Phis_d_v_vbvsp__ = -d_Vbseff_d_v_vbvsp__;
        Phis = BSIM3phi-Vbseff;
            d_sqrtPhis_d_v_vdpvsp__ = (1/(2*sqrt(Phis)))*d_Phis_d_v_vdpvsp__;
            d_sqrtPhis_d_v_vbvsp__ = (1/(2*sqrt(Phis)))*d_Phis_d_v_vbvsp__;
        sqrtPhis = sqrt(Phis);
    end
        d_Xdep_d_v_vdpvsp__ = (BSIM3Xdep0*d_sqrtPhis_d_v_vdpvsp__)/BSIM3sqrtPhi;
        d_Xdep_d_v_vbvsp__ = (BSIM3Xdep0*d_sqrtPhis_d_v_vbvsp__)/BSIM3sqrtPhi;
    Xdep = (BSIM3Xdep0*sqrtPhis)/BSIM3sqrtPhi;
    Leff = BSIM3leff;
    Vtm = BSIM3vtm;
        d_T3_d_v_vgvb__ = 0;
        d_T3_d_v_vdpvsp__ = (1/(2*sqrt(Xdep)))*d_Xdep_d_v_vdpvsp__;
        d_T3_d_v_vbvsp__ = (1/(2*sqrt(Xdep)))*d_Xdep_d_v_vbvsp__;
    T3 = sqrt(Xdep);
    V0 = BSIM3vbi-BSIM3phi;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = BSIM3dvt2*d_Vbseff_d_v_vdpvsp__;
        d_T0_d_v_vbvsp__ = BSIM3dvt2*d_Vbseff_d_v_vbvsp__;
    T0 = BSIM3dvt2*Vbseff;
    if T0>=-0.5
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__;
            d_T1_d_v_vbvsp__ = d_T0_d_v_vbvsp__;
        T1 = 1+T0;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = 0;
            d_T2_d_v_vbvsp__ = 0;
        T2 = BSIM3dvt2;
    else
            d_T4_d_v_vgvb__ = 0;
            d_T4_d_v_vdpvsp__ = -(1*((8*d_T0_d_v_vdpvsp__)))/(3+8*T0)^2;
            d_T4_d_v_vbvsp__ = -(1*((8*d_T0_d_v_vbvsp__)))/(3+8*T0)^2;
        T4 = 1/(3+8*T0);
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = (1+3*T0)*d_T4_d_v_vdpvsp__+((3*d_T0_d_v_vdpvsp__))*T4;
            d_T1_d_v_vbvsp__ = (1+3*T0)*d_T4_d_v_vbvsp__+((3*d_T0_d_v_vbvsp__))*T4;
        T1 = (1+3*T0)*T4;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = (BSIM3dvt2*T4)*d_T4_d_v_vdpvsp__+(BSIM3dvt2*d_T4_d_v_vdpvsp__)*T4;
            d_T2_d_v_vbvsp__ = (BSIM3dvt2*T4)*d_T4_d_v_vbvsp__+(BSIM3dvt2*d_T4_d_v_vbvsp__)*T4;
        T2 = (BSIM3dvt2*T4)*T4;
    end
        d_lt1_d_v_vdpvsp__ = (BSIM3factor1*T3)*d_T1_d_v_vdpvsp__+(BSIM3factor1*d_T3_d_v_vdpvsp__)*T1;
        d_lt1_d_v_vbvsp__ = (BSIM3factor1*T3)*d_T1_d_v_vbvsp__+(BSIM3factor1*d_T3_d_v_vbvsp__)*T1;
    lt1 = (BSIM3factor1*T3)*T1;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = BSIM3dvt2w*d_Vbseff_d_v_vdpvsp__;
        d_T0_d_v_vbvsp__ = BSIM3dvt2w*d_Vbseff_d_v_vbvsp__;
    T0 = BSIM3dvt2w*Vbseff;
    if T0>=-0.5
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__;
            d_T1_d_v_vbvsp__ = d_T0_d_v_vbvsp__;
        T1 = 1+T0;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = 0;
            d_T2_d_v_vbvsp__ = 0;
        T2 = BSIM3dvt2w;
    else
            d_T4_d_v_vgvb__ = 0;
            d_T4_d_v_vdpvsp__ = -(1*((8*d_T0_d_v_vdpvsp__)))/(3+8*T0)^2;
            d_T4_d_v_vbvsp__ = -(1*((8*d_T0_d_v_vbvsp__)))/(3+8*T0)^2;
        T4 = 1/(3+8*T0);
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = (1+3*T0)*d_T4_d_v_vdpvsp__+((3*d_T0_d_v_vdpvsp__))*T4;
            d_T1_d_v_vbvsp__ = (1+3*T0)*d_T4_d_v_vbvsp__+((3*d_T0_d_v_vbvsp__))*T4;
        T1 = (1+3*T0)*T4;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = (BSIM3dvt2w*T4)*d_T4_d_v_vdpvsp__+(BSIM3dvt2w*d_T4_d_v_vdpvsp__)*T4;
            d_T2_d_v_vbvsp__ = (BSIM3dvt2w*T4)*d_T4_d_v_vbvsp__+(BSIM3dvt2w*d_T4_d_v_vbvsp__)*T4;
        T2 = (BSIM3dvt2w*T4)*T4;
    end
        d_ltw_d_v_vdpvsp__ = (BSIM3factor1*T3)*d_T1_d_v_vdpvsp__+(BSIM3factor1*d_T3_d_v_vdpvsp__)*T1;
        d_ltw_d_v_vbvsp__ = (BSIM3factor1*T3)*d_T1_d_v_vbvsp__+(BSIM3factor1*d_T3_d_v_vbvsp__)*T1;
    ltw = (BSIM3factor1*T3)*T1;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = -(((-0.5*BSIM3dvt1)*Leff)*d_lt1_d_v_vdpvsp__)/lt1^2;
        d_T0_d_v_vbvsp__ = -(((-0.5*BSIM3dvt1)*Leff)*d_lt1_d_v_vbvsp__)/lt1^2;
    T0 = ((-0.5*BSIM3dvt1)*Leff)/lt1;
    if T0>-34
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = exp(T0)*d_T0_d_v_vdpvsp__;
            d_T1_d_v_vbvsp__ = exp(T0)*d_T0_d_v_vbvsp__;
        T1 = exp(T0);
            d_Theta0_d_v_vdpvsp__ = T1*((2*d_T1_d_v_vdpvsp__))+d_T1_d_v_vdpvsp__*(1+2*T1);
            d_Theta0_d_v_vbvsp__ = T1*((2*d_T1_d_v_vbvsp__))+d_T1_d_v_vbvsp__*(1+2*T1);
        Theta0 = T1*(1+2*T1);
    else
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = 1.7139e-15;
            d_Theta0_d_v_vdpvsp__ = T1*((2*d_T1_d_v_vdpvsp__))+d_T1_d_v_vdpvsp__*(1+2*T1);
            d_Theta0_d_v_vbvsp__ = T1*((2*d_T1_d_v_vbvsp__))+d_T1_d_v_vbvsp__*(1+2*T1);
        Theta0 = T1*(1+2*T1);
    end
        d_BSIM3thetavth_d_v_vdpvsp__ = BSIM3dvt0*d_Theta0_d_v_vdpvsp__;
        d_BSIM3thetavth_d_v_vbvsp__ = BSIM3dvt0*d_Theta0_d_v_vbvsp__;
    BSIM3thetavth = BSIM3dvt0*Theta0;
        d_Delt_vth_d_v_vdpvsp__ = d_BSIM3thetavth_d_v_vdpvsp__*V0;
        d_Delt_vth_d_v_vbvsp__ = d_BSIM3thetavth_d_v_vbvsp__*V0;
    Delt_vth = BSIM3thetavth*V0;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = -((((-0.5*BSIM3dvt1w)*BSIM3weff)*Leff)*d_ltw_d_v_vdpvsp__)/ltw^2;
        d_T0_d_v_vbvsp__ = -((((-0.5*BSIM3dvt1w)*BSIM3weff)*Leff)*d_ltw_d_v_vbvsp__)/ltw^2;
    T0 = (((-0.5*BSIM3dvt1w)*BSIM3weff)*Leff)/ltw;
    if T0>-34
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = exp(T0)*d_T0_d_v_vdpvsp__;
            d_T1_d_v_vbvsp__ = exp(T0)*d_T0_d_v_vbvsp__;
        T1 = exp(T0);
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = T1*((2*d_T1_d_v_vdpvsp__))+d_T1_d_v_vdpvsp__*(1+2*T1);
            d_T2_d_v_vbvsp__ = T1*((2*d_T1_d_v_vbvsp__))+d_T1_d_v_vbvsp__*(1+2*T1);
        T2 = T1*(1+2*T1);
    else
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = 1.7139e-15;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = T1*((2*d_T1_d_v_vdpvsp__))+d_T1_d_v_vdpvsp__*(1+2*T1);
            d_T2_d_v_vbvsp__ = T1*((2*d_T1_d_v_vbvsp__))+d_T1_d_v_vbvsp__*(1+2*T1);
        T2 = T1*(1+2*T1);
    end
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = BSIM3dvt0w*d_T2_d_v_vdpvsp__;
        d_T0_d_v_vbvsp__ = BSIM3dvt0w*d_T2_d_v_vbvsp__;
    T0 = BSIM3dvt0w*T2;
        d_T2_d_v_vgvb__ = 0;
        d_T2_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__*V0;
        d_T2_d_v_vbvsp__ = d_T0_d_v_vbvsp__*V0;
    T2 = T0*V0;
    TempRatio = (27+273.15)/BSIM3tnom-1;
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = sqrt(1+BSIM3nlx/Leff);
        d_T1_d_v_vgvb__ = 0;
        d_T1_d_v_vdpvsp__ = ((BSIM3k1ox*(d_T0_d_v_vdpvsp__))*BSIM3sqrtPhi)+(((BSIM3kt2*d_Vbseff_d_v_vdpvsp__))*TempRatio);
        d_T1_d_v_vbvsp__ = ((BSIM3k1ox*(d_T0_d_v_vbvsp__))*BSIM3sqrtPhi)+(((BSIM3kt2*d_Vbseff_d_v_vbvsp__))*TempRatio);
    T1 = (BSIM3k1ox*(T0-1))*BSIM3sqrtPhi+((BSIM3kt1+BSIM3kt1l/Leff)+BSIM3kt2*Vbseff)*TempRatio;
        d_tmp2_d_v_vgvb__ = 0;
        d_tmp2_d_v_vdpvsp__ = 0;
        d_tmp2_d_v_vbvsp__ = 0;
    tmp2 = (BSIM3tox*BSIM3phi)/(BSIM3weff+BSIM3w0);
        d_T3_d_v_vgvb__ = 0;
        d_T3_d_v_vdpvsp__ = (BSIM3etab*d_Vbseff_d_v_vdpvsp__);
        d_T3_d_v_vbvsp__ = (BSIM3etab*d_Vbseff_d_v_vbvsp__);
    T3 = BSIM3eta0+BSIM3etab*Vbseff;
    if T3<0.0001
            d_T9_d_v_vgvb__ = 0;
            d_T9_d_v_vdpvsp__ = -(1*(-(20000*d_T3_d_v_vdpvsp__)))/(3-20000*T3)^2;
            d_T9_d_v_vbvsp__ = -(1*(-(20000*d_T3_d_v_vbvsp__)))/(3-20000*T3)^2;
        T9 = 1/(3-20000*T3);
            d_T3_d_v_vgvb__ = 0;
            d_T3_d_v_vdpvsp__ = (0.0002-T3)*d_T9_d_v_vdpvsp__+(-d_T3_d_v_vdpvsp__)*T9;
            d_T3_d_v_vbvsp__ = (0.0002-T3)*d_T9_d_v_vbvsp__+(-d_T3_d_v_vbvsp__)*T9;
        T3 = (0.0002-T3)*T9;
            d_T4_d_v_vgvb__ = 0;
            d_T4_d_v_vdpvsp__ = T9*d_T9_d_v_vdpvsp__+d_T9_d_v_vdpvsp__*T9;
            d_T4_d_v_vbvsp__ = T9*d_T9_d_v_vbvsp__+d_T9_d_v_vbvsp__*T9;
        T4 = T9*T9;
    else
            d_T4_d_v_vgvb__ = 0;
            d_T4_d_v_vdpvsp__ = 0;
            d_T4_d_v_vbvsp__ = 0;
        T4 = 1;
    end
        d_dDIBL_Sft_dVd_d_v_vdpvsp__ = d_T3_d_v_vdpvsp__*BSIM3theta0vb0;
        d_dDIBL_Sft_dVd_d_v_vbvsp__ = d_T3_d_v_vbvsp__*BSIM3theta0vb0;
    dDIBL_Sft_dVd = T3*BSIM3theta0vb0;
        d_DIBL_Sft_d_v_vdpvsp__ = dDIBL_Sft_dVd*d_Vds_d_v_vdpvsp__+d_dDIBL_Sft_dVd_d_v_vdpvsp__*Vds;
        d_DIBL_Sft_d_v_vbvsp__ = d_dDIBL_Sft_dVd_d_v_vbvsp__*Vds;
    DIBL_Sft = dDIBL_Sft_dVd*Vds;
        d_Vth_d_v_vdpvsp__ = (((((((BSIM3k1ox*d_sqrtPhis_d_v_vdpvsp__))-(BSIM3k2ox*d_Vbseff_d_v_vdpvsp__))-d_Delt_vth_d_v_vdpvsp__)-d_T2_d_v_vdpvsp__)+((BSIM3k3+BSIM3k3b*Vbseff)*d_tmp2_d_v_vdpvsp__+((BSIM3k3b*d_Vbseff_d_v_vdpvsp__))*tmp2))+d_T1_d_v_vdpvsp__)-d_DIBL_Sft_d_v_vdpvsp__;
        d_Vth_d_v_vbvsp__ = (((((((BSIM3k1ox*d_sqrtPhis_d_v_vbvsp__))-(BSIM3k2ox*d_Vbseff_d_v_vbvsp__))-d_Delt_vth_d_v_vbvsp__)-d_T2_d_v_vbvsp__)+((BSIM3k3+BSIM3k3b*Vbseff)*d_tmp2_d_v_vbvsp__+((BSIM3k3b*d_Vbseff_d_v_vbvsp__))*tmp2))+d_T1_d_v_vbvsp__)-d_DIBL_Sft_d_v_vbvsp__;
    Vth = (((((((BSIM3type*BSIM3vth0-BSIM3k1*BSIM3sqrtPhi)+BSIM3k1ox*sqrtPhis)-BSIM3k2ox*Vbseff)-Delt_vth)-T2)+(BSIM3k3+BSIM3k3b*Vbseff)*tmp2)+T1)-DIBL_Sft;
        d_BSIM3von_d_v_vdpvsp__ = d_Vth_d_v_vdpvsp__;
        d_BSIM3von_d_v_vbvsp__ = d_Vth_d_v_vbvsp__;
    BSIM3von = Vth;
        d_tmp2_d_v_vgvb__ = 0;
        d_tmp2_d_v_vdpvsp__ = -((BSIM3nfactor*1.0359e-10)*d_Xdep_d_v_vdpvsp__)/Xdep^2;
        d_tmp2_d_v_vbvsp__ = -((BSIM3nfactor*1.0359e-10)*d_Xdep_d_v_vbvsp__)/Xdep^2;
    tmp2 = (BSIM3nfactor*1.0359e-10)/Xdep;
        d_tmp3_d_v_vgvb__ = 0;
        d_tmp3_d_v_vdpvsp__ = ((BSIM3cdscb*d_Vbseff_d_v_vdpvsp__))+(BSIM3cdscd*d_Vds_d_v_vdpvsp__);
        d_tmp3_d_v_vbvsp__ = ((BSIM3cdscb*d_Vbseff_d_v_vbvsp__));
    tmp3 = (BSIM3cdsc+BSIM3cdscb*Vbseff)+BSIM3cdscd*Vds;
        d_tmp4_d_v_vgvb__ = 0;
        d_tmp4_d_v_vdpvsp__ = ((d_tmp2_d_v_vdpvsp__+(tmp3*d_Theta0_d_v_vdpvsp__+d_tmp3_d_v_vdpvsp__*Theta0)))/BSIM3cox;
        d_tmp4_d_v_vbvsp__ = ((d_tmp2_d_v_vbvsp__+(tmp3*d_Theta0_d_v_vbvsp__+d_tmp3_d_v_vbvsp__*Theta0)))/BSIM3cox;
    tmp4 = ((tmp2+tmp3*Theta0)+BSIM3cit)/BSIM3cox;
    if tmp4>=-0.5
            d_n_d_v_vdpvsp__ = d_tmp4_d_v_vdpvsp__;
            d_n_d_v_vbvsp__ = d_tmp4_d_v_vbvsp__;
        n = 1+tmp4;
    else
            d_T0_d_v_vgvb__ = 0;
            d_T0_d_v_vdpvsp__ = -(1*((8*d_tmp4_d_v_vdpvsp__)))/(3+8*tmp4)^2;
            d_T0_d_v_vbvsp__ = -(1*((8*d_tmp4_d_v_vbvsp__)))/(3+8*tmp4)^2;
        T0 = 1/(3+8*tmp4);
            d_n_d_v_vdpvsp__ = (1+3*tmp4)*d_T0_d_v_vdpvsp__+((3*d_tmp4_d_v_vdpvsp__))*T0;
            d_n_d_v_vbvsp__ = (1+3*tmp4)*d_T0_d_v_vbvsp__+((3*d_tmp4_d_v_vbvsp__))*T0;
        n = (1+3*tmp4)*T0;
    end
        d_T0_d_v_vgvb__ = 0;
        d_T0_d_v_vdpvsp__ = 0;
        d_T0_d_v_vbvsp__ = 0;
    T0 = BSIM3vfb+BSIM3phi;
    if (BSIM3ngate>1e+18&&BSIM3ngate<1e+25)&&Vgs>T0
            d_T1_d_v_vgvb__ = 0;
            d_T1_d_v_vdpvsp__ = 0;
            d_T1_d_v_vbvsp__ = 0;
        T1 = (((1000000*1.6022e-19)*1.0359e-10)*BSIM3ngate)/(BSIM3cox*BSIM3cox);
            d_T4_d_v_vgvb__ = (1/(2*sqrt(1+(2*(Vgs-T0))/T1)))*(((2*(d_Vgs_d_v_vgvb__-d_T0_d_v_vgvb__))/T1-((2*(Vgs-T0))*d_T1_d_v_vgvb__)/T1^2));
            d_T4_d_v_vdpvsp__ = (1/(2*sqrt(1+(2*(Vgs-T0))/T1)))*(((2*(d_Vgs_d_v_vdpvsp__-d_T0_d_v_vdpvsp__))/T1-((2*(Vgs-T0))*d_T1_d_v_vdpvsp__)/T1^2));
            d_T4_d_v_vbvsp__ = (1/(2*sqrt(1+(2*(Vgs-T0))/T1)))*(((2*(d_Vgs_d_v_vbvsp__-d_T0_d_v_vbvsp__))/T1-((2*(Vgs-T0))*d_T1_d_v_vbvsp__)/T1^2));
        T4 = sqrt(1+(2*(Vgs-T0))/T1);
            d_T2_d_v_vgvb__ = T1*(d_T4_d_v_vgvb__)+d_T1_d_v_vgvb__*(T4-1);
            d_T2_d_v_vdpvsp__ = T1*(d_T4_d_v_vdpvsp__)+d_T1_d_v_vdpvsp__*(T4-1);
            d_T2_d_v_vbvsp__ = T1*(d_T4_d_v_vbvsp__)+d_T1_d_v_vbvsp__*(T4-1);
        T2 = T1*(T4-1);
            d_T3_d_v_vgvb__ = ((0.5*T2)*d_T2_d_v_vgvb__+(0.5*d_T2_d_v_vgvb__)*T2)/T1-(((0.5*T2)*T2)*d_T1_d_v_vgvb__)/T1^2;
            d_T3_d_v_vdpvsp__ = ((0.5*T2)*d_T2_d_v_vdpvsp__+(0.5*d_T2_d_v_vdpvsp__)*T2)/T1-(((0.5*T2)*T2)*d_T1_d_v_vdpvsp__)/T1^2;
            d_T3_d_v_vbvsp__ = ((0.5*T2)*d_T2_d_v_vbvsp__+(0.5*d_T2_d_v_vbvsp__)*T2)/T1-(((0.5*T2)*T2)*d_T1_d_v_vbvsp__)/T1^2;
        T3 = ((0.5*T2)*T2)/T1;
            d_T7_d_v_vgvb__ = (-d_T3_d_v_vgvb__);
            d_T7_d_v_vdpvsp__ = (-d_T3_d_v_vdpvsp__);
            d_T7_d_v_vbvsp__ = (-d_T3_d_v_vbvsp__);
        T7 = (1.12-T3)-0.05;
            d_T6_d_v_vgvb__ = (1/(2*sqrt(T7*T7+0.224)))*((T7*d_T7_d_v_vgvb__+d_T7_d_v_vgvb__*T7));
            d_T6_d_v_vdpvsp__ = (1/(2*sqrt(T7*T7+0.224)))*((T7*d_T7_d_v_vdpvsp__+d_T7_d_v_vdpvsp__*T7));
            d_T6_d_v_vbvsp__ = (1/(2*sqrt(T7*T7+0.224)))*((T7*d_T7_d_v_vbvsp__+d_T7_d_v_vbvsp__*T7));
        T6 = sqrt(T7*T7+0.224);
            d_T5_d_v_vgvb__ = -(0.5*(d_T7_d_v_vgvb__+d_T6_d_v_vgvb__));
            d_T5_d_v_vdpvsp__ = -(0.5*(d_T7_d_v_vdpvsp__+d_T6_d_v_vdpvsp__));
            d_T5_d_v_vbvsp__ = -(0.5*(d_T7_d_v_vbvsp__+d_T6_d_v_vbvsp__));
        T5 = 1.12-0.5*(T7+T6);
            d_Vgs_eff_d_v_vgvb__ = d_Vgs_d_v_vgvb__-d_T5_d_v_vgvb__;
            d_Vgs_eff_d_v_vdpvsp__ = d_Vgs_d_v_vdpvsp__-d_T5_d_v_vdpvsp__;
            d_Vgs_eff_d_v_vbvsp__ = d_Vgs_d_v_vbvsp__-d_T5_d_v_vbvsp__;
        Vgs_eff = Vgs-T5;
    else
            d_Vgs_eff_d_v_vgvb__ = d_Vgs_d_v_vgvb__;
            d_Vgs_eff_d_v_vdpvsp__ = d_Vgs_d_v_vdpvsp__;
            d_Vgs_eff_d_v_vbvsp__ = d_Vgs_d_v_vbvsp__;
        Vgs_eff = Vgs;
    end
        d_Vgst_d_v_vgvb__ = d_Vgs_eff_d_v_vgvb__;
        d_Vgst_d_v_vdpvsp__ = d_Vgs_eff_d_v_vdpvsp__-d_Vth_d_v_vdpvsp__;
        d_Vgst_d_v_vbvsp__ = d_Vgs_eff_d_v_vbvsp__-d_Vth_d_v_vbvsp__;
    Vgst = Vgs_eff-Vth;
        d_T10_d_v_vgvb__ = 0;
        d_T10_d_v_vdpvsp__ = (2*d_n_d_v_vdpvsp__)*Vtm;
        d_T10_d_v_vbvsp__ = (2*d_n_d_v_vbvsp__)*Vtm;
    T10 = (2*n)*Vtm;
        d_VgstNVt_d_v_vgvb__ = d_Vgst_d_v_vgvb__/T10-(Vgst*d_T10_d_v_vgvb__)/T10^2;
        d_VgstNVt_d_v_vdpvsp__ = d_Vgst_d_v_vdpvsp__/T10-(Vgst*d_T10_d_v_vdpvsp__)/T10^2;
        d_VgstNVt_d_v_vbvsp__ = d_Vgst_d_v_vbvsp__/T10-(Vgst*d_T10_d_v_vbvsp__)/T10^2;
    VgstNVt = Vgst/T10;
        d_ExpArg_d_v_vgvb__ = (-d_Vgst_d_v_vgvb__)/T10-((2*BSIM3voff-Vgst)*d_T10_d_v_vgvb__)/T10^2;
        d_ExpArg_d_v_vdpvsp__ = (-d_Vgst_d_v_vdpvsp__)/T10-((2*BSIM3voff-Vgst)*d_T10_d_v_vdpvsp__)/T10^2;
        d_ExpArg_d_v_vbvsp__ = (-d_Vgst_d_v_vbvsp__)/T10-((2*BSIM3voff-Vgst)*d_T10_d_v_vbvsp__)/T10^2;
    ExpArg = (2*BSIM3voff-Vgst)/T10;
    if VgstNVt>34
            d_Vgsteff_d_v_vgvb__ = d_Vgst_d_v_vgvb__;
            d_Vgsteff_d_v_vdpvsp__ = d_Vgst_d_v_vdpvsp__;
            d_Vgsteff_d_v_vbvsp__ = d_Vgst_d_v_vbvsp__;
        Vgsteff = Vgst;
    else
        if ExpArg>34
                d_T0_d_v_vgvb__ = (d_Vgst_d_v_vgvb__)/(n*Vtm);
                d_T0_d_v_vdpvsp__ = (d_Vgst_d_v_vdpvsp__)/(n*Vtm)-((Vgst-BSIM3voff)*(d_n_d_v_vdpvsp__*Vtm))/(n*Vtm)^2;
                d_T0_d_v_vbvsp__ = (d_Vgst_d_v_vbvsp__)/(n*Vtm)-((Vgst-BSIM3voff)*(d_n_d_v_vbvsp__*Vtm))/(n*Vtm)^2;
            T0 = (Vgst-BSIM3voff)/(n*Vtm);
                d_ExpVgst_d_v_vgvb__ = exp(T0)*d_T0_d_v_vgvb__;
                d_ExpVgst_d_v_vdpvsp__ = exp(T0)*d_T0_d_v_vdpvsp__;
                d_ExpVgst_d_v_vbvsp__ = exp(T0)*d_T0_d_v_vbvsp__;
            ExpVgst = exp(T0);
                d_Vgsteff_d_v_vgvb__ = ((Vtm*BSIM3cdep0)/BSIM3cox)*d_ExpVgst_d_v_vgvb__;
                d_Vgsteff_d_v_vdpvsp__ = ((Vtm*BSIM3cdep0)/BSIM3cox)*d_ExpVgst_d_v_vdpvsp__;
                d_Vgsteff_d_v_vbvsp__ = ((Vtm*BSIM3cdep0)/BSIM3cox)*d_ExpVgst_d_v_vbvsp__;
            Vgsteff = ((Vtm*BSIM3cdep0)/BSIM3cox)*ExpVgst;
        else
                d_ExpVgst_d_v_vgvb__ = exp(VgstNVt)*d_VgstNVt_d_v_vgvb__;
                d_ExpVgst_d_v_vdpvsp__ = exp(VgstNVt)*d_VgstNVt_d_v_vdpvsp__;
                d_ExpVgst_d_v_vbvsp__ = exp(VgstNVt)*d_VgstNVt_d_v_vbvsp__;
            ExpVgst = exp(VgstNVt);
                d_T1_d_v_vgvb__ = T10*((1/((1+ExpVgst)*log(10)))*(d_ExpVgst_d_v_vgvb__))+d_T10_d_v_vgvb__*log10(1+ExpVgst);
                d_T1_d_v_vdpvsp__ = T10*((1/((1+ExpVgst)*log(10)))*(d_ExpVgst_d_v_vdpvsp__))+d_T10_d_v_vdpvsp__*log10(1+ExpVgst);
                d_T1_d_v_vbvsp__ = T10*((1/((1+ExpVgst)*log(10)))*(d_ExpVgst_d_v_vbvsp__))+d_T10_d_v_vbvsp__*log10(1+ExpVgst);
            T1 = T10*log10(1+ExpVgst);
                d_dT2_dVg_d_v_vgvb__ = (-BSIM3cox/(Vtm*BSIM3cdep0))*(exp(ExpArg)*d_ExpArg_d_v_vgvb__);
                d_dT2_dVg_d_v_vdpvsp__ = (-BSIM3cox/(Vtm*BSIM3cdep0))*(exp(ExpArg)*d_ExpArg_d_v_vdpvsp__);
                d_dT2_dVg_d_v_vbvsp__ = (-BSIM3cox/(Vtm*BSIM3cdep0))*(exp(ExpArg)*d_ExpArg_d_v_vbvsp__);
            dT2_dVg = (-BSIM3cox/(Vtm*BSIM3cdep0))*exp(ExpArg);
                d_T2_d_v_vgvb__ = -(T10*d_dT2_dVg_d_v_vgvb__+d_T10_d_v_vgvb__*dT2_dVg);
                d_T2_d_v_vdpvsp__ = -(T10*d_dT2_dVg_d_v_vdpvsp__+d_T10_d_v_vdpvsp__*dT2_dVg);
                d_T2_d_v_vbvsp__ = -(T10*d_dT2_dVg_d_v_vbvsp__+d_T10_d_v_vbvsp__*dT2_dVg);
            T2 = 1-T10*dT2_dVg;
                d_Vgsteff_d_v_vgvb__ = d_T1_d_v_vgvb__/T2-(T1*d_T2_d_v_vgvb__)/T2^2;
                d_Vgsteff_d_v_vdpvsp__ = d_T1_d_v_vdpvsp__/T2-(T1*d_T2_d_v_vdpvsp__)/T2^2;
                d_Vgsteff_d_v_vbvsp__ = d_T1_d_v_vbvsp__/T2-(T1*d_T2_d_v_vbvsp__)/T2^2;
            Vgsteff = T1/T2;
        end
    end
        d_BSIM3Vgsteff_d_v_vgvb__ = d_Vgsteff_d_v_vgvb__;
        d_BSIM3Vgsteff_d_v_vdpvsp__ = d_Vgsteff_d_v_vdpvsp__;
        d_BSIM3Vgsteff_d_v_vbvsp__ = d_Vgsteff_d_v_vbvsp__;
    BSIM3Vgsteff = Vgsteff;
        d_T9_d_v_vgvb__ = 0;
        d_T9_d_v_vdpvsp__ = d_sqrtPhis_d_v_vdpvsp__;
        d_T9_d_v_vbvsp__ = d_sqrtPhis_d_v_vbvsp__;
    T9 = sqrtPhis-BSIM3sqrtPhi;
        d_Weff_d_v_vgvb__ = -(2*((BSIM3dwg*d_Vgsteff_d_v_vgvb__)+(BSIM3dwb*d_T9_d_v_vgvb__)));
        d_Weff_d_v_vdpvsp__ = -(2*((BSIM3dwg*d_Vgsteff_d_v_vdpvsp__)+(BSIM3dwb*d_T9_d_v_vdpvsp__)));
        d_Weff_d_v_vbvsp__ = -(2*((BSIM3dwg*d_Vgsteff_d_v_vbvsp__)+(BSIM3dwb*d_T9_d_v_vbvsp__)));
    Weff = BSIM3weff-2*(BSIM3dwg*Vgsteff+BSIM3dwb*T9);
    if Weff<2e-08
            d_T0_d_v_vgvb__ = -(1*(-(2*d_Weff_d_v_vgvb__)))/(6e-08-2*Weff)^2;
            d_T0_d_v_vdpvsp__ = -(1*(-(2*d_Weff_d_v_vdpvsp__)))/(6e-08-2*Weff)^2;
            d_T0_d_v_vbvsp__ = -(1*(-(2*d_Weff_d_v_vbvsp__)))/(6e-08-2*Weff)^2;
        T0 = 1/(6e-08-2*Weff);
            d_Weff_d_v_vgvb__ = (2e-08*(4e-08-Weff))*d_T0_d_v_vgvb__+(2e-08*(-d_Weff_d_v_vgvb__))*T0;
            d_Weff_d_v_vdpvsp__ = (2e-08*(4e-08-Weff))*d_T0_d_v_vdpvsp__+(2e-08*(-d_Weff_d_v_vdpvsp__))*T0;
            d_Weff_d_v_vbvsp__ = (2e-08*(4e-08-Weff))*d_T0_d_v_vbvsp__+(2e-08*(-d_Weff_d_v_vbvsp__))*T0;
        Weff = (2e-08*(4e-08-Weff))*T0;
    end
        d_T0_d_v_vgvb__ = (BSIM3prwg*d_Vgsteff_d_v_vgvb__)+(BSIM3prwb*d_T9_d_v_vgvb__);
        d_T0_d_v_vdpvsp__ = (BSIM3prwg*d_Vgsteff_d_v_vdpvsp__)+(BSIM3prwb*d_T9_d_v_vdpvsp__);
        d_T0_d_v_vbvsp__ = (BSIM3prwg*d_Vgsteff_d_v_vbvsp__)+(BSIM3prwb*d_T9_d_v_vbvsp__);
    T0 = BSIM3prwg*Vgsteff+BSIM3prwb*T9;
    if T0>=-0.9
            d_Rds_d_v_vgvb__ = BSIM3rds0*(d_T0_d_v_vgvb__);
            d_Rds_d_v_vdpvsp__ = BSIM3rds0*(d_T0_d_v_vdpvsp__);
            d_Rds_d_v_vbvsp__ = BSIM3rds0*(d_T0_d_v_vbvsp__);
        Rds = BSIM3rds0*(1+T0);
    else
            d_T1_d_v_vgvb__ = -(1*((20*d_T0_d_v_vgvb__)))/(17+20*T0)^2;
            d_T1_d_v_vdpvsp__ = -(1*((20*d_T0_d_v_vdpvsp__)))/(17+20*T0)^2;
            d_T1_d_v_vbvsp__ = -(1*((20*d_T0_d_v_vbvsp__)))/(17+20*T0)^2;
        T1 = 1/(17+20*T0);
            d_Rds_d_v_vgvb__ = (BSIM3rds0*(0.8+T0))*d_T1_d_v_vgvb__+(BSIM3rds0*(d_T0_d_v_vgvb__))*T1;
            d_Rds_d_v_vdpvsp__ = (BSIM3rds0*(0.8+T0))*d_T1_d_v_vdpvsp__+(BSIM3rds0*(d_T0_d_v_vdpvsp__))*T1;
            d_Rds_d_v_vbvsp__ = (BSIM3rds0*(0.8+T0))*d_T1_d_v_vbvsp__+(BSIM3rds0*(d_T0_d_v_vbvsp__))*T1;
        Rds = (BSIM3rds0*(0.8+T0))*T1;
    end
        d_BSIM3rds_d_v_vgvb__ = d_Rds_d_v_vgvb__;
        d_BSIM3rds_d_v_vdpvsp__ = d_Rds_d_v_vdpvsp__;
        d_BSIM3rds_d_v_vbvsp__ = d_Rds_d_v_vbvsp__;
    BSIM3rds = Rds;
        d_T1_d_v_vgvb__ = 0;
        d_T1_d_v_vdpvsp__ = -((0.5*BSIM3k1ox)*d_sqrtPhis_d_v_vdpvsp__)/sqrtPhis^2;
        d_T1_d_v_vbvsp__ = -((0.5*BSIM3k1ox)*d_sqrtPhis_d_v_vbvsp__)/sqrtPhis^2;
    T1 = (0.5*BSIM3k1ox)/sqrtPhis;
        d_dT1_dVb_d_v_vgvb__ = (-d_T1_d_v_vgvb__/sqrtPhis)*dsqrtPhis_dVb;
        d_dT1_dVb_d_v_vdpvsp__ = (-d_T1_d_v_vdpvsp__/sqrtPhis-(-T1*d_sqrtPhis_d_v_vdpvsp__)/sqrtPhis^2)*dsqrtPhis_dVb;
        d_dT1_dVb_d_v_vbvsp__ = (-d_T1_d_v_vbvsp__/sqrtPhis-(-T1*d_sqrtPhis_d_v_vbvsp__)/sqrtPhis^2)*dsqrtPhis_dVb;
    dT1_dVb = (-T1/sqrtPhis)*dsqrtPhis_dVb;
        d_T9_d_v_vgvb__ = 0;
        d_T9_d_v_vdpvsp__ = (1/(2*sqrt(BSIM3xj*Xdep)))*(BSIM3xj*d_Xdep_d_v_vdpvsp__);
        d_T9_d_v_vbvsp__ = (1/(2*sqrt(BSIM3xj*Xdep)))*(BSIM3xj*d_Xdep_d_v_vbvsp__);
    T9 = sqrt(BSIM3xj*Xdep);
        d_tmp1_d_v_vdpvsp__ = (2*d_T9_d_v_vdpvsp__);
        d_tmp1_d_v_vbvsp__ = (2*d_T9_d_v_vbvsp__);
    tmp1 = Leff+2*T9;
        d_T5_d_v_vgvb__ = 0;
        d_T5_d_v_vdpvsp__ = -(Leff*d_tmp1_d_v_vdpvsp__)/tmp1^2;
        d_T5_d_v_vbvsp__ = -(Leff*d_tmp1_d_v_vbvsp__)/tmp1^2;
    T5 = Leff/tmp1;
        d_tmp2_d_v_vgvb__ = BSIM3a0*d_T5_d_v_vgvb__;
        d_tmp2_d_v_vdpvsp__ = BSIM3a0*d_T5_d_v_vdpvsp__;
        d_tmp2_d_v_vbvsp__ = BSIM3a0*d_T5_d_v_vbvsp__;
    tmp2 = BSIM3a0*T5;
        d_tmp3_d_v_vgvb__ = 0;
        d_tmp3_d_v_vdpvsp__ = 0;
        d_tmp3_d_v_vbvsp__ = 0;
    tmp3 = BSIM3weff+BSIM3b1;
        d_tmp4_d_v_vgvb__ = 0;
        d_tmp4_d_v_vdpvsp__ = -(BSIM3b0*d_tmp3_d_v_vdpvsp__)/tmp3^2;
        d_tmp4_d_v_vbvsp__ = -(BSIM3b0*d_tmp3_d_v_vbvsp__)/tmp3^2;
    tmp4 = BSIM3b0/tmp3;
        d_T2_d_v_vgvb__ = d_tmp2_d_v_vgvb__+d_tmp4_d_v_vgvb__;
        d_T2_d_v_vdpvsp__ = d_tmp2_d_v_vdpvsp__+d_tmp4_d_v_vdpvsp__;
        d_T2_d_v_vbvsp__ = d_tmp2_d_v_vbvsp__+d_tmp4_d_v_vbvsp__;
    T2 = tmp2+tmp4;
        d_T6_d_v_vgvb__ = T5*d_T5_d_v_vgvb__+d_T5_d_v_vgvb__*T5;
        d_T6_d_v_vdpvsp__ = T5*d_T5_d_v_vdpvsp__+d_T5_d_v_vdpvsp__*T5;
        d_T6_d_v_vbvsp__ = T5*d_T5_d_v_vbvsp__+d_T5_d_v_vbvsp__*T5;
    T6 = T5*T5;
        d_T7_d_v_vgvb__ = T5*d_T6_d_v_vgvb__+d_T5_d_v_vgvb__*T6;
        d_T7_d_v_vdpvsp__ = T5*d_T6_d_v_vdpvsp__+d_T5_d_v_vdpvsp__*T6;
        d_T7_d_v_vbvsp__ = T5*d_T6_d_v_vbvsp__+d_T5_d_v_vbvsp__*T6;
    T7 = T5*T6;
        d_Abulk0_d_v_vgvb__ = (T1*d_T2_d_v_vgvb__+d_T1_d_v_vgvb__*T2);
        d_Abulk0_d_v_vdpvsp__ = (T1*d_T2_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*T2);
        d_Abulk0_d_v_vbvsp__ = (T1*d_T2_d_v_vbvsp__+d_T1_d_v_vbvsp__*T2);
    Abulk0 = 1+T1*T2;
        d_T8_d_v_vgvb__ = (BSIM3ags*BSIM3a0)*d_T7_d_v_vgvb__;
        d_T8_d_v_vdpvsp__ = (BSIM3ags*BSIM3a0)*d_T7_d_v_vdpvsp__;
        d_T8_d_v_vbvsp__ = (BSIM3ags*BSIM3a0)*d_T7_d_v_vbvsp__;
    T8 = (BSIM3ags*BSIM3a0)*T7;
        d_dAbulk_dVg_d_v_vgvb__ = -T1*d_T8_d_v_vgvb__+-d_T1_d_v_vgvb__*T8;
        d_dAbulk_dVg_d_v_vdpvsp__ = -T1*d_T8_d_v_vdpvsp__+-d_T1_d_v_vdpvsp__*T8;
        d_dAbulk_dVg_d_v_vbvsp__ = -T1*d_T8_d_v_vbvsp__+-d_T1_d_v_vbvsp__*T8;
    dAbulk_dVg = -T1*T8;
        d_Abulk_d_v_vgvb__ = d_Abulk0_d_v_vgvb__+(dAbulk_dVg*d_Vgsteff_d_v_vgvb__+d_dAbulk_dVg_d_v_vgvb__*Vgsteff);
        d_Abulk_d_v_vdpvsp__ = d_Abulk0_d_v_vdpvsp__+(dAbulk_dVg*d_Vgsteff_d_v_vdpvsp__+d_dAbulk_dVg_d_v_vdpvsp__*Vgsteff);
        d_Abulk_d_v_vbvsp__ = d_Abulk0_d_v_vbvsp__+(dAbulk_dVg*d_Vgsteff_d_v_vbvsp__+d_dAbulk_dVg_d_v_vbvsp__*Vgsteff);
    Abulk = Abulk0+dAbulk_dVg*Vgsteff;
    if Abulk0<0.1
            d_T9_d_v_vgvb__ = -(1*(-(20*d_Abulk0_d_v_vgvb__)))/(3-20*Abulk0)^2;
            d_T9_d_v_vdpvsp__ = -(1*(-(20*d_Abulk0_d_v_vdpvsp__)))/(3-20*Abulk0)^2;
            d_T9_d_v_vbvsp__ = -(1*(-(20*d_Abulk0_d_v_vbvsp__)))/(3-20*Abulk0)^2;
        T9 = 1/(3-20*Abulk0);
            d_Abulk0_d_v_vgvb__ = (0.2-Abulk0)*d_T9_d_v_vgvb__+(-d_Abulk0_d_v_vgvb__)*T9;
            d_Abulk0_d_v_vdpvsp__ = (0.2-Abulk0)*d_T9_d_v_vdpvsp__+(-d_Abulk0_d_v_vdpvsp__)*T9;
            d_Abulk0_d_v_vbvsp__ = (0.2-Abulk0)*d_T9_d_v_vbvsp__+(-d_Abulk0_d_v_vbvsp__)*T9;
        Abulk0 = (0.2-Abulk0)*T9;
    end
    if Abulk<0.1
            d_T9_d_v_vgvb__ = -(1*(-(20*d_Abulk_d_v_vgvb__)))/(3-20*Abulk)^2;
            d_T9_d_v_vdpvsp__ = -(1*(-(20*d_Abulk_d_v_vdpvsp__)))/(3-20*Abulk)^2;
            d_T9_d_v_vbvsp__ = -(1*(-(20*d_Abulk_d_v_vbvsp__)))/(3-20*Abulk)^2;
        T9 = 1/(3-20*Abulk);
            d_Abulk_d_v_vgvb__ = (0.2-Abulk)*d_T9_d_v_vgvb__+(-d_Abulk_d_v_vgvb__)*T9;
            d_Abulk_d_v_vdpvsp__ = (0.2-Abulk)*d_T9_d_v_vdpvsp__+(-d_Abulk_d_v_vdpvsp__)*T9;
            d_Abulk_d_v_vbvsp__ = (0.2-Abulk)*d_T9_d_v_vbvsp__+(-d_Abulk_d_v_vbvsp__)*T9;
        Abulk = (0.2-Abulk)*T9;
    end
        d_BSIM3Abulk_d_v_vgvb__ = d_Abulk_d_v_vgvb__;
        d_BSIM3Abulk_d_v_vdpvsp__ = d_Abulk_d_v_vdpvsp__;
        d_BSIM3Abulk_d_v_vbvsp__ = d_Abulk_d_v_vbvsp__;
    BSIM3Abulk = Abulk;
        d_T2_d_v_vgvb__ = 0;
        d_T2_d_v_vdpvsp__ = BSIM3keta*d_Vbseff_d_v_vdpvsp__;
        d_T2_d_v_vbvsp__ = BSIM3keta*d_Vbseff_d_v_vbvsp__;
    T2 = BSIM3keta*Vbseff;
    if T2>=-0.9
            d_T0_d_v_vgvb__ = -(1*(d_T2_d_v_vgvb__))/(1+T2)^2;
            d_T0_d_v_vdpvsp__ = -(1*(d_T2_d_v_vdpvsp__))/(1+T2)^2;
            d_T0_d_v_vbvsp__ = -(1*(d_T2_d_v_vbvsp__))/(1+T2)^2;
        T0 = 1/(1+T2);
    else
            d_T1_d_v_vgvb__ = -(1*(d_T2_d_v_vgvb__))/(0.8+T2)^2;
            d_T1_d_v_vdpvsp__ = -(1*(d_T2_d_v_vdpvsp__))/(0.8+T2)^2;
            d_T1_d_v_vbvsp__ = -(1*(d_T2_d_v_vbvsp__))/(0.8+T2)^2;
        T1 = 1/(0.8+T2);
            d_T0_d_v_vgvb__ = (17+20*T2)*d_T1_d_v_vgvb__+((20*d_T2_d_v_vgvb__))*T1;
            d_T0_d_v_vdpvsp__ = (17+20*T2)*d_T1_d_v_vdpvsp__+((20*d_T2_d_v_vdpvsp__))*T1;
            d_T0_d_v_vbvsp__ = (17+20*T2)*d_T1_d_v_vbvsp__+((20*d_T2_d_v_vbvsp__))*T1;
        T0 = (17+20*T2)*T1;
    end
        d_Abulk_d_v_vgvb__ = Abulk*d_T0_d_v_vgvb__+d_Abulk_d_v_vgvb__*T0;
        d_Abulk_d_v_vdpvsp__ = Abulk*d_T0_d_v_vdpvsp__+d_Abulk_d_v_vdpvsp__*T0;
        d_Abulk_d_v_vbvsp__ = Abulk*d_T0_d_v_vbvsp__+d_Abulk_d_v_vbvsp__*T0;
    Abulk = Abulk*T0;
        d_Abulk0_d_v_vgvb__ = Abulk0*d_T0_d_v_vgvb__+d_Abulk0_d_v_vgvb__*T0;
        d_Abulk0_d_v_vdpvsp__ = Abulk0*d_T0_d_v_vdpvsp__+d_Abulk0_d_v_vdpvsp__*T0;
        d_Abulk0_d_v_vbvsp__ = Abulk0*d_T0_d_v_vbvsp__+d_Abulk0_d_v_vbvsp__*T0;
    Abulk0 = Abulk0*T0;
    if BSIM3mobMod==1
            d_T0_d_v_vgvb__ = (d_Vgsteff_d_v_vgvb__);
            d_T0_d_v_vdpvsp__ = (d_Vgsteff_d_v_vdpvsp__+d_Vth_d_v_vdpvsp__)+d_Vth_d_v_vdpvsp__;
            d_T0_d_v_vbvsp__ = (d_Vgsteff_d_v_vbvsp__+d_Vth_d_v_vbvsp__)+d_Vth_d_v_vbvsp__;
        T0 = (Vgsteff+Vth)+Vth;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = (BSIM3uc*d_Vbseff_d_v_vdpvsp__);
            d_T2_d_v_vbvsp__ = (BSIM3uc*d_Vbseff_d_v_vbvsp__);
        T2 = BSIM3ua+BSIM3uc*Vbseff;
            d_T3_d_v_vgvb__ = d_T0_d_v_vgvb__/BSIM3tox;
            d_T3_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__/BSIM3tox;
            d_T3_d_v_vbvsp__ = d_T0_d_v_vbvsp__/BSIM3tox;
        T3 = T0/BSIM3tox;
            d_T5_d_v_vgvb__ = T3*(d_T2_d_v_vgvb__+(BSIM3ub*d_T3_d_v_vgvb__))+d_T3_d_v_vgvb__*(T2+BSIM3ub*T3);
            d_T5_d_v_vdpvsp__ = T3*(d_T2_d_v_vdpvsp__+(BSIM3ub*d_T3_d_v_vdpvsp__))+d_T3_d_v_vdpvsp__*(T2+BSIM3ub*T3);
            d_T5_d_v_vbvsp__ = T3*(d_T2_d_v_vbvsp__+(BSIM3ub*d_T3_d_v_vbvsp__))+d_T3_d_v_vbvsp__*(T2+BSIM3ub*T3);
        T5 = T3*(T2+BSIM3ub*T3);
    else
        if BSIM3mobMod==2
                d_T5_d_v_vgvb__ = (Vgsteff/BSIM3tox)*(((BSIM3ub*d_Vgsteff_d_v_vgvb__)/BSIM3tox))+(d_Vgsteff_d_v_vgvb__/BSIM3tox)*((BSIM3ua+BSIM3uc*Vbseff)+(BSIM3ub*Vgsteff)/BSIM3tox);
                d_T5_d_v_vdpvsp__ = (Vgsteff/BSIM3tox)*(((BSIM3uc*d_Vbseff_d_v_vdpvsp__))+((BSIM3ub*d_Vgsteff_d_v_vdpvsp__)/BSIM3tox))+(d_Vgsteff_d_v_vdpvsp__/BSIM3tox)*((BSIM3ua+BSIM3uc*Vbseff)+(BSIM3ub*Vgsteff)/BSIM3tox);
                d_T5_d_v_vbvsp__ = (Vgsteff/BSIM3tox)*(((BSIM3uc*d_Vbseff_d_v_vbvsp__))+((BSIM3ub*d_Vgsteff_d_v_vbvsp__)/BSIM3tox))+(d_Vgsteff_d_v_vbvsp__/BSIM3tox)*((BSIM3ua+BSIM3uc*Vbseff)+(BSIM3ub*Vgsteff)/BSIM3tox);
            T5 = (Vgsteff/BSIM3tox)*((BSIM3ua+BSIM3uc*Vbseff)+(BSIM3ub*Vgsteff)/BSIM3tox);
        else
                d_T0_d_v_vgvb__ = (d_Vgsteff_d_v_vgvb__);
                d_T0_d_v_vdpvsp__ = (d_Vgsteff_d_v_vdpvsp__+d_Vth_d_v_vdpvsp__)+d_Vth_d_v_vdpvsp__;
                d_T0_d_v_vbvsp__ = (d_Vgsteff_d_v_vbvsp__+d_Vth_d_v_vbvsp__)+d_Vth_d_v_vbvsp__;
            T0 = (Vgsteff+Vth)+Vth;
                d_T2_d_v_vgvb__ = 0;
                d_T2_d_v_vdpvsp__ = (BSIM3uc*d_Vbseff_d_v_vdpvsp__);
                d_T2_d_v_vbvsp__ = (BSIM3uc*d_Vbseff_d_v_vbvsp__);
            T2 = 1+BSIM3uc*Vbseff;
                d_T3_d_v_vgvb__ = d_T0_d_v_vgvb__/BSIM3tox;
                d_T3_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__/BSIM3tox;
                d_T3_d_v_vbvsp__ = d_T0_d_v_vbvsp__/BSIM3tox;
            T3 = T0/BSIM3tox;
                d_T4_d_v_vgvb__ = T3*((BSIM3ub*d_T3_d_v_vgvb__))+d_T3_d_v_vgvb__*(BSIM3ua+BSIM3ub*T3);
                d_T4_d_v_vdpvsp__ = T3*((BSIM3ub*d_T3_d_v_vdpvsp__))+d_T3_d_v_vdpvsp__*(BSIM3ua+BSIM3ub*T3);
                d_T4_d_v_vbvsp__ = T3*((BSIM3ub*d_T3_d_v_vbvsp__))+d_T3_d_v_vbvsp__*(BSIM3ua+BSIM3ub*T3);
            T4 = T3*(BSIM3ua+BSIM3ub*T3);
                d_T5_d_v_vgvb__ = T4*d_T2_d_v_vgvb__+d_T4_d_v_vgvb__*T2;
                d_T5_d_v_vdpvsp__ = T4*d_T2_d_v_vdpvsp__+d_T4_d_v_vdpvsp__*T2;
                d_T5_d_v_vbvsp__ = T4*d_T2_d_v_vbvsp__+d_T4_d_v_vbvsp__*T2;
            T5 = T4*T2;
        end
    end
    if T5>=-0.8
            d_Denomi_d_v_vgvb__ = d_T5_d_v_vgvb__;
            d_Denomi_d_v_vdpvsp__ = d_T5_d_v_vdpvsp__;
            d_Denomi_d_v_vbvsp__ = d_T5_d_v_vbvsp__;
        Denomi = 1+T5;
    else
            d_T9_d_v_vgvb__ = -(1*((10*d_T5_d_v_vgvb__)))/(7+10*T5)^2;
            d_T9_d_v_vdpvsp__ = -(1*((10*d_T5_d_v_vdpvsp__)))/(7+10*T5)^2;
            d_T9_d_v_vbvsp__ = -(1*((10*d_T5_d_v_vbvsp__)))/(7+10*T5)^2;
        T9 = 1/(7+10*T5);
            d_Denomi_d_v_vgvb__ = (0.6+T5)*d_T9_d_v_vgvb__+(d_T5_d_v_vgvb__)*T9;
            d_Denomi_d_v_vdpvsp__ = (0.6+T5)*d_T9_d_v_vdpvsp__+(d_T5_d_v_vdpvsp__)*T9;
            d_Denomi_d_v_vbvsp__ = (0.6+T5)*d_T9_d_v_vbvsp__+(d_T5_d_v_vbvsp__)*T9;
        Denomi = (0.6+T5)*T9;
    end
        d_BSIM3ueff_d_v_vgvb__ = -(BSIM3u0temp*d_Denomi_d_v_vgvb__)/Denomi^2;
        d_BSIM3ueff_d_v_vdpvsp__ = -(BSIM3u0temp*d_Denomi_d_v_vdpvsp__)/Denomi^2;
        d_BSIM3ueff_d_v_vbvsp__ = -(BSIM3u0temp*d_Denomi_d_v_vbvsp__)/Denomi^2;
    BSIM3ueff = BSIM3u0temp/Denomi;
        d_ueff_d_v_vgvb__ = d_BSIM3ueff_d_v_vgvb__;
        d_ueff_d_v_vdpvsp__ = d_BSIM3ueff_d_v_vdpvsp__;
        d_ueff_d_v_vbvsp__ = d_BSIM3ueff_d_v_vbvsp__;
    ueff = BSIM3ueff;
        d_WVCox_d_v_vgvb__ = (d_Weff_d_v_vgvb__*BSIM3vsattemp)*BSIM3cox;
        d_WVCox_d_v_vdpvsp__ = (d_Weff_d_v_vdpvsp__*BSIM3vsattemp)*BSIM3cox;
        d_WVCox_d_v_vbvsp__ = (d_Weff_d_v_vbvsp__*BSIM3vsattemp)*BSIM3cox;
    WVCox = (Weff*BSIM3vsattemp)*BSIM3cox;
        d_WVCoxRds_d_v_vgvb__ = WVCox*d_Rds_d_v_vgvb__+d_WVCox_d_v_vgvb__*Rds;
        d_WVCoxRds_d_v_vdpvsp__ = WVCox*d_Rds_d_v_vdpvsp__+d_WVCox_d_v_vdpvsp__*Rds;
        d_WVCoxRds_d_v_vbvsp__ = WVCox*d_Rds_d_v_vbvsp__+d_WVCox_d_v_vbvsp__*Rds;
    WVCoxRds = WVCox*Rds;
        d_Esat_d_v_vgvb__ = -((2*BSIM3vsattemp)*d_ueff_d_v_vgvb__)/ueff^2;
        d_Esat_d_v_vdpvsp__ = -((2*BSIM3vsattemp)*d_ueff_d_v_vdpvsp__)/ueff^2;
        d_Esat_d_v_vbvsp__ = -((2*BSIM3vsattemp)*d_ueff_d_v_vbvsp__)/ueff^2;
    Esat = (2*BSIM3vsattemp)/ueff;
        d_EsatL_d_v_vgvb__ = d_Esat_d_v_vgvb__*Leff;
        d_EsatL_d_v_vdpvsp__ = d_Esat_d_v_vdpvsp__*Leff;
        d_EsatL_d_v_vbvsp__ = d_Esat_d_v_vbvsp__*Leff;
    EsatL = Esat*Leff;
    if BSIM3a1==0
            d_Lambda_d_v_vgvb__ = 0;
            d_Lambda_d_v_vdpvsp__ = 0;
            d_Lambda_d_v_vbvsp__ = 0;
        Lambda = BSIM3a2;
    else
        if BSIM3a1>0
                d_T0_d_v_vgvb__ = 0;
                d_T0_d_v_vdpvsp__ = 0;
                d_T0_d_v_vbvsp__ = 0;
            T0 = 1-BSIM3a2;
                d_T1_d_v_vgvb__ = (d_T0_d_v_vgvb__-(BSIM3a1*d_Vgsteff_d_v_vgvb__));
                d_T1_d_v_vdpvsp__ = (d_T0_d_v_vdpvsp__-(BSIM3a1*d_Vgsteff_d_v_vdpvsp__));
                d_T1_d_v_vbvsp__ = (d_T0_d_v_vbvsp__-(BSIM3a1*d_Vgsteff_d_v_vbvsp__));
            T1 = (T0-BSIM3a1*Vgsteff)-0.0001;
                d_T2_d_v_vgvb__ = (1/(2*sqrt(T1*T1+0.0004*T0)))*((T1*d_T1_d_v_vgvb__+d_T1_d_v_vgvb__*T1)+(0.0004*d_T0_d_v_vgvb__));
                d_T2_d_v_vdpvsp__ = (1/(2*sqrt(T1*T1+0.0004*T0)))*((T1*d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*T1)+(0.0004*d_T0_d_v_vdpvsp__));
                d_T2_d_v_vbvsp__ = (1/(2*sqrt(T1*T1+0.0004*T0)))*((T1*d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__*T1)+(0.0004*d_T0_d_v_vbvsp__));
            T2 = sqrt(T1*T1+0.0004*T0);
                d_Lambda_d_v_vgvb__ = (d_T0_d_v_vgvb__)-(0.5*(d_T1_d_v_vgvb__+d_T2_d_v_vgvb__));
                d_Lambda_d_v_vdpvsp__ = (d_T0_d_v_vdpvsp__)-(0.5*(d_T1_d_v_vdpvsp__+d_T2_d_v_vdpvsp__));
                d_Lambda_d_v_vbvsp__ = (d_T0_d_v_vbvsp__)-(0.5*(d_T1_d_v_vbvsp__+d_T2_d_v_vbvsp__));
            Lambda = (BSIM3a2+T0)-0.5*(T1+T2);
        else
                d_T1_d_v_vgvb__ = ((BSIM3a1*d_Vgsteff_d_v_vgvb__));
                d_T1_d_v_vdpvsp__ = ((BSIM3a1*d_Vgsteff_d_v_vdpvsp__));
                d_T1_d_v_vbvsp__ = ((BSIM3a1*d_Vgsteff_d_v_vbvsp__));
            T1 = (BSIM3a2+BSIM3a1*Vgsteff)-0.0001;
                d_T2_d_v_vgvb__ = (1/(2*sqrt(T1*T1+0.0004*BSIM3a2)))*((T1*d_T1_d_v_vgvb__+d_T1_d_v_vgvb__*T1));
                d_T2_d_v_vdpvsp__ = (1/(2*sqrt(T1*T1+0.0004*BSIM3a2)))*((T1*d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*T1));
                d_T2_d_v_vbvsp__ = (1/(2*sqrt(T1*T1+0.0004*BSIM3a2)))*((T1*d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__*T1));
            T2 = sqrt(T1*T1+0.0004*BSIM3a2);
                d_Lambda_d_v_vgvb__ = 0.5*(d_T1_d_v_vgvb__+d_T2_d_v_vgvb__);
                d_Lambda_d_v_vdpvsp__ = 0.5*(d_T1_d_v_vdpvsp__+d_T2_d_v_vdpvsp__);
                d_Lambda_d_v_vbvsp__ = 0.5*(d_T1_d_v_vbvsp__+d_T2_d_v_vbvsp__);
            Lambda = 0.5*(T1+T2);
        end
    end
        d_Vgst2Vtm_d_v_vgvb__ = d_Vgsteff_d_v_vgvb__;
        d_Vgst2Vtm_d_v_vdpvsp__ = d_Vgsteff_d_v_vdpvsp__;
        d_Vgst2Vtm_d_v_vbvsp__ = d_Vgsteff_d_v_vbvsp__;
    Vgst2Vtm = Vgsteff+2*Vtm;
        d_BSIM3AbovVgst2Vtm_d_v_vgvb__ = d_Abulk_d_v_vgvb__/Vgst2Vtm-(Abulk*d_Vgst2Vtm_d_v_vgvb__)/Vgst2Vtm^2;
        d_BSIM3AbovVgst2Vtm_d_v_vdpvsp__ = d_Abulk_d_v_vdpvsp__/Vgst2Vtm-(Abulk*d_Vgst2Vtm_d_v_vdpvsp__)/Vgst2Vtm^2;
        d_BSIM3AbovVgst2Vtm_d_v_vbvsp__ = d_Abulk_d_v_vbvsp__/Vgst2Vtm-(Abulk*d_Vgst2Vtm_d_v_vbvsp__)/Vgst2Vtm^2;
    BSIM3AbovVgst2Vtm = Abulk/Vgst2Vtm;
    if Rds==0&&Lambda==1
            d_T0_d_v_vgvb__ = -(1*((Abulk*d_EsatL_d_v_vgvb__+d_Abulk_d_v_vgvb__*EsatL)+d_Vgst2Vtm_d_v_vgvb__))/(Abulk*EsatL+Vgst2Vtm)^2;
            d_T0_d_v_vdpvsp__ = -(1*((Abulk*d_EsatL_d_v_vdpvsp__+d_Abulk_d_v_vdpvsp__*EsatL)+d_Vgst2Vtm_d_v_vdpvsp__))/(Abulk*EsatL+Vgst2Vtm)^2;
            d_T0_d_v_vbvsp__ = -(1*((Abulk*d_EsatL_d_v_vbvsp__+d_Abulk_d_v_vbvsp__*EsatL)+d_Vgst2Vtm_d_v_vbvsp__))/(Abulk*EsatL+Vgst2Vtm)^2;
        T0 = 1/(Abulk*EsatL+Vgst2Vtm);
            d_T3_d_v_vgvb__ = EsatL*d_Vgst2Vtm_d_v_vgvb__+d_EsatL_d_v_vgvb__*Vgst2Vtm;
            d_T3_d_v_vdpvsp__ = EsatL*d_Vgst2Vtm_d_v_vdpvsp__+d_EsatL_d_v_vdpvsp__*Vgst2Vtm;
            d_T3_d_v_vbvsp__ = EsatL*d_Vgst2Vtm_d_v_vbvsp__+d_EsatL_d_v_vbvsp__*Vgst2Vtm;
        T3 = EsatL*Vgst2Vtm;
            d_Vdsat_d_v_vgvb__ = T3*d_T0_d_v_vgvb__+d_T3_d_v_vgvb__*T0;
            d_Vdsat_d_v_vdpvsp__ = T3*d_T0_d_v_vdpvsp__+d_T3_d_v_vdpvsp__*T0;
            d_Vdsat_d_v_vbvsp__ = T3*d_T0_d_v_vbvsp__+d_T3_d_v_vbvsp__*T0;
        Vdsat = T3*T0;
    else
            d_T9_d_v_vgvb__ = Abulk*d_WVCoxRds_d_v_vgvb__+d_Abulk_d_v_vgvb__*WVCoxRds;
            d_T9_d_v_vdpvsp__ = Abulk*d_WVCoxRds_d_v_vdpvsp__+d_Abulk_d_v_vdpvsp__*WVCoxRds;
            d_T9_d_v_vbvsp__ = Abulk*d_WVCoxRds_d_v_vbvsp__+d_Abulk_d_v_vbvsp__*WVCoxRds;
        T9 = Abulk*WVCoxRds;
            d_T7_d_v_vgvb__ = Vgst2Vtm*d_T9_d_v_vgvb__+d_Vgst2Vtm_d_v_vgvb__*T9;
            d_T7_d_v_vdpvsp__ = Vgst2Vtm*d_T9_d_v_vdpvsp__+d_Vgst2Vtm_d_v_vdpvsp__*T9;
            d_T7_d_v_vbvsp__ = Vgst2Vtm*d_T9_d_v_vbvsp__+d_Vgst2Vtm_d_v_vbvsp__*T9;
        T7 = Vgst2Vtm*T9;
            d_T6_d_v_vgvb__ = Vgst2Vtm*d_WVCoxRds_d_v_vgvb__+d_Vgst2Vtm_d_v_vgvb__*WVCoxRds;
            d_T6_d_v_vdpvsp__ = Vgst2Vtm*d_WVCoxRds_d_v_vdpvsp__+d_Vgst2Vtm_d_v_vdpvsp__*WVCoxRds;
            d_T6_d_v_vbvsp__ = Vgst2Vtm*d_WVCoxRds_d_v_vbvsp__+d_Vgst2Vtm_d_v_vbvsp__*WVCoxRds;
        T6 = Vgst2Vtm*WVCoxRds;
            d_T0_d_v_vgvb__ = (2*Abulk)*((d_T9_d_v_vgvb__)+(-(1*d_Lambda_d_v_vgvb__)/Lambda^2))+(2*d_Abulk_d_v_vgvb__)*((T9-1)+1/Lambda);
            d_T0_d_v_vdpvsp__ = (2*Abulk)*((d_T9_d_v_vdpvsp__)+(-(1*d_Lambda_d_v_vdpvsp__)/Lambda^2))+(2*d_Abulk_d_v_vdpvsp__)*((T9-1)+1/Lambda);
            d_T0_d_v_vbvsp__ = (2*Abulk)*((d_T9_d_v_vbvsp__)+(-(1*d_Lambda_d_v_vbvsp__)/Lambda^2))+(2*d_Abulk_d_v_vbvsp__)*((T9-1)+1/Lambda);
        T0 = (2*Abulk)*((T9-1)+1/Lambda);
            d_T1_d_v_vgvb__ = ((Vgst2Vtm*((-(2*d_Lambda_d_v_vgvb__)/Lambda^2))+d_Vgst2Vtm_d_v_vgvb__*(2/Lambda-1))+(Abulk*d_EsatL_d_v_vgvb__+d_Abulk_d_v_vgvb__*EsatL))+(3*d_T7_d_v_vgvb__);
            d_T1_d_v_vdpvsp__ = ((Vgst2Vtm*((-(2*d_Lambda_d_v_vdpvsp__)/Lambda^2))+d_Vgst2Vtm_d_v_vdpvsp__*(2/Lambda-1))+(Abulk*d_EsatL_d_v_vdpvsp__+d_Abulk_d_v_vdpvsp__*EsatL))+(3*d_T7_d_v_vdpvsp__);
            d_T1_d_v_vbvsp__ = ((Vgst2Vtm*((-(2*d_Lambda_d_v_vbvsp__)/Lambda^2))+d_Vgst2Vtm_d_v_vbvsp__*(2/Lambda-1))+(Abulk*d_EsatL_d_v_vbvsp__+d_Abulk_d_v_vbvsp__*EsatL))+(3*d_T7_d_v_vbvsp__);
        T1 = (Vgst2Vtm*(2/Lambda-1)+Abulk*EsatL)+3*T7;
            d_T2_d_v_vgvb__ = Vgst2Vtm*(d_EsatL_d_v_vgvb__+(2*d_T6_d_v_vgvb__))+d_Vgst2Vtm_d_v_vgvb__*(EsatL+2*T6);
            d_T2_d_v_vdpvsp__ = Vgst2Vtm*(d_EsatL_d_v_vdpvsp__+(2*d_T6_d_v_vdpvsp__))+d_Vgst2Vtm_d_v_vdpvsp__*(EsatL+2*T6);
            d_T2_d_v_vbvsp__ = Vgst2Vtm*(d_EsatL_d_v_vbvsp__+(2*d_T6_d_v_vbvsp__))+d_Vgst2Vtm_d_v_vbvsp__*(EsatL+2*T6);
        T2 = Vgst2Vtm*(EsatL+2*T6);
            d_T3_d_v_vgvb__ = (1/(2*sqrt(T1*T1-(2*T0)*T2)))*((T1*d_T1_d_v_vgvb__+d_T1_d_v_vgvb__*T1)-((2*T0)*d_T2_d_v_vgvb__+(2*d_T0_d_v_vgvb__)*T2));
            d_T3_d_v_vdpvsp__ = (1/(2*sqrt(T1*T1-(2*T0)*T2)))*((T1*d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*T1)-((2*T0)*d_T2_d_v_vdpvsp__+(2*d_T0_d_v_vdpvsp__)*T2));
            d_T3_d_v_vbvsp__ = (1/(2*sqrt(T1*T1-(2*T0)*T2)))*((T1*d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__*T1)-((2*T0)*d_T2_d_v_vbvsp__+(2*d_T0_d_v_vbvsp__)*T2));
        T3 = sqrt(T1*T1-(2*T0)*T2);
            d_Vdsat_d_v_vgvb__ = (d_T1_d_v_vgvb__-d_T3_d_v_vgvb__)/T0-((T1-T3)*d_T0_d_v_vgvb__)/T0^2;
            d_Vdsat_d_v_vdpvsp__ = (d_T1_d_v_vdpvsp__-d_T3_d_v_vdpvsp__)/T0-((T1-T3)*d_T0_d_v_vdpvsp__)/T0^2;
            d_Vdsat_d_v_vbvsp__ = (d_T1_d_v_vbvsp__-d_T3_d_v_vbvsp__)/T0-((T1-T3)*d_T0_d_v_vbvsp__)/T0^2;
        Vdsat = (T1-T3)/T0;
    end
        d_BSIM3vdsat_d_v_vgvb__ = d_Vdsat_d_v_vgvb__;
        d_BSIM3vdsat_d_v_vdpvsp__ = d_Vdsat_d_v_vdpvsp__;
        d_BSIM3vdsat_d_v_vbvsp__ = d_Vdsat_d_v_vbvsp__;
    BSIM3vdsat = Vdsat;
        d_T1_d_v_vgvb__ = (d_Vdsat_d_v_vgvb__);
        d_T1_d_v_vdpvsp__ = (d_Vdsat_d_v_vdpvsp__-d_Vds_d_v_vdpvsp__);
        d_T1_d_v_vbvsp__ = (d_Vdsat_d_v_vbvsp__);
    T1 = (Vdsat-Vds)-BSIM3delta;
        d_T2_d_v_vgvb__ = (1/(2*sqrt(T1*T1+(4*BSIM3delta)*Vdsat)))*((T1*d_T1_d_v_vgvb__+d_T1_d_v_vgvb__*T1)+((4*BSIM3delta)*d_Vdsat_d_v_vgvb__));
        d_T2_d_v_vdpvsp__ = (1/(2*sqrt(T1*T1+(4*BSIM3delta)*Vdsat)))*((T1*d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*T1)+((4*BSIM3delta)*d_Vdsat_d_v_vdpvsp__));
        d_T2_d_v_vbvsp__ = (1/(2*sqrt(T1*T1+(4*BSIM3delta)*Vdsat)))*((T1*d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__*T1)+((4*BSIM3delta)*d_Vdsat_d_v_vbvsp__));
    T2 = sqrt(T1*T1+(4*BSIM3delta)*Vdsat);
        d_Vdseff_d_v_vgvb__ = d_Vdsat_d_v_vgvb__-(0.5*(d_T1_d_v_vgvb__+d_T2_d_v_vgvb__));
        d_Vdseff_d_v_vdpvsp__ = d_Vdsat_d_v_vdpvsp__-(0.5*(d_T1_d_v_vdpvsp__+d_T2_d_v_vdpvsp__));
        d_Vdseff_d_v_vbvsp__ = d_Vdsat_d_v_vbvsp__-(0.5*(d_T1_d_v_vbvsp__+d_T2_d_v_vbvsp__));
    Vdseff = Vdsat-0.5*(T1+T2);
    if Vds==0
            d_Vdseff_d_v_vgvb__ = 0;
            d_Vdseff_d_v_vdpvsp__ = 0;
            d_Vdseff_d_v_vbvsp__ = 0;
        Vdseff = 0;
    end
        d_tmp4_d_v_vgvb__ = -(((0.5*Abulk)*d_Vdsat_d_v_vgvb__+(0.5*d_Abulk_d_v_vgvb__)*Vdsat)/Vgst2Vtm-(((0.5*Abulk)*Vdsat)*d_Vgst2Vtm_d_v_vgvb__)/Vgst2Vtm^2);
        d_tmp4_d_v_vdpvsp__ = -(((0.5*Abulk)*d_Vdsat_d_v_vdpvsp__+(0.5*d_Abulk_d_v_vdpvsp__)*Vdsat)/Vgst2Vtm-(((0.5*Abulk)*Vdsat)*d_Vgst2Vtm_d_v_vdpvsp__)/Vgst2Vtm^2);
        d_tmp4_d_v_vbvsp__ = -(((0.5*Abulk)*d_Vdsat_d_v_vbvsp__+(0.5*d_Abulk_d_v_vbvsp__)*Vdsat)/Vgst2Vtm-(((0.5*Abulk)*Vdsat)*d_Vgst2Vtm_d_v_vbvsp__)/Vgst2Vtm^2);
    tmp4 = 1-((0.5*Abulk)*Vdsat)/Vgst2Vtm;
        d_T9_d_v_vgvb__ = WVCoxRds*d_Vgsteff_d_v_vgvb__+d_WVCoxRds_d_v_vgvb__*Vgsteff;
        d_T9_d_v_vdpvsp__ = WVCoxRds*d_Vgsteff_d_v_vdpvsp__+d_WVCoxRds_d_v_vdpvsp__*Vgsteff;
        d_T9_d_v_vbvsp__ = WVCoxRds*d_Vgsteff_d_v_vbvsp__+d_WVCoxRds_d_v_vbvsp__*Vgsteff;
    T9 = WVCoxRds*Vgsteff;
        d_T0_d_v_vgvb__ = (d_EsatL_d_v_vgvb__+d_Vdsat_d_v_vgvb__)+((2*T9)*d_tmp4_d_v_vgvb__+(2*d_T9_d_v_vgvb__)*tmp4);
        d_T0_d_v_vdpvsp__ = (d_EsatL_d_v_vdpvsp__+d_Vdsat_d_v_vdpvsp__)+((2*T9)*d_tmp4_d_v_vdpvsp__+(2*d_T9_d_v_vdpvsp__)*tmp4);
        d_T0_d_v_vbvsp__ = (d_EsatL_d_v_vbvsp__+d_Vdsat_d_v_vbvsp__)+((2*T9)*d_tmp4_d_v_vbvsp__+(2*d_T9_d_v_vbvsp__)*tmp4);
    T0 = (EsatL+Vdsat)+(2*T9)*tmp4;
        d_T9_d_v_vgvb__ = WVCoxRds*d_Abulk_d_v_vgvb__+d_WVCoxRds_d_v_vgvb__*Abulk;
        d_T9_d_v_vdpvsp__ = WVCoxRds*d_Abulk_d_v_vdpvsp__+d_WVCoxRds_d_v_vdpvsp__*Abulk;
        d_T9_d_v_vbvsp__ = WVCoxRds*d_Abulk_d_v_vbvsp__+d_WVCoxRds_d_v_vbvsp__*Abulk;
    T9 = WVCoxRds*Abulk;
        d_T1_d_v_vgvb__ = ((-(2*d_Lambda_d_v_vgvb__)/Lambda^2))+d_T9_d_v_vgvb__;
        d_T1_d_v_vdpvsp__ = ((-(2*d_Lambda_d_v_vdpvsp__)/Lambda^2))+d_T9_d_v_vdpvsp__;
        d_T1_d_v_vbvsp__ = ((-(2*d_Lambda_d_v_vbvsp__)/Lambda^2))+d_T9_d_v_vbvsp__;
    T1 = (2/Lambda-1)+T9;
        d_Vasat_d_v_vgvb__ = d_T0_d_v_vgvb__/T1-(T0*d_T1_d_v_vgvb__)/T1^2;
        d_Vasat_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__/T1-(T0*d_T1_d_v_vdpvsp__)/T1^2;
        d_Vasat_d_v_vbvsp__ = d_T0_d_v_vbvsp__/T1-(T0*d_T1_d_v_vbvsp__)/T1^2;
    Vasat = T0/T1;
    if Vdseff>Vds
            d_Vdseff_d_v_vgvb__ = 0;
            d_Vdseff_d_v_vdpvsp__ = d_Vds_d_v_vdpvsp__;
            d_Vdseff_d_v_vbvsp__ = 0;
        Vdseff = Vds;
    end
        d_diffVds_d_v_vgvb__ = -d_Vdseff_d_v_vgvb__;
        d_diffVds_d_v_vdpvsp__ = d_Vds_d_v_vdpvsp__-d_Vdseff_d_v_vdpvsp__;
        d_diffVds_d_v_vbvsp__ = -d_Vdseff_d_v_vbvsp__;
    diffVds = Vds-Vdseff;
        d_BSIM3Vdseff_d_v_vgvb__ = d_Vdseff_d_v_vgvb__;
        d_BSIM3Vdseff_d_v_vdpvsp__ = d_Vdseff_d_v_vdpvsp__;
        d_BSIM3Vdseff_d_v_vbvsp__ = d_Vdseff_d_v_vbvsp__;
    BSIM3Vdseff = Vdseff;
    if BSIM3pclm>0&&diffVds>1e-10
            d_T0_d_v_vgvb__ = -(1*((BSIM3pclm*d_Abulk_d_v_vgvb__)*BSIM3litl))/((BSIM3pclm*Abulk)*BSIM3litl)^2;
            d_T0_d_v_vdpvsp__ = -(1*((BSIM3pclm*d_Abulk_d_v_vdpvsp__)*BSIM3litl))/((BSIM3pclm*Abulk)*BSIM3litl)^2;
            d_T0_d_v_vbvsp__ = -(1*((BSIM3pclm*d_Abulk_d_v_vbvsp__)*BSIM3litl))/((BSIM3pclm*Abulk)*BSIM3litl)^2;
        T0 = 1/((BSIM3pclm*Abulk)*BSIM3litl);
            d_T2_d_v_vgvb__ = d_Vgsteff_d_v_vgvb__/EsatL-(Vgsteff*d_EsatL_d_v_vgvb__)/EsatL^2;
            d_T2_d_v_vdpvsp__ = d_Vgsteff_d_v_vdpvsp__/EsatL-(Vgsteff*d_EsatL_d_v_vdpvsp__)/EsatL^2;
            d_T2_d_v_vbvsp__ = d_Vgsteff_d_v_vbvsp__/EsatL-(Vgsteff*d_EsatL_d_v_vbvsp__)/EsatL^2;
        T2 = Vgsteff/EsatL;
            d_T1_d_v_vgvb__ = Leff*(d_Abulk_d_v_vgvb__+d_T2_d_v_vgvb__);
            d_T1_d_v_vdpvsp__ = Leff*(d_Abulk_d_v_vdpvsp__+d_T2_d_v_vdpvsp__);
            d_T1_d_v_vbvsp__ = Leff*(d_Abulk_d_v_vbvsp__+d_T2_d_v_vbvsp__);
        T1 = Leff*(Abulk+T2);
            d_T9_d_v_vgvb__ = T0*d_T1_d_v_vgvb__+d_T0_d_v_vgvb__*T1;
            d_T9_d_v_vdpvsp__ = T0*d_T1_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T1;
            d_T9_d_v_vbvsp__ = T0*d_T1_d_v_vbvsp__+d_T0_d_v_vbvsp__*T1;
        T9 = T0*T1;
            d_VACLM_d_v_vgvb__ = T9*d_diffVds_d_v_vgvb__+d_T9_d_v_vgvb__*diffVds;
            d_VACLM_d_v_vdpvsp__ = T9*d_diffVds_d_v_vdpvsp__+d_T9_d_v_vdpvsp__*diffVds;
            d_VACLM_d_v_vbvsp__ = T9*d_diffVds_d_v_vbvsp__+d_T9_d_v_vbvsp__*diffVds;
        VACLM = T9*diffVds;
    else
            d_VACLM_d_v_vgvb__ = 0;
            d_VACLM_d_v_vdpvsp__ = 0;
            d_VACLM_d_v_vbvsp__ = 0;
        VACLM = 583461742500000;
    end
    if BSIM3thetaRout>0
            d_T8_d_v_vgvb__ = Abulk*d_Vdsat_d_v_vgvb__+d_Abulk_d_v_vgvb__*Vdsat;
            d_T8_d_v_vdpvsp__ = Abulk*d_Vdsat_d_v_vdpvsp__+d_Abulk_d_v_vdpvsp__*Vdsat;
            d_T8_d_v_vbvsp__ = Abulk*d_Vdsat_d_v_vbvsp__+d_Abulk_d_v_vbvsp__*Vdsat;
        T8 = Abulk*Vdsat;
            d_T0_d_v_vgvb__ = Vgst2Vtm*d_T8_d_v_vgvb__+d_Vgst2Vtm_d_v_vgvb__*T8;
            d_T0_d_v_vdpvsp__ = Vgst2Vtm*d_T8_d_v_vdpvsp__+d_Vgst2Vtm_d_v_vdpvsp__*T8;
            d_T0_d_v_vbvsp__ = Vgst2Vtm*d_T8_d_v_vbvsp__+d_Vgst2Vtm_d_v_vbvsp__*T8;
        T0 = Vgst2Vtm*T8;
            d_T1_d_v_vgvb__ = d_Vgst2Vtm_d_v_vgvb__+d_T8_d_v_vgvb__;
            d_T1_d_v_vdpvsp__ = d_Vgst2Vtm_d_v_vdpvsp__+d_T8_d_v_vdpvsp__;
            d_T1_d_v_vbvsp__ = d_Vgst2Vtm_d_v_vbvsp__+d_T8_d_v_vbvsp__;
        T1 = Vgst2Vtm+T8;
            d_T2_d_v_vgvb__ = 0;
            d_T2_d_v_vdpvsp__ = 0;
            d_T2_d_v_vbvsp__ = 0;
        T2 = BSIM3thetaRout;
            d_VADIBL_d_v_vgvb__ = (d_Vgst2Vtm_d_v_vgvb__-(d_T0_d_v_vgvb__/T1-(T0*d_T1_d_v_vgvb__)/T1^2))/T2-((Vgst2Vtm-T0/T1)*d_T2_d_v_vgvb__)/T2^2;
            d_VADIBL_d_v_vdpvsp__ = (d_Vgst2Vtm_d_v_vdpvsp__-(d_T0_d_v_vdpvsp__/T1-(T0*d_T1_d_v_vdpvsp__)/T1^2))/T2-((Vgst2Vtm-T0/T1)*d_T2_d_v_vdpvsp__)/T2^2;
            d_VADIBL_d_v_vbvsp__ = (d_Vgst2Vtm_d_v_vbvsp__-(d_T0_d_v_vbvsp__/T1-(T0*d_T1_d_v_vbvsp__)/T1^2))/T2-((Vgst2Vtm-T0/T1)*d_T2_d_v_vbvsp__)/T2^2;
        VADIBL = (Vgst2Vtm-T0/T1)/T2;
            d_T7_d_v_vgvb__ = 0;
            d_T7_d_v_vdpvsp__ = BSIM3pdiblb*d_Vbseff_d_v_vdpvsp__;
            d_T7_d_v_vbvsp__ = BSIM3pdiblb*d_Vbseff_d_v_vbvsp__;
        T7 = BSIM3pdiblb*Vbseff;
        if T7>=-0.9
                d_T3_d_v_vgvb__ = -(1*(d_T7_d_v_vgvb__))/(1+T7)^2;
                d_T3_d_v_vdpvsp__ = -(1*(d_T7_d_v_vdpvsp__))/(1+T7)^2;
                d_T3_d_v_vbvsp__ = -(1*(d_T7_d_v_vbvsp__))/(1+T7)^2;
            T3 = 1/(1+T7);
                d_VADIBL_d_v_vgvb__ = VADIBL*d_T3_d_v_vgvb__+d_VADIBL_d_v_vgvb__*T3;
                d_VADIBL_d_v_vdpvsp__ = VADIBL*d_T3_d_v_vdpvsp__+d_VADIBL_d_v_vdpvsp__*T3;
                d_VADIBL_d_v_vbvsp__ = VADIBL*d_T3_d_v_vbvsp__+d_VADIBL_d_v_vbvsp__*T3;
            VADIBL = VADIBL*T3;
        else
                d_T4_d_v_vgvb__ = -(1*(d_T7_d_v_vgvb__))/(0.8+T7)^2;
                d_T4_d_v_vdpvsp__ = -(1*(d_T7_d_v_vdpvsp__))/(0.8+T7)^2;
                d_T4_d_v_vbvsp__ = -(1*(d_T7_d_v_vbvsp__))/(0.8+T7)^2;
            T4 = 1/(0.8+T7);
                d_T3_d_v_vgvb__ = (17+20*T7)*d_T4_d_v_vgvb__+((20*d_T7_d_v_vgvb__))*T4;
                d_T3_d_v_vdpvsp__ = (17+20*T7)*d_T4_d_v_vdpvsp__+((20*d_T7_d_v_vdpvsp__))*T4;
                d_T3_d_v_vbvsp__ = (17+20*T7)*d_T4_d_v_vbvsp__+((20*d_T7_d_v_vbvsp__))*T4;
            T3 = (17+20*T7)*T4;
                d_VADIBL_d_v_vgvb__ = VADIBL*d_T3_d_v_vgvb__+d_VADIBL_d_v_vgvb__*T3;
                d_VADIBL_d_v_vdpvsp__ = VADIBL*d_T3_d_v_vdpvsp__+d_VADIBL_d_v_vdpvsp__*T3;
                d_VADIBL_d_v_vbvsp__ = VADIBL*d_T3_d_v_vbvsp__+d_VADIBL_d_v_vbvsp__*T3;
            VADIBL = VADIBL*T3;
        end
    else
            d_VADIBL_d_v_vgvb__ = 0;
            d_VADIBL_d_v_vdpvsp__ = 0;
            d_VADIBL_d_v_vbvsp__ = 0;
        VADIBL = 583461742500000;
    end
        d_T8_d_v_vgvb__ = -(BSIM3pvag*d_EsatL_d_v_vgvb__)/EsatL^2;
        d_T8_d_v_vdpvsp__ = -(BSIM3pvag*d_EsatL_d_v_vdpvsp__)/EsatL^2;
        d_T8_d_v_vbvsp__ = -(BSIM3pvag*d_EsatL_d_v_vbvsp__)/EsatL^2;
    T8 = BSIM3pvag/EsatL;
        d_T9_d_v_vgvb__ = T8*d_Vgsteff_d_v_vgvb__+d_T8_d_v_vgvb__*Vgsteff;
        d_T9_d_v_vdpvsp__ = T8*d_Vgsteff_d_v_vdpvsp__+d_T8_d_v_vdpvsp__*Vgsteff;
        d_T9_d_v_vbvsp__ = T8*d_Vgsteff_d_v_vbvsp__+d_T8_d_v_vbvsp__*Vgsteff;
    T9 = T8*Vgsteff;
    if T9>-0.9
            d_T0_d_v_vgvb__ = d_T9_d_v_vgvb__;
            d_T0_d_v_vdpvsp__ = d_T9_d_v_vdpvsp__;
            d_T0_d_v_vbvsp__ = d_T9_d_v_vbvsp__;
        T0 = 1+T9;
    else
            d_T1_d_v_vgvb__ = -(1*((20*d_T9_d_v_vgvb__)))/(17+20*T9)^2;
            d_T1_d_v_vdpvsp__ = -(1*((20*d_T9_d_v_vdpvsp__)))/(17+20*T9)^2;
            d_T1_d_v_vbvsp__ = -(1*((20*d_T9_d_v_vbvsp__)))/(17+20*T9)^2;
        T1 = 1/(17+20*T9);
            d_T0_d_v_vgvb__ = (0.8+T9)*d_T1_d_v_vgvb__+(d_T9_d_v_vgvb__)*T1;
            d_T0_d_v_vdpvsp__ = (0.8+T9)*d_T1_d_v_vdpvsp__+(d_T9_d_v_vdpvsp__)*T1;
            d_T0_d_v_vbvsp__ = (0.8+T9)*d_T1_d_v_vbvsp__+(d_T9_d_v_vbvsp__)*T1;
        T0 = (0.8+T9)*T1;
    end
        d_tmp3_d_v_vgvb__ = d_VACLM_d_v_vgvb__+d_VADIBL_d_v_vgvb__;
        d_tmp3_d_v_vdpvsp__ = d_VACLM_d_v_vdpvsp__+d_VADIBL_d_v_vdpvsp__;
        d_tmp3_d_v_vbvsp__ = d_VACLM_d_v_vbvsp__+d_VADIBL_d_v_vbvsp__;
    tmp3 = VACLM+VADIBL;
        d_T1_d_v_vgvb__ = (VACLM*d_VADIBL_d_v_vgvb__+d_VACLM_d_v_vgvb__*VADIBL)/tmp3-((VACLM*VADIBL)*d_tmp3_d_v_vgvb__)/tmp3^2;
        d_T1_d_v_vdpvsp__ = (VACLM*d_VADIBL_d_v_vdpvsp__+d_VACLM_d_v_vdpvsp__*VADIBL)/tmp3-((VACLM*VADIBL)*d_tmp3_d_v_vdpvsp__)/tmp3^2;
        d_T1_d_v_vbvsp__ = (VACLM*d_VADIBL_d_v_vbvsp__+d_VACLM_d_v_vbvsp__*VADIBL)/tmp3-((VACLM*VADIBL)*d_tmp3_d_v_vbvsp__)/tmp3^2;
    T1 = (VACLM*VADIBL)/tmp3;
        d_Va_d_v_vgvb__ = d_Vasat_d_v_vgvb__+(T0*d_T1_d_v_vgvb__+d_T0_d_v_vgvb__*T1);
        d_Va_d_v_vdpvsp__ = d_Vasat_d_v_vdpvsp__+(T0*d_T1_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T1);
        d_Va_d_v_vbvsp__ = d_Vasat_d_v_vbvsp__+(T0*d_T1_d_v_vbvsp__+d_T0_d_v_vbvsp__*T1);
    Va = Vasat+T0*T1;
    if BSIM3pscbe2>0
        if diffVds>(BSIM3pscbe1*BSIM3litl)/34
                d_T0_d_v_vgvb__ = -((BSIM3pscbe1*BSIM3litl)*d_diffVds_d_v_vgvb__)/diffVds^2;
                d_T0_d_v_vdpvsp__ = -((BSIM3pscbe1*BSIM3litl)*d_diffVds_d_v_vdpvsp__)/diffVds^2;
                d_T0_d_v_vbvsp__ = -((BSIM3pscbe1*BSIM3litl)*d_diffVds_d_v_vbvsp__)/diffVds^2;
            T0 = (BSIM3pscbe1*BSIM3litl)/diffVds;
                d_VASCBE_d_v_vgvb__ = (Leff*(exp(T0)*d_T0_d_v_vgvb__))/BSIM3pscbe2;
                d_VASCBE_d_v_vdpvsp__ = (Leff*(exp(T0)*d_T0_d_v_vdpvsp__))/BSIM3pscbe2;
                d_VASCBE_d_v_vbvsp__ = (Leff*(exp(T0)*d_T0_d_v_vbvsp__))/BSIM3pscbe2;
            VASCBE = (Leff*exp(T0))/BSIM3pscbe2;
                d_T1_d_v_vgvb__ = (T0*d_VASCBE_d_v_vgvb__+d_T0_d_v_vgvb__*VASCBE)/diffVds-((T0*VASCBE)*d_diffVds_d_v_vgvb__)/diffVds^2;
                d_T1_d_v_vdpvsp__ = (T0*d_VASCBE_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*VASCBE)/diffVds-((T0*VASCBE)*d_diffVds_d_v_vdpvsp__)/diffVds^2;
                d_T1_d_v_vbvsp__ = (T0*d_VASCBE_d_v_vbvsp__+d_T0_d_v_vbvsp__*VASCBE)/diffVds-((T0*VASCBE)*d_diffVds_d_v_vbvsp__)/diffVds^2;
            T1 = (T0*VASCBE)/diffVds;
        else
                d_VASCBE_d_v_vgvb__ = 0;
                d_VASCBE_d_v_vdpvsp__ = 0;
                d_VASCBE_d_v_vbvsp__ = 0;
            VASCBE = (583461742500000*Leff)/BSIM3pscbe2;
        end
    else
            d_VASCBE_d_v_vgvb__ = 0;
            d_VASCBE_d_v_vdpvsp__ = 0;
            d_VASCBE_d_v_vbvsp__ = 0;
        VASCBE = 583461742500000;
    end
        d_CoxWovL_d_v_vgvb__ = (BSIM3cox*d_Weff_d_v_vgvb__)/Leff;
        d_CoxWovL_d_v_vdpvsp__ = (BSIM3cox*d_Weff_d_v_vdpvsp__)/Leff;
        d_CoxWovL_d_v_vbvsp__ = (BSIM3cox*d_Weff_d_v_vbvsp__)/Leff;
    CoxWovL = (BSIM3cox*Weff)/Leff;
        d_beta_d_v_vgvb__ = ueff*d_CoxWovL_d_v_vgvb__+d_ueff_d_v_vgvb__*CoxWovL;
        d_beta_d_v_vdpvsp__ = ueff*d_CoxWovL_d_v_vdpvsp__+d_ueff_d_v_vdpvsp__*CoxWovL;
        d_beta_d_v_vbvsp__ = ueff*d_CoxWovL_d_v_vbvsp__+d_ueff_d_v_vbvsp__*CoxWovL;
    beta = ueff*CoxWovL;
        d_T0_d_v_vgvb__ = -(((0.5*Abulk)*d_Vdseff_d_v_vgvb__+(0.5*d_Abulk_d_v_vgvb__)*Vdseff)/Vgst2Vtm-(((0.5*Abulk)*Vdseff)*d_Vgst2Vtm_d_v_vgvb__)/Vgst2Vtm^2);
        d_T0_d_v_vdpvsp__ = -(((0.5*Abulk)*d_Vdseff_d_v_vdpvsp__+(0.5*d_Abulk_d_v_vdpvsp__)*Vdseff)/Vgst2Vtm-(((0.5*Abulk)*Vdseff)*d_Vgst2Vtm_d_v_vdpvsp__)/Vgst2Vtm^2);
        d_T0_d_v_vbvsp__ = -(((0.5*Abulk)*d_Vdseff_d_v_vbvsp__+(0.5*d_Abulk_d_v_vbvsp__)*Vdseff)/Vgst2Vtm-(((0.5*Abulk)*Vdseff)*d_Vgst2Vtm_d_v_vbvsp__)/Vgst2Vtm^2);
    T0 = 1-((0.5*Abulk)*Vdseff)/Vgst2Vtm;
        d_fgche1_d_v_vgvb__ = Vgsteff*d_T0_d_v_vgvb__+d_Vgsteff_d_v_vgvb__*T0;
        d_fgche1_d_v_vdpvsp__ = Vgsteff*d_T0_d_v_vdpvsp__+d_Vgsteff_d_v_vdpvsp__*T0;
        d_fgche1_d_v_vbvsp__ = Vgsteff*d_T0_d_v_vbvsp__+d_Vgsteff_d_v_vbvsp__*T0;
    fgche1 = Vgsteff*T0;
        d_T9_d_v_vgvb__ = d_Vdseff_d_v_vgvb__/EsatL-(Vdseff*d_EsatL_d_v_vgvb__)/EsatL^2;
        d_T9_d_v_vdpvsp__ = d_Vdseff_d_v_vdpvsp__/EsatL-(Vdseff*d_EsatL_d_v_vdpvsp__)/EsatL^2;
        d_T9_d_v_vbvsp__ = d_Vdseff_d_v_vbvsp__/EsatL-(Vdseff*d_EsatL_d_v_vbvsp__)/EsatL^2;
    T9 = Vdseff/EsatL;
        d_fgche2_d_v_vgvb__ = d_T9_d_v_vgvb__;
        d_fgche2_d_v_vdpvsp__ = d_T9_d_v_vdpvsp__;
        d_fgche2_d_v_vbvsp__ = d_T9_d_v_vbvsp__;
    fgche2 = 1+T9;
        d_gche_d_v_vgvb__ = (beta*d_fgche1_d_v_vgvb__+d_beta_d_v_vgvb__*fgche1)/fgche2-((beta*fgche1)*d_fgche2_d_v_vgvb__)/fgche2^2;
        d_gche_d_v_vdpvsp__ = (beta*d_fgche1_d_v_vdpvsp__+d_beta_d_v_vdpvsp__*fgche1)/fgche2-((beta*fgche1)*d_fgche2_d_v_vdpvsp__)/fgche2^2;
        d_gche_d_v_vbvsp__ = (beta*d_fgche1_d_v_vbvsp__+d_beta_d_v_vbvsp__*fgche1)/fgche2-((beta*fgche1)*d_fgche2_d_v_vbvsp__)/fgche2^2;
    gche = (beta*fgche1)/fgche2;
        d_T0_d_v_vgvb__ = (gche*d_Rds_d_v_vgvb__+d_gche_d_v_vgvb__*Rds);
        d_T0_d_v_vdpvsp__ = (gche*d_Rds_d_v_vdpvsp__+d_gche_d_v_vdpvsp__*Rds);
        d_T0_d_v_vbvsp__ = (gche*d_Rds_d_v_vbvsp__+d_gche_d_v_vbvsp__*Rds);
    T0 = 1+gche*Rds;
        d_T9_d_v_vgvb__ = d_Vdseff_d_v_vgvb__/T0-(Vdseff*d_T0_d_v_vgvb__)/T0^2;
        d_T9_d_v_vdpvsp__ = d_Vdseff_d_v_vdpvsp__/T0-(Vdseff*d_T0_d_v_vdpvsp__)/T0^2;
        d_T9_d_v_vbvsp__ = d_Vdseff_d_v_vbvsp__/T0-(Vdseff*d_T0_d_v_vbvsp__)/T0^2;
    T9 = Vdseff/T0;
        d_Idl_d_v_vgvb__ = gche*d_T9_d_v_vgvb__+d_gche_d_v_vgvb__*T9;
        d_Idl_d_v_vdpvsp__ = gche*d_T9_d_v_vdpvsp__+d_gche_d_v_vdpvsp__*T9;
        d_Idl_d_v_vbvsp__ = gche*d_T9_d_v_vbvsp__+d_gche_d_v_vbvsp__*T9;
    Idl = gche*T9;
        d_T9_d_v_vgvb__ = d_diffVds_d_v_vgvb__/Va-(diffVds*d_Va_d_v_vgvb__)/Va^2;
        d_T9_d_v_vdpvsp__ = d_diffVds_d_v_vdpvsp__/Va-(diffVds*d_Va_d_v_vdpvsp__)/Va^2;
        d_T9_d_v_vbvsp__ = d_diffVds_d_v_vbvsp__/Va-(diffVds*d_Va_d_v_vbvsp__)/Va^2;
    T9 = diffVds/Va;
        d_T0_d_v_vgvb__ = d_T9_d_v_vgvb__;
        d_T0_d_v_vdpvsp__ = d_T9_d_v_vdpvsp__;
        d_T0_d_v_vbvsp__ = d_T9_d_v_vbvsp__;
    T0 = 1+T9;
        d_Idsa_d_v_vgvb__ = Idl*d_T0_d_v_vgvb__+d_Idl_d_v_vgvb__*T0;
        d_Idsa_d_v_vdpvsp__ = Idl*d_T0_d_v_vdpvsp__+d_Idl_d_v_vdpvsp__*T0;
        d_Idsa_d_v_vbvsp__ = Idl*d_T0_d_v_vbvsp__+d_Idl_d_v_vbvsp__*T0;
    Idsa = Idl*T0;
        d_T9_d_v_vgvb__ = d_diffVds_d_v_vgvb__/VASCBE-(diffVds*d_VASCBE_d_v_vgvb__)/VASCBE^2;
        d_T9_d_v_vdpvsp__ = d_diffVds_d_v_vdpvsp__/VASCBE-(diffVds*d_VASCBE_d_v_vdpvsp__)/VASCBE^2;
        d_T9_d_v_vbvsp__ = d_diffVds_d_v_vbvsp__/VASCBE-(diffVds*d_VASCBE_d_v_vbvsp__)/VASCBE^2;
    T9 = diffVds/VASCBE;
        d_T0_d_v_vgvb__ = d_T9_d_v_vgvb__;
        d_T0_d_v_vdpvsp__ = d_T9_d_v_vdpvsp__;
        d_T0_d_v_vbvsp__ = d_T9_d_v_vbvsp__;
    T0 = 1+T9;
        d_Ids_d_v_vgvb__ = Idsa*d_T0_d_v_vgvb__+d_Idsa_d_v_vgvb__*T0;
        d_Ids_d_v_vdpvsp__ = Idsa*d_T0_d_v_vdpvsp__+d_Idsa_d_v_vdpvsp__*T0;
        d_Ids_d_v_vbvsp__ = Idsa*d_T0_d_v_vbvsp__+d_Idsa_d_v_vbvsp__*T0;
    Ids = Idsa*T0;
        d_tmp_d_v_vgvb__ = 0;
        d_tmp_d_v_vdpvsp__ = 0;
        d_tmp_d_v_vbvsp__ = 0;
    tmp = BSIM3alpha0+BSIM3alpha1*Leff;
    if tmp<=0||BSIM3beta0<=0
            d_Isub_d_v_vgvb__ = 0;
            d_Isub_d_v_vdpvsp__ = 0;
            d_Isub_d_v_vbvsp__ = 0;
        Isub = 0;
    else
            d_T2_d_v_vgvb__ = d_tmp_d_v_vgvb__/Leff;
            d_T2_d_v_vdpvsp__ = d_tmp_d_v_vdpvsp__/Leff;
            d_T2_d_v_vbvsp__ = d_tmp_d_v_vbvsp__/Leff;
        T2 = tmp/Leff;
        if diffVds>BSIM3beta0/34
                d_T0_d_v_vgvb__ = -(-BSIM3beta0*d_diffVds_d_v_vgvb__)/diffVds^2;
                d_T0_d_v_vdpvsp__ = -(-BSIM3beta0*d_diffVds_d_v_vdpvsp__)/diffVds^2;
                d_T0_d_v_vbvsp__ = -(-BSIM3beta0*d_diffVds_d_v_vbvsp__)/diffVds^2;
            T0 = -BSIM3beta0/diffVds;
                d_T1_d_v_vgvb__ = (T2*diffVds)*(exp(T0)*d_T0_d_v_vgvb__)+(T2*d_diffVds_d_v_vgvb__+d_T2_d_v_vgvb__*diffVds)*exp(T0);
                d_T1_d_v_vdpvsp__ = (T2*diffVds)*(exp(T0)*d_T0_d_v_vdpvsp__)+(T2*d_diffVds_d_v_vdpvsp__+d_T2_d_v_vdpvsp__*diffVds)*exp(T0);
                d_T1_d_v_vbvsp__ = (T2*diffVds)*(exp(T0)*d_T0_d_v_vbvsp__)+(T2*d_diffVds_d_v_vbvsp__+d_T2_d_v_vbvsp__*diffVds)*exp(T0);
            T1 = (T2*diffVds)*exp(T0);
        else
                d_T3_d_v_vgvb__ = d_T2_d_v_vgvb__*1.7139e-15;
                d_T3_d_v_vdpvsp__ = d_T2_d_v_vdpvsp__*1.7139e-15;
                d_T3_d_v_vbvsp__ = d_T2_d_v_vbvsp__*1.7139e-15;
            T3 = T2*1.7139e-15;
                d_T1_d_v_vgvb__ = T3*d_diffVds_d_v_vgvb__+d_T3_d_v_vgvb__*diffVds;
                d_T1_d_v_vdpvsp__ = T3*d_diffVds_d_v_vdpvsp__+d_T3_d_v_vdpvsp__*diffVds;
                d_T1_d_v_vbvsp__ = T3*d_diffVds_d_v_vbvsp__+d_T3_d_v_vbvsp__*diffVds;
            T1 = T3*diffVds;
        end
            d_Isub_d_v_vgvb__ = T1*d_Idsa_d_v_vgvb__+d_T1_d_v_vgvb__*Idsa;
            d_Isub_d_v_vdpvsp__ = T1*d_Idsa_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*Idsa;
            d_Isub_d_v_vbvsp__ = T1*d_Idsa_d_v_vbvsp__+d_T1_d_v_vbvsp__*Idsa;
        Isub = T1*Idsa;
    end
    if BSIM3xpart<0
            d_qgate_d_v_vgvb__ = 0;
            d_qgate_d_v_vdpvsp__ = 0;
            d_qgate_d_v_vbvsp__ = 0;
        qgate = 0;
            d_qdrn_d_v_vgvb__ = 0;
            d_qdrn_d_v_vdpvsp__ = 0;
            d_qdrn_d_v_vbvsp__ = 0;
        qdrn = 0;
            d_qsrc_d_v_vgvb__ = 0;
            d_qsrc_d_v_vdpvsp__ = 0;
            d_qsrc_d_v_vbvsp__ = 0;
        qsrc = 0;
            d_qbulk_d_v_vgvb__ = 0;
            d_qbulk_d_v_vdpvsp__ = 0;
            d_qbulk_d_v_vbvsp__ = 0;
        qbulk = 0;
    else
        if BSIM3capMod==0
            if Vbseff<0
                    d_Vbseff_d_v_vdpvsp__ = d_Vbs_d_v_vdpvsp__;
                    d_Vbseff_d_v_vbvsp__ = d_Vbs_d_v_vbvsp__;
                Vbseff = Vbs;
            else
                    d_Vbseff_d_v_vdpvsp__ = -d_Phis_d_v_vdpvsp__;
                    d_Vbseff_d_v_vbvsp__ = -d_Phis_d_v_vbvsp__;
                Vbseff = BSIM3phi-Phis;
            end
            Vfb = BSIM3vfbcv;
                d_Vth_d_v_vdpvsp__ = (BSIM3k1ox*d_sqrtPhis_d_v_vdpvsp__);
                d_Vth_d_v_vbvsp__ = (BSIM3k1ox*d_sqrtPhis_d_v_vbvsp__);
            Vth = (Vfb+BSIM3phi)+BSIM3k1ox*sqrtPhis;
                d_Vgst_d_v_vgvb__ = d_Vgs_eff_d_v_vgvb__;
                d_Vgst_d_v_vdpvsp__ = d_Vgs_eff_d_v_vdpvsp__-d_Vth_d_v_vdpvsp__;
                d_Vgst_d_v_vbvsp__ = d_Vgs_eff_d_v_vbvsp__-d_Vth_d_v_vbvsp__;
            Vgst = Vgs_eff-Vth;
            CoxWL = (BSIM3cox*BSIM3weffCV)*BSIM3leffCV;
                d_Arg1_d_v_vgvb__ = (d_Vgs_eff_d_v_vgvb__);
                d_Arg1_d_v_vdpvsp__ = (d_Vgs_eff_d_v_vdpvsp__-d_Vbseff_d_v_vdpvsp__);
                d_Arg1_d_v_vbvsp__ = (d_Vgs_eff_d_v_vbvsp__-d_Vbseff_d_v_vbvsp__);
            Arg1 = (Vgs_eff-Vbseff)-Vfb;
            if Arg1<=0
                    d_qgate_d_v_vgvb__ = CoxWL*d_Arg1_d_v_vgvb__;
                    d_qgate_d_v_vdpvsp__ = CoxWL*d_Arg1_d_v_vdpvsp__;
                    d_qgate_d_v_vbvsp__ = CoxWL*d_Arg1_d_v_vbvsp__;
                qgate = CoxWL*Arg1;
                    d_qbulk_d_v_vgvb__ = -d_qgate_d_v_vgvb__;
                    d_qbulk_d_v_vdpvsp__ = -d_qgate_d_v_vdpvsp__;
                    d_qbulk_d_v_vbvsp__ = -d_qgate_d_v_vbvsp__;
                qbulk = -qgate;
                    d_qdrn_d_v_vgvb__ = 0;
                    d_qdrn_d_v_vdpvsp__ = 0;
                    d_qdrn_d_v_vbvsp__ = 0;
                qdrn = 0;
            else
                if Vgst<=0
                        d_T1_d_v_vgvb__ = 0;
                        d_T1_d_v_vdpvsp__ = 0;
                        d_T1_d_v_vbvsp__ = 0;
                    T1 = 0.5*BSIM3k1ox;
                        d_T2_d_v_vgvb__ = (1/(2*sqrt(T1*T1+Arg1)))*((T1*d_T1_d_v_vgvb__+d_T1_d_v_vgvb__*T1)+d_Arg1_d_v_vgvb__);
                        d_T2_d_v_vdpvsp__ = (1/(2*sqrt(T1*T1+Arg1)))*((T1*d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*T1)+d_Arg1_d_v_vdpvsp__);
                        d_T2_d_v_vbvsp__ = (1/(2*sqrt(T1*T1+Arg1)))*((T1*d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__*T1)+d_Arg1_d_v_vbvsp__);
                    T2 = sqrt(T1*T1+Arg1);
                        d_qgate_d_v_vgvb__ = (CoxWL*BSIM3k1ox)*(d_T2_d_v_vgvb__-d_T1_d_v_vgvb__);
                        d_qgate_d_v_vdpvsp__ = (CoxWL*BSIM3k1ox)*(d_T2_d_v_vdpvsp__-d_T1_d_v_vdpvsp__);
                        d_qgate_d_v_vbvsp__ = (CoxWL*BSIM3k1ox)*(d_T2_d_v_vbvsp__-d_T1_d_v_vbvsp__);
                    qgate = (CoxWL*BSIM3k1ox)*(T2-T1);
                        d_qbulk_d_v_vgvb__ = -d_qgate_d_v_vgvb__;
                        d_qbulk_d_v_vdpvsp__ = -d_qgate_d_v_vdpvsp__;
                        d_qbulk_d_v_vbvsp__ = -d_qgate_d_v_vbvsp__;
                    qbulk = -qgate;
                        d_qdrn_d_v_vgvb__ = 0;
                        d_qdrn_d_v_vdpvsp__ = 0;
                        d_qdrn_d_v_vbvsp__ = 0;
                    qdrn = 0;
                else
                        d_One_Third_CoxWL_d_v_vgvb__ = 0;
                        d_One_Third_CoxWL_d_v_vdpvsp__ = 0;
                        d_One_Third_CoxWL_d_v_vbvsp__ = 0;
                    One_Third_CoxWL = CoxWL/3;
                        d_Two_Third_CoxWL_d_v_vgvb__ = 2*d_One_Third_CoxWL_d_v_vgvb__;
                        d_Two_Third_CoxWL_d_v_vdpvsp__ = 2*d_One_Third_CoxWL_d_v_vdpvsp__;
                        d_Two_Third_CoxWL_d_v_vbvsp__ = 2*d_One_Third_CoxWL_d_v_vbvsp__;
                    Two_Third_CoxWL = 2*One_Third_CoxWL;
                        d_AbulkCV_d_v_vgvb__ = d_Abulk0_d_v_vgvb__*BSIM3abulkCVfactor;
                        d_AbulkCV_d_v_vdpvsp__ = d_Abulk0_d_v_vdpvsp__*BSIM3abulkCVfactor;
                        d_AbulkCV_d_v_vbvsp__ = d_Abulk0_d_v_vbvsp__*BSIM3abulkCVfactor;
                    AbulkCV = Abulk0*BSIM3abulkCVfactor;
                        d_Vdsat_d_v_vgvb__ = d_Vgst_d_v_vgvb__/AbulkCV-(Vgst*d_AbulkCV_d_v_vgvb__)/AbulkCV^2;
                        d_Vdsat_d_v_vdpvsp__ = d_Vgst_d_v_vdpvsp__/AbulkCV-(Vgst*d_AbulkCV_d_v_vdpvsp__)/AbulkCV^2;
                        d_Vdsat_d_v_vbvsp__ = d_Vgst_d_v_vbvsp__/AbulkCV-(Vgst*d_AbulkCV_d_v_vbvsp__)/AbulkCV^2;
                    Vdsat = Vgst/AbulkCV;
                    if BSIM3xpart>0.5
                        if Vdsat<=Vds
                                d_T1_d_v_vgvb__ = d_Vdsat_d_v_vgvb__/3;
                                d_T1_d_v_vdpvsp__ = d_Vdsat_d_v_vdpvsp__/3;
                                d_T1_d_v_vbvsp__ = d_Vdsat_d_v_vbvsp__/3;
                            T1 = Vdsat/3;
                                d_qgate_d_v_vgvb__ = CoxWL*(((d_Vgs_eff_d_v_vgvb__))-d_T1_d_v_vgvb__);
                                d_qgate_d_v_vdpvsp__ = CoxWL*(((d_Vgs_eff_d_v_vdpvsp__))-d_T1_d_v_vdpvsp__);
                                d_qgate_d_v_vbvsp__ = CoxWL*(((d_Vgs_eff_d_v_vbvsp__))-d_T1_d_v_vbvsp__);
                            qgate = CoxWL*(((Vgs_eff-Vfb)-BSIM3phi)-T1);
                                d_T2_d_v_vgvb__ = -Two_Third_CoxWL*d_Vgst_d_v_vgvb__+-d_Two_Third_CoxWL_d_v_vgvb__*Vgst;
                                d_T2_d_v_vdpvsp__ = -Two_Third_CoxWL*d_Vgst_d_v_vdpvsp__+-d_Two_Third_CoxWL_d_v_vdpvsp__*Vgst;
                                d_T2_d_v_vbvsp__ = -Two_Third_CoxWL*d_Vgst_d_v_vbvsp__+-d_Two_Third_CoxWL_d_v_vbvsp__*Vgst;
                            T2 = -Two_Third_CoxWL*Vgst;
                                d_qbulk_d_v_vgvb__ = -(d_qgate_d_v_vgvb__+d_T2_d_v_vgvb__);
                                d_qbulk_d_v_vdpvsp__ = -(d_qgate_d_v_vdpvsp__+d_T2_d_v_vdpvsp__);
                                d_qbulk_d_v_vbvsp__ = -(d_qgate_d_v_vbvsp__+d_T2_d_v_vbvsp__);
                            qbulk = -(qgate+T2);
                                d_qdrn_d_v_vgvb__ = 0;
                                d_qdrn_d_v_vdpvsp__ = 0;
                                d_qdrn_d_v_vbvsp__ = 0;
                            qdrn = 0;
                        else
                                d_Alphaz_d_v_vgvb__ = d_Vgst_d_v_vgvb__/Vdsat-(Vgst*d_Vdsat_d_v_vgvb__)/Vdsat^2;
                                d_Alphaz_d_v_vdpvsp__ = d_Vgst_d_v_vdpvsp__/Vdsat-(Vgst*d_Vdsat_d_v_vdpvsp__)/Vdsat^2;
                                d_Alphaz_d_v_vbvsp__ = d_Vgst_d_v_vbvsp__/Vdsat-(Vgst*d_Vdsat_d_v_vbvsp__)/Vdsat^2;
                            Alphaz = Vgst/Vdsat;
                                d_T1_d_v_vgvb__ = (2*d_Vdsat_d_v_vgvb__);
                                d_T1_d_v_vdpvsp__ = (2*d_Vdsat_d_v_vdpvsp__)-d_Vds_d_v_vdpvsp__;
                                d_T1_d_v_vbvsp__ = (2*d_Vdsat_d_v_vbvsp__);
                            T1 = 2*Vdsat-Vds;
                                d_T2_d_v_vgvb__ = -(Vds*(3*d_T1_d_v_vgvb__))/(3*T1)^2;
                                d_T2_d_v_vdpvsp__ = d_Vds_d_v_vdpvsp__/(3*T1)-(Vds*(3*d_T1_d_v_vdpvsp__))/(3*T1)^2;
                                d_T2_d_v_vbvsp__ = -(Vds*(3*d_T1_d_v_vbvsp__))/(3*T1)^2;
                            T2 = Vds/(3*T1);
                                d_T3_d_v_vgvb__ = d_T2_d_v_vgvb__*Vds;
                                d_T3_d_v_vdpvsp__ = T2*d_Vds_d_v_vdpvsp__+d_T2_d_v_vdpvsp__*Vds;
                                d_T3_d_v_vbvsp__ = d_T2_d_v_vbvsp__*Vds;
                            T3 = T2*Vds;
                                d_T9_d_v_vgvb__ = 0;
                                d_T9_d_v_vdpvsp__ = 0;
                                d_T9_d_v_vbvsp__ = 0;
                            T9 = 0.25*CoxWL;
                                d_T4_d_v_vgvb__ = T9*d_Alphaz_d_v_vgvb__+d_T9_d_v_vgvb__*Alphaz;
                                d_T4_d_v_vdpvsp__ = T9*d_Alphaz_d_v_vdpvsp__+d_T9_d_v_vdpvsp__*Alphaz;
                                d_T4_d_v_vbvsp__ = T9*d_Alphaz_d_v_vbvsp__+d_T9_d_v_vbvsp__*Alphaz;
                            T4 = T9*Alphaz;
                                d_T7_d_v_vgvb__ = (-d_T1_d_v_vgvb__)-(3*d_T3_d_v_vgvb__);
                                d_T7_d_v_vdpvsp__ = ((2*d_Vds_d_v_vdpvsp__)-d_T1_d_v_vdpvsp__)-(3*d_T3_d_v_vdpvsp__);
                                d_T7_d_v_vbvsp__ = (-d_T1_d_v_vbvsp__)-(3*d_T3_d_v_vbvsp__);
                            T7 = (2*Vds-T1)-3*T3;
                                d_T8_d_v_vgvb__ = (d_T3_d_v_vgvb__-d_T1_d_v_vgvb__);
                                d_T8_d_v_vdpvsp__ = (d_T3_d_v_vdpvsp__-d_T1_d_v_vdpvsp__)-(2*d_Vds_d_v_vdpvsp__);
                                d_T8_d_v_vbvsp__ = (d_T3_d_v_vbvsp__-d_T1_d_v_vbvsp__);
                            T8 = (T3-T1)-2*Vds;
                                d_qgate_d_v_vgvb__ = CoxWL*(((d_Vgs_eff_d_v_vgvb__))-(0.5*(-d_T3_d_v_vgvb__)));
                                d_qgate_d_v_vdpvsp__ = CoxWL*(((d_Vgs_eff_d_v_vdpvsp__))-(0.5*(d_Vds_d_v_vdpvsp__-d_T3_d_v_vdpvsp__)));
                                d_qgate_d_v_vbvsp__ = CoxWL*(((d_Vgs_eff_d_v_vbvsp__))-(0.5*(-d_T3_d_v_vbvsp__)));
                            qgate = CoxWL*(((Vgs_eff-Vfb)-BSIM3phi)-0.5*(Vds-T3));
                                d_T10_d_v_vgvb__ = T4*d_T8_d_v_vgvb__+d_T4_d_v_vgvb__*T8;
                                d_T10_d_v_vdpvsp__ = T4*d_T8_d_v_vdpvsp__+d_T4_d_v_vdpvsp__*T8;
                                d_T10_d_v_vbvsp__ = T4*d_T8_d_v_vbvsp__+d_T4_d_v_vbvsp__*T8;
                            T10 = T4*T8;
                                d_qdrn_d_v_vgvb__ = T4*d_T7_d_v_vgvb__+d_T4_d_v_vgvb__*T7;
                                d_qdrn_d_v_vdpvsp__ = T4*d_T7_d_v_vdpvsp__+d_T4_d_v_vdpvsp__*T7;
                                d_qdrn_d_v_vbvsp__ = T4*d_T7_d_v_vbvsp__+d_T4_d_v_vbvsp__*T7;
                            qdrn = T4*T7;
                                d_qbulk_d_v_vgvb__ = -((d_qgate_d_v_vgvb__+d_qdrn_d_v_vgvb__)+d_T10_d_v_vgvb__);
                                d_qbulk_d_v_vdpvsp__ = -((d_qgate_d_v_vdpvsp__+d_qdrn_d_v_vdpvsp__)+d_T10_d_v_vdpvsp__);
                                d_qbulk_d_v_vbvsp__ = -((d_qgate_d_v_vbvsp__+d_qdrn_d_v_vbvsp__)+d_T10_d_v_vbvsp__);
                            qbulk = -((qgate+qdrn)+T10);
                        end
                    else
                        if BSIM3xpart<0.5
                            if Vds>=Vdsat
                                    d_T1_d_v_vgvb__ = d_Vdsat_d_v_vgvb__/3;
                                    d_T1_d_v_vdpvsp__ = d_Vdsat_d_v_vdpvsp__/3;
                                    d_T1_d_v_vbvsp__ = d_Vdsat_d_v_vbvsp__/3;
                                T1 = Vdsat/3;
                                    d_qgate_d_v_vgvb__ = CoxWL*(((d_Vgs_eff_d_v_vgvb__))-d_T1_d_v_vgvb__);
                                    d_qgate_d_v_vdpvsp__ = CoxWL*(((d_Vgs_eff_d_v_vdpvsp__))-d_T1_d_v_vdpvsp__);
                                    d_qgate_d_v_vbvsp__ = CoxWL*(((d_Vgs_eff_d_v_vbvsp__))-d_T1_d_v_vbvsp__);
                                qgate = CoxWL*(((Vgs_eff-Vfb)-BSIM3phi)-T1);
                                    d_T2_d_v_vgvb__ = -Two_Third_CoxWL*d_Vgst_d_v_vgvb__+-d_Two_Third_CoxWL_d_v_vgvb__*Vgst;
                                    d_T2_d_v_vdpvsp__ = -Two_Third_CoxWL*d_Vgst_d_v_vdpvsp__+-d_Two_Third_CoxWL_d_v_vdpvsp__*Vgst;
                                    d_T2_d_v_vbvsp__ = -Two_Third_CoxWL*d_Vgst_d_v_vbvsp__+-d_Two_Third_CoxWL_d_v_vbvsp__*Vgst;
                                T2 = -Two_Third_CoxWL*Vgst;
                                    d_qbulk_d_v_vgvb__ = -(d_qgate_d_v_vgvb__+d_T2_d_v_vgvb__);
                                    d_qbulk_d_v_vdpvsp__ = -(d_qgate_d_v_vdpvsp__+d_T2_d_v_vdpvsp__);
                                    d_qbulk_d_v_vbvsp__ = -(d_qgate_d_v_vbvsp__+d_T2_d_v_vbvsp__);
                                qbulk = -(qgate+T2);
                                    d_qdrn_d_v_vgvb__ = 0.4*d_T2_d_v_vgvb__;
                                    d_qdrn_d_v_vdpvsp__ = 0.4*d_T2_d_v_vdpvsp__;
                                    d_qdrn_d_v_vbvsp__ = 0.4*d_T2_d_v_vbvsp__;
                                qdrn = 0.4*T2;
                            else
                                    d_Alphaz_d_v_vgvb__ = d_Vgst_d_v_vgvb__/Vdsat-(Vgst*d_Vdsat_d_v_vgvb__)/Vdsat^2;
                                    d_Alphaz_d_v_vdpvsp__ = d_Vgst_d_v_vdpvsp__/Vdsat-(Vgst*d_Vdsat_d_v_vdpvsp__)/Vdsat^2;
                                    d_Alphaz_d_v_vbvsp__ = d_Vgst_d_v_vbvsp__/Vdsat-(Vgst*d_Vdsat_d_v_vbvsp__)/Vdsat^2;
                                Alphaz = Vgst/Vdsat;
                                    d_T1_d_v_vgvb__ = (2*d_Vdsat_d_v_vgvb__);
                                    d_T1_d_v_vdpvsp__ = (2*d_Vdsat_d_v_vdpvsp__)-d_Vds_d_v_vdpvsp__;
                                    d_T1_d_v_vbvsp__ = (2*d_Vdsat_d_v_vbvsp__);
                                T1 = 2*Vdsat-Vds;
                                    d_T2_d_v_vgvb__ = -(Vds*(3*d_T1_d_v_vgvb__))/(3*T1)^2;
                                    d_T2_d_v_vdpvsp__ = d_Vds_d_v_vdpvsp__/(3*T1)-(Vds*(3*d_T1_d_v_vdpvsp__))/(3*T1)^2;
                                    d_T2_d_v_vbvsp__ = -(Vds*(3*d_T1_d_v_vbvsp__))/(3*T1)^2;
                                T2 = Vds/(3*T1);
                                    d_T3_d_v_vgvb__ = d_T2_d_v_vgvb__*Vds;
                                    d_T3_d_v_vdpvsp__ = T2*d_Vds_d_v_vdpvsp__+d_T2_d_v_vdpvsp__*Vds;
                                    d_T3_d_v_vbvsp__ = d_T2_d_v_vbvsp__*Vds;
                                T3 = T2*Vds;
                                    d_T9_d_v_vgvb__ = 0;
                                    d_T9_d_v_vdpvsp__ = 0;
                                    d_T9_d_v_vbvsp__ = 0;
                                T9 = 0.25*CoxWL;
                                    d_T4_d_v_vgvb__ = T9*d_Alphaz_d_v_vgvb__+d_T9_d_v_vgvb__*Alphaz;
                                    d_T4_d_v_vdpvsp__ = T9*d_Alphaz_d_v_vdpvsp__+d_T9_d_v_vdpvsp__*Alphaz;
                                    d_T4_d_v_vbvsp__ = T9*d_Alphaz_d_v_vbvsp__+d_T9_d_v_vbvsp__*Alphaz;
                                T4 = T9*Alphaz;
                                    d_qgate_d_v_vgvb__ = CoxWL*(((d_Vgs_eff_d_v_vgvb__))-(0.5*(-d_T3_d_v_vgvb__)));
                                    d_qgate_d_v_vdpvsp__ = CoxWL*(((d_Vgs_eff_d_v_vdpvsp__))-(0.5*(d_Vds_d_v_vdpvsp__-d_T3_d_v_vdpvsp__)));
                                    d_qgate_d_v_vbvsp__ = CoxWL*(((d_Vgs_eff_d_v_vbvsp__))-(0.5*(-d_T3_d_v_vbvsp__)));
                                qgate = CoxWL*(((Vgs_eff-Vfb)-BSIM3phi)-0.5*(Vds-T3));
                                    d_T6_d_v_vgvb__ = (((8*Vdsat)*d_Vdsat_d_v_vgvb__+(8*d_Vdsat_d_v_vgvb__)*Vdsat)-((6*d_Vdsat_d_v_vgvb__)*Vds));
                                    d_T6_d_v_vdpvsp__ = (((8*Vdsat)*d_Vdsat_d_v_vdpvsp__+(8*d_Vdsat_d_v_vdpvsp__)*Vdsat)-((6*Vdsat)*d_Vds_d_v_vdpvsp__+(6*d_Vdsat_d_v_vdpvsp__)*Vds))+((1.2*Vds)*d_Vds_d_v_vdpvsp__+(1.2*d_Vds_d_v_vdpvsp__)*Vds);
                                    d_T6_d_v_vbvsp__ = (((8*Vdsat)*d_Vdsat_d_v_vbvsp__+(8*d_Vdsat_d_v_vbvsp__)*Vdsat)-((6*d_Vdsat_d_v_vbvsp__)*Vds));
                                T6 = ((8*Vdsat)*Vdsat-(6*Vdsat)*Vds)+(1.2*Vds)*Vds;
                                    d_T8_d_v_vgvb__ = d_T2_d_v_vgvb__/T1-(T2*d_T1_d_v_vgvb__)/T1^2;
                                    d_T8_d_v_vdpvsp__ = d_T2_d_v_vdpvsp__/T1-(T2*d_T1_d_v_vdpvsp__)/T1^2;
                                    d_T8_d_v_vbvsp__ = d_T2_d_v_vbvsp__/T1-(T2*d_T1_d_v_vbvsp__)/T1^2;
                                T8 = T2/T1;
                                    d_T7_d_v_vgvb__ = (-d_T1_d_v_vgvb__)-(T8*d_T6_d_v_vgvb__+d_T8_d_v_vgvb__*T6);
                                    d_T7_d_v_vdpvsp__ = (d_Vds_d_v_vdpvsp__-d_T1_d_v_vdpvsp__)-(T8*d_T6_d_v_vdpvsp__+d_T8_d_v_vdpvsp__*T6);
                                    d_T7_d_v_vbvsp__ = (-d_T1_d_v_vbvsp__)-(T8*d_T6_d_v_vbvsp__+d_T8_d_v_vbvsp__*T6);
                                T7 = (Vds-T1)-T8*T6;
                                    d_qdrn_d_v_vgvb__ = T4*d_T7_d_v_vgvb__+d_T4_d_v_vgvb__*T7;
                                    d_qdrn_d_v_vdpvsp__ = T4*d_T7_d_v_vdpvsp__+d_T4_d_v_vdpvsp__*T7;
                                    d_qdrn_d_v_vbvsp__ = T4*d_T7_d_v_vbvsp__+d_T4_d_v_vbvsp__*T7;
                                qdrn = T4*T7;
                                    d_T7_d_v_vgvb__ = 2*(d_T1_d_v_vgvb__+d_T3_d_v_vgvb__);
                                    d_T7_d_v_vdpvsp__ = 2*(d_T1_d_v_vdpvsp__+d_T3_d_v_vdpvsp__);
                                    d_T7_d_v_vbvsp__ = 2*(d_T1_d_v_vbvsp__+d_T3_d_v_vbvsp__);
                                T7 = 2*(T1+T3);
                                    d_qbulk_d_v_vgvb__ = -(d_qgate_d_v_vgvb__-(T4*d_T7_d_v_vgvb__+d_T4_d_v_vgvb__*T7));
                                    d_qbulk_d_v_vdpvsp__ = -(d_qgate_d_v_vdpvsp__-(T4*d_T7_d_v_vdpvsp__+d_T4_d_v_vdpvsp__*T7));
                                    d_qbulk_d_v_vbvsp__ = -(d_qgate_d_v_vbvsp__-(T4*d_T7_d_v_vbvsp__+d_T4_d_v_vbvsp__*T7));
                                qbulk = -(qgate-T4*T7);
                            end
                        else
                            if Vds>=Vdsat
                                    d_T1_d_v_vgvb__ = d_Vdsat_d_v_vgvb__/3;
                                    d_T1_d_v_vdpvsp__ = d_Vdsat_d_v_vdpvsp__/3;
                                    d_T1_d_v_vbvsp__ = d_Vdsat_d_v_vbvsp__/3;
                                T1 = Vdsat/3;
                                    d_qgate_d_v_vgvb__ = CoxWL*(((d_Vgs_eff_d_v_vgvb__))-d_T1_d_v_vgvb__);
                                    d_qgate_d_v_vdpvsp__ = CoxWL*(((d_Vgs_eff_d_v_vdpvsp__))-d_T1_d_v_vdpvsp__);
                                    d_qgate_d_v_vbvsp__ = CoxWL*(((d_Vgs_eff_d_v_vbvsp__))-d_T1_d_v_vbvsp__);
                                qgate = CoxWL*(((Vgs_eff-Vfb)-BSIM3phi)-T1);
                                    d_T2_d_v_vgvb__ = -Two_Third_CoxWL*d_Vgst_d_v_vgvb__+-d_Two_Third_CoxWL_d_v_vgvb__*Vgst;
                                    d_T2_d_v_vdpvsp__ = -Two_Third_CoxWL*d_Vgst_d_v_vdpvsp__+-d_Two_Third_CoxWL_d_v_vdpvsp__*Vgst;
                                    d_T2_d_v_vbvsp__ = -Two_Third_CoxWL*d_Vgst_d_v_vbvsp__+-d_Two_Third_CoxWL_d_v_vbvsp__*Vgst;
                                T2 = -Two_Third_CoxWL*Vgst;
                                    d_qbulk_d_v_vgvb__ = -(d_qgate_d_v_vgvb__+d_T2_d_v_vgvb__);
                                    d_qbulk_d_v_vdpvsp__ = -(d_qgate_d_v_vdpvsp__+d_T2_d_v_vdpvsp__);
                                    d_qbulk_d_v_vbvsp__ = -(d_qgate_d_v_vbvsp__+d_T2_d_v_vbvsp__);
                                qbulk = -(qgate+T2);
                                    d_qdrn_d_v_vgvb__ = 0.5*d_T2_d_v_vgvb__;
                                    d_qdrn_d_v_vdpvsp__ = 0.5*d_T2_d_v_vdpvsp__;
                                    d_qdrn_d_v_vbvsp__ = 0.5*d_T2_d_v_vbvsp__;
                                qdrn = 0.5*T2;
                            else
                                    d_Alphaz_d_v_vgvb__ = d_Vgst_d_v_vgvb__/Vdsat-(Vgst*d_Vdsat_d_v_vgvb__)/Vdsat^2;
                                    d_Alphaz_d_v_vdpvsp__ = d_Vgst_d_v_vdpvsp__/Vdsat-(Vgst*d_Vdsat_d_v_vdpvsp__)/Vdsat^2;
                                    d_Alphaz_d_v_vbvsp__ = d_Vgst_d_v_vbvsp__/Vdsat-(Vgst*d_Vdsat_d_v_vbvsp__)/Vdsat^2;
                                Alphaz = Vgst/Vdsat;
                                    d_T1_d_v_vgvb__ = (2*d_Vdsat_d_v_vgvb__);
                                    d_T1_d_v_vdpvsp__ = (2*d_Vdsat_d_v_vdpvsp__)-d_Vds_d_v_vdpvsp__;
                                    d_T1_d_v_vbvsp__ = (2*d_Vdsat_d_v_vbvsp__);
                                T1 = 2*Vdsat-Vds;
                                    d_T2_d_v_vgvb__ = -(Vds*(3*d_T1_d_v_vgvb__))/(3*T1)^2;
                                    d_T2_d_v_vdpvsp__ = d_Vds_d_v_vdpvsp__/(3*T1)-(Vds*(3*d_T1_d_v_vdpvsp__))/(3*T1)^2;
                                    d_T2_d_v_vbvsp__ = -(Vds*(3*d_T1_d_v_vbvsp__))/(3*T1)^2;
                                T2 = Vds/(3*T1);
                                    d_T3_d_v_vgvb__ = d_T2_d_v_vgvb__*Vds;
                                    d_T3_d_v_vdpvsp__ = T2*d_Vds_d_v_vdpvsp__+d_T2_d_v_vdpvsp__*Vds;
                                    d_T3_d_v_vbvsp__ = d_T2_d_v_vbvsp__*Vds;
                                T3 = T2*Vds;
                                    d_T9_d_v_vgvb__ = 0;
                                    d_T9_d_v_vdpvsp__ = 0;
                                    d_T9_d_v_vbvsp__ = 0;
                                T9 = 0.25*CoxWL;
                                    d_T4_d_v_vgvb__ = T9*d_Alphaz_d_v_vgvb__+d_T9_d_v_vgvb__*Alphaz;
                                    d_T4_d_v_vdpvsp__ = T9*d_Alphaz_d_v_vdpvsp__+d_T9_d_v_vdpvsp__*Alphaz;
                                    d_T4_d_v_vbvsp__ = T9*d_Alphaz_d_v_vbvsp__+d_T9_d_v_vbvsp__*Alphaz;
                                T4 = T9*Alphaz;
                                    d_qgate_d_v_vgvb__ = CoxWL*(((d_Vgs_eff_d_v_vgvb__))-(0.5*(-d_T3_d_v_vgvb__)));
                                    d_qgate_d_v_vdpvsp__ = CoxWL*(((d_Vgs_eff_d_v_vdpvsp__))-(0.5*(d_Vds_d_v_vdpvsp__-d_T3_d_v_vdpvsp__)));
                                    d_qgate_d_v_vbvsp__ = CoxWL*(((d_Vgs_eff_d_v_vbvsp__))-(0.5*(-d_T3_d_v_vbvsp__)));
                                qgate = CoxWL*(((Vgs_eff-Vfb)-BSIM3phi)-0.5*(Vds-T3));
                                    d_T7_d_v_vgvb__ = d_T1_d_v_vgvb__+d_T3_d_v_vgvb__;
                                    d_T7_d_v_vdpvsp__ = d_T1_d_v_vdpvsp__+d_T3_d_v_vdpvsp__;
                                    d_T7_d_v_vbvsp__ = d_T1_d_v_vbvsp__+d_T3_d_v_vbvsp__;
                                T7 = T1+T3;
                                    d_qdrn_d_v_vgvb__ = -T4*d_T7_d_v_vgvb__+-d_T4_d_v_vgvb__*T7;
                                    d_qdrn_d_v_vdpvsp__ = -T4*d_T7_d_v_vdpvsp__+-d_T4_d_v_vdpvsp__*T7;
                                    d_qdrn_d_v_vbvsp__ = -T4*d_T7_d_v_vbvsp__+-d_T4_d_v_vbvsp__*T7;
                                qdrn = -T4*T7;
                                    d_qbulk_d_v_vgvb__ = -((d_qgate_d_v_vgvb__+d_qdrn_d_v_vgvb__)+d_qdrn_d_v_vgvb__);
                                    d_qbulk_d_v_vdpvsp__ = -((d_qgate_d_v_vdpvsp__+d_qdrn_d_v_vdpvsp__)+d_qdrn_d_v_vdpvsp__);
                                    d_qbulk_d_v_vbvsp__ = -((d_qgate_d_v_vbvsp__+d_qdrn_d_v_vbvsp__)+d_qdrn_d_v_vbvsp__);
                                qbulk = -((qgate+qdrn)+qdrn);
                            end
                        end
                    end
                end
            end
        else
            if Vbseff<0
                    d_VbseffCV_d_v_vdpvsp__ = d_Vbseff_d_v_vdpvsp__;
                    d_VbseffCV_d_v_vbvsp__ = d_Vbseff_d_v_vbvsp__;
                VbseffCV = Vbseff;
            else
                    d_VbseffCV_d_v_vdpvsp__ = -d_Phis_d_v_vdpvsp__;
                    d_VbseffCV_d_v_vbvsp__ = -d_Phis_d_v_vbvsp__;
                VbseffCV = BSIM3phi-Phis;
            end
            CoxWL = (BSIM3cox*BSIM3weffCV)*BSIM3leffCV;
                d_LOCAL_noff_d_v_vdpvsp__ = d_n_d_v_vdpvsp__*BSIM3noff;
                d_LOCAL_noff_d_v_vbvsp__ = d_n_d_v_vbvsp__*BSIM3noff;
            LOCAL_noff = n*BSIM3noff;
                d_T0_d_v_vgvb__ = 0;
                d_T0_d_v_vdpvsp__ = Vtm*d_LOCAL_noff_d_v_vdpvsp__;
                d_T0_d_v_vbvsp__ = Vtm*d_LOCAL_noff_d_v_vbvsp__;
            T0 = Vtm*LOCAL_noff;
            LOCAL_voffcv = BSIM3voffcv;
                d_VgstNVt_d_v_vgvb__ = (d_Vgst_d_v_vgvb__)/T0-((Vgst-LOCAL_voffcv)*d_T0_d_v_vgvb__)/T0^2;
                d_VgstNVt_d_v_vdpvsp__ = (d_Vgst_d_v_vdpvsp__)/T0-((Vgst-LOCAL_voffcv)*d_T0_d_v_vdpvsp__)/T0^2;
                d_VgstNVt_d_v_vbvsp__ = (d_Vgst_d_v_vbvsp__)/T0-((Vgst-LOCAL_voffcv)*d_T0_d_v_vbvsp__)/T0^2;
            VgstNVt = (Vgst-LOCAL_voffcv)/T0;
            if VgstNVt>34
                    d_Vgsteff_d_v_vgvb__ = d_Vgst_d_v_vgvb__;
                    d_Vgsteff_d_v_vdpvsp__ = d_Vgst_d_v_vdpvsp__;
                    d_Vgsteff_d_v_vbvsp__ = d_Vgst_d_v_vbvsp__;
                Vgsteff = Vgst-LOCAL_voffcv;
            else
                if VgstNVt<-34
                        d_Vgsteff_d_v_vgvb__ = d_T0_d_v_vgvb__*log10(1+1.7139e-15);
                        d_Vgsteff_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__*log10(1+1.7139e-15);
                        d_Vgsteff_d_v_vbvsp__ = d_T0_d_v_vbvsp__*log10(1+1.7139e-15);
                    Vgsteff = T0*log10(1+1.7139e-15);
                else
                        d_ExpVgst_d_v_vgvb__ = exp(VgstNVt)*d_VgstNVt_d_v_vgvb__;
                        d_ExpVgst_d_v_vdpvsp__ = exp(VgstNVt)*d_VgstNVt_d_v_vdpvsp__;
                        d_ExpVgst_d_v_vbvsp__ = exp(VgstNVt)*d_VgstNVt_d_v_vbvsp__;
                    ExpVgst = exp(VgstNVt);
                        d_Vgsteff_d_v_vgvb__ = T0*((1/((1+ExpVgst)*log(10)))*(d_ExpVgst_d_v_vgvb__))+d_T0_d_v_vgvb__*log10(1+ExpVgst);
                        d_Vgsteff_d_v_vdpvsp__ = T0*((1/((1+ExpVgst)*log(10)))*(d_ExpVgst_d_v_vdpvsp__))+d_T0_d_v_vdpvsp__*log10(1+ExpVgst);
                        d_Vgsteff_d_v_vbvsp__ = T0*((1/((1+ExpVgst)*log(10)))*(d_ExpVgst_d_v_vbvsp__))+d_T0_d_v_vbvsp__*log10(1+ExpVgst);
                    Vgsteff = T0*log10(1+ExpVgst);
                end
            end
            if BSIM3capMod==1
                Vfb = BSIM3vfbzb;
                    d_Arg1_d_v_vgvb__ = ((d_Vgs_eff_d_v_vgvb__))-d_Vgsteff_d_v_vgvb__;
                    d_Arg1_d_v_vdpvsp__ = ((d_Vgs_eff_d_v_vdpvsp__-d_VbseffCV_d_v_vdpvsp__))-d_Vgsteff_d_v_vdpvsp__;
                    d_Arg1_d_v_vbvsp__ = ((d_Vgs_eff_d_v_vbvsp__-d_VbseffCV_d_v_vbvsp__))-d_Vgsteff_d_v_vbvsp__;
                Arg1 = ((Vgs_eff-VbseffCV)-Vfb)-Vgsteff;
                if Arg1<=0
                        d_qgate_d_v_vgvb__ = CoxWL*d_Arg1_d_v_vgvb__;
                        d_qgate_d_v_vdpvsp__ = CoxWL*d_Arg1_d_v_vdpvsp__;
                        d_qgate_d_v_vbvsp__ = CoxWL*d_Arg1_d_v_vbvsp__;
                    qgate = CoxWL*Arg1;
                else
                        d_T0_d_v_vgvb__ = 0;
                        d_T0_d_v_vdpvsp__ = 0;
                        d_T0_d_v_vbvsp__ = 0;
                    T0 = 0.5*BSIM3k1ox;
                        d_T1_d_v_vgvb__ = (1/(2*sqrt(T0*T0+Arg1)))*((T0*d_T0_d_v_vgvb__+d_T0_d_v_vgvb__*T0)+d_Arg1_d_v_vgvb__);
                        d_T1_d_v_vdpvsp__ = (1/(2*sqrt(T0*T0+Arg1)))*((T0*d_T0_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T0)+d_Arg1_d_v_vdpvsp__);
                        d_T1_d_v_vbvsp__ = (1/(2*sqrt(T0*T0+Arg1)))*((T0*d_T0_d_v_vbvsp__+d_T0_d_v_vbvsp__*T0)+d_Arg1_d_v_vbvsp__);
                    T1 = sqrt(T0*T0+Arg1);
                        d_qgate_d_v_vgvb__ = (CoxWL*BSIM3k1ox)*(d_T1_d_v_vgvb__-d_T0_d_v_vgvb__);
                        d_qgate_d_v_vdpvsp__ = (CoxWL*BSIM3k1ox)*(d_T1_d_v_vdpvsp__-d_T0_d_v_vdpvsp__);
                        d_qgate_d_v_vbvsp__ = (CoxWL*BSIM3k1ox)*(d_T1_d_v_vbvsp__-d_T0_d_v_vbvsp__);
                    qgate = (CoxWL*BSIM3k1ox)*(T1-T0);
                end
                    d_qbulk_d_v_vgvb__ = -d_qgate_d_v_vgvb__;
                    d_qbulk_d_v_vdpvsp__ = -d_qgate_d_v_vdpvsp__;
                    d_qbulk_d_v_vbvsp__ = -d_qgate_d_v_vbvsp__;
                qbulk = -qgate;
                    d_One_Third_CoxWL_d_v_vgvb__ = 0;
                    d_One_Third_CoxWL_d_v_vdpvsp__ = 0;
                    d_One_Third_CoxWL_d_v_vbvsp__ = 0;
                One_Third_CoxWL = CoxWL/3;
                    d_Two_Third_CoxWL_d_v_vgvb__ = 2*d_One_Third_CoxWL_d_v_vgvb__;
                    d_Two_Third_CoxWL_d_v_vdpvsp__ = 2*d_One_Third_CoxWL_d_v_vdpvsp__;
                    d_Two_Third_CoxWL_d_v_vbvsp__ = 2*d_One_Third_CoxWL_d_v_vbvsp__;
                Two_Third_CoxWL = 2*One_Third_CoxWL;
                    d_AbulkCV_d_v_vgvb__ = d_Abulk0_d_v_vgvb__*BSIM3abulkCVfactor;
                    d_AbulkCV_d_v_vdpvsp__ = d_Abulk0_d_v_vdpvsp__*BSIM3abulkCVfactor;
                    d_AbulkCV_d_v_vbvsp__ = d_Abulk0_d_v_vbvsp__*BSIM3abulkCVfactor;
                AbulkCV = Abulk0*BSIM3abulkCVfactor;
                    d_VdsatCV_d_v_vgvb__ = d_Vgsteff_d_v_vgvb__/AbulkCV-(Vgsteff*d_AbulkCV_d_v_vgvb__)/AbulkCV^2;
                    d_VdsatCV_d_v_vdpvsp__ = d_Vgsteff_d_v_vdpvsp__/AbulkCV-(Vgsteff*d_AbulkCV_d_v_vdpvsp__)/AbulkCV^2;
                    d_VdsatCV_d_v_vbvsp__ = d_Vgsteff_d_v_vbvsp__/AbulkCV-(Vgsteff*d_AbulkCV_d_v_vbvsp__)/AbulkCV^2;
                VdsatCV = Vgsteff/AbulkCV;
                if VdsatCV<Vds
                        d_T0_d_v_vgvb__ = d_Vgsteff_d_v_vgvb__-(d_VdsatCV_d_v_vgvb__/3);
                        d_T0_d_v_vdpvsp__ = d_Vgsteff_d_v_vdpvsp__-(d_VdsatCV_d_v_vdpvsp__/3);
                        d_T0_d_v_vbvsp__ = d_Vgsteff_d_v_vbvsp__-(d_VdsatCV_d_v_vbvsp__/3);
                    T0 = Vgsteff-VdsatCV/3;
                        d_qgate_d_v_vgvb__ = d_qgate_d_v_vgvb__+(CoxWL*d_T0_d_v_vgvb__);
                        d_qgate_d_v_vdpvsp__ = d_qgate_d_v_vdpvsp__+(CoxWL*d_T0_d_v_vdpvsp__);
                        d_qgate_d_v_vbvsp__ = d_qgate_d_v_vbvsp__+(CoxWL*d_T0_d_v_vbvsp__);
                    qgate = qgate+CoxWL*T0;
                        d_T0_d_v_vgvb__ = d_VdsatCV_d_v_vgvb__-d_Vgsteff_d_v_vgvb__;
                        d_T0_d_v_vdpvsp__ = d_VdsatCV_d_v_vdpvsp__-d_Vgsteff_d_v_vdpvsp__;
                        d_T0_d_v_vbvsp__ = d_VdsatCV_d_v_vbvsp__-d_Vgsteff_d_v_vbvsp__;
                    T0 = VdsatCV-Vgsteff;
                        d_qbulk_d_v_vgvb__ = d_qgate_d_v_vgvb__+(One_Third_CoxWL*d_T0_d_v_vgvb__+d_One_Third_CoxWL_d_v_vgvb__*T0);
                        d_qbulk_d_v_vdpvsp__ = d_qgate_d_v_vdpvsp__+(One_Third_CoxWL*d_T0_d_v_vdpvsp__+d_One_Third_CoxWL_d_v_vdpvsp__*T0);
                        d_qbulk_d_v_vbvsp__ = d_qgate_d_v_vbvsp__+(One_Third_CoxWL*d_T0_d_v_vbvsp__+d_One_Third_CoxWL_d_v_vbvsp__*T0);
                    qbulk = qgate+One_Third_CoxWL*T0;
                    if BSIM3xpart>0.5
                            d_T0_d_v_vgvb__ = -d_Two_Third_CoxWL_d_v_vgvb__;
                            d_T0_d_v_vdpvsp__ = -d_Two_Third_CoxWL_d_v_vdpvsp__;
                            d_T0_d_v_vbvsp__ = -d_Two_Third_CoxWL_d_v_vbvsp__;
                        T0 = -Two_Third_CoxWL;
                    else
                        if BSIM3xpart<0.5
                                d_T0_d_v_vgvb__ = 0;
                                d_T0_d_v_vdpvsp__ = 0;
                                d_T0_d_v_vbvsp__ = 0;
                            T0 = -0.4*CoxWL;
                        else
                                d_T0_d_v_vgvb__ = -d_One_Third_CoxWL_d_v_vgvb__;
                                d_T0_d_v_vdpvsp__ = -d_One_Third_CoxWL_d_v_vdpvsp__;
                                d_T0_d_v_vbvsp__ = -d_One_Third_CoxWL_d_v_vbvsp__;
                            T0 = -One_Third_CoxWL;
                        end
                    end
                        d_qsrc_d_v_vgvb__ = T0*d_Vgsteff_d_v_vgvb__+d_T0_d_v_vgvb__*Vgsteff;
                        d_qsrc_d_v_vdpvsp__ = T0*d_Vgsteff_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*Vgsteff;
                        d_qsrc_d_v_vbvsp__ = T0*d_Vgsteff_d_v_vbvsp__+d_T0_d_v_vbvsp__*Vgsteff;
                    qsrc = T0*Vgsteff;
                else
                        d_T0_d_v_vgvb__ = d_AbulkCV_d_v_vgvb__*Vds;
                        d_T0_d_v_vdpvsp__ = AbulkCV*d_Vds_d_v_vdpvsp__+d_AbulkCV_d_v_vdpvsp__*Vds;
                        d_T0_d_v_vbvsp__ = d_AbulkCV_d_v_vbvsp__*Vds;
                    T0 = AbulkCV*Vds;
                        d_T1_d_v_vgvb__ = 12*((d_Vgsteff_d_v_vgvb__-(0.5*d_T0_d_v_vgvb__)));
                        d_T1_d_v_vdpvsp__ = 12*((d_Vgsteff_d_v_vdpvsp__-(0.5*d_T0_d_v_vdpvsp__)));
                        d_T1_d_v_vbvsp__ = 12*((d_Vgsteff_d_v_vbvsp__-(0.5*d_T0_d_v_vbvsp__)));
                    T1 = 12*((Vgsteff-0.5*T0)+1e-20);
                        d_T2_d_v_vgvb__ = -(Vds*d_T1_d_v_vgvb__)/T1^2;
                        d_T2_d_v_vdpvsp__ = d_Vds_d_v_vdpvsp__/T1-(Vds*d_T1_d_v_vdpvsp__)/T1^2;
                        d_T2_d_v_vbvsp__ = -(Vds*d_T1_d_v_vbvsp__)/T1^2;
                    T2 = Vds/T1;
                        d_T3_d_v_vgvb__ = T0*d_T2_d_v_vgvb__+d_T0_d_v_vgvb__*T2;
                        d_T3_d_v_vdpvsp__ = T0*d_T2_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T2;
                        d_T3_d_v_vbvsp__ = T0*d_T2_d_v_vbvsp__+d_T0_d_v_vbvsp__*T2;
                    T3 = T0*T2;
                        d_qgate_d_v_vgvb__ = d_qgate_d_v_vgvb__+(CoxWL*((d_Vgsteff_d_v_vgvb__)+d_T3_d_v_vgvb__));
                        d_qgate_d_v_vdpvsp__ = d_qgate_d_v_vdpvsp__+(CoxWL*((d_Vgsteff_d_v_vdpvsp__-(0.5*d_Vds_d_v_vdpvsp__))+d_T3_d_v_vdpvsp__));
                        d_qgate_d_v_vbvsp__ = d_qgate_d_v_vbvsp__+(CoxWL*((d_Vgsteff_d_v_vbvsp__)+d_T3_d_v_vbvsp__));
                    qgate = qgate+CoxWL*((Vgsteff-0.5*Vds)+T3);
                        d_qbulk_d_v_vgvb__ = d_qgate_d_v_vgvb__+((CoxWL*(1-AbulkCV))*(-d_T3_d_v_vgvb__)+(CoxWL*(-d_AbulkCV_d_v_vgvb__))*(0.5*Vds-T3));
                        d_qbulk_d_v_vdpvsp__ = d_qgate_d_v_vdpvsp__+((CoxWL*(1-AbulkCV))*((0.5*d_Vds_d_v_vdpvsp__)-d_T3_d_v_vdpvsp__)+(CoxWL*(-d_AbulkCV_d_v_vdpvsp__))*(0.5*Vds-T3));
                        d_qbulk_d_v_vbvsp__ = d_qgate_d_v_vbvsp__+((CoxWL*(1-AbulkCV))*(-d_T3_d_v_vbvsp__)+(CoxWL*(-d_AbulkCV_d_v_vbvsp__))*(0.5*Vds-T3));
                    qbulk = qgate+(CoxWL*(1-AbulkCV))*(0.5*Vds-T3);
                    if BSIM3xpart>0.5
                            d_T1_d_v_vgvb__ = d_T1_d_v_vgvb__+d_T1_d_v_vgvb__;
                            d_T1_d_v_vdpvsp__ = d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__;
                            d_T1_d_v_vbvsp__ = d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__;
                        T1 = T1+T1;
                            d_qsrc_d_v_vgvb__ = -CoxWL*(((0.5*d_Vgsteff_d_v_vgvb__)+(0.25*d_T0_d_v_vgvb__))-((T0*d_T0_d_v_vgvb__+d_T0_d_v_vgvb__*T0)/T1-((T0*T0)*d_T1_d_v_vgvb__)/T1^2));
                            d_qsrc_d_v_vdpvsp__ = -CoxWL*(((0.5*d_Vgsteff_d_v_vdpvsp__)+(0.25*d_T0_d_v_vdpvsp__))-((T0*d_T0_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T0)/T1-((T0*T0)*d_T1_d_v_vdpvsp__)/T1^2));
                            d_qsrc_d_v_vbvsp__ = -CoxWL*(((0.5*d_Vgsteff_d_v_vbvsp__)+(0.25*d_T0_d_v_vbvsp__))-((T0*d_T0_d_v_vbvsp__+d_T0_d_v_vbvsp__*T0)/T1-((T0*T0)*d_T1_d_v_vbvsp__)/T1^2));
                        qsrc = -CoxWL*((0.5*Vgsteff+0.25*T0)-(T0*T0)/T1);
                    else
                        if BSIM3xpart<0.5
                                d_T1_d_v_vgvb__ = d_T1_d_v_vgvb__/12;
                                d_T1_d_v_vdpvsp__ = d_T1_d_v_vdpvsp__/12;
                                d_T1_d_v_vbvsp__ = d_T1_d_v_vbvsp__/12;
                            T1 = T1/12;
                                d_T2_d_v_vgvb__ = -((0.5*CoxWL)*(T1*d_T1_d_v_vgvb__+d_T1_d_v_vgvb__*T1))/(T1*T1)^2;
                                d_T2_d_v_vdpvsp__ = -((0.5*CoxWL)*(T1*d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*T1))/(T1*T1)^2;
                                d_T2_d_v_vbvsp__ = -((0.5*CoxWL)*(T1*d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__*T1))/(T1*T1)^2;
                            T2 = (0.5*CoxWL)/(T1*T1);
                                d_T3_d_v_vgvb__ = (Vgsteff*((((2*T0)*d_T0_d_v_vgvb__+(2*d_T0_d_v_vgvb__)*T0)/3)+(Vgsteff*(d_Vgsteff_d_v_vgvb__-((4*d_T0_d_v_vgvb__)/3))+d_Vgsteff_d_v_vgvb__*(Vgsteff-(4*T0)/3)))+d_Vgsteff_d_v_vgvb__*(((2*T0)*T0)/3+Vgsteff*(Vgsteff-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vgvb__+((2*T0)*d_T0_d_v_vgvb__+(2*d_T0_d_v_vgvb__)*T0)*T0)/15);
                                d_T3_d_v_vdpvsp__ = (Vgsteff*((((2*T0)*d_T0_d_v_vdpvsp__+(2*d_T0_d_v_vdpvsp__)*T0)/3)+(Vgsteff*(d_Vgsteff_d_v_vdpvsp__-((4*d_T0_d_v_vdpvsp__)/3))+d_Vgsteff_d_v_vdpvsp__*(Vgsteff-(4*T0)/3)))+d_Vgsteff_d_v_vdpvsp__*(((2*T0)*T0)/3+Vgsteff*(Vgsteff-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vdpvsp__+((2*T0)*d_T0_d_v_vdpvsp__+(2*d_T0_d_v_vdpvsp__)*T0)*T0)/15);
                                d_T3_d_v_vbvsp__ = (Vgsteff*((((2*T0)*d_T0_d_v_vbvsp__+(2*d_T0_d_v_vbvsp__)*T0)/3)+(Vgsteff*(d_Vgsteff_d_v_vbvsp__-((4*d_T0_d_v_vbvsp__)/3))+d_Vgsteff_d_v_vbvsp__*(Vgsteff-(4*T0)/3)))+d_Vgsteff_d_v_vbvsp__*(((2*T0)*T0)/3+Vgsteff*(Vgsteff-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vbvsp__+((2*T0)*d_T0_d_v_vbvsp__+(2*d_T0_d_v_vbvsp__)*T0)*T0)/15);
                            T3 = Vgsteff*(((2*T0)*T0)/3+Vgsteff*(Vgsteff-(4*T0)/3))-(((2*T0)*T0)*T0)/15;
                                d_qsrc_d_v_vgvb__ = -T2*d_T3_d_v_vgvb__+-d_T2_d_v_vgvb__*T3;
                                d_qsrc_d_v_vdpvsp__ = -T2*d_T3_d_v_vdpvsp__+-d_T2_d_v_vdpvsp__*T3;
                                d_qsrc_d_v_vbvsp__ = -T2*d_T3_d_v_vbvsp__+-d_T2_d_v_vbvsp__*T3;
                            qsrc = -T2*T3;
                        else
                                d_qsrc_d_v_vgvb__ = -0.5*(d_qgate_d_v_vgvb__+d_qbulk_d_v_vgvb__);
                                d_qsrc_d_v_vdpvsp__ = -0.5*(d_qgate_d_v_vdpvsp__+d_qbulk_d_v_vdpvsp__);
                                d_qsrc_d_v_vbvsp__ = -0.5*(d_qgate_d_v_vbvsp__+d_qbulk_d_v_vbvsp__);
                            qsrc = -0.5*(qgate+qbulk);
                        end
                    end
                end
                    d_qdrn_d_v_vgvb__ = -((d_qgate_d_v_vgvb__+d_qbulk_d_v_vgvb__)+d_qsrc_d_v_vgvb__);
                    d_qdrn_d_v_vdpvsp__ = -((d_qgate_d_v_vdpvsp__+d_qbulk_d_v_vdpvsp__)+d_qsrc_d_v_vdpvsp__);
                    d_qdrn_d_v_vbvsp__ = -((d_qgate_d_v_vbvsp__+d_qbulk_d_v_vbvsp__)+d_qsrc_d_v_vbvsp__);
                qdrn = -((qgate+qbulk)+qsrc);
            else
                if BSIM3capMod==2
                    Vfb = BSIM3vfbzb;
                        d_V3_d_v_vgvb__ = ((-d_Vgs_eff_d_v_vgvb__));
                        d_V3_d_v_vdpvsp__ = ((-d_Vgs_eff_d_v_vdpvsp__)+d_VbseffCV_d_v_vdpvsp__);
                        d_V3_d_v_vbvsp__ = ((-d_Vgs_eff_d_v_vbvsp__)+d_VbseffCV_d_v_vbvsp__);
                    V3 = ((Vfb-Vgs_eff)+VbseffCV)-0.02;
                    if Vfb<=0
                            d_T0_d_v_vgvb__ = (1/(2*sqrt(V3*V3-(4*0.02)*Vfb)))*((V3*d_V3_d_v_vgvb__+d_V3_d_v_vgvb__*V3));
                            d_T0_d_v_vdpvsp__ = (1/(2*sqrt(V3*V3-(4*0.02)*Vfb)))*((V3*d_V3_d_v_vdpvsp__+d_V3_d_v_vdpvsp__*V3));
                            d_T0_d_v_vbvsp__ = (1/(2*sqrt(V3*V3-(4*0.02)*Vfb)))*((V3*d_V3_d_v_vbvsp__+d_V3_d_v_vbvsp__*V3));
                        T0 = sqrt(V3*V3-(4*0.02)*Vfb);
                    else
                            d_T0_d_v_vgvb__ = (1/(2*sqrt(V3*V3+(4*0.02)*Vfb)))*((V3*d_V3_d_v_vgvb__+d_V3_d_v_vgvb__*V3));
                            d_T0_d_v_vdpvsp__ = (1/(2*sqrt(V3*V3+(4*0.02)*Vfb)))*((V3*d_V3_d_v_vdpvsp__+d_V3_d_v_vdpvsp__*V3));
                            d_T0_d_v_vbvsp__ = (1/(2*sqrt(V3*V3+(4*0.02)*Vfb)))*((V3*d_V3_d_v_vbvsp__+d_V3_d_v_vbvsp__*V3));
                        T0 = sqrt(V3*V3+(4*0.02)*Vfb);
                    end
                        d_Vfbeff_d_v_vgvb__ = -(0.5*(d_V3_d_v_vgvb__+d_T0_d_v_vgvb__));
                        d_Vfbeff_d_v_vdpvsp__ = -(0.5*(d_V3_d_v_vdpvsp__+d_T0_d_v_vdpvsp__));
                        d_Vfbeff_d_v_vbvsp__ = -(0.5*(d_V3_d_v_vbvsp__+d_T0_d_v_vbvsp__));
                    Vfbeff = Vfb-0.5*(V3+T0);
                        d_Qac0_d_v_vgvb__ = CoxWL*(d_Vfbeff_d_v_vgvb__);
                        d_Qac0_d_v_vdpvsp__ = CoxWL*(d_Vfbeff_d_v_vdpvsp__);
                        d_Qac0_d_v_vbvsp__ = CoxWL*(d_Vfbeff_d_v_vbvsp__);
                    Qac0 = CoxWL*(Vfbeff-Vfb);
                        d_T0_d_v_vgvb__ = 0;
                        d_T0_d_v_vdpvsp__ = 0;
                        d_T0_d_v_vbvsp__ = 0;
                    T0 = 0.5*BSIM3k1ox;
                        d_T3_d_v_vgvb__ = ((d_Vgs_eff_d_v_vgvb__-d_Vfbeff_d_v_vgvb__))-d_Vgsteff_d_v_vgvb__;
                        d_T3_d_v_vdpvsp__ = ((d_Vgs_eff_d_v_vdpvsp__-d_Vfbeff_d_v_vdpvsp__)-d_VbseffCV_d_v_vdpvsp__)-d_Vgsteff_d_v_vdpvsp__;
                        d_T3_d_v_vbvsp__ = ((d_Vgs_eff_d_v_vbvsp__-d_Vfbeff_d_v_vbvsp__)-d_VbseffCV_d_v_vbvsp__)-d_Vgsteff_d_v_vbvsp__;
                    T3 = ((Vgs_eff-Vfbeff)-VbseffCV)-Vgsteff;
                    if BSIM3k1ox==0
                            d_T1_d_v_vgvb__ = 0;
                            d_T1_d_v_vdpvsp__ = 0;
                            d_T1_d_v_vbvsp__ = 0;
                        T1 = 0;
                    else
                        if T3<0
                                d_T1_d_v_vgvb__ = d_T0_d_v_vgvb__+(d_T3_d_v_vgvb__/BSIM3k1ox);
                                d_T1_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__+(d_T3_d_v_vdpvsp__/BSIM3k1ox);
                                d_T1_d_v_vbvsp__ = d_T0_d_v_vbvsp__+(d_T3_d_v_vbvsp__/BSIM3k1ox);
                            T1 = T0+T3/BSIM3k1ox;
                        else
                                d_T1_d_v_vgvb__ = (1/(2*sqrt(T0*T0+T3)))*((T0*d_T0_d_v_vgvb__+d_T0_d_v_vgvb__*T0)+d_T3_d_v_vgvb__);
                                d_T1_d_v_vdpvsp__ = (1/(2*sqrt(T0*T0+T3)))*((T0*d_T0_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T0)+d_T3_d_v_vdpvsp__);
                                d_T1_d_v_vbvsp__ = (1/(2*sqrt(T0*T0+T3)))*((T0*d_T0_d_v_vbvsp__+d_T0_d_v_vbvsp__*T0)+d_T3_d_v_vbvsp__);
                            T1 = sqrt(T0*T0+T3);
                        end
                    end
                        d_Qsub0_d_v_vgvb__ = (CoxWL*BSIM3k1ox)*(d_T1_d_v_vgvb__-d_T0_d_v_vgvb__);
                        d_Qsub0_d_v_vdpvsp__ = (CoxWL*BSIM3k1ox)*(d_T1_d_v_vdpvsp__-d_T0_d_v_vdpvsp__);
                        d_Qsub0_d_v_vbvsp__ = (CoxWL*BSIM3k1ox)*(d_T1_d_v_vbvsp__-d_T0_d_v_vbvsp__);
                    Qsub0 = (CoxWL*BSIM3k1ox)*(T1-T0);
                        d_AbulkCV_d_v_vgvb__ = d_Abulk0_d_v_vgvb__*BSIM3abulkCVfactor;
                        d_AbulkCV_d_v_vdpvsp__ = d_Abulk0_d_v_vdpvsp__*BSIM3abulkCVfactor;
                        d_AbulkCV_d_v_vbvsp__ = d_Abulk0_d_v_vbvsp__*BSIM3abulkCVfactor;
                    AbulkCV = Abulk0*BSIM3abulkCVfactor;
                        d_VdsatCV_d_v_vgvb__ = d_Vgsteff_d_v_vgvb__/AbulkCV-(Vgsteff*d_AbulkCV_d_v_vgvb__)/AbulkCV^2;
                        d_VdsatCV_d_v_vdpvsp__ = d_Vgsteff_d_v_vdpvsp__/AbulkCV-(Vgsteff*d_AbulkCV_d_v_vdpvsp__)/AbulkCV^2;
                        d_VdsatCV_d_v_vbvsp__ = d_Vgsteff_d_v_vbvsp__/AbulkCV-(Vgsteff*d_AbulkCV_d_v_vbvsp__)/AbulkCV^2;
                    VdsatCV = Vgsteff/AbulkCV;
                        d_V4_d_v_vgvb__ = (d_VdsatCV_d_v_vgvb__);
                        d_V4_d_v_vdpvsp__ = (d_VdsatCV_d_v_vdpvsp__-d_Vds_d_v_vdpvsp__);
                        d_V4_d_v_vbvsp__ = (d_VdsatCV_d_v_vbvsp__);
                    V4 = (VdsatCV-Vds)-0.02;
                        d_T0_d_v_vgvb__ = (1/(2*sqrt(V4*V4+(4*0.02)*VdsatCV)))*((V4*d_V4_d_v_vgvb__+d_V4_d_v_vgvb__*V4)+((4*0.02)*d_VdsatCV_d_v_vgvb__));
                        d_T0_d_v_vdpvsp__ = (1/(2*sqrt(V4*V4+(4*0.02)*VdsatCV)))*((V4*d_V4_d_v_vdpvsp__+d_V4_d_v_vdpvsp__*V4)+((4*0.02)*d_VdsatCV_d_v_vdpvsp__));
                        d_T0_d_v_vbvsp__ = (1/(2*sqrt(V4*V4+(4*0.02)*VdsatCV)))*((V4*d_V4_d_v_vbvsp__+d_V4_d_v_vbvsp__*V4)+((4*0.02)*d_VdsatCV_d_v_vbvsp__));
                    T0 = sqrt(V4*V4+(4*0.02)*VdsatCV);
                        d_VdseffCV_d_v_vgvb__ = d_VdsatCV_d_v_vgvb__-(0.5*(d_V4_d_v_vgvb__+d_T0_d_v_vgvb__));
                        d_VdseffCV_d_v_vdpvsp__ = d_VdsatCV_d_v_vdpvsp__-(0.5*(d_V4_d_v_vdpvsp__+d_T0_d_v_vdpvsp__));
                        d_VdseffCV_d_v_vbvsp__ = d_VdsatCV_d_v_vbvsp__-(0.5*(d_V4_d_v_vbvsp__+d_T0_d_v_vbvsp__));
                    VdseffCV = VdsatCV-0.5*(V4+T0);
                    if Vds==0
                            d_VdseffCV_d_v_vgvb__ = 0;
                            d_VdseffCV_d_v_vdpvsp__ = 0;
                            d_VdseffCV_d_v_vbvsp__ = 0;
                        VdseffCV = 0;
                    end
                        d_T0_d_v_vgvb__ = AbulkCV*d_VdseffCV_d_v_vgvb__+d_AbulkCV_d_v_vgvb__*VdseffCV;
                        d_T0_d_v_vdpvsp__ = AbulkCV*d_VdseffCV_d_v_vdpvsp__+d_AbulkCV_d_v_vdpvsp__*VdseffCV;
                        d_T0_d_v_vbvsp__ = AbulkCV*d_VdseffCV_d_v_vbvsp__+d_AbulkCV_d_v_vbvsp__*VdseffCV;
                    T0 = AbulkCV*VdseffCV;
                        d_T1_d_v_vgvb__ = 12*((d_Vgsteff_d_v_vgvb__-(0.5*d_T0_d_v_vgvb__)));
                        d_T1_d_v_vdpvsp__ = 12*((d_Vgsteff_d_v_vdpvsp__-(0.5*d_T0_d_v_vdpvsp__)));
                        d_T1_d_v_vbvsp__ = 12*((d_Vgsteff_d_v_vbvsp__-(0.5*d_T0_d_v_vbvsp__)));
                    T1 = 12*((Vgsteff-0.5*T0)+1e-20);
                        d_T2_d_v_vgvb__ = d_VdseffCV_d_v_vgvb__/T1-(VdseffCV*d_T1_d_v_vgvb__)/T1^2;
                        d_T2_d_v_vdpvsp__ = d_VdseffCV_d_v_vdpvsp__/T1-(VdseffCV*d_T1_d_v_vdpvsp__)/T1^2;
                        d_T2_d_v_vbvsp__ = d_VdseffCV_d_v_vbvsp__/T1-(VdseffCV*d_T1_d_v_vbvsp__)/T1^2;
                    T2 = VdseffCV/T1;
                        d_T3_d_v_vgvb__ = T0*d_T2_d_v_vgvb__+d_T0_d_v_vgvb__*T2;
                        d_T3_d_v_vdpvsp__ = T0*d_T2_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T2;
                        d_T3_d_v_vbvsp__ = T0*d_T2_d_v_vbvsp__+d_T0_d_v_vbvsp__*T2;
                    T3 = T0*T2;
                        d_qinoi_d_v_vgvb__ = -CoxWL*((d_Vgsteff_d_v_vgvb__-(0.5*d_T0_d_v_vgvb__))+(AbulkCV*d_T3_d_v_vgvb__+d_AbulkCV_d_v_vgvb__*T3));
                        d_qinoi_d_v_vdpvsp__ = -CoxWL*((d_Vgsteff_d_v_vdpvsp__-(0.5*d_T0_d_v_vdpvsp__))+(AbulkCV*d_T3_d_v_vdpvsp__+d_AbulkCV_d_v_vdpvsp__*T3));
                        d_qinoi_d_v_vbvsp__ = -CoxWL*((d_Vgsteff_d_v_vbvsp__-(0.5*d_T0_d_v_vbvsp__))+(AbulkCV*d_T3_d_v_vbvsp__+d_AbulkCV_d_v_vbvsp__*T3));
                    qinoi = -CoxWL*((Vgsteff-0.5*T0)+AbulkCV*T3);
                        d_qgate_d_v_vgvb__ = CoxWL*((d_Vgsteff_d_v_vgvb__-(0.5*d_VdseffCV_d_v_vgvb__))+d_T3_d_v_vgvb__);
                        d_qgate_d_v_vdpvsp__ = CoxWL*((d_Vgsteff_d_v_vdpvsp__-(0.5*d_VdseffCV_d_v_vdpvsp__))+d_T3_d_v_vdpvsp__);
                        d_qgate_d_v_vbvsp__ = CoxWL*((d_Vgsteff_d_v_vbvsp__-(0.5*d_VdseffCV_d_v_vbvsp__))+d_T3_d_v_vbvsp__);
                    qgate = CoxWL*((Vgsteff-0.5*VdseffCV)+T3);
                        d_T7_d_v_vgvb__ = -d_AbulkCV_d_v_vgvb__;
                        d_T7_d_v_vdpvsp__ = -d_AbulkCV_d_v_vdpvsp__;
                        d_T7_d_v_vbvsp__ = -d_AbulkCV_d_v_vbvsp__;
                    T7 = 1-AbulkCV;
                        d_qbulk_d_v_vgvb__ = (CoxWL*T7)*((0.5*d_VdseffCV_d_v_vgvb__)-d_T3_d_v_vgvb__)+(CoxWL*d_T7_d_v_vgvb__)*(0.5*VdseffCV-T3);
                        d_qbulk_d_v_vdpvsp__ = (CoxWL*T7)*((0.5*d_VdseffCV_d_v_vdpvsp__)-d_T3_d_v_vdpvsp__)+(CoxWL*d_T7_d_v_vdpvsp__)*(0.5*VdseffCV-T3);
                        d_qbulk_d_v_vbvsp__ = (CoxWL*T7)*((0.5*d_VdseffCV_d_v_vbvsp__)-d_T3_d_v_vbvsp__)+(CoxWL*d_T7_d_v_vbvsp__)*(0.5*VdseffCV-T3);
                    qbulk = (CoxWL*T7)*(0.5*VdseffCV-T3);
                    if BSIM3xpart>0.5
                            d_T1_d_v_vgvb__ = d_T1_d_v_vgvb__+d_T1_d_v_vgvb__;
                            d_T1_d_v_vdpvsp__ = d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__;
                            d_T1_d_v_vbvsp__ = d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__;
                        T1 = T1+T1;
                            d_qsrc_d_v_vgvb__ = -CoxWL*(((0.5*d_Vgsteff_d_v_vgvb__)+(0.25*d_T0_d_v_vgvb__))-((T0*d_T0_d_v_vgvb__+d_T0_d_v_vgvb__*T0)/T1-((T0*T0)*d_T1_d_v_vgvb__)/T1^2));
                            d_qsrc_d_v_vdpvsp__ = -CoxWL*(((0.5*d_Vgsteff_d_v_vdpvsp__)+(0.25*d_T0_d_v_vdpvsp__))-((T0*d_T0_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T0)/T1-((T0*T0)*d_T1_d_v_vdpvsp__)/T1^2));
                            d_qsrc_d_v_vbvsp__ = -CoxWL*(((0.5*d_Vgsteff_d_v_vbvsp__)+(0.25*d_T0_d_v_vbvsp__))-((T0*d_T0_d_v_vbvsp__+d_T0_d_v_vbvsp__*T0)/T1-((T0*T0)*d_T1_d_v_vbvsp__)/T1^2));
                        qsrc = -CoxWL*((0.5*Vgsteff+0.25*T0)-(T0*T0)/T1);
                    else
                        if BSIM3xpart<0.5
                                d_T1_d_v_vgvb__ = d_T1_d_v_vgvb__/12;
                                d_T1_d_v_vdpvsp__ = d_T1_d_v_vdpvsp__/12;
                                d_T1_d_v_vbvsp__ = d_T1_d_v_vbvsp__/12;
                            T1 = T1/12;
                                d_T2_d_v_vgvb__ = -((0.5*CoxWL)*(T1*d_T1_d_v_vgvb__+d_T1_d_v_vgvb__*T1))/(T1*T1)^2;
                                d_T2_d_v_vdpvsp__ = -((0.5*CoxWL)*(T1*d_T1_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*T1))/(T1*T1)^2;
                                d_T2_d_v_vbvsp__ = -((0.5*CoxWL)*(T1*d_T1_d_v_vbvsp__+d_T1_d_v_vbvsp__*T1))/(T1*T1)^2;
                            T2 = (0.5*CoxWL)/(T1*T1);
                                d_T3_d_v_vgvb__ = (Vgsteff*((((2*T0)*d_T0_d_v_vgvb__+(2*d_T0_d_v_vgvb__)*T0)/3)+(Vgsteff*(d_Vgsteff_d_v_vgvb__-((4*d_T0_d_v_vgvb__)/3))+d_Vgsteff_d_v_vgvb__*(Vgsteff-(4*T0)/3)))+d_Vgsteff_d_v_vgvb__*(((2*T0)*T0)/3+Vgsteff*(Vgsteff-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vgvb__+((2*T0)*d_T0_d_v_vgvb__+(2*d_T0_d_v_vgvb__)*T0)*T0)/15);
                                d_T3_d_v_vdpvsp__ = (Vgsteff*((((2*T0)*d_T0_d_v_vdpvsp__+(2*d_T0_d_v_vdpvsp__)*T0)/3)+(Vgsteff*(d_Vgsteff_d_v_vdpvsp__-((4*d_T0_d_v_vdpvsp__)/3))+d_Vgsteff_d_v_vdpvsp__*(Vgsteff-(4*T0)/3)))+d_Vgsteff_d_v_vdpvsp__*(((2*T0)*T0)/3+Vgsteff*(Vgsteff-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vdpvsp__+((2*T0)*d_T0_d_v_vdpvsp__+(2*d_T0_d_v_vdpvsp__)*T0)*T0)/15);
                                d_T3_d_v_vbvsp__ = (Vgsteff*((((2*T0)*d_T0_d_v_vbvsp__+(2*d_T0_d_v_vbvsp__)*T0)/3)+(Vgsteff*(d_Vgsteff_d_v_vbvsp__-((4*d_T0_d_v_vbvsp__)/3))+d_Vgsteff_d_v_vbvsp__*(Vgsteff-(4*T0)/3)))+d_Vgsteff_d_v_vbvsp__*(((2*T0)*T0)/3+Vgsteff*(Vgsteff-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vbvsp__+((2*T0)*d_T0_d_v_vbvsp__+(2*d_T0_d_v_vbvsp__)*T0)*T0)/15);
                            T3 = Vgsteff*(((2*T0)*T0)/3+Vgsteff*(Vgsteff-(4*T0)/3))-(((2*T0)*T0)*T0)/15;
                                d_qsrc_d_v_vgvb__ = -T2*d_T3_d_v_vgvb__+-d_T2_d_v_vgvb__*T3;
                                d_qsrc_d_v_vdpvsp__ = -T2*d_T3_d_v_vdpvsp__+-d_T2_d_v_vdpvsp__*T3;
                                d_qsrc_d_v_vbvsp__ = -T2*d_T3_d_v_vbvsp__+-d_T2_d_v_vbvsp__*T3;
                            qsrc = -T2*T3;
                        else
                                d_qsrc_d_v_vgvb__ = -0.5*(d_qgate_d_v_vgvb__+d_qbulk_d_v_vgvb__);
                                d_qsrc_d_v_vdpvsp__ = -0.5*(d_qgate_d_v_vdpvsp__+d_qbulk_d_v_vdpvsp__);
                                d_qsrc_d_v_vbvsp__ = -0.5*(d_qgate_d_v_vbvsp__+d_qbulk_d_v_vbvsp__);
                            qsrc = -0.5*(qgate+qbulk);
                        end
                    end
                        d_qgate_d_v_vgvb__ = (d_qgate_d_v_vgvb__+d_Qac0_d_v_vgvb__)+d_Qsub0_d_v_vgvb__;
                        d_qgate_d_v_vdpvsp__ = (d_qgate_d_v_vdpvsp__+d_Qac0_d_v_vdpvsp__)+d_Qsub0_d_v_vdpvsp__;
                        d_qgate_d_v_vbvsp__ = (d_qgate_d_v_vbvsp__+d_Qac0_d_v_vbvsp__)+d_Qsub0_d_v_vbvsp__;
                    qgate = (qgate+Qac0)+Qsub0;
                        d_qbulk_d_v_vgvb__ = d_qbulk_d_v_vgvb__-(d_Qac0_d_v_vgvb__+d_Qsub0_d_v_vgvb__);
                        d_qbulk_d_v_vdpvsp__ = d_qbulk_d_v_vdpvsp__-(d_Qac0_d_v_vdpvsp__+d_Qsub0_d_v_vdpvsp__);
                        d_qbulk_d_v_vbvsp__ = d_qbulk_d_v_vbvsp__-(d_Qac0_d_v_vbvsp__+d_Qsub0_d_v_vbvsp__);
                    qbulk = qbulk-(Qac0+Qsub0);
                        d_qdrn_d_v_vgvb__ = -((d_qgate_d_v_vgvb__+d_qbulk_d_v_vgvb__)+d_qsrc_d_v_vgvb__);
                        d_qdrn_d_v_vdpvsp__ = -((d_qgate_d_v_vdpvsp__+d_qbulk_d_v_vdpvsp__)+d_qsrc_d_v_vdpvsp__);
                        d_qdrn_d_v_vbvsp__ = -((d_qgate_d_v_vbvsp__+d_qbulk_d_v_vbvsp__)+d_qsrc_d_v_vbvsp__);
                    qdrn = -((qgate+qbulk)+qsrc);
                        d_BSIM3qinv_d_v_vgvb__ = d_qinoi_d_v_vgvb__;
                        d_BSIM3qinv_d_v_vdpvsp__ = d_qinoi_d_v_vdpvsp__;
                        d_BSIM3qinv_d_v_vbvsp__ = d_qinoi_d_v_vbvsp__;
                    BSIM3qinv = qinoi;
                else
                    if BSIM3capMod==3
                            d_V3_d_v_vgvb__ = ((-d_Vgs_eff_d_v_vgvb__));
                            d_V3_d_v_vdpvsp__ = ((-d_Vgs_eff_d_v_vdpvsp__)+d_VbseffCV_d_v_vdpvsp__);
                            d_V3_d_v_vbvsp__ = ((-d_Vgs_eff_d_v_vbvsp__)+d_VbseffCV_d_v_vbvsp__);
                        V3 = ((BSIM3vfbzb-Vgs_eff)+VbseffCV)-0.02;
                        if BSIM3vfbzb<=0
                                d_T0_d_v_vgvb__ = (1/(2*sqrt(V3*V3-(4*0.02)*BSIM3vfbzb)))*((V3*d_V3_d_v_vgvb__+d_V3_d_v_vgvb__*V3));
                                d_T0_d_v_vdpvsp__ = (1/(2*sqrt(V3*V3-(4*0.02)*BSIM3vfbzb)))*((V3*d_V3_d_v_vdpvsp__+d_V3_d_v_vdpvsp__*V3));
                                d_T0_d_v_vbvsp__ = (1/(2*sqrt(V3*V3-(4*0.02)*BSIM3vfbzb)))*((V3*d_V3_d_v_vbvsp__+d_V3_d_v_vbvsp__*V3));
                            T0 = sqrt(V3*V3-(4*0.02)*BSIM3vfbzb);
                        else
                                d_T0_d_v_vgvb__ = (1/(2*sqrt(V3*V3+(4*0.02)*BSIM3vfbzb)))*((V3*d_V3_d_v_vgvb__+d_V3_d_v_vgvb__*V3));
                                d_T0_d_v_vdpvsp__ = (1/(2*sqrt(V3*V3+(4*0.02)*BSIM3vfbzb)))*((V3*d_V3_d_v_vdpvsp__+d_V3_d_v_vdpvsp__*V3));
                                d_T0_d_v_vbvsp__ = (1/(2*sqrt(V3*V3+(4*0.02)*BSIM3vfbzb)))*((V3*d_V3_d_v_vbvsp__+d_V3_d_v_vbvsp__*V3));
                            T0 = sqrt(V3*V3+(4*0.02)*BSIM3vfbzb);
                        end
                            d_Vfbeff_d_v_vgvb__ = -(0.5*(d_V3_d_v_vgvb__+d_T0_d_v_vgvb__));
                            d_Vfbeff_d_v_vdpvsp__ = -(0.5*(d_V3_d_v_vdpvsp__+d_T0_d_v_vdpvsp__));
                            d_Vfbeff_d_v_vbvsp__ = -(0.5*(d_V3_d_v_vbvsp__+d_T0_d_v_vbvsp__));
                        Vfbeff = BSIM3vfbzb-0.5*(V3+T0);
                        Cox = BSIM3cox;
                        Tox = 100000000*BSIM3tox;
                            d_T0_d_v_vgvb__ = ((d_Vgs_eff_d_v_vgvb__))/Tox;
                            d_T0_d_v_vdpvsp__ = ((d_Vgs_eff_d_v_vdpvsp__-d_VbseffCV_d_v_vdpvsp__))/Tox;
                            d_T0_d_v_vbvsp__ = ((d_Vgs_eff_d_v_vbvsp__-d_VbseffCV_d_v_vbvsp__))/Tox;
                        T0 = ((Vgs_eff-VbseffCV)-BSIM3vfbzb)/Tox;
                            d_tmp_d_v_vgvb__ = d_T0_d_v_vgvb__*BSIM3acde;
                            d_tmp_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__*BSIM3acde;
                            d_tmp_d_v_vbvsp__ = d_T0_d_v_vbvsp__*BSIM3acde;
                        tmp = T0*BSIM3acde;
                        if -34<tmp&&tmp<34
                                d_Tcen_d_v_vgvb__ = BSIM3ldeb*(exp(tmp)*d_tmp_d_v_vgvb__);
                                d_Tcen_d_v_vdpvsp__ = BSIM3ldeb*(exp(tmp)*d_tmp_d_v_vdpvsp__);
                                d_Tcen_d_v_vbvsp__ = BSIM3ldeb*(exp(tmp)*d_tmp_d_v_vbvsp__);
                            Tcen = BSIM3ldeb*exp(tmp);
                        else
                            if tmp<=-34
                                    d_Tcen_d_v_vgvb__ = 0;
                                    d_Tcen_d_v_vdpvsp__ = 0;
                                    d_Tcen_d_v_vbvsp__ = 0;
                                Tcen = BSIM3ldeb*1.7139e-15;
                            else
                                    d_Tcen_d_v_vgvb__ = 0;
                                    d_Tcen_d_v_vdpvsp__ = 0;
                                    d_Tcen_d_v_vbvsp__ = 0;
                                Tcen = BSIM3ldeb*583461742500000;
                            end
                        end
                        LINK = 0.001*BSIM3tox;
                            d_V3_d_v_vgvb__ = (-d_Tcen_d_v_vgvb__);
                            d_V3_d_v_vdpvsp__ = (-d_Tcen_d_v_vdpvsp__);
                            d_V3_d_v_vbvsp__ = (-d_Tcen_d_v_vbvsp__);
                        V3 = (BSIM3ldeb-Tcen)-LINK;
                            d_V4_d_v_vgvb__ = (1/(2*sqrt(V3*V3+(4*LINK)*BSIM3ldeb)))*((V3*d_V3_d_v_vgvb__+d_V3_d_v_vgvb__*V3));
                            d_V4_d_v_vdpvsp__ = (1/(2*sqrt(V3*V3+(4*LINK)*BSIM3ldeb)))*((V3*d_V3_d_v_vdpvsp__+d_V3_d_v_vdpvsp__*V3));
                            d_V4_d_v_vbvsp__ = (1/(2*sqrt(V3*V3+(4*LINK)*BSIM3ldeb)))*((V3*d_V3_d_v_vbvsp__+d_V3_d_v_vbvsp__*V3));
                        V4 = sqrt(V3*V3+(4*LINK)*BSIM3ldeb);
                            d_Tcen_d_v_vgvb__ = -(0.5*(d_V3_d_v_vgvb__+d_V4_d_v_vgvb__));
                            d_Tcen_d_v_vdpvsp__ = -(0.5*(d_V3_d_v_vdpvsp__+d_V4_d_v_vdpvsp__));
                            d_Tcen_d_v_vbvsp__ = -(0.5*(d_V3_d_v_vbvsp__+d_V4_d_v_vbvsp__));
                        Tcen = BSIM3ldeb-0.5*(V3+V4);
                            d_Ccen_d_v_vgvb__ = -(1.0359e-10*d_Tcen_d_v_vgvb__)/Tcen^2;
                            d_Ccen_d_v_vdpvsp__ = -(1.0359e-10*d_Tcen_d_v_vdpvsp__)/Tcen^2;
                            d_Ccen_d_v_vbvsp__ = -(1.0359e-10*d_Tcen_d_v_vbvsp__)/Tcen^2;
                        Ccen = 1.0359e-10/Tcen;
                            d_T2_d_v_vgvb__ = -(Cox*(d_Ccen_d_v_vgvb__))/(Cox+Ccen)^2;
                            d_T2_d_v_vdpvsp__ = -(Cox*(d_Ccen_d_v_vdpvsp__))/(Cox+Ccen)^2;
                            d_T2_d_v_vbvsp__ = -(Cox*(d_Ccen_d_v_vbvsp__))/(Cox+Ccen)^2;
                        T2 = Cox/(Cox+Ccen);
                            d_Coxeff_d_v_vgvb__ = T2*d_Ccen_d_v_vgvb__+d_T2_d_v_vgvb__*Ccen;
                            d_Coxeff_d_v_vdpvsp__ = T2*d_Ccen_d_v_vdpvsp__+d_T2_d_v_vdpvsp__*Ccen;
                            d_Coxeff_d_v_vbvsp__ = T2*d_Ccen_d_v_vbvsp__+d_T2_d_v_vbvsp__*Ccen;
                        Coxeff = T2*Ccen;
                            d_CoxWLcen_d_v_vgvb__ = (CoxWL*d_Coxeff_d_v_vgvb__)/Cox;
                            d_CoxWLcen_d_v_vdpvsp__ = (CoxWL*d_Coxeff_d_v_vdpvsp__)/Cox;
                            d_CoxWLcen_d_v_vbvsp__ = (CoxWL*d_Coxeff_d_v_vbvsp__)/Cox;
                        CoxWLcen = (CoxWL*Coxeff)/Cox;
                            d_Qac0_d_v_vgvb__ = CoxWLcen*(d_Vfbeff_d_v_vgvb__)+d_CoxWLcen_d_v_vgvb__*(Vfbeff-BSIM3vfbzb);
                            d_Qac0_d_v_vdpvsp__ = CoxWLcen*(d_Vfbeff_d_v_vdpvsp__)+d_CoxWLcen_d_v_vdpvsp__*(Vfbeff-BSIM3vfbzb);
                            d_Qac0_d_v_vbvsp__ = CoxWLcen*(d_Vfbeff_d_v_vbvsp__)+d_CoxWLcen_d_v_vbvsp__*(Vfbeff-BSIM3vfbzb);
                        Qac0 = CoxWLcen*(Vfbeff-BSIM3vfbzb);
                            d_T0_d_v_vgvb__ = 0;
                            d_T0_d_v_vdpvsp__ = 0;
                            d_T0_d_v_vbvsp__ = 0;
                        T0 = 0.5*BSIM3k1ox;
                            d_T3_d_v_vgvb__ = ((d_Vgs_eff_d_v_vgvb__-d_Vfbeff_d_v_vgvb__))-d_Vgsteff_d_v_vgvb__;
                            d_T3_d_v_vdpvsp__ = ((d_Vgs_eff_d_v_vdpvsp__-d_Vfbeff_d_v_vdpvsp__)-d_VbseffCV_d_v_vdpvsp__)-d_Vgsteff_d_v_vdpvsp__;
                            d_T3_d_v_vbvsp__ = ((d_Vgs_eff_d_v_vbvsp__-d_Vfbeff_d_v_vbvsp__)-d_VbseffCV_d_v_vbvsp__)-d_Vgsteff_d_v_vbvsp__;
                        T3 = ((Vgs_eff-Vfbeff)-VbseffCV)-Vgsteff;
                        if BSIM3k1ox==0
                                d_T1_d_v_vgvb__ = 0;
                                d_T1_d_v_vdpvsp__ = 0;
                                d_T1_d_v_vbvsp__ = 0;
                            T1 = 0;
                        else
                            if T3<0
                                    d_T1_d_v_vgvb__ = d_T0_d_v_vgvb__+(d_T3_d_v_vgvb__/BSIM3k1ox);
                                    d_T1_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__+(d_T3_d_v_vdpvsp__/BSIM3k1ox);
                                    d_T1_d_v_vbvsp__ = d_T0_d_v_vbvsp__+(d_T3_d_v_vbvsp__/BSIM3k1ox);
                                T1 = T0+T3/BSIM3k1ox;
                            else
                                    d_T1_d_v_vgvb__ = (1/(2*sqrt(T0*T0+T3)))*((T0*d_T0_d_v_vgvb__+d_T0_d_v_vgvb__*T0)+d_T3_d_v_vgvb__);
                                    d_T1_d_v_vdpvsp__ = (1/(2*sqrt(T0*T0+T3)))*((T0*d_T0_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T0)+d_T3_d_v_vdpvsp__);
                                    d_T1_d_v_vbvsp__ = (1/(2*sqrt(T0*T0+T3)))*((T0*d_T0_d_v_vbvsp__+d_T0_d_v_vbvsp__*T0)+d_T3_d_v_vbvsp__);
                                T1 = sqrt(T0*T0+T3);
                            end
                        end
                            d_Qsub0_d_v_vgvb__ = (CoxWLcen*BSIM3k1ox)*(d_T1_d_v_vgvb__-d_T0_d_v_vgvb__)+(d_CoxWLcen_d_v_vgvb__*BSIM3k1ox)*(T1-T0);
                            d_Qsub0_d_v_vdpvsp__ = (CoxWLcen*BSIM3k1ox)*(d_T1_d_v_vdpvsp__-d_T0_d_v_vdpvsp__)+(d_CoxWLcen_d_v_vdpvsp__*BSIM3k1ox)*(T1-T0);
                            d_Qsub0_d_v_vbvsp__ = (CoxWLcen*BSIM3k1ox)*(d_T1_d_v_vbvsp__-d_T0_d_v_vbvsp__)+(d_CoxWLcen_d_v_vbvsp__*BSIM3k1ox)*(T1-T0);
                        Qsub0 = (CoxWLcen*BSIM3k1ox)*(T1-T0);
                        if BSIM3k1ox<=0
                                d_Denomi_d_v_vgvb__ = 0;
                                d_Denomi_d_v_vdpvsp__ = 0;
                                d_Denomi_d_v_vbvsp__ = 0;
                            Denomi = (0.25*BSIM3moin)*Vtm;
                                d_T0_d_v_vgvb__ = 0;
                                d_T0_d_v_vdpvsp__ = 0;
                                d_T0_d_v_vbvsp__ = 0;
                            T0 = 0.5*BSIM3sqrtPhi;
                        else
                                d_Denomi_d_v_vgvb__ = 0;
                                d_Denomi_d_v_vdpvsp__ = 0;
                                d_Denomi_d_v_vbvsp__ = 0;
                            Denomi = ((BSIM3moin*Vtm)*BSIM3k1ox)*BSIM3k1ox;
                                d_T0_d_v_vgvb__ = 0;
                                d_T0_d_v_vdpvsp__ = 0;
                                d_T0_d_v_vbvsp__ = 0;
                            T0 = BSIM3k1ox*BSIM3sqrtPhi;
                        end
                            d_T1_d_v_vgvb__ = (2*d_T0_d_v_vgvb__)+d_Vgsteff_d_v_vgvb__;
                            d_T1_d_v_vdpvsp__ = (2*d_T0_d_v_vdpvsp__)+d_Vgsteff_d_v_vdpvsp__;
                            d_T1_d_v_vbvsp__ = (2*d_T0_d_v_vbvsp__)+d_Vgsteff_d_v_vbvsp__;
                        T1 = 2*T0+Vgsteff;
                            d_DeltaPhi_d_v_vgvb__ = Vtm*((1/((1+(T1*Vgsteff)/Denomi)*log(10)))*(((T1*d_Vgsteff_d_v_vgvb__+d_T1_d_v_vgvb__*Vgsteff)/Denomi-((T1*Vgsteff)*d_Denomi_d_v_vgvb__)/Denomi^2)));
                            d_DeltaPhi_d_v_vdpvsp__ = Vtm*((1/((1+(T1*Vgsteff)/Denomi)*log(10)))*(((T1*d_Vgsteff_d_v_vdpvsp__+d_T1_d_v_vdpvsp__*Vgsteff)/Denomi-((T1*Vgsteff)*d_Denomi_d_v_vdpvsp__)/Denomi^2)));
                            d_DeltaPhi_d_v_vbvsp__ = Vtm*((1/((1+(T1*Vgsteff)/Denomi)*log(10)))*(((T1*d_Vgsteff_d_v_vbvsp__+d_T1_d_v_vbvsp__*Vgsteff)/Denomi-((T1*Vgsteff)*d_Denomi_d_v_vbvsp__)/Denomi^2)));
                        DeltaPhi = Vtm*log10(1+(T1*Vgsteff)/Denomi);
                            d_T3_d_v_vgvb__ = 0;
                            d_T3_d_v_vdpvsp__ = 4*((d_Vth_d_v_vdpvsp__));
                            d_T3_d_v_vbvsp__ = 4*((d_Vth_d_v_vbvsp__));
                        T3 = 4*((Vth-BSIM3vfbzb)-BSIM3phi);
                        Tox = Tox+Tox;
                        if T3>=0
                                d_T0_d_v_vgvb__ = (d_Vgsteff_d_v_vgvb__+d_T3_d_v_vgvb__)/Tox;
                                d_T0_d_v_vdpvsp__ = (d_Vgsteff_d_v_vdpvsp__+d_T3_d_v_vdpvsp__)/Tox;
                                d_T0_d_v_vbvsp__ = (d_Vgsteff_d_v_vbvsp__+d_T3_d_v_vbvsp__)/Tox;
                            T0 = (Vgsteff+T3)/Tox;
                        else
                                d_T0_d_v_vgvb__ = (d_Vgsteff_d_v_vgvb__)/Tox;
                                d_T0_d_v_vdpvsp__ = (d_Vgsteff_d_v_vdpvsp__)/Tox;
                                d_T0_d_v_vbvsp__ = (d_Vgsteff_d_v_vbvsp__)/Tox;
                            T0 = (Vgsteff+1e-20)/Tox;
                        end
                            d_tmp_d_v_vgvb__ = exp(0.7*log10(T0))*(0.7*((1/(T0*log(10)))*d_T0_d_v_vgvb__));
                            d_tmp_d_v_vdpvsp__ = exp(0.7*log10(T0))*(0.7*((1/(T0*log(10)))*d_T0_d_v_vdpvsp__));
                            d_tmp_d_v_vbvsp__ = exp(0.7*log10(T0))*(0.7*((1/(T0*log(10)))*d_T0_d_v_vbvsp__));
                        tmp = exp(0.7*log10(T0));
                            d_T1_d_v_vgvb__ = d_tmp_d_v_vgvb__;
                            d_T1_d_v_vdpvsp__ = d_tmp_d_v_vdpvsp__;
                            d_T1_d_v_vbvsp__ = d_tmp_d_v_vbvsp__;
                        T1 = 1+tmp;
                            d_Tcen_d_v_vgvb__ = -(1.9e-09*d_T1_d_v_vgvb__)/T1^2;
                            d_Tcen_d_v_vdpvsp__ = -(1.9e-09*d_T1_d_v_vdpvsp__)/T1^2;
                            d_Tcen_d_v_vbvsp__ = -(1.9e-09*d_T1_d_v_vbvsp__)/T1^2;
                        Tcen = 1.9e-09/T1;
                            d_Ccen_d_v_vgvb__ = -(1.0359e-10*d_Tcen_d_v_vgvb__)/Tcen^2;
                            d_Ccen_d_v_vdpvsp__ = -(1.0359e-10*d_Tcen_d_v_vdpvsp__)/Tcen^2;
                            d_Ccen_d_v_vbvsp__ = -(1.0359e-10*d_Tcen_d_v_vbvsp__)/Tcen^2;
                        Ccen = 1.0359e-10/Tcen;
                            d_T0_d_v_vgvb__ = -(Cox*(d_Ccen_d_v_vgvb__))/(Cox+Ccen)^2;
                            d_T0_d_v_vdpvsp__ = -(Cox*(d_Ccen_d_v_vdpvsp__))/(Cox+Ccen)^2;
                            d_T0_d_v_vbvsp__ = -(Cox*(d_Ccen_d_v_vbvsp__))/(Cox+Ccen)^2;
                        T0 = Cox/(Cox+Ccen);
                            d_Coxeff_d_v_vgvb__ = T0*d_Ccen_d_v_vgvb__+d_T0_d_v_vgvb__*Ccen;
                            d_Coxeff_d_v_vdpvsp__ = T0*d_Ccen_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*Ccen;
                            d_Coxeff_d_v_vbvsp__ = T0*d_Ccen_d_v_vbvsp__+d_T0_d_v_vbvsp__*Ccen;
                        Coxeff = T0*Ccen;
                            d_CoxWLcen_d_v_vgvb__ = (CoxWL*d_Coxeff_d_v_vgvb__)/Cox;
                            d_CoxWLcen_d_v_vdpvsp__ = (CoxWL*d_Coxeff_d_v_vdpvsp__)/Cox;
                            d_CoxWLcen_d_v_vbvsp__ = (CoxWL*d_Coxeff_d_v_vbvsp__)/Cox;
                        CoxWLcen = (CoxWL*Coxeff)/Cox;
                            d_AbulkCV_d_v_vgvb__ = d_Abulk0_d_v_vgvb__*BSIM3abulkCVfactor;
                            d_AbulkCV_d_v_vdpvsp__ = d_Abulk0_d_v_vdpvsp__*BSIM3abulkCVfactor;
                            d_AbulkCV_d_v_vbvsp__ = d_Abulk0_d_v_vbvsp__*BSIM3abulkCVfactor;
                        AbulkCV = Abulk0*BSIM3abulkCVfactor;
                            d_VdsatCV_d_v_vgvb__ = (d_Vgsteff_d_v_vgvb__-d_DeltaPhi_d_v_vgvb__)/AbulkCV-((Vgsteff-DeltaPhi)*d_AbulkCV_d_v_vgvb__)/AbulkCV^2;
                            d_VdsatCV_d_v_vdpvsp__ = (d_Vgsteff_d_v_vdpvsp__-d_DeltaPhi_d_v_vdpvsp__)/AbulkCV-((Vgsteff-DeltaPhi)*d_AbulkCV_d_v_vdpvsp__)/AbulkCV^2;
                            d_VdsatCV_d_v_vbvsp__ = (d_Vgsteff_d_v_vbvsp__-d_DeltaPhi_d_v_vbvsp__)/AbulkCV-((Vgsteff-DeltaPhi)*d_AbulkCV_d_v_vbvsp__)/AbulkCV^2;
                        VdsatCV = (Vgsteff-DeltaPhi)/AbulkCV;
                            d_V4_d_v_vgvb__ = (d_VdsatCV_d_v_vgvb__);
                            d_V4_d_v_vdpvsp__ = (d_VdsatCV_d_v_vdpvsp__-d_Vds_d_v_vdpvsp__);
                            d_V4_d_v_vbvsp__ = (d_VdsatCV_d_v_vbvsp__);
                        V4 = (VdsatCV-Vds)-0.02;
                            d_T0_d_v_vgvb__ = (1/(2*sqrt(V4*V4+(4*0.02)*VdsatCV)))*((V4*d_V4_d_v_vgvb__+d_V4_d_v_vgvb__*V4)+((4*0.02)*d_VdsatCV_d_v_vgvb__));
                            d_T0_d_v_vdpvsp__ = (1/(2*sqrt(V4*V4+(4*0.02)*VdsatCV)))*((V4*d_V4_d_v_vdpvsp__+d_V4_d_v_vdpvsp__*V4)+((4*0.02)*d_VdsatCV_d_v_vdpvsp__));
                            d_T0_d_v_vbvsp__ = (1/(2*sqrt(V4*V4+(4*0.02)*VdsatCV)))*((V4*d_V4_d_v_vbvsp__+d_V4_d_v_vbvsp__*V4)+((4*0.02)*d_VdsatCV_d_v_vbvsp__));
                        T0 = sqrt(V4*V4+(4*0.02)*VdsatCV);
                            d_VdseffCV_d_v_vgvb__ = d_VdsatCV_d_v_vgvb__-(0.5*(d_V4_d_v_vgvb__+d_T0_d_v_vgvb__));
                            d_VdseffCV_d_v_vdpvsp__ = d_VdsatCV_d_v_vdpvsp__-(0.5*(d_V4_d_v_vdpvsp__+d_T0_d_v_vdpvsp__));
                            d_VdseffCV_d_v_vbvsp__ = d_VdsatCV_d_v_vbvsp__-(0.5*(d_V4_d_v_vbvsp__+d_T0_d_v_vbvsp__));
                        VdseffCV = VdsatCV-0.5*(V4+T0);
                            d_T1_d_v_vgvb__ = 0.5*((d_V4_d_v_vgvb__/T0-(V4*d_T0_d_v_vgvb__)/T0^2));
                            d_T1_d_v_vdpvsp__ = 0.5*((d_V4_d_v_vdpvsp__/T0-(V4*d_T0_d_v_vdpvsp__)/T0^2));
                            d_T1_d_v_vbvsp__ = 0.5*((d_V4_d_v_vbvsp__/T0-(V4*d_T0_d_v_vbvsp__)/T0^2));
                        T1 = 0.5*(1+V4/T0);
                        if Vds==0
                                d_VdseffCV_d_v_vgvb__ = 0;
                                d_VdseffCV_d_v_vdpvsp__ = 0;
                                d_VdseffCV_d_v_vbvsp__ = 0;
                            VdseffCV = 0;
                        end
                            d_T0_d_v_vgvb__ = AbulkCV*d_VdseffCV_d_v_vgvb__+d_AbulkCV_d_v_vgvb__*VdseffCV;
                            d_T0_d_v_vdpvsp__ = AbulkCV*d_VdseffCV_d_v_vdpvsp__+d_AbulkCV_d_v_vdpvsp__*VdseffCV;
                            d_T0_d_v_vbvsp__ = AbulkCV*d_VdseffCV_d_v_vbvsp__+d_AbulkCV_d_v_vbvsp__*VdseffCV;
                        T0 = AbulkCV*VdseffCV;
                            d_T1_d_v_vgvb__ = d_Vgsteff_d_v_vgvb__-d_DeltaPhi_d_v_vgvb__;
                            d_T1_d_v_vdpvsp__ = d_Vgsteff_d_v_vdpvsp__-d_DeltaPhi_d_v_vdpvsp__;
                            d_T1_d_v_vbvsp__ = d_Vgsteff_d_v_vbvsp__-d_DeltaPhi_d_v_vbvsp__;
                        T1 = Vgsteff-DeltaPhi;
                            d_T2_d_v_vgvb__ = 12*((d_T1_d_v_vgvb__-(0.5*d_T0_d_v_vgvb__)));
                            d_T2_d_v_vdpvsp__ = 12*((d_T1_d_v_vdpvsp__-(0.5*d_T0_d_v_vdpvsp__)));
                            d_T2_d_v_vbvsp__ = 12*((d_T1_d_v_vbvsp__-(0.5*d_T0_d_v_vbvsp__)));
                        T2 = 12*((T1-0.5*T0)+1e-20);
                            d_T3_d_v_vgvb__ = d_T0_d_v_vgvb__/T2-(T0*d_T2_d_v_vgvb__)/T2^2;
                            d_T3_d_v_vdpvsp__ = d_T0_d_v_vdpvsp__/T2-(T0*d_T2_d_v_vdpvsp__)/T2^2;
                            d_T3_d_v_vbvsp__ = d_T0_d_v_vbvsp__/T2-(T0*d_T2_d_v_vbvsp__)/T2^2;
                        T3 = T0/T2;
                            d_T4_d_v_vgvb__ = -((12*T3)*d_T3_d_v_vgvb__+(12*d_T3_d_v_vgvb__)*T3);
                            d_T4_d_v_vdpvsp__ = -((12*T3)*d_T3_d_v_vdpvsp__+(12*d_T3_d_v_vdpvsp__)*T3);
                            d_T4_d_v_vbvsp__ = -((12*T3)*d_T3_d_v_vbvsp__+(12*d_T3_d_v_vbvsp__)*T3);
                        T4 = 1-(12*T3)*T3;
                            d_T5_d_v_vgvb__ = AbulkCV*((((6*T0)*((4*d_T1_d_v_vgvb__)-d_T0_d_v_vgvb__)+(6*d_T0_d_v_vgvb__)*(4*T1-T0))/(T2*T2)-(((6*T0)*(4*T1-T0))*(T2*d_T2_d_v_vgvb__+d_T2_d_v_vgvb__*T2))/(T2*T2)^2))+d_AbulkCV_d_v_vgvb__*(((6*T0)*(4*T1-T0))/(T2*T2)-0.5);
                            d_T5_d_v_vdpvsp__ = AbulkCV*((((6*T0)*((4*d_T1_d_v_vdpvsp__)-d_T0_d_v_vdpvsp__)+(6*d_T0_d_v_vdpvsp__)*(4*T1-T0))/(T2*T2)-(((6*T0)*(4*T1-T0))*(T2*d_T2_d_v_vdpvsp__+d_T2_d_v_vdpvsp__*T2))/(T2*T2)^2))+d_AbulkCV_d_v_vdpvsp__*(((6*T0)*(4*T1-T0))/(T2*T2)-0.5);
                            d_T5_d_v_vbvsp__ = AbulkCV*((((6*T0)*((4*d_T1_d_v_vbvsp__)-d_T0_d_v_vbvsp__)+(6*d_T0_d_v_vbvsp__)*(4*T1-T0))/(T2*T2)-(((6*T0)*(4*T1-T0))*(T2*d_T2_d_v_vbvsp__+d_T2_d_v_vbvsp__*T2))/(T2*T2)^2))+d_AbulkCV_d_v_vbvsp__*(((6*T0)*(4*T1-T0))/(T2*T2)-0.5);
                        T5 = AbulkCV*(((6*T0)*(4*T1-T0))/(T2*T2)-0.5);
                            d_T6_d_v_vgvb__ = (T5*d_VdseffCV_d_v_vgvb__+d_T5_d_v_vgvb__*VdseffCV)/AbulkCV-((T5*VdseffCV)*d_AbulkCV_d_v_vgvb__)/AbulkCV^2;
                            d_T6_d_v_vdpvsp__ = (T5*d_VdseffCV_d_v_vdpvsp__+d_T5_d_v_vdpvsp__*VdseffCV)/AbulkCV-((T5*VdseffCV)*d_AbulkCV_d_v_vdpvsp__)/AbulkCV^2;
                            d_T6_d_v_vbvsp__ = (T5*d_VdseffCV_d_v_vbvsp__+d_T5_d_v_vbvsp__*VdseffCV)/AbulkCV-((T5*VdseffCV)*d_AbulkCV_d_v_vbvsp__)/AbulkCV^2;
                        T6 = (T5*VdseffCV)/AbulkCV;
                            d_qgate_d_v_vgvb__ = CoxWLcen*(d_T1_d_v_vgvb__-(T0*(-d_T3_d_v_vgvb__)+d_T0_d_v_vgvb__*(0.5-T3)))+d_CoxWLcen_d_v_vgvb__*(T1-T0*(0.5-T3));
                            d_qgate_d_v_vdpvsp__ = CoxWLcen*(d_T1_d_v_vdpvsp__-(T0*(-d_T3_d_v_vdpvsp__)+d_T0_d_v_vdpvsp__*(0.5-T3)))+d_CoxWLcen_d_v_vdpvsp__*(T1-T0*(0.5-T3));
                            d_qgate_d_v_vbvsp__ = CoxWLcen*(d_T1_d_v_vbvsp__-(T0*(-d_T3_d_v_vbvsp__)+d_T0_d_v_vbvsp__*(0.5-T3)))+d_CoxWLcen_d_v_vbvsp__*(T1-T0*(0.5-T3));
                        qgate = CoxWLcen*(T1-T0*(0.5-T3));
                            d_qinoi_d_v_vgvb__ = d_qgate_d_v_vgvb__;
                            d_qinoi_d_v_vdpvsp__ = d_qgate_d_v_vdpvsp__;
                            d_qinoi_d_v_vbvsp__ = d_qgate_d_v_vbvsp__;
                        qinoi = qgate;
                            d_T7_d_v_vgvb__ = -d_AbulkCV_d_v_vgvb__;
                            d_T7_d_v_vdpvsp__ = -d_AbulkCV_d_v_vdpvsp__;
                            d_T7_d_v_vbvsp__ = -d_AbulkCV_d_v_vbvsp__;
                        T7 = 1-AbulkCV;
                            d_qbulk_d_v_vgvb__ = (CoxWLcen*T7)*((0.5*d_VdseffCV_d_v_vgvb__)-((T0*d_VdseffCV_d_v_vgvb__+d_T0_d_v_vgvb__*VdseffCV)/T2-((T0*VdseffCV)*d_T2_d_v_vgvb__)/T2^2))+(CoxWLcen*d_T7_d_v_vgvb__+d_CoxWLcen_d_v_vgvb__*T7)*(0.5*VdseffCV-(T0*VdseffCV)/T2);
                            d_qbulk_d_v_vdpvsp__ = (CoxWLcen*T7)*((0.5*d_VdseffCV_d_v_vdpvsp__)-((T0*d_VdseffCV_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*VdseffCV)/T2-((T0*VdseffCV)*d_T2_d_v_vdpvsp__)/T2^2))+(CoxWLcen*d_T7_d_v_vdpvsp__+d_CoxWLcen_d_v_vdpvsp__*T7)*(0.5*VdseffCV-(T0*VdseffCV)/T2);
                            d_qbulk_d_v_vbvsp__ = (CoxWLcen*T7)*((0.5*d_VdseffCV_d_v_vbvsp__)-((T0*d_VdseffCV_d_v_vbvsp__+d_T0_d_v_vbvsp__*VdseffCV)/T2-((T0*VdseffCV)*d_T2_d_v_vbvsp__)/T2^2))+(CoxWLcen*d_T7_d_v_vbvsp__+d_CoxWLcen_d_v_vbvsp__*T7)*(0.5*VdseffCV-(T0*VdseffCV)/T2);
                        qbulk = (CoxWLcen*T7)*(0.5*VdseffCV-(T0*VdseffCV)/T2);
                        if BSIM3xpart>0.5
                                d_qsrc_d_v_vgvb__ = -CoxWLcen*(((d_T1_d_v_vgvb__/2)+(d_T0_d_v_vgvb__/4))-(((0.5*T0)*d_T0_d_v_vgvb__+(0.5*d_T0_d_v_vgvb__)*T0)/T2-(((0.5*T0)*T0)*d_T2_d_v_vgvb__)/T2^2))+-d_CoxWLcen_d_v_vgvb__*((T1/2+T0/4)-((0.5*T0)*T0)/T2);
                                d_qsrc_d_v_vdpvsp__ = -CoxWLcen*(((d_T1_d_v_vdpvsp__/2)+(d_T0_d_v_vdpvsp__/4))-(((0.5*T0)*d_T0_d_v_vdpvsp__+(0.5*d_T0_d_v_vdpvsp__)*T0)/T2-(((0.5*T0)*T0)*d_T2_d_v_vdpvsp__)/T2^2))+-d_CoxWLcen_d_v_vdpvsp__*((T1/2+T0/4)-((0.5*T0)*T0)/T2);
                                d_qsrc_d_v_vbvsp__ = -CoxWLcen*(((d_T1_d_v_vbvsp__/2)+(d_T0_d_v_vbvsp__/4))-(((0.5*T0)*d_T0_d_v_vbvsp__+(0.5*d_T0_d_v_vbvsp__)*T0)/T2-(((0.5*T0)*T0)*d_T2_d_v_vbvsp__)/T2^2))+-d_CoxWLcen_d_v_vbvsp__*((T1/2+T0/4)-((0.5*T0)*T0)/T2);
                            qsrc = -CoxWLcen*((T1/2+T0/4)-((0.5*T0)*T0)/T2);
                        else
                            if BSIM3xpart<0.5
                                    d_T2_d_v_vgvb__ = d_T2_d_v_vgvb__/12;
                                    d_T2_d_v_vdpvsp__ = d_T2_d_v_vdpvsp__/12;
                                    d_T2_d_v_vbvsp__ = d_T2_d_v_vbvsp__/12;
                                T2 = T2/12;
                                    d_T3_d_v_vgvb__ = (0.5*d_CoxWLcen_d_v_vgvb__)/(T2*T2)-((0.5*CoxWLcen)*(T2*d_T2_d_v_vgvb__+d_T2_d_v_vgvb__*T2))/(T2*T2)^2;
                                    d_T3_d_v_vdpvsp__ = (0.5*d_CoxWLcen_d_v_vdpvsp__)/(T2*T2)-((0.5*CoxWLcen)*(T2*d_T2_d_v_vdpvsp__+d_T2_d_v_vdpvsp__*T2))/(T2*T2)^2;
                                    d_T3_d_v_vbvsp__ = (0.5*d_CoxWLcen_d_v_vbvsp__)/(T2*T2)-((0.5*CoxWLcen)*(T2*d_T2_d_v_vbvsp__+d_T2_d_v_vbvsp__*T2))/(T2*T2)^2;
                                T3 = (0.5*CoxWLcen)/(T2*T2);
                                    d_T4_d_v_vgvb__ = (T1*((((2*T0)*d_T0_d_v_vgvb__+(2*d_T0_d_v_vgvb__)*T0)/3)+(T1*(d_T1_d_v_vgvb__-((4*d_T0_d_v_vgvb__)/3))+d_T1_d_v_vgvb__*(T1-(4*T0)/3)))+d_T1_d_v_vgvb__*(((2*T0)*T0)/3+T1*(T1-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vgvb__+((2*T0)*d_T0_d_v_vgvb__+(2*d_T0_d_v_vgvb__)*T0)*T0)/15);
                                    d_T4_d_v_vdpvsp__ = (T1*((((2*T0)*d_T0_d_v_vdpvsp__+(2*d_T0_d_v_vdpvsp__)*T0)/3)+(T1*(d_T1_d_v_vdpvsp__-((4*d_T0_d_v_vdpvsp__)/3))+d_T1_d_v_vdpvsp__*(T1-(4*T0)/3)))+d_T1_d_v_vdpvsp__*(((2*T0)*T0)/3+T1*(T1-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vdpvsp__+((2*T0)*d_T0_d_v_vdpvsp__+(2*d_T0_d_v_vdpvsp__)*T0)*T0)/15);
                                    d_T4_d_v_vbvsp__ = (T1*((((2*T0)*d_T0_d_v_vbvsp__+(2*d_T0_d_v_vbvsp__)*T0)/3)+(T1*(d_T1_d_v_vbvsp__-((4*d_T0_d_v_vbvsp__)/3))+d_T1_d_v_vbvsp__*(T1-(4*T0)/3)))+d_T1_d_v_vbvsp__*(((2*T0)*T0)/3+T1*(T1-(4*T0)/3)))-((((2*T0)*T0)*d_T0_d_v_vbvsp__+((2*T0)*d_T0_d_v_vbvsp__+(2*d_T0_d_v_vbvsp__)*T0)*T0)/15);
                                T4 = T1*(((2*T0)*T0)/3+T1*(T1-(4*T0)/3))-(((2*T0)*T0)*T0)/15;
                                    d_qsrc_d_v_vgvb__ = -T3*d_T4_d_v_vgvb__+-d_T3_d_v_vgvb__*T4;
                                    d_qsrc_d_v_vdpvsp__ = -T3*d_T4_d_v_vdpvsp__+-d_T3_d_v_vdpvsp__*T4;
                                    d_qsrc_d_v_vbvsp__ = -T3*d_T4_d_v_vbvsp__+-d_T3_d_v_vbvsp__*T4;
                                qsrc = -T3*T4;
                            else
                                    d_qsrc_d_v_vgvb__ = -0.5*d_qgate_d_v_vgvb__;
                                    d_qsrc_d_v_vdpvsp__ = -0.5*d_qgate_d_v_vdpvsp__;
                                    d_qsrc_d_v_vbvsp__ = -0.5*d_qgate_d_v_vbvsp__;
                                qsrc = -0.5*qgate;
                            end
                        end
                            d_qgate_d_v_vgvb__ = ((d_qgate_d_v_vgvb__+d_Qac0_d_v_vgvb__)+d_Qsub0_d_v_vgvb__)-d_qbulk_d_v_vgvb__;
                            d_qgate_d_v_vdpvsp__ = ((d_qgate_d_v_vdpvsp__+d_Qac0_d_v_vdpvsp__)+d_Qsub0_d_v_vdpvsp__)-d_qbulk_d_v_vdpvsp__;
                            d_qgate_d_v_vbvsp__ = ((d_qgate_d_v_vbvsp__+d_Qac0_d_v_vbvsp__)+d_Qsub0_d_v_vbvsp__)-d_qbulk_d_v_vbvsp__;
                        qgate = ((qgate+Qac0)+Qsub0)-qbulk;
                            d_qbulk_d_v_vgvb__ = d_qbulk_d_v_vgvb__-(d_Qac0_d_v_vgvb__+d_Qsub0_d_v_vgvb__);
                            d_qbulk_d_v_vdpvsp__ = d_qbulk_d_v_vdpvsp__-(d_Qac0_d_v_vdpvsp__+d_Qsub0_d_v_vdpvsp__);
                            d_qbulk_d_v_vbvsp__ = d_qbulk_d_v_vbvsp__-(d_Qac0_d_v_vbvsp__+d_Qsub0_d_v_vbvsp__);
                        qbulk = qbulk-(Qac0+Qsub0);
                            d_qdrn_d_v_vgvb__ = -((d_qgate_d_v_vgvb__+d_qbulk_d_v_vgvb__)+d_qsrc_d_v_vgvb__);
                            d_qdrn_d_v_vdpvsp__ = -((d_qgate_d_v_vdpvsp__+d_qbulk_d_v_vdpvsp__)+d_qsrc_d_v_vdpvsp__);
                            d_qdrn_d_v_vbvsp__ = -((d_qgate_d_v_vbvsp__+d_qbulk_d_v_vbvsp__)+d_qsrc_d_v_vbvsp__);
                        qdrn = -((qgate+qbulk)+qsrc);
                            d_BSIM3qinv_d_v_vgvb__ = -d_qinoi_d_v_vgvb__;
                            d_BSIM3qinv_d_v_vdpvsp__ = -d_qinoi_d_v_vdpvsp__;
                            d_BSIM3qinv_d_v_vbvsp__ = -d_qinoi_d_v_vbvsp__;
                        BSIM3qinv = -qinoi;
                    end
                end
            end
        end
    end
    czbd = BSIM3unitAreaTempJctCap*BSIM3drainArea;
    czbs = BSIM3unitAreaTempJctCap*BSIM3sourceArea;
    if BSIM3drainPerimeter<BSIM3weff
        czbdswg = BSIM3unitLengthGateSidewallTempJctCap*BSIM3drainPerimeter;
        czbdsw = 0;
    else
        czbdsw = BSIM3unitLengthSidewallTempJctCap*(BSIM3drainPerimeter-BSIM3weff);
        czbdswg = BSIM3unitLengthGateSidewallTempJctCap*BSIM3weff;
    end
    if BSIM3sourcePerimeter<BSIM3weff
        czbssw = 0;
        czbsswg = BSIM3unitLengthGateSidewallTempJctCap*BSIM3sourcePerimeter;
    else
        czbssw = BSIM3unitLengthSidewallTempJctCap*(BSIM3sourcePerimeter-BSIM3weff);
        czbsswg = BSIM3unitLengthGateSidewallTempJctCap*BSIM3weff;
    end
    MJ = BSIM3bulkJctBotGradingCoeff;
    MJSW = BSIM3bulkJctSideGradingCoeff;
    MJSWG = BSIM3bulkJctGateSideGradingCoeff;
    if vbs==0
            d_BSIM3qbs_d_v_vgvb__ = 0;
            d_BSIM3qbs_d_v_vdpvsp__ = 0;
            d_BSIM3qbs_d_v_vbvsp__ = 0;
        BSIM3qbs = 0;
    else
        if vbs<0
            if czbs>0
                    d_arg_d_v_vdpvsp__ = 0;
                    d_arg_d_v_vbvsp__ = -(d_vbs_d_v_vbvsp__/BSIM3PhiB);
                arg = 1-vbs/BSIM3PhiB;
                if MJ==0.5
                        d_sarg_d_v_vdpvsp__ = 0;
                        d_sarg_d_v_vbvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vbvsp__))/sqrt(arg)^2;
                    sarg = 1/sqrt(arg);
                else
                        d_sarg_d_v_vdpvsp__ = 0;
                        d_sarg_d_v_vbvsp__ = exp(-MJ*log10(arg))*(-MJ*((1/(arg*log(10)))*d_arg_d_v_vbvsp__));
                    sarg = exp(-MJ*log10(arg));
                end
                    d_BSIM3qbs_d_v_vgvb__ = 0;
                    d_BSIM3qbs_d_v_vdpvsp__ = 0;
                    d_BSIM3qbs_d_v_vbvsp__ = ((BSIM3PhiB*czbs)*(-(arg*d_sarg_d_v_vbvsp__+d_arg_d_v_vbvsp__*sarg)))/(1-MJ);
                BSIM3qbs = ((BSIM3PhiB*czbs)*(1-arg*sarg))/(1-MJ);
            else
                    d_BSIM3qbs_d_v_vgvb__ = 0;
                    d_BSIM3qbs_d_v_vdpvsp__ = 0;
                    d_BSIM3qbs_d_v_vbvsp__ = 0;
                BSIM3qbs = 0;
            end
            if czbssw>0
                    d_arg_d_v_vdpvsp__ = 0;
                    d_arg_d_v_vbvsp__ = -(d_vbs_d_v_vbvsp__/BSIM3PhiBSW);
                arg = 1-vbs/BSIM3PhiBSW;
                if MJSW==0.5
                        d_sarg_d_v_vdpvsp__ = 0;
                        d_sarg_d_v_vbvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vbvsp__))/sqrt(arg)^2;
                    sarg = 1/sqrt(arg);
                else
                        d_sarg_d_v_vdpvsp__ = 0;
                        d_sarg_d_v_vbvsp__ = exp(-MJSW*log10(arg))*(-MJSW*((1/(arg*log(10)))*d_arg_d_v_vbvsp__));
                    sarg = exp(-MJSW*log10(arg));
                end
                    d_BSIM3qbs_d_v_vgvb__ = 0;
                    d_BSIM3qbs_d_v_vdpvsp__ = 0;
                    d_BSIM3qbs_d_v_vbvsp__ = d_BSIM3qbs_d_v_vbvsp__+(((BSIM3PhiBSW*czbssw)*(-(arg*d_sarg_d_v_vbvsp__+d_arg_d_v_vbvsp__*sarg)))/(1-MJSW));
                BSIM3qbs = BSIM3qbs+((BSIM3PhiBSW*czbssw)*(1-arg*sarg))/(1-MJSW);
            end
            if czbsswg>0
                    d_arg_d_v_vdpvsp__ = 0;
                    d_arg_d_v_vbvsp__ = -(d_vbs_d_v_vbvsp__/BSIM3PhiBSWG);
                arg = 1-vbs/BSIM3PhiBSWG;
                if MJSWG==0.5
                        d_sarg_d_v_vdpvsp__ = 0;
                        d_sarg_d_v_vbvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vbvsp__))/sqrt(arg)^2;
                    sarg = 1/sqrt(arg);
                else
                        d_sarg_d_v_vdpvsp__ = 0;
                        d_sarg_d_v_vbvsp__ = exp(-MJSWG*log10(arg))*(-MJSWG*((1/(arg*log(10)))*d_arg_d_v_vbvsp__));
                    sarg = exp(-MJSWG*log10(arg));
                end
                    d_BSIM3qbs_d_v_vgvb__ = 0;
                    d_BSIM3qbs_d_v_vdpvsp__ = 0;
                    d_BSIM3qbs_d_v_vbvsp__ = d_BSIM3qbs_d_v_vbvsp__+(((BSIM3PhiBSWG*czbsswg)*(-(arg*d_sarg_d_v_vbvsp__+d_arg_d_v_vbvsp__*sarg)))/(1-MJSWG));
                BSIM3qbs = BSIM3qbs+((BSIM3PhiBSWG*czbsswg)*(1-arg*sarg))/(1-MJSWG);
            end
        else
                d_T0_d_v_vgvb__ = 0;
                d_T0_d_v_vdpvsp__ = 0;
                d_T0_d_v_vbvsp__ = 0;
            T0 = (czbs+czbssw)+czbsswg;
                d_T1_d_v_vgvb__ = 0;
                d_T1_d_v_vdpvsp__ = 0;
                d_T1_d_v_vbvsp__ = d_vbs_d_v_vbvsp__*(((czbs*MJ)/BSIM3PhiB+(czbssw*MJSW)/BSIM3PhiBSW)+(czbsswg*MJSWG)/BSIM3PhiBSWG);
            T1 = vbs*(((czbs*MJ)/BSIM3PhiB+(czbssw*MJSW)/BSIM3PhiBSW)+(czbsswg*MJSWG)/BSIM3PhiBSWG);
                d_BSIM3qbs_d_v_vgvb__ = vbs*(d_T0_d_v_vgvb__+(0.5*d_T1_d_v_vgvb__));
                d_BSIM3qbs_d_v_vdpvsp__ = vbs*(d_T0_d_v_vdpvsp__+(0.5*d_T1_d_v_vdpvsp__));
                d_BSIM3qbs_d_v_vbvsp__ = vbs*(d_T0_d_v_vbvsp__+(0.5*d_T1_d_v_vbvsp__))+d_vbs_d_v_vbvsp__*(T0+0.5*T1);
            BSIM3qbs = vbs*(T0+0.5*T1);
        end
    end
    if vbd==0
            d_BSIM3qbd_d_v_vgvb__ = 0;
            d_BSIM3qbd_d_v_vdpvsp__ = 0;
            d_BSIM3qbd_d_v_vbvsp__ = 0;
        BSIM3qbd = 0;
    else
        if vbd<0
            if czbd>0
                    d_arg_d_v_vdpvsp__ = -(d_vbd_d_v_vdpvsp__/BSIM3PhiB);
                    d_arg_d_v_vbvsp__ = -(d_vbd_d_v_vbvsp__/BSIM3PhiB);
                arg = 1-vbd/BSIM3PhiB;
                if MJ==0.5
                        d_sarg_d_v_vdpvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vdpvsp__))/sqrt(arg)^2;
                        d_sarg_d_v_vbvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vbvsp__))/sqrt(arg)^2;
                    sarg = 1/sqrt(arg);
                else
                        d_sarg_d_v_vdpvsp__ = exp(-MJ*log10(arg))*(-MJ*((1/(arg*log(10)))*d_arg_d_v_vdpvsp__));
                        d_sarg_d_v_vbvsp__ = exp(-MJ*log10(arg))*(-MJ*((1/(arg*log(10)))*d_arg_d_v_vbvsp__));
                    sarg = exp(-MJ*log10(arg));
                end
                    d_BSIM3qbd_d_v_vgvb__ = 0;
                    d_BSIM3qbd_d_v_vdpvsp__ = ((BSIM3PhiB*czbd)*(-(arg*d_sarg_d_v_vdpvsp__+d_arg_d_v_vdpvsp__*sarg)))/(1-MJ);
                    d_BSIM3qbd_d_v_vbvsp__ = ((BSIM3PhiB*czbd)*(-(arg*d_sarg_d_v_vbvsp__+d_arg_d_v_vbvsp__*sarg)))/(1-MJ);
                BSIM3qbd = ((BSIM3PhiB*czbd)*(1-arg*sarg))/(1-MJ);
            else
                    d_BSIM3qbd_d_v_vgvb__ = 0;
                    d_BSIM3qbd_d_v_vdpvsp__ = 0;
                    d_BSIM3qbd_d_v_vbvsp__ = 0;
                BSIM3qbd = 0;
            end
            if czbdsw>0
                    d_arg_d_v_vdpvsp__ = -(d_vbd_d_v_vdpvsp__/BSIM3PhiBSW);
                    d_arg_d_v_vbvsp__ = -(d_vbd_d_v_vbvsp__/BSIM3PhiBSW);
                arg = 1-vbd/BSIM3PhiBSW;
                if MJSW==0.5
                        d_sarg_d_v_vdpvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vdpvsp__))/sqrt(arg)^2;
                        d_sarg_d_v_vbvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vbvsp__))/sqrt(arg)^2;
                    sarg = 1/sqrt(arg);
                else
                        d_sarg_d_v_vdpvsp__ = exp(-MJSW*log10(arg))*(-MJSW*((1/(arg*log(10)))*d_arg_d_v_vdpvsp__));
                        d_sarg_d_v_vbvsp__ = exp(-MJSW*log10(arg))*(-MJSW*((1/(arg*log(10)))*d_arg_d_v_vbvsp__));
                    sarg = exp(-MJSW*log10(arg));
                end
                    d_BSIM3qbd_d_v_vgvb__ = 0;
                    d_BSIM3qbd_d_v_vdpvsp__ = d_BSIM3qbd_d_v_vdpvsp__+(((BSIM3PhiBSW*czbdsw)*(-(arg*d_sarg_d_v_vdpvsp__+d_arg_d_v_vdpvsp__*sarg)))/(1-MJSW));
                    d_BSIM3qbd_d_v_vbvsp__ = d_BSIM3qbd_d_v_vbvsp__+(((BSIM3PhiBSW*czbdsw)*(-(arg*d_sarg_d_v_vbvsp__+d_arg_d_v_vbvsp__*sarg)))/(1-MJSW));
                BSIM3qbd = BSIM3qbd+((BSIM3PhiBSW*czbdsw)*(1-arg*sarg))/(1-MJSW);
            end
            if czbdswg>0
                    d_arg_d_v_vdpvsp__ = -(d_vbd_d_v_vdpvsp__/BSIM3PhiBSWG);
                    d_arg_d_v_vbvsp__ = -(d_vbd_d_v_vbvsp__/BSIM3PhiBSWG);
                arg = 1-vbd/BSIM3PhiBSWG;
                if MJSWG==0.5
                        d_sarg_d_v_vdpvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vdpvsp__))/sqrt(arg)^2;
                        d_sarg_d_v_vbvsp__ = -(1*((1/(2*sqrt(arg)))*d_arg_d_v_vbvsp__))/sqrt(arg)^2;
                    sarg = 1/sqrt(arg);
                else
                        d_sarg_d_v_vdpvsp__ = exp(-MJSWG*log10(arg))*(-MJSWG*((1/(arg*log(10)))*d_arg_d_v_vdpvsp__));
                        d_sarg_d_v_vbvsp__ = exp(-MJSWG*log10(arg))*(-MJSWG*((1/(arg*log(10)))*d_arg_d_v_vbvsp__));
                    sarg = exp(-MJSWG*log10(arg));
                end
                    d_BSIM3qbd_d_v_vgvb__ = 0;
                    d_BSIM3qbd_d_v_vdpvsp__ = d_BSIM3qbd_d_v_vdpvsp__+(((BSIM3PhiBSWG*czbdswg)*(-(arg*d_sarg_d_v_vdpvsp__+d_arg_d_v_vdpvsp__*sarg)))/(1-MJSWG));
                    d_BSIM3qbd_d_v_vbvsp__ = d_BSIM3qbd_d_v_vbvsp__+(((BSIM3PhiBSWG*czbdswg)*(-(arg*d_sarg_d_v_vbvsp__+d_arg_d_v_vbvsp__*sarg)))/(1-MJSWG));
                BSIM3qbd = BSIM3qbd+((BSIM3PhiBSWG*czbdswg)*(1-arg*sarg))/(1-MJSWG);
            end
        else
                d_T0_d_v_vgvb__ = 0;
                d_T0_d_v_vdpvsp__ = 0;
                d_T0_d_v_vbvsp__ = 0;
            T0 = (czbd+czbdsw)+czbdswg;
                d_T1_d_v_vgvb__ = 0;
                d_T1_d_v_vdpvsp__ = d_vbd_d_v_vdpvsp__*(((czbd*MJ)/BSIM3PhiB+(czbdsw*MJSW)/BSIM3PhiBSW)+(czbdswg*MJSWG)/BSIM3PhiBSWG);
                d_T1_d_v_vbvsp__ = d_vbd_d_v_vbvsp__*(((czbd*MJ)/BSIM3PhiB+(czbdsw*MJSW)/BSIM3PhiBSW)+(czbdswg*MJSWG)/BSIM3PhiBSWG);
            T1 = vbd*(((czbd*MJ)/BSIM3PhiB+(czbdsw*MJSW)/BSIM3PhiBSW)+(czbdswg*MJSWG)/BSIM3PhiBSWG);
                d_BSIM3qbd_d_v_vgvb__ = vbd*(d_T0_d_v_vgvb__+(0.5*d_T1_d_v_vgvb__));
                d_BSIM3qbd_d_v_vdpvsp__ = vbd*(d_T0_d_v_vdpvsp__+(0.5*d_T1_d_v_vdpvsp__))+d_vbd_d_v_vdpvsp__*(T0+0.5*T1);
                d_BSIM3qbd_d_v_vbvsp__ = vbd*(d_T0_d_v_vbvsp__+(0.5*d_T1_d_v_vbvsp__))+d_vbd_d_v_vbvsp__*(T0+0.5*T1);
            BSIM3qbd = vbd*(T0+0.5*T1);
        end
    end
    if BSIM3capMod==0
            d_LOCAL_cgdo_d_v_vgvb__ = 0;
            d_LOCAL_cgdo_d_v_vdpvsp__ = 0;
            d_LOCAL_cgdo_d_v_vbvsp__ = 0;
        LOCAL_cgdo = BSIM3cgdo;
            d_qgdo_d_v_vgvb__ = BSIM3cgdo*d_vgd_d_v_vgvb__+d_BSIM3cgdo_d_v_vgvb__*vgd;
            d_qgdo_d_v_vdpvsp__ = BSIM3cgdo*d_vgd_d_v_vdpvsp__+d_BSIM3cgdo_d_v_vdpvsp__*vgd;
            d_qgdo_d_v_vbvsp__ = BSIM3cgdo*d_vgd_d_v_vbvsp__+d_BSIM3cgdo_d_v_vbvsp__*vgd;
        qgdo = BSIM3cgdo*vgd;
            d_LOCAL_cgso_d_v_vgvb__ = 0;
            d_LOCAL_cgso_d_v_vdpvsp__ = 0;
            d_LOCAL_cgso_d_v_vbvsp__ = 0;
        LOCAL_cgso = BSIM3cgso;
            d_qgso_d_v_vgvb__ = BSIM3cgso*d_vgs_d_v_vgvb__+d_BSIM3cgso_d_v_vgvb__*vgs;
            d_qgso_d_v_vdpvsp__ = 0;
            d_qgso_d_v_vbvsp__ = BSIM3cgso*d_vgs_d_v_vbvsp__+d_BSIM3cgso_d_v_vbvsp__*vgs;
        qgso = BSIM3cgso*vgs;
    end
    if BSIM3capMod==1
        if vgd<0
                d_T1_d_v_vgvb__ = (1/(2*sqrt(1-(4*vgd)/BSIM3ckappa)))*(-((4*d_vgd_d_v_vgvb__)/BSIM3ckappa));
                d_T1_d_v_vdpvsp__ = (1/(2*sqrt(1-(4*vgd)/BSIM3ckappa)))*(-((4*d_vgd_d_v_vdpvsp__)/BSIM3ckappa));
                d_T1_d_v_vbvsp__ = (1/(2*sqrt(1-(4*vgd)/BSIM3ckappa)))*(-((4*d_vgd_d_v_vbvsp__)/BSIM3ckappa));
            T1 = sqrt(1-(4*vgd)/BSIM3ckappa);
                d_LOCAL_cgdo_d_v_vgvb__ = d_BSIM3cgdo_d_v_vgvb__+(-((BSIM3weffCV*BSIM3cgdl)*d_T1_d_v_vgvb__)/T1^2);
                d_LOCAL_cgdo_d_v_vdpvsp__ = d_BSIM3cgdo_d_v_vdpvsp__+(-((BSIM3weffCV*BSIM3cgdl)*d_T1_d_v_vdpvsp__)/T1^2);
                d_LOCAL_cgdo_d_v_vbvsp__ = d_BSIM3cgdo_d_v_vbvsp__+(-((BSIM3weffCV*BSIM3cgdl)*d_T1_d_v_vbvsp__)/T1^2);
            LOCAL_cgdo = BSIM3cgdo+(BSIM3weffCV*BSIM3cgdl)/T1;
                d_qgdo_d_v_vgvb__ = (BSIM3cgdo*d_vgd_d_v_vgvb__+d_BSIM3cgdo_d_v_vgvb__*vgd)-((((BSIM3weffCV*0.5)*BSIM3cgdl)*BSIM3ckappa)*(d_T1_d_v_vgvb__));
                d_qgdo_d_v_vdpvsp__ = (BSIM3cgdo*d_vgd_d_v_vdpvsp__+d_BSIM3cgdo_d_v_vdpvsp__*vgd)-((((BSIM3weffCV*0.5)*BSIM3cgdl)*BSIM3ckappa)*(d_T1_d_v_vdpvsp__));
                d_qgdo_d_v_vbvsp__ = (BSIM3cgdo*d_vgd_d_v_vbvsp__+d_BSIM3cgdo_d_v_vbvsp__*vgd)-((((BSIM3weffCV*0.5)*BSIM3cgdl)*BSIM3ckappa)*(d_T1_d_v_vbvsp__));
            qgdo = BSIM3cgdo*vgd-(((BSIM3weffCV*0.5)*BSIM3cgdl)*BSIM3ckappa)*(T1-1);
        else
                d_LOCAL_cgdo_d_v_vgvb__ = d_BSIM3cgdo_d_v_vgvb__;
                d_LOCAL_cgdo_d_v_vdpvsp__ = d_BSIM3cgdo_d_v_vdpvsp__;
                d_LOCAL_cgdo_d_v_vbvsp__ = d_BSIM3cgdo_d_v_vbvsp__;
            LOCAL_cgdo = BSIM3cgdo+BSIM3weffCV*BSIM3cgdl;
                d_qgdo_d_v_vgvb__ = (BSIM3weffCV*BSIM3cgdl+BSIM3cgdo)*d_vgd_d_v_vgvb__+(d_BSIM3cgdo_d_v_vgvb__)*vgd;
                d_qgdo_d_v_vdpvsp__ = (BSIM3weffCV*BSIM3cgdl+BSIM3cgdo)*d_vgd_d_v_vdpvsp__+(d_BSIM3cgdo_d_v_vdpvsp__)*vgd;
                d_qgdo_d_v_vbvsp__ = (BSIM3weffCV*BSIM3cgdl+BSIM3cgdo)*d_vgd_d_v_vbvsp__+(d_BSIM3cgdo_d_v_vbvsp__)*vgd;
            qgdo = (BSIM3weffCV*BSIM3cgdl+BSIM3cgdo)*vgd;
        end
        if vgs<0
                d_T1_d_v_vgvb__ = (1/(2*sqrt(1-(4*vgs)/BSIM3ckappa)))*(-((4*d_vgs_d_v_vgvb__)/BSIM3ckappa));
                d_T1_d_v_vdpvsp__ = 0;
                d_T1_d_v_vbvsp__ = (1/(2*sqrt(1-(4*vgs)/BSIM3ckappa)))*(-((4*d_vgs_d_v_vbvsp__)/BSIM3ckappa));
            T1 = sqrt(1-(4*vgs)/BSIM3ckappa);
                d_LOCAL_cgso_d_v_vgvb__ = d_BSIM3cgso_d_v_vgvb__+(-((BSIM3weffCV*BSIM3cgsl)*d_T1_d_v_vgvb__)/T1^2);
                d_LOCAL_cgso_d_v_vdpvsp__ = d_BSIM3cgso_d_v_vdpvsp__+(-((BSIM3weffCV*BSIM3cgsl)*d_T1_d_v_vdpvsp__)/T1^2);
                d_LOCAL_cgso_d_v_vbvsp__ = d_BSIM3cgso_d_v_vbvsp__+(-((BSIM3weffCV*BSIM3cgsl)*d_T1_d_v_vbvsp__)/T1^2);
            LOCAL_cgso = BSIM3cgso+(BSIM3weffCV*BSIM3cgsl)/T1;
                d_qgso_d_v_vgvb__ = (BSIM3cgso*d_vgs_d_v_vgvb__+d_BSIM3cgso_d_v_vgvb__*vgs)-((((BSIM3weffCV*0.5)*BSIM3cgsl)*BSIM3ckappa)*(d_T1_d_v_vgvb__));
                d_qgso_d_v_vdpvsp__ = (d_BSIM3cgso_d_v_vdpvsp__*vgs)-((((BSIM3weffCV*0.5)*BSIM3cgsl)*BSIM3ckappa)*(d_T1_d_v_vdpvsp__));
                d_qgso_d_v_vbvsp__ = (BSIM3cgso*d_vgs_d_v_vbvsp__+d_BSIM3cgso_d_v_vbvsp__*vgs)-((((BSIM3weffCV*0.5)*BSIM3cgsl)*BSIM3ckappa)*(d_T1_d_v_vbvsp__));
            qgso = BSIM3cgso*vgs-(((BSIM3weffCV*0.5)*BSIM3cgsl)*BSIM3ckappa)*(T1-1);
        else
                d_LOCAL_cgso_d_v_vgvb__ = d_BSIM3cgso_d_v_vgvb__;
                d_LOCAL_cgso_d_v_vdpvsp__ = d_BSIM3cgso_d_v_vdpvsp__;
                d_LOCAL_cgso_d_v_vbvsp__ = d_BSIM3cgso_d_v_vbvsp__;
            LOCAL_cgso = BSIM3cgso+BSIM3weffCV*BSIM3cgsl;
                d_qgso_d_v_vgvb__ = (BSIM3weffCV*BSIM3cgsl+BSIM3cgso)*d_vgs_d_v_vgvb__+(d_BSIM3cgso_d_v_vgvb__)*vgs;
                d_qgso_d_v_vdpvsp__ = (d_BSIM3cgso_d_v_vdpvsp__)*vgs;
                d_qgso_d_v_vbvsp__ = (BSIM3weffCV*BSIM3cgsl+BSIM3cgso)*d_vgs_d_v_vbvsp__+(d_BSIM3cgso_d_v_vbvsp__)*vgs;
            qgso = (BSIM3weffCV*BSIM3cgsl+BSIM3cgso)*vgs;
        end
    else
            d_T0_d_v_vgvb__ = d_vgd_d_v_vgvb__;
            d_T0_d_v_vdpvsp__ = d_vgd_d_v_vdpvsp__;
            d_T0_d_v_vbvsp__ = d_vgd_d_v_vbvsp__;
        T0 = vgd+0.02;
            d_T1_d_v_vgvb__ = (1/(2*sqrt(T0*T0+4*0.02)))*((T0*d_T0_d_v_vgvb__+d_T0_d_v_vgvb__*T0));
            d_T1_d_v_vdpvsp__ = (1/(2*sqrt(T0*T0+4*0.02)))*((T0*d_T0_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T0));
            d_T1_d_v_vbvsp__ = (1/(2*sqrt(T0*T0+4*0.02)))*((T0*d_T0_d_v_vbvsp__+d_T0_d_v_vbvsp__*T0));
        T1 = sqrt(T0*T0+4*0.02);
            d_T2_d_v_vgvb__ = 0.5*(d_T0_d_v_vgvb__-d_T1_d_v_vgvb__);
            d_T2_d_v_vdpvsp__ = 0.5*(d_T0_d_v_vdpvsp__-d_T1_d_v_vdpvsp__);
            d_T2_d_v_vbvsp__ = 0.5*(d_T0_d_v_vbvsp__-d_T1_d_v_vbvsp__);
        T2 = 0.5*(T0-T1);
            d_T3_d_v_vgvb__ = 0;
            d_T3_d_v_vdpvsp__ = 0;
            d_T3_d_v_vbvsp__ = 0;
        T3 = BSIM3weffCV*BSIM3cgdl;
            d_T4_d_v_vgvb__ = (1/(2*sqrt(1-(4*T2)/BSIM3ckappa)))*(-((4*d_T2_d_v_vgvb__)/BSIM3ckappa));
            d_T4_d_v_vdpvsp__ = (1/(2*sqrt(1-(4*T2)/BSIM3ckappa)))*(-((4*d_T2_d_v_vdpvsp__)/BSIM3ckappa));
            d_T4_d_v_vbvsp__ = (1/(2*sqrt(1-(4*T2)/BSIM3ckappa)))*(-((4*d_T2_d_v_vbvsp__)/BSIM3ckappa));
        T4 = sqrt(1-(4*T2)/BSIM3ckappa);
            d_LOCAL_cgdo_d_v_vgvb__ = (d_BSIM3cgdo_d_v_vgvb__+d_T3_d_v_vgvb__)-((T3*(1-1/T4))*(-((0.5*d_T0_d_v_vgvb__)/T1-((0.5*T0)*d_T1_d_v_vgvb__)/T1^2))+(T3*(-(-(1*d_T4_d_v_vgvb__)/T4^2))+d_T3_d_v_vgvb__*(1-1/T4))*(0.5-(0.5*T0)/T1));
            d_LOCAL_cgdo_d_v_vdpvsp__ = (d_BSIM3cgdo_d_v_vdpvsp__+d_T3_d_v_vdpvsp__)-((T3*(1-1/T4))*(-((0.5*d_T0_d_v_vdpvsp__)/T1-((0.5*T0)*d_T1_d_v_vdpvsp__)/T1^2))+(T3*(-(-(1*d_T4_d_v_vdpvsp__)/T4^2))+d_T3_d_v_vdpvsp__*(1-1/T4))*(0.5-(0.5*T0)/T1));
            d_LOCAL_cgdo_d_v_vbvsp__ = (d_BSIM3cgdo_d_v_vbvsp__+d_T3_d_v_vbvsp__)-((T3*(1-1/T4))*(-((0.5*d_T0_d_v_vbvsp__)/T1-((0.5*T0)*d_T1_d_v_vbvsp__)/T1^2))+(T3*(-(-(1*d_T4_d_v_vbvsp__)/T4^2))+d_T3_d_v_vbvsp__*(1-1/T4))*(0.5-(0.5*T0)/T1));
        LOCAL_cgdo = (BSIM3cgdo+T3)-(T3*(1-1/T4))*(0.5-(0.5*T0)/T1);
            d_qgdo_d_v_vgvb__ = ((BSIM3cgdo+T3)*d_vgd_d_v_vgvb__+(d_BSIM3cgdo_d_v_vgvb__+d_T3_d_v_vgvb__)*vgd)-(T3*(d_T2_d_v_vgvb__+((0.5*BSIM3ckappa)*(d_T4_d_v_vgvb__)))+d_T3_d_v_vgvb__*(T2+(0.5*BSIM3ckappa)*(T4-1)));
            d_qgdo_d_v_vdpvsp__ = ((BSIM3cgdo+T3)*d_vgd_d_v_vdpvsp__+(d_BSIM3cgdo_d_v_vdpvsp__+d_T3_d_v_vdpvsp__)*vgd)-(T3*(d_T2_d_v_vdpvsp__+((0.5*BSIM3ckappa)*(d_T4_d_v_vdpvsp__)))+d_T3_d_v_vdpvsp__*(T2+(0.5*BSIM3ckappa)*(T4-1)));
            d_qgdo_d_v_vbvsp__ = ((BSIM3cgdo+T3)*d_vgd_d_v_vbvsp__+(d_BSIM3cgdo_d_v_vbvsp__+d_T3_d_v_vbvsp__)*vgd)-(T3*(d_T2_d_v_vbvsp__+((0.5*BSIM3ckappa)*(d_T4_d_v_vbvsp__)))+d_T3_d_v_vbvsp__*(T2+(0.5*BSIM3ckappa)*(T4-1)));
        qgdo = (BSIM3cgdo+T3)*vgd-T3*(T2+(0.5*BSIM3ckappa)*(T4-1));
            d_T0_d_v_vgvb__ = d_vgs_d_v_vgvb__;
            d_T0_d_v_vdpvsp__ = 0;
            d_T0_d_v_vbvsp__ = d_vgs_d_v_vbvsp__;
        T0 = vgs+0.02;
            d_T1_d_v_vgvb__ = (1/(2*sqrt(T0*T0+4*0.02)))*((T0*d_T0_d_v_vgvb__+d_T0_d_v_vgvb__*T0));
            d_T1_d_v_vdpvsp__ = (1/(2*sqrt(T0*T0+4*0.02)))*((T0*d_T0_d_v_vdpvsp__+d_T0_d_v_vdpvsp__*T0));
            d_T1_d_v_vbvsp__ = (1/(2*sqrt(T0*T0+4*0.02)))*((T0*d_T0_d_v_vbvsp__+d_T0_d_v_vbvsp__*T0));
        T1 = sqrt(T0*T0+4*0.02);
            d_T2_d_v_vgvb__ = 0.5*(d_T0_d_v_vgvb__-d_T1_d_v_vgvb__);
            d_T2_d_v_vdpvsp__ = 0.5*(d_T0_d_v_vdpvsp__-d_T1_d_v_vdpvsp__);
            d_T2_d_v_vbvsp__ = 0.5*(d_T0_d_v_vbvsp__-d_T1_d_v_vbvsp__);
        T2 = 0.5*(T0-T1);
            d_T3_d_v_vgvb__ = 0;
            d_T3_d_v_vdpvsp__ = 0;
            d_T3_d_v_vbvsp__ = 0;
        T3 = BSIM3weffCV*BSIM3cgsl;
            d_T4_d_v_vgvb__ = (1/(2*sqrt(1-(4*T2)/BSIM3ckappa)))*(-((4*d_T2_d_v_vgvb__)/BSIM3ckappa));
            d_T4_d_v_vdpvsp__ = (1/(2*sqrt(1-(4*T2)/BSIM3ckappa)))*(-((4*d_T2_d_v_vdpvsp__)/BSIM3ckappa));
            d_T4_d_v_vbvsp__ = (1/(2*sqrt(1-(4*T2)/BSIM3ckappa)))*(-((4*d_T2_d_v_vbvsp__)/BSIM3ckappa));
        T4 = sqrt(1-(4*T2)/BSIM3ckappa);
            d_LOCAL_cgso_d_v_vgvb__ = (d_BSIM3cgso_d_v_vgvb__+d_T3_d_v_vgvb__)-((T3*(1-1/T4))*(-((0.5*d_T0_d_v_vgvb__)/T1-((0.5*T0)*d_T1_d_v_vgvb__)/T1^2))+(T3*(-(-(1*d_T4_d_v_vgvb__)/T4^2))+d_T3_d_v_vgvb__*(1-1/T4))*(0.5-(0.5*T0)/T1));
            d_LOCAL_cgso_d_v_vdpvsp__ = (d_BSIM3cgso_d_v_vdpvsp__+d_T3_d_v_vdpvsp__)-((T3*(1-1/T4))*(-((0.5*d_T0_d_v_vdpvsp__)/T1-((0.5*T0)*d_T1_d_v_vdpvsp__)/T1^2))+(T3*(-(-(1*d_T4_d_v_vdpvsp__)/T4^2))+d_T3_d_v_vdpvsp__*(1-1/T4))*(0.5-(0.5*T0)/T1));
            d_LOCAL_cgso_d_v_vbvsp__ = (d_BSIM3cgso_d_v_vbvsp__+d_T3_d_v_vbvsp__)-((T3*(1-1/T4))*(-((0.5*d_T0_d_v_vbvsp__)/T1-((0.5*T0)*d_T1_d_v_vbvsp__)/T1^2))+(T3*(-(-(1*d_T4_d_v_vbvsp__)/T4^2))+d_T3_d_v_vbvsp__*(1-1/T4))*(0.5-(0.5*T0)/T1));
        LOCAL_cgso = (BSIM3cgso+T3)-(T3*(1-1/T4))*(0.5-(0.5*T0)/T1);
            d_qgso_d_v_vgvb__ = ((BSIM3cgso+T3)*d_vgs_d_v_vgvb__+(d_BSIM3cgso_d_v_vgvb__+d_T3_d_v_vgvb__)*vgs)-(T3*(d_T2_d_v_vgvb__+((0.5*BSIM3ckappa)*(d_T4_d_v_vgvb__)))+d_T3_d_v_vgvb__*(T2+(0.5*BSIM3ckappa)*(T4-1)));
            d_qgso_d_v_vdpvsp__ = ((d_BSIM3cgso_d_v_vdpvsp__+d_T3_d_v_vdpvsp__)*vgs)-(T3*(d_T2_d_v_vdpvsp__+((0.5*BSIM3ckappa)*(d_T4_d_v_vdpvsp__)))+d_T3_d_v_vdpvsp__*(T2+(0.5*BSIM3ckappa)*(T4-1)));
            d_qgso_d_v_vbvsp__ = ((BSIM3cgso+T3)*d_vgs_d_v_vbvsp__+(d_BSIM3cgso_d_v_vbvsp__+d_T3_d_v_vbvsp__)*vgs)-(T3*(d_T2_d_v_vbvsp__+((0.5*BSIM3ckappa)*(d_T4_d_v_vbvsp__)))+d_T3_d_v_vbvsp__*(T2+(0.5*BSIM3ckappa)*(T4-1)));
        qgso = (BSIM3cgso+T3)*vgs-T3*(T2+(0.5*BSIM3ckappa)*(T4-1));
    end
        d_BSIM3cgdo_d_v_vgvb__ = d_LOCAL_cgdo_d_v_vgvb__;
        d_BSIM3cgdo_d_v_vdpvsp__ = d_LOCAL_cgdo_d_v_vdpvsp__;
        d_BSIM3cgdo_d_v_vbvsp__ = d_LOCAL_cgdo_d_v_vbvsp__;
    BSIM3cgdo = LOCAL_cgdo;
        d_BSIM3cgso_d_v_vgvb__ = d_LOCAL_cgso_d_v_vgvb__;
        d_BSIM3cgso_d_v_vdpvsp__ = d_LOCAL_cgso_d_v_vdpvsp__;
        d_BSIM3cgso_d_v_vbvsp__ = d_LOCAL_cgso_d_v_vbvsp__;
    BSIM3cgso = LOCAL_cgso;
    if BSIM3mode>0
        if BSIM3nqsMod==0
                d_qgd_d_v_vgvb__ = d_qgdo_d_v_vgvb__;
                d_qgd_d_v_vdpvsp__ = d_qgdo_d_v_vdpvsp__;
                d_qgd_d_v_vbvsp__ = d_qgdo_d_v_vbvsp__;
            qgd = qgdo;
                d_qgs_d_v_vgvb__ = d_qgso_d_v_vgvb__;
                d_qgs_d_v_vdpvsp__ = d_qgso_d_v_vdpvsp__;
                d_qgs_d_v_vbvsp__ = d_qgso_d_v_vbvsp__;
            qgs = qgso;
                d_qgb_d_v_vgvb__ = BSIM3cgbo*d_vgb_d_v_vgvb__;
                d_qgb_d_v_vdpvsp__ = 0;
                d_qgb_d_v_vbvsp__ = BSIM3cgbo*d_vgb_d_v_vbvsp__;
            qgb = BSIM3cgbo*vgb;
                d_qgate_d_v_vgvb__ = ((d_qgate_d_v_vgvb__+d_qgd_d_v_vgvb__)+d_qgs_d_v_vgvb__)+d_qgb_d_v_vgvb__;
                d_qgate_d_v_vdpvsp__ = ((d_qgate_d_v_vdpvsp__+d_qgd_d_v_vdpvsp__)+d_qgs_d_v_vdpvsp__)+d_qgb_d_v_vdpvsp__;
                d_qgate_d_v_vbvsp__ = ((d_qgate_d_v_vbvsp__+d_qgd_d_v_vbvsp__)+d_qgs_d_v_vbvsp__)+d_qgb_d_v_vbvsp__;
            qgate = ((qgate+qgd)+qgs)+qgb;
                d_qbulk_d_v_vgvb__ = d_qbulk_d_v_vgvb__-d_qgb_d_v_vgvb__;
                d_qbulk_d_v_vdpvsp__ = d_qbulk_d_v_vdpvsp__-d_qgb_d_v_vdpvsp__;
                d_qbulk_d_v_vbvsp__ = d_qbulk_d_v_vbvsp__-d_qgb_d_v_vbvsp__;
            qbulk = qbulk-qgb;
                d_qdrn_d_v_vgvb__ = d_qdrn_d_v_vgvb__-d_qgd_d_v_vgvb__;
                d_qdrn_d_v_vdpvsp__ = d_qdrn_d_v_vdpvsp__-d_qgd_d_v_vdpvsp__;
                d_qdrn_d_v_vbvsp__ = d_qdrn_d_v_vbvsp__-d_qgd_d_v_vbvsp__;
            qdrn = qdrn-qgd;
                d_qsrc_d_v_vgvb__ = -((d_qgate_d_v_vgvb__+d_qbulk_d_v_vgvb__)+d_qdrn_d_v_vgvb__);
                d_qsrc_d_v_vdpvsp__ = -((d_qgate_d_v_vdpvsp__+d_qbulk_d_v_vdpvsp__)+d_qdrn_d_v_vdpvsp__);
                d_qsrc_d_v_vbvsp__ = -((d_qgate_d_v_vbvsp__+d_qbulk_d_v_vbvsp__)+d_qdrn_d_v_vbvsp__);
            qsrc = -((qgate+qbulk)+qdrn);
        end
    else
        if BSIM3nqsMod==0
                d_qgd_d_v_vgvb__ = d_qgdo_d_v_vgvb__;
                d_qgd_d_v_vdpvsp__ = d_qgdo_d_v_vdpvsp__;
                d_qgd_d_v_vbvsp__ = d_qgdo_d_v_vbvsp__;
            qgd = qgdo;
                d_qgs_d_v_vgvb__ = d_qgso_d_v_vgvb__;
                d_qgs_d_v_vdpvsp__ = d_qgso_d_v_vdpvsp__;
                d_qgs_d_v_vbvsp__ = d_qgso_d_v_vbvsp__;
            qgs = qgso;
                d_qgb_d_v_vgvb__ = BSIM3cgbo*d_vgb_d_v_vgvb__;
                d_qgb_d_v_vdpvsp__ = 0;
                d_qgb_d_v_vbvsp__ = BSIM3cgbo*d_vgb_d_v_vbvsp__;
            qgb = BSIM3cgbo*vgb;
                d_qgate_d_v_vgvb__ = ((d_qgate_d_v_vgvb__+d_qgd_d_v_vgvb__)+d_qgs_d_v_vgvb__)+d_qgb_d_v_vgvb__;
                d_qgate_d_v_vdpvsp__ = ((d_qgate_d_v_vdpvsp__+d_qgd_d_v_vdpvsp__)+d_qgs_d_v_vdpvsp__)+d_qgb_d_v_vdpvsp__;
                d_qgate_d_v_vbvsp__ = ((d_qgate_d_v_vbvsp__+d_qgd_d_v_vbvsp__)+d_qgs_d_v_vbvsp__)+d_qgb_d_v_vbvsp__;
            qgate = ((qgate+qgd)+qgs)+qgb;
                d_qbulk_d_v_vgvb__ = d_qbulk_d_v_vgvb__-d_qgb_d_v_vgvb__;
                d_qbulk_d_v_vdpvsp__ = d_qbulk_d_v_vdpvsp__-d_qgb_d_v_vdpvsp__;
                d_qbulk_d_v_vbvsp__ = d_qbulk_d_v_vbvsp__-d_qgb_d_v_vbvsp__;
            qbulk = qbulk-qgb;
                d_qsrc_d_v_vgvb__ = d_qdrn_d_v_vgvb__-d_qgs_d_v_vgvb__;
                d_qsrc_d_v_vdpvsp__ = d_qdrn_d_v_vdpvsp__-d_qgs_d_v_vdpvsp__;
                d_qsrc_d_v_vbvsp__ = d_qdrn_d_v_vbvsp__-d_qgs_d_v_vbvsp__;
            qsrc = qdrn-qgs;
                d_qdrn_d_v_vgvb__ = -((d_qgate_d_v_vgvb__+d_qbulk_d_v_vgvb__)+d_qsrc_d_v_vgvb__);
                d_qdrn_d_v_vdpvsp__ = -((d_qgate_d_v_vdpvsp__+d_qbulk_d_v_vdpvsp__)+d_qsrc_d_v_vdpvsp__);
                d_qdrn_d_v_vbvsp__ = -((d_qgate_d_v_vbvsp__+d_qbulk_d_v_vbvsp__)+d_qsrc_d_v_vbvsp__);
            qdrn = -((qgate+qbulk)+qsrc);
        end
    end
    if BSIM3mode>0
            d_cdreq_d_v_vgvb__ = BSIM3type*d_Ids_d_v_vgvb__;
            d_cdreq_d_v_vdpvsp__ = BSIM3type*d_Ids_d_v_vdpvsp__;
            d_cdreq_d_v_vbvsp__ = BSIM3type*d_Ids_d_v_vbvsp__;
        cdreq = BSIM3type*Ids;
            d_ceqbd_d_v_vgvb__ = -BSIM3type*d_Isub_d_v_vgvb__;
            d_ceqbd_d_v_vdpvsp__ = -BSIM3type*d_Isub_d_v_vdpvsp__;
            d_ceqbd_d_v_vbvsp__ = -BSIM3type*d_Isub_d_v_vbvsp__;
        ceqbd = -BSIM3type*Isub;
            d_ceqbs_d_v_vgvb__ = 0;
            d_ceqbs_d_v_vdpvsp__ = 0;
            d_ceqbs_d_v_vbvsp__ = 0;
        ceqbs = 0;
    else
            d_cdreq_d_v_vgvb__ = -BSIM3type*d_Ids_d_v_vgvb__;
            d_cdreq_d_v_vdpvsp__ = -BSIM3type*d_Ids_d_v_vdpvsp__;
            d_cdreq_d_v_vbvsp__ = -BSIM3type*d_Ids_d_v_vbvsp__;
        cdreq = -BSIM3type*Ids;
            d_ceqbs_d_v_vgvb__ = -BSIM3type*d_Isub_d_v_vgvb__;
            d_ceqbs_d_v_vdpvsp__ = -BSIM3type*d_Isub_d_v_vdpvsp__;
            d_ceqbs_d_v_vbvsp__ = -BSIM3type*d_Isub_d_v_vbvsp__;
        ceqbs = -BSIM3type*Isub;
            d_ceqbd_d_v_vgvb__ = 0;
            d_ceqbd_d_v_vdpvsp__ = 0;
            d_ceqbd_d_v_vbvsp__ = 0;
        ceqbd = 0;
    end
    if BSIM3type>0
            d_ceqbs_d_v_vgvb__ = d_ceqbs_d_v_vgvb__;
            d_ceqbs_d_v_vdpvsp__ = d_ceqbs_d_v_vdpvsp__;
            d_ceqbs_d_v_vbvsp__ = d_ceqbs_d_v_vbvsp__+d_BSIM3cbs_d_v_vbvsp__;
        ceqbs = ceqbs+BSIM3cbs;
            d_ceqbd_d_v_vgvb__ = d_ceqbd_d_v_vgvb__;
            d_ceqbd_d_v_vdpvsp__ = d_ceqbd_d_v_vdpvsp__+d_BSIM3cbd_d_v_vdpvsp__;
            d_ceqbd_d_v_vbvsp__ = d_ceqbd_d_v_vbvsp__+d_BSIM3cbd_d_v_vbvsp__;
        ceqbd = ceqbd+BSIM3cbd;
    else
            d_ceqbs_d_v_vgvb__ = d_ceqbs_d_v_vgvb__;
            d_ceqbs_d_v_vdpvsp__ = d_ceqbs_d_v_vdpvsp__;
            d_ceqbs_d_v_vbvsp__ = d_ceqbs_d_v_vbvsp__-d_BSIM3cbs_d_v_vbvsp__;
        ceqbs = ceqbs-BSIM3cbs;
            d_ceqbd_d_v_vgvb__ = d_ceqbd_d_v_vgvb__;
            d_ceqbd_d_v_vdpvsp__ = d_ceqbd_d_v_vdpvsp__-d_BSIM3cbd_d_v_vdpvsp__;
            d_ceqbd_d_v_vbvsp__ = d_ceqbd_d_v_vbvsp__-d_BSIM3cbd_d_v_vbvsp__;
        ceqbd = ceqbd-BSIM3cbd;
    end
        d_vd_vdp_d_v_vdvb__ = d_v_vdvdp_d_v_vdvb__;
        d_vd_vdp_d_v_vdpvsp__ = d_v_vdvdp_d_v_vdpvsp__;
        d_vd_vdp_d_v_vbvsp__ = d_v_vdvdp_d_v_vbvsp__;
    vd_vdp = v_vdvdp__;
        d_vs_vsp_d_v_vsvb__ = d_v_vsvsp_d_v_vsvb__;
        d_vs_vsp_d_v_vbvsp__ = d_v_vsvsp_d_v_vbvsp__;
    vs_vsp = v_vsvsp__;
        d_f_i_vdvdp_d_v_vdvb__ = d_f_i_vdvdp_d_v_vdvb__+(d_vd_vdp_d_v_vdvb__*BSIM3drainConductance);
        d_f_i_vdvdp_d_v_vdpvsp__ = d_f_i_vdvdp_d_v_vdpvsp__+(d_vd_vdp_d_v_vdpvsp__*BSIM3drainConductance);
        d_f_i_vdvdp_d_v_vbvsp__ = d_f_i_vdvdp_d_v_vbvsp__+(d_vd_vdp_d_v_vbvsp__*BSIM3drainConductance);
    % contribution for i_vdvdp;
    f_i_vdvdp__ = f_i_vdvdp__ + vd_vdp*BSIM3drainConductance;
        d_f_i_vsvsp_d_v_vsvb__ = d_f_i_vsvsp_d_v_vsvb__+(d_vs_vsp_d_v_vsvb__*BSIM3sourceConductance);
        d_f_i_vsvsp_d_v_vbvsp__ = d_f_i_vsvsp_d_v_vbvsp__+(d_vs_vsp_d_v_vbvsp__*BSIM3sourceConductance);
    % contribution for i_vsvsp;
    f_i_vsvsp__ = f_i_vsvsp__ + vs_vsp*BSIM3sourceConductance;
        d_f_i_vdpvsp_d_v_vgvb__ = d_f_i_vdpvsp_d_v_vgvb__+d_cdreq_d_v_vgvb__;
        d_f_i_vdpvsp_d_v_vdpvsp__ = d_f_i_vdpvsp_d_v_vdpvsp__+d_cdreq_d_v_vdpvsp__;
        d_f_i_vdpvsp_d_v_vbvsp__ = d_f_i_vdpvsp_d_v_vbvsp__+d_cdreq_d_v_vbvsp__;
    % contribution for i_vdpvsp;
    f_i_vdpvsp__ = f_i_vdpvsp__ + cdreq;
        d_f_i_vbvdp_d_v_vgvb__ = d_f_i_vbvdp_d_v_vgvb__+d_ceqbd_d_v_vgvb__;
        d_f_i_vbvdp_d_v_vdpvsp__ = d_f_i_vbvdp_d_v_vdpvsp__+d_ceqbd_d_v_vdpvsp__;
        d_f_i_vbvdp_d_v_vbvsp__ = d_f_i_vbvdp_d_v_vbvsp__+d_ceqbd_d_v_vbvsp__;
    % contribution for i_vbvdp;
    f_i_vbvdp__ = f_i_vbvdp__ + ceqbd;
        d_f_i_vbvsp_d_v_vgvb__ = d_f_i_vbvsp_d_v_vgvb__+d_ceqbs_d_v_vgvb__;
        d_f_i_vbvsp_d_v_vdpvsp__ = d_f_i_vbvsp_d_v_vdpvsp__+d_ceqbs_d_v_vdpvsp__;
        d_f_i_vbvsp_d_v_vbvsp__ = d_f_i_vbvsp_d_v_vbvsp__+d_ceqbs_d_v_vbvsp__;
    % contribution for i_vbvsp;
    f_i_vbvsp__ = f_i_vbvsp__ + ceqbs;
        d_q_i_vgvsp_d_v_vgvb__ = d_q_i_vgvsp_d_v_vgvb__+(BSIM3type*d_qgate_d_v_vgvb__);
        d_q_i_vgvsp_d_v_vdpvsp__ = d_q_i_vgvsp_d_v_vdpvsp__+(BSIM3type*d_qgate_d_v_vdpvsp__);
        d_q_i_vgvsp_d_v_vbvsp__ = d_q_i_vgvsp_d_v_vbvsp__+(BSIM3type*d_qgate_d_v_vbvsp__);
    % contribution for i_vgvsp;
    q_i_vgvsp__ = q_i_vgvsp__ + BSIM3type*qgate;
        d_q_i_vbvsp_d_v_vgvb__ = d_q_i_vbvsp_d_v_vgvb__+(BSIM3type*d_qbulk_d_v_vgvb__);
        d_q_i_vbvsp_d_v_vdpvsp__ = d_q_i_vbvsp_d_v_vdpvsp__+(BSIM3type*d_qbulk_d_v_vdpvsp__);
        d_q_i_vbvsp_d_v_vbvsp__ = d_q_i_vbvsp_d_v_vbvsp__+(BSIM3type*d_qbulk_d_v_vbvsp__);
    % contribution for i_vbvsp;
    q_i_vbvsp__ = q_i_vbvsp__ + BSIM3type*qbulk;
        d_q_i_vbvsp_d_v_vgvb__ = d_q_i_vbvsp_d_v_vgvb__+(BSIM3type*d_BSIM3qbs_d_v_vgvb__);
        d_q_i_vbvsp_d_v_vdpvsp__ = d_q_i_vbvsp_d_v_vdpvsp__+(BSIM3type*d_BSIM3qbs_d_v_vdpvsp__);
        d_q_i_vbvsp_d_v_vbvsp__ = d_q_i_vbvsp_d_v_vbvsp__+(BSIM3type*d_BSIM3qbs_d_v_vbvsp__);
    % contribution for i_vbvsp;
    q_i_vbvsp__ = q_i_vbvsp__ + BSIM3type*BSIM3qbs;
        d_q_i_vbvdp_d_v_vgvb__ = d_q_i_vbvdp_d_v_vgvb__+(BSIM3type*d_BSIM3qbd_d_v_vgvb__);
        d_q_i_vbvdp_d_v_vdpvsp__ = d_q_i_vbvdp_d_v_vdpvsp__+(BSIM3type*d_BSIM3qbd_d_v_vdpvsp__);
        d_q_i_vbvdp_d_v_vbvsp__ = d_q_i_vbvdp_d_v_vbvsp__+(BSIM3type*d_BSIM3qbd_d_v_vbvsp__);
    % contribution for i_vbvdp;
    q_i_vbvdp__ = q_i_vbvdp__ + BSIM3type*BSIM3qbd;
        d_q_i_vdpvsp_d_v_vgvb__ = d_q_i_vdpvsp_d_v_vgvb__+(BSIM3type*d_qdrn_d_v_vgvb__);
        d_q_i_vdpvsp_d_v_vdpvsp__ = d_q_i_vdpvsp_d_v_vdpvsp__+(BSIM3type*d_qdrn_d_v_vdpvsp__);
        d_q_i_vdpvsp_d_v_vbvsp__ = d_q_i_vdpvsp_d_v_vbvsp__+(BSIM3type*d_qdrn_d_v_vbvsp__);
    % contribution for i_vdpvsp;
    q_i_vdpvsp__ = q_i_vdpvsp__ + BSIM3type*qdrn;
        d_fe_d_X__(1,1) = d_f_i_vdvdp_d_v_vdvb__;
        d_qe_d_X__(1,1) = d_q_i_vdvdp_d_v_vdvb__;
        d_fe_d_Y__(1,1) = d_f_i_vdvdp_d_v_vdpvsp__;
        d_qe_d_Y__(1,1) = d_q_i_vdvdp_d_v_vdpvsp__;
        d_fe_d_Y__(1,2) = d_f_i_vdvdp_d_v_vbvsp__;
        d_qe_d_Y__(1,2) = d_q_i_vdvdp_d_v_vbvsp__;
    % output for terminalFlow_vd (explicit out)
    fe__(1) = +f_i_vdvdp__;
    qe__(1) = +q_i_vdvdp__;
        d_fe_d_X__(2,2) = d_f_i_vgvsp_d_v_vgvb__;
        d_qe_d_X__(2,2) = d_q_i_vgvsp_d_v_vgvb__;
        d_fe_d_Y__(2,1) = d_f_i_vgvsp_d_v_vdpvsp__;
        d_qe_d_Y__(2,1) = d_q_i_vgvsp_d_v_vdpvsp__;
        d_fe_d_Y__(2,2) = d_f_i_vgvsp_d_v_vbvsp__;
        d_qe_d_Y__(2,2) = d_q_i_vgvsp_d_v_vbvsp__;
    % output for terminalFlow_vg (explicit out)
    fe__(2) = +f_i_vgvsp__;
    qe__(2) = +q_i_vgvsp__;
        d_fe_d_X__(3,3) = d_f_i_vsvsp_d_v_vsvb__;
        d_qe_d_X__(3,3) = d_q_i_vsvsp_d_v_vsvb__;
        d_fe_d_Y__(3,2) = d_f_i_vsvsp_d_v_vbvsp__;
        d_qe_d_Y__(3,2) = d_q_i_vsvsp_d_v_vbvsp__;
    % output for terminalFlow_vs (explicit out)
    fe__(3) = +f_i_vsvsp__;
    qe__(3) = +q_i_vsvsp__;
        d_fi_d_X__(1,1) = (d_f_i_vdvdp_d_v_vdvb__);
        d_qi_d_X__(1,1) = (d_q_i_vdvdp_d_v_vdvb__);
        d_fi_d_X__(1,2) = (d_f_i_vbvdp_d_v_vgvb__)-d_f_i_vdpvsp_d_v_vgvb__;
        d_qi_d_X__(1,2) = (d_q_i_vbvdp_d_v_vgvb__)-d_q_i_vdpvsp_d_v_vgvb__;
        d_fi_d_Y__(1,1) = (d_f_i_vdvdp_d_v_vdpvsp__+d_f_i_vbvdp_d_v_vdpvsp__)-d_f_i_vdpvsp_d_v_vdpvsp__;
        d_qi_d_Y__(1,1) = (d_q_i_vdvdp_d_v_vdpvsp__+d_q_i_vbvdp_d_v_vdpvsp__)-d_q_i_vdpvsp_d_v_vdpvsp__;
        d_fi_d_Y__(1,2) = (d_f_i_vdvdp_d_v_vbvsp__+d_f_i_vbvdp_d_v_vbvsp__)-d_f_i_vdpvsp_d_v_vbvsp__;
        d_qi_d_Y__(1,2) = (d_q_i_vdvdp_d_v_vbvsp__+d_q_i_vbvdp_d_v_vbvsp__)-d_q_i_vdpvsp_d_v_vbvsp__;
    % output for v_vdpvsp (internal unknown)
    fi__(1) = +f_i_vdvdp__+f_i_vbvdp__ - f_i_vdpvsp__;
    qi__(1) = +q_i_vdvdp__+q_i_vbvdp__ - q_i_vdpvsp__;
        d_fi_d_X__(2,1) = (((-d_f_i_vdvdp_d_v_vdvb__)));
        d_qi_d_X__(2,1) = (((-d_q_i_vdvdp_d_v_vdvb__)));
        d_fi_d_X__(2,2) = (((-d_f_i_vgvsp_d_v_vgvb__))-d_f_i_vbvdp_d_v_vgvb__)-d_f_i_vbvsp_d_v_vgvb__;
        d_qi_d_X__(2,2) = (((-d_q_i_vgvsp_d_v_vgvb__))-d_q_i_vbvdp_d_v_vgvb__)-d_q_i_vbvsp_d_v_vgvb__;
        d_fi_d_X__(2,3) = ((-d_f_i_vsvsp_d_v_vsvb__));
        d_qi_d_X__(2,3) = ((-d_q_i_vsvsp_d_v_vsvb__));
        d_fi_d_Y__(2,1) = (((-d_f_i_vgvsp_d_v_vdpvsp__-d_f_i_vdvdp_d_v_vdpvsp__))-d_f_i_vbvdp_d_v_vdpvsp__)-d_f_i_vbvsp_d_v_vdpvsp__;
        d_qi_d_Y__(2,1) = (((-d_q_i_vgvsp_d_v_vdpvsp__-d_q_i_vdvdp_d_v_vdpvsp__))-d_q_i_vbvdp_d_v_vdpvsp__)-d_q_i_vbvsp_d_v_vdpvsp__;
        d_fi_d_Y__(2,2) = (((-d_f_i_vgvsp_d_v_vbvsp__-d_f_i_vdvdp_d_v_vbvsp__)-d_f_i_vsvsp_d_v_vbvsp__)-d_f_i_vbvdp_d_v_vbvsp__)-d_f_i_vbvsp_d_v_vbvsp__;
        d_qi_d_Y__(2,2) = (((-d_q_i_vgvsp_d_v_vbvsp__-d_q_i_vdvdp_d_v_vbvsp__)-d_q_i_vsvsp_d_v_vbvsp__)-d_q_i_vbvdp_d_v_vbvsp__)-d_q_i_vbvsp_d_v_vbvsp__;
    % output for v_vbvsp (internal unknown)
    fi__(2) = -f_i_vgvsp__-f_i_vdvdp__-f_i_vsvsp__-f_i_vbvdp__ - f_i_vbvsp__;
    qi__(2) = -q_i_vgvsp__-q_i_vdvdp__-q_i_vsvsp__-q_i_vbvdp__ - q_i_vbvsp__;
end

function [eonames, iunames, ienames] = get_oui_names__(MOD__)
    eonames = {'ivdvb', 'ivgvb', 'ivsvb'};
    iunames = {'v_vdpvsp', 'v_vbvsp'};
    ienames = {'KCL for i_vdpvsp', 'KCL for i_vbvsp'};
end

function [nFeQe, nFiQi, nOtherIo, nIntUnk] = get_nfq__(MOD__)
    nFeQe = 3;
    nFiQi = 2;
    nOtherIo = 3;
    nIntUnk = 2;
end

function iun = get_iu_names__(MOD)
    [~, iun, ~] = get_oui_names__(MOD);
end

function ien = get_ie_names__(MOD)
    [~, ~, ien] = get_oui_names__(MOD);
end


function d_outVal_d_base__ = d_pow_vapp_d_arg1__(base, exponent)
    d_outVal_d_base__ = 0;
        d_outVal_d_base__ = base^(exponent-1)*(1*exponent);
    outVal = base^exponent;
end

function d_outVal_d_exponent__ = d_pow_vapp_d_arg2__(base, exponent)
    d_outVal_d_exponent__ = 0;
        d_outVal_d_exponent__ = (base^exponent*1)*qmcol_vapp(base>0, log(base), 0);
    outVal = base^exponent;
end

function outVal = pow_vapp(base, exponent)
    outVal = base^exponent;
end
