function MOD = r3(uniqID)

%===============================================================================
% This file was created using VAPP, the Berkeley Verilog-A Parser and Processor.   
% Last modified: 23-Feb-2017 13:16:53
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

    MOD.model_name = 'r3';
    MOD.NIL.node_names = {'n1', 'nc', 'n2'};
    MOD.NIL.refnode_name = 'n2';

    parmNameDefValArr = {'parm_w', 1e-06,...
                         'parm_l', 1e-06,...
                         'parm_wd', 0,...
                         'parm_a1', 0,...
                         'parm_p1', 0,...
                         'parm_c1', 0,...
                         'parm_a2', 0,...
                         'parm_p2', 0,...
                         'parm_c2', 0,...
                         'parm_trise', 0,...
                         'parm_nsmm_rsh', 0,...
                         'parm_nsmm_w', 0,...
                         'parm_nsmm_l', 0,...
                         'parm_sw_noise', 1,...
                         'parm_sw_et', 1,...
                         'parm_sw_lin', 0,...
                         'parm_sw_mman', 0,...
                         'parm_version', 2,...
                         'parm_subversion', 0,...
                         'parm_revision', 0,...
                         'parm_tmin', -100,...
                         'parm_tmax', 500,...
                         'parm_gmin', 1e-12,...
                         'parm_imax', 1,...
                         'parm_scale', 1,...
                         'parm_shrink', 0,...
                         'parm_rthresh', 0.001,...
                         'parm_type', -1,...
                         'parm_tnom', 27,...
                         'parm_lmin', 0,...
                         'parm_lmax', 9900000000,...
                         'parm_wmin', 0,...
                         'parm_wmax', 9900000000,...
                         'parm_jmax', 100,...
                         'parm_vmax', 9900000000,...
                         'parm_tminclip', -100,...
                         'parm_tmaxclip', 1000,...
                         'parm_sw_accpo', 0,...
                         'parm_grpo', 1e-12,...
                         'parm_rsh', 100,...
                         'parm_xw', 0,...
                         'parm_nwxw', 0,...
                         'parm_wexw', 0,...
                         'parm_fdrw', 1,...
                         'parm_fdxwinf', 0,...
                         'parm_xl', 0,...
                         'parm_xlw', 0,...
                         'parm_dxlsat', 0,...
                         'parm_nst', 1,...
                         'parm_atsinf', 0,...
                         'parm_atsl', 0,...
                         'parm_dfinf', 0.01,...
                         'parm_dfw', 0,...
                         'parm_dfl', 0,...
                         'parm_dfwl', 0,...
                         'parm_sw_dfgeo', 1,...
                         'parm_dpinf', 2,...
                         'parm_dpw', 0,...
                         'parm_dpwe', 0.5,...
                         'parm_dpl', 0,...
                         'parm_dple', 2,...
                         'parm_dpwl', 0,...
                         'parm_ecrit', 4,...
                         'parm_ecorn', 0.4,...
                         'parm_du', 0.02,...
                         'parm_dibl1l', 0,...
                         'parm_dibl1le', 1,...
                         'parm_dibl2l', 0,...
                         'parm_dibl2le', 1,...
                         'parm_dibl2v', 0.1,...
                         'parm_dibl2e', 0.5,...
                         'parm_clm1l', 0,...
                         'parm_clm1le', 1,...
                         'parm_clm1c', 0,...
                         'parm_clm2l', 0,...
                         'parm_clm2le', 1,...
                         'parm_clm2v', 0.1,...
                         'parm_clm2e', 0.5,...
                         'parm_rc', 0,...
                         'parm_rcw', 0,...
                         'parm_fc', 0.9,...
                         'parm_isa', 0,...
                         'parm_na', 1,...
                         'parm_ca', 0,...
                         'parm_cja', 0,...
                         'parm_pa', 0.75,...
                         'parm_ma', 0.33,...
                         'parm_aja', -0.5,...
                         'parm_isp', 0,...
                         'parm_np', 1,...
                         'parm_cp', 0,...
                         'parm_cjp', 0,...
                         'parm_pp', 0.75,...
                         'parm_mp', 0.33,...
                         'parm_ajp', -0.5,...
                         'parm_vbv', 0,...
                         'parm_ibv', 1e-06,...
                         'parm_nbv', 1,...
                         'parm_kfn', 0,...
                         'parm_afn', 2,...
                         'parm_bfn', 1,...
                         'parm_sw_fngeo', 0,...
                         'parm_ea', 1.12,...
                         'parm_xis', 3,...
                         'parm_xvsat', 0,...
                         'parm_tc1', 0,...
                         'parm_tc2', 0,...
                         'parm_tc1w', 0,...
                         'parm_tc2w', 0,...
                         'parm_tc1l', 0,...
                         'parm_tc2l', 0,...
                         'parm_tc1wl', 0,...
                         'parm_tc2wl', 0,...
                         'parm_tc1rc', 0,...
                         'parm_tc2rc', 0,...
                         'parm_tc1dp', 0,...
                         'parm_tc2dp', 0,...
                         'parm_tc1vbv', 0,...
                         'parm_tc2vbv', 0,...
                         'parm_tc1nbv', 0,...
                         'parm_tc1kfn', 0,...
                         'parm_tegth', 0,...
                         'parm_gth0', 0,...
                         'parm_gthp', 0,...
                         'parm_gtha', 0,...
                         'parm_gthc', 0,...
                         'parm_cth0', 0,...
                         'parm_cthp', 0,...
                         'parm_ctha', 0,...
                         'parm_cthc', 0,...
                         'parm_nsig_rsh', 0,...
                         'parm_nsig_w', 0,...
                         'parm_nsig_l', 0,...
                         'parm_sig_rsh', 0,...
                         'parm_sig_w', 0,...
                         'parm_sig_l', 0,...
                         'parm_smm_rsh', 0,...
                         'parm_smm_w', 0,...
                         'parm_smm_l', 0,...
                         'parm_sw_mmgeo', 0};

    nParm = 140;
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
    parm_w = MOD__.parm_vals{1};
    parm_l = MOD__.parm_vals{2};
    parm_wd = MOD__.parm_vals{3};
    parm_a1 = MOD__.parm_vals{4};
    parm_p1 = MOD__.parm_vals{5};
    parm_c1 = MOD__.parm_vals{6};
    parm_a2 = MOD__.parm_vals{7};
    parm_p2 = MOD__.parm_vals{8};
    parm_c2 = MOD__.parm_vals{9};
    parm_trise = MOD__.parm_vals{10};
    parm_nsmm_rsh = MOD__.parm_vals{11};
    parm_nsmm_w = MOD__.parm_vals{12};
    parm_nsmm_l = MOD__.parm_vals{13};
    parm_sw_noise = MOD__.parm_vals{14};
    parm_sw_et = MOD__.parm_vals{15};
    parm_sw_lin = MOD__.parm_vals{16};
    parm_sw_mman = MOD__.parm_vals{17};
    parm_version = MOD__.parm_vals{18};
    parm_subversion = MOD__.parm_vals{19};
    parm_revision = MOD__.parm_vals{20};
    parm_tmin = MOD__.parm_vals{21};
    parm_tmax = MOD__.parm_vals{22};
    parm_gmin = MOD__.parm_vals{23};
    parm_imax = MOD__.parm_vals{24};
    parm_scale = MOD__.parm_vals{25};
    parm_shrink = MOD__.parm_vals{26};
    parm_rthresh = MOD__.parm_vals{27};
    parm_type = MOD__.parm_vals{28};
    parm_tnom = MOD__.parm_vals{29};
    parm_lmin = MOD__.parm_vals{30};
    parm_lmax = MOD__.parm_vals{31};
    parm_wmin = MOD__.parm_vals{32};
    parm_wmax = MOD__.parm_vals{33};
    parm_jmax = MOD__.parm_vals{34};
    parm_vmax = MOD__.parm_vals{35};
    parm_tminclip = MOD__.parm_vals{36};
    parm_tmaxclip = MOD__.parm_vals{37};
    parm_sw_accpo = MOD__.parm_vals{38};
    parm_grpo = MOD__.parm_vals{39};
    parm_rsh = MOD__.parm_vals{40};
    parm_xw = MOD__.parm_vals{41};
    parm_nwxw = MOD__.parm_vals{42};
    parm_wexw = MOD__.parm_vals{43};
    parm_fdrw = MOD__.parm_vals{44};
    parm_fdxwinf = MOD__.parm_vals{45};
    parm_xl = MOD__.parm_vals{46};
    parm_xlw = MOD__.parm_vals{47};
    parm_dxlsat = MOD__.parm_vals{48};
    parm_nst = MOD__.parm_vals{49};
    parm_atsinf = MOD__.parm_vals{50};
    parm_atsl = MOD__.parm_vals{51};
    parm_dfinf = MOD__.parm_vals{52};
    parm_dfw = MOD__.parm_vals{53};
    parm_dfl = MOD__.parm_vals{54};
    parm_dfwl = MOD__.parm_vals{55};
    parm_sw_dfgeo = MOD__.parm_vals{56};
    parm_dpinf = MOD__.parm_vals{57};
    parm_dpw = MOD__.parm_vals{58};
    parm_dpwe = MOD__.parm_vals{59};
    parm_dpl = MOD__.parm_vals{60};
    parm_dple = MOD__.parm_vals{61};
    parm_dpwl = MOD__.parm_vals{62};
    parm_ecrit = MOD__.parm_vals{63};
    parm_ecorn = MOD__.parm_vals{64};
    parm_du = MOD__.parm_vals{65};
    parm_dibl1l = MOD__.parm_vals{66};
    parm_dibl1le = MOD__.parm_vals{67};
    parm_dibl2l = MOD__.parm_vals{68};
    parm_dibl2le = MOD__.parm_vals{69};
    parm_dibl2v = MOD__.parm_vals{70};
    parm_dibl2e = MOD__.parm_vals{71};
    parm_clm1l = MOD__.parm_vals{72};
    parm_clm1le = MOD__.parm_vals{73};
    parm_clm1c = MOD__.parm_vals{74};
    parm_clm2l = MOD__.parm_vals{75};
    parm_clm2le = MOD__.parm_vals{76};
    parm_clm2v = MOD__.parm_vals{77};
    parm_clm2e = MOD__.parm_vals{78};
    parm_rc = MOD__.parm_vals{79};
    parm_rcw = MOD__.parm_vals{80};
    parm_fc = MOD__.parm_vals{81};
    parm_isa = MOD__.parm_vals{82};
    parm_na = MOD__.parm_vals{83};
    parm_ca = MOD__.parm_vals{84};
    parm_cja = MOD__.parm_vals{85};
    parm_pa = MOD__.parm_vals{86};
    parm_ma = MOD__.parm_vals{87};
    parm_aja = MOD__.parm_vals{88};
    parm_isp = MOD__.parm_vals{89};
    parm_np = MOD__.parm_vals{90};
    parm_cp = MOD__.parm_vals{91};
    parm_cjp = MOD__.parm_vals{92};
    parm_pp = MOD__.parm_vals{93};
    parm_mp = MOD__.parm_vals{94};
    parm_ajp = MOD__.parm_vals{95};
    parm_vbv = MOD__.parm_vals{96};
    parm_ibv = MOD__.parm_vals{97};
    parm_nbv = MOD__.parm_vals{98};
    parm_kfn = MOD__.parm_vals{99};
    parm_afn = MOD__.parm_vals{100};
    parm_bfn = MOD__.parm_vals{101};
    parm_sw_fngeo = MOD__.parm_vals{102};
    parm_ea = MOD__.parm_vals{103};
    parm_xis = MOD__.parm_vals{104};
    parm_xvsat = MOD__.parm_vals{105};
    parm_tc1 = MOD__.parm_vals{106};
    parm_tc2 = MOD__.parm_vals{107};
    parm_tc1w = MOD__.parm_vals{108};
    parm_tc2w = MOD__.parm_vals{109};
    parm_tc1l = MOD__.parm_vals{110};
    parm_tc2l = MOD__.parm_vals{111};
    parm_tc1wl = MOD__.parm_vals{112};
    parm_tc2wl = MOD__.parm_vals{113};
    parm_tc1rc = MOD__.parm_vals{114};
    parm_tc2rc = MOD__.parm_vals{115};
    parm_tc1dp = MOD__.parm_vals{116};
    parm_tc2dp = MOD__.parm_vals{117};
    parm_tc1vbv = MOD__.parm_vals{118};
    parm_tc2vbv = MOD__.parm_vals{119};
    parm_tc1nbv = MOD__.parm_vals{120};
    parm_tc1kfn = MOD__.parm_vals{121};
    parm_tegth = MOD__.parm_vals{122};
    parm_gth0 = MOD__.parm_vals{123};
    parm_gthp = MOD__.parm_vals{124};
    parm_gtha = MOD__.parm_vals{125};
    parm_gthc = MOD__.parm_vals{126};
    parm_cth0 = MOD__.parm_vals{127};
    parm_cthp = MOD__.parm_vals{128};
    parm_ctha = MOD__.parm_vals{129};
    parm_cthc = MOD__.parm_vals{130};
    parm_nsig_rsh = MOD__.parm_vals{131};
    parm_nsig_w = MOD__.parm_vals{132};
    parm_nsig_l = MOD__.parm_vals{133};
    parm_sig_rsh = MOD__.parm_vals{134};
    parm_sig_w = MOD__.parm_vals{135};
    parm_sig_l = MOD__.parm_vals{136};
    parm_smm_rsh = MOD__.parm_vals{137};
    parm_smm_w = MOD__.parm_vals{138};
    parm_smm_l = MOD__.parm_vals{139};
    parm_sw_mmgeo = MOD__.parm_vals{140};

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
    d_Fsatphi_d_temp_dtn2__ = 0;
    d_Fsatphi_d_v_i2i1__ = 0;
    d_Fsatphi_d_v_n1i1__ = 0;
    d_Fsatphi_d_v_n1n2__ = 0;
    d_Fsatphi_d_v_ncn2__ = 0;
    d_Ib1_d_temp_dtn2__ = 0;
    d_Ib1_d_v_i2i1__ = 0;
    d_Ib1_d_v_n1i1__ = 0;
    d_Ib1_d_v_n1n2__ = 0;
    d_Ib1_d_v_ncn2__ = 0;
    d_Ib2_d_temp_dtn2__ = 0;
    d_Ib2_d_v_i2i1__ = 0;
    d_Ib2_d_v_n1i1__ = 0;
    d_Ib2_d_v_n1n2__ = 0;
    d_Ib2_d_v_ncn2__ = 0;
    d_Ib_d_temp_dtn2__ = 0;
    d_Ib_d_v_i2i1__ = 0;
    d_Ib_d_v_n1i1__ = 0;
    d_Ib_d_v_n1n2__ = 0;
    d_Ib_d_v_ncn2__ = 0;
    d_Id1_d_temp_dtn2__ = 0;
    d_Id1_d_v_i2i1__ = 0;
    d_Id1_d_v_n1i1__ = 0;
    d_Id1_d_v_n1n2__ = 0;
    d_Id1_d_v_ncn2__ = 0;
    d_Id2_d_temp_dtn2__ = 0;
    d_Id2_d_v_i2i1__ = 0;
    d_Id2_d_v_n1i1__ = 0;
    d_Id2_d_v_n1n2__ = 0;
    d_Id2_d_v_ncn2__ = 0;
    d_Ip1_d_temp_dtn2__ = 0;
    d_Ip1_d_v_i2i1__ = 0;
    d_Ip1_d_v_n1i1__ = 0;
    d_Ip1_d_v_n1n2__ = 0;
    d_Ip1_d_v_ncn2__ = 0;
    d_Ip2_d_temp_dtn2__ = 0;
    d_Ip2_d_v_i2i1__ = 0;
    d_Ip2_d_v_n1i1__ = 0;
    d_Ip2_d_v_n1n2__ = 0;
    d_Ip2_d_v_ncn2__ = 0;
    d_Irth_d_temp_dtn2__ = 0;
    d_Is1_d_temp_dtn2__ = 0;
    d_Is2_d_temp_dtn2__ = 0;
    d_Ith_d_i_n2i2__ = 0;
    d_Ith_d_i_nci1__ = 0;
    d_Ith_d_i_nci2__ = 0;
    d_Ith_d_temp_dtn2__ = 0;
    d_Ith_d_v_i2i1__ = 0;
    d_Ith_d_v_n1i1__ = 0;
    d_Ith_d_v_n1n2__ = 0;
    d_Ith_d_v_ncn2__ = 0;
    d_Qcp1_d_temp_dtn2__ = 0;
    d_Qcp1_d_v_i2i1__ = 0;
    d_Qcp1_d_v_n1i1__ = 0;
    d_Qcp1_d_v_n1n2__ = 0;
    d_Qcp1_d_v_ncn2__ = 0;
    d_Qcp2_d_temp_dtn2__ = 0;
    d_Qcp2_d_v_i2i1__ = 0;
    d_Qcp2_d_v_n1i1__ = 0;
    d_Qcp2_d_v_n1n2__ = 0;
    d_Qcp2_d_v_ncn2__ = 0;
    d_Qcth_d_temp_dtn2__ = 0;
    d_V1c_d_v_i2i1__ = 0;
    d_V1c_d_v_n1i1__ = 0;
    d_V1c_d_v_n1n2__ = 0;
    d_V1c_d_v_ncn2__ = 0;
    d_V1ci_d_v_i2i1__ = 0;
    d_V1ci_d_v_n1i1__ = 0;
    d_V1ci_d_v_n1n2__ = 0;
    d_V1ci_d_v_ncn2__ = 0;
    d_V1cl_d_v_i2i1__ = 0;
    d_V1cl_d_v_n1i1__ = 0;
    d_V1cl_d_v_n1n2__ = 0;
    d_V1cl_d_v_ncn2__ = 0;
    d_Vb_d_v_i2i1__ = 0;
    d_Vb_d_v_n1n2__ = 0;
    d_Vbeff_d_temp_dtn2__ = 0;
    d_Vbeff_d_v_i2i1__ = 0;
    d_Vbeff_d_v_n1i1__ = 0;
    d_Vbeff_d_v_n1n2__ = 0;
    d_Vbeff_d_v_ncn2__ = 0;
    d_Vbi_d_v_i2i1__ = 0;
    d_Vbi_d_v_n1n2__ = 0;
    d_Vbkd_d_temp_dtn2__ = 0;
    d_Vbkd_d_v_i2i1__ = 0;
    d_Vbkd_d_v_n1i1__ = 0;
    d_Vbkd_d_v_n1n2__ = 0;
    d_Vbkd_d_v_ncn2__ = 0;
    d_Vc1_d_v_i2i1__ = 0;
    d_Vc1_d_v_n1i1__ = 0;
    d_Vc1_d_v_n1n2__ = 0;
    d_Vc1_d_v_ncn2__ = 0;
    d_Vc2_d_v_i2i1__ = 0;
    d_Vc2_d_v_n1i1__ = 0;
    d_Vc2_d_v_n1n2__ = 0;
    d_Vc2_d_v_ncn2__ = 0;
    d_Vcl_d_v_i2i1__ = 0;
    d_Vcl_d_v_n1i1__ = 0;
    d_Vcl_d_v_n1n2__ = 0;
    d_Vcl_d_v_ncn2__ = 0;
    d_Vsat_d_temp_dtn2__ = 0;
    d_Vsat_d_v_i2i1__ = 0;
    d_Vsat_d_v_n1i1__ = 0;
    d_Vsat_d_v_n1n2__ = 0;
    d_Vsat_d_v_ncn2__ = 0;
    d_Vsatphi_d_temp_dtn2__ = 0;
    d_Vsatphi_d_v_i2i1__ = 0;
    d_Vsatphi_d_v_n1i1__ = 0;
    d_Vsatphi_d_v_n1n2__ = 0;
    d_Vsatphi_d_v_ncn2__ = 0;
    d_a0_d_temp_dtn2__ = 0;
    d_a0_d_v_i2i1__ = 0;
    d_a0_d_v_n1i1__ = 0;
    d_a0_d_v_n1n2__ = 0;
    d_a0_d_v_ncn2__ = 0;
    d_a11_d_temp_dtn2__ = 0;
    d_a11_d_v_i2i1__ = 0;
    d_a11_d_v_n1i1__ = 0;
    d_a11_d_v_n1n2__ = 0;
    d_a11_d_v_ncn2__ = 0;
    d_a22_d_temp_dtn2__ = 0;
    d_a22_d_v_i2i1__ = 0;
    d_a22_d_v_n1i1__ = 0;
    d_a22_d_v_n1n2__ = 0;
    d_a22_d_v_ncn2__ = 0;
    d_a3_d_temp_dtn2__ = 0;
    d_a4_d_temp_dtn2__ = 0;
    d_aa3d27_d_temp_dtn2__ = 0;
    d_aa3d27_d_v_i2i1__ = 0;
    d_aa3d27_d_v_n1i1__ = 0;
    d_aa3d27_d_v_n1n2__ = 0;
    d_aa3d27_d_v_ncn2__ = 0;
    d_aa_d_temp_dtn2__ = 0;
    d_aa_d_v_i2i1__ = 0;
    d_aa_d_v_n1i1__ = 0;
    d_aa_d_v_n1n2__ = 0;
    d_aa_d_v_ncn2__ = 0;
    d_acja_d_temp_dtn2__ = 0;
    d_aisa_d_temp_dtn2__ = 0;
    d_arg1_d_temp_dtn2__ = 0;
    d_arg1_d_v_i2i1__ = 0;
    d_arg1_d_v_n1i1__ = 0;
    d_arg1_d_v_n1n2__ = 0;
    d_arg1_d_v_ncn2__ = 0;
    d_arg2_d_temp_dtn2__ = 0;
    d_arg2_d_v_i2i1__ = 0;
    d_arg2_d_v_n1i1__ = 0;
    d_arg2_d_v_n1n2__ = 0;
    d_arg2_d_v_ncn2__ = 0;
    d_arga_d_temp_dtn2__ = 0;
    d_arga_d_v_i2i1__ = 0;
    d_arga_d_v_n1i1__ = 0;
    d_arga_d_v_n1n2__ = 0;
    d_arga_d_v_ncn2__ = 0;
    d_argp_d_temp_dtn2__ = 0;
    d_argp_d_v_i2i1__ = 0;
    d_argp_d_v_n1i1__ = 0;
    d_argp_d_v_n1n2__ = 0;
    d_argp_d_v_ncn2__ = 0;
    d_argx_d_temp_dtn2__ = 0;
    d_asq_d_temp_dtn2__ = 0;
    d_atseff_d_temp_dtn2__ = 0;
    d_atseff_d_v_i2i1__ = 0;
    d_atseff_d_v_n1i1__ = 0;
    d_atseff_d_v_n1n2__ = 0;
    d_atseff_d_v_ncn2__ = 0;
    d_avar2_d_temp_dtn2__ = 0;
    d_avar2_d_v_i2i1__ = 0;
    d_avar2_d_v_n1i1__ = 0;
    d_avar2_d_v_n1n2__ = 0;
    d_avar2_d_v_ncn2__ = 0;
    d_avar_d_temp_dtn2__ = 0;
    d_bb_d_temp_dtn2__ = 0;
    d_bb_d_v_i2i1__ = 0;
    d_bb_d_v_n1i1__ = 0;
    d_bb_d_v_n1n2__ = 0;
    d_bb_d_v_ncn2__ = 0;
    d_bvar2_d_temp_dtn2__ = 0;
    d_bvar2_d_v_i2i1__ = 0;
    d_bvar2_d_v_n1i1__ = 0;
    d_bvar2_d_v_n1n2__ = 0;
    d_bvar2_d_v_ncn2__ = 0;
    d_bvar_d_temp_dtn2__ = 0;
    d_bvar_d_v_i2i1__ = 0;
    d_bvar_d_v_n1i1__ = 0;
    d_bvar_d_v_n1n2__ = 0;
    d_bvar_d_v_ncn2__ = 0;
    d_cja_t_d_temp_dtn2__ = 0;
    d_cjp_t_d_temp_dtn2__ = 0;
    d_cvar_d_temp_dtn2__ = 0;
    d_cvar_d_v_i2i1__ = 0;
    d_cvar_d_v_n1i1__ = 0;
    d_cvar_d_v_n1n2__ = 0;
    d_cvar_d_v_ncn2__ = 0;
    d_dT_d_temp_dtn2__ = 0;
    d_dd_d_temp_dtn2__ = 0;
    d_dd_d_v_i2i1__ = 0;
    d_dd_d_v_n1i1__ = 0;
    d_dd_d_v_n1n2__ = 0;
    d_dd_d_v_ncn2__ = 0;
    d_de_d_temp_dtn2__ = 0;
    d_dfe_d_temp_dtn2__ = 0;
    d_dfe_d_v_i2i1__ = 0;
    d_dfe_d_v_n1i1__ = 0;
    d_dfe_d_v_n1n2__ = 0;
    d_dfe_d_v_ncn2__ = 0;
    d_dore_d_temp_dtn2__ = 0;
    d_dore_d_v_i2i1__ = 0;
    d_dore_d_v_n1i1__ = 0;
    d_dore_d_v_n1n2__ = 0;
    d_dore_d_v_ncn2__ = 0;
    d_dpe_d_v_i2i1__ = 0;
    d_dpe_d_v_n1i1__ = 0;
    d_dpe_d_v_n1n2__ = 0;
    d_dpe_d_v_ncn2__ = 0;
    d_dpee_d_temp_dtn2__ = 0;
    d_dpee_d_v_i2i1__ = 0;
    d_dpee_d_v_n1i1__ = 0;
    d_dpee_d_v_n1n2__ = 0;
    d_dpee_d_v_ncn2__ = 0;
    d_dpfctr_d_temp_dtn2__ = 0;
    d_dpfctr_d_v_i2i1__ = 0;
    d_dpfctr_d_v_n1i1__ = 0;
    d_dpfctr_d_v_n1n2__ = 0;
    d_dpfctr_d_v_ncn2__ = 0;
    d_drmu_d_temp_dtn2__ = 0;
    d_drmu_d_v_i2i1__ = 0;
    d_drmu_d_v_n1i1__ = 0;
    d_drmu_d_v_n1n2__ = 0;
    d_drmu_d_v_ncn2__ = 0;
    d_dt_et_d_temp_dtn2__ = 0;
    d_dufctr_d_temp_dtn2__ = 0;
    d_dv0_d_temp_dtn2__ = 0;
    d_dv_d_temp_dtn2__ = 0;
    d_dv_d_v_i2i1__ = 0;
    d_dv_d_v_n1i1__ = 0;
    d_dv_d_v_n1n2__ = 0;
    d_dv_d_v_ncn2__ = 0;
    d_dvar_d_temp_dtn2__ = 0;
    d_dvar_d_v_i2i1__ = 0;
    d_dvar_d_v_n1i1__ = 0;
    d_dvar_d_v_n1n2__ = 0;
    d_dvar_d_v_ncn2__ = 0;
    d_dvh_d_temp_dtn2__ = 0;
    d_dvh_d_v_i2i1__ = 0;
    d_dvh_d_v_n1i1__ = 0;
    d_dvh_d_v_n1n2__ = 0;
    d_dvh_d_v_ncn2__ = 0;
    d_ecorn_t_d_temp_dtn2__ = 0;
    d_ecrit_t_d_temp_dtn2__ = 0;
    d_ecrneff_d_temp_dtn2__ = 0;
    d_expx_d_temp_dtn2__ = 0;
    d_expx_d_v_i2i1__ = 0;
    d_expx_d_v_n1i1__ = 0;
    d_expx_d_v_n1n2__ = 0;
    d_expx_d_v_ncn2__ = 0;
    d_f_i_i2i1_d_temp_dtn2__ = 0;
    d_f_i_i2i1_d_v_i2i1__ = 0;
    d_f_i_i2i1_d_v_n1i1__ = 0;
    d_f_i_i2i1_d_v_n1n2__ = 0;
    d_f_i_i2i1_d_v_ncn2__ = 0;
    d_f_i_n1i1_d_i_n2i2__ = 0;
    d_f_i_n1i1_d_i_nci1__ = 0;
    d_f_i_n1i1_d_i_nci2__ = 0;
    d_f_i_n1i1_d_temp_dtn2__ = 0;
    d_f_i_n1i1_d_v_i2i1__ = 0;
    d_f_i_n1i1_d_v_n1i1__ = 0;
    d_f_i_n1i1_d_v_n1n2__ = 0;
    d_f_i_n2i2_d_i_n2i2__ = 0;
    d_f_i_n2i2_d_temp_dtn2__ = 0;
    d_f_i_n2i2_d_v_i2i1__ = 0;
    d_f_i_n2i2_d_v_n1i1__ = 0;
    d_f_i_n2i2_d_v_n1n2__ = 0;
    d_f_i_nci1_d_i_nci1__ = 0;
    d_f_i_nci1_d_temp_dtn2__ = 0;
    d_f_i_nci1_d_v_i2i1__ = 0;
    d_f_i_nci1_d_v_n1i1__ = 0;
    d_f_i_nci1_d_v_n1n2__ = 0;
    d_f_i_nci1_d_v_ncn2__ = 0;
    d_f_i_nci2_d_i_nci2__ = 0;
    d_f_i_nci2_d_temp_dtn2__ = 0;
    d_f_i_nci2_d_v_i2i1__ = 0;
    d_f_i_nci2_d_v_n1i1__ = 0;
    d_f_i_nci2_d_v_n1n2__ = 0;
    d_f_i_nci2_d_v_ncn2__ = 0;
    d_f_pwr_dtn2_d_i_n2i2__ = 0;
    d_f_pwr_dtn2_d_i_nci1__ = 0;
    d_f_pwr_dtn2_d_i_nci2__ = 0;
    d_f_pwr_dtn2_d_temp_dtn2__ = 0;
    d_f_pwr_dtn2_d_v_i2i1__ = 0;
    d_f_pwr_dtn2_d_v_n1i1__ = 0;
    d_f_pwr_dtn2_d_v_n1n2__ = 0;
    d_f_pwr_dtn2_d_v_ncn2__ = 0;
    d_f_v_n1i1_d_i_n2i2__ = 0;
    d_f_v_n1i1_d_i_nci1__ = 0;
    d_f_v_n1i1_d_i_nci2__ = 0;
    d_f_v_n1i1_d_temp_dtn2__ = 0;
    d_f_v_n1i1_d_v_i2i1__ = 0;
    d_f_v_n1i1_d_v_n1i1__ = 0;
    d_f_v_n1i1_d_v_n1n2__ = 0;
    d_f_v_n2i2_d_i_n2i2__ = 0;
    d_f_v_n2i2_d_temp_dtn2__ = 0;
    d_f_v_n2i2_d_v_i2i1__ = 0;
    d_f_v_n2i2_d_v_n1i1__ = 0;
    d_f_v_n2i2_d_v_n1n2__ = 0;
    d_fctrm_d_temp_dtn2__ = 0;
    d_fctrm_d_v_i2i1__ = 0;
    d_fctrm_d_v_n1i1__ = 0;
    d_fctrm_d_v_n1n2__ = 0;
    d_fctrm_d_v_ncn2__ = 0;
    d_fctrp_d_temp_dtn2__ = 0;
    d_fctrp_d_v_i2i1__ = 0;
    d_fctrp_d_v_n1i1__ = 0;
    d_fctrp_d_v_n1n2__ = 0;
    d_fctrp_d_v_ncn2__ = 0;
    d_fn_d_temp_dtn2__ = 0;
    d_fn_d_v_i2i1__ = 0;
    d_fn_d_v_n1i1__ = 0;
    d_fn_d_v_n1n2__ = 0;
    d_fn_d_v_ncn2__ = 0;
    d_fouratsq_d_temp_dtn2__ = 0;
    d_fouratsq_d_v_i2i1__ = 0;
    d_fouratsq_d_v_n1i1__ = 0;
    d_fouratsq_d_v_n1n2__ = 0;
    d_fouratsq_d_v_ncn2__ = 0;
    d_geff_d_temp_dtn2__ = 0;
    d_geff_d_v_i2i1__ = 0;
    d_geff_d_v_n1i1__ = 0;
    d_geff_d_v_n1n2__ = 0;
    d_geff_d_v_ncn2__ = 0;
    d_gf_d_temp_dtn2__ = 0;
    d_i_n1i1_d_i_n2i2__ = 0;
    d_i_n1i1_d_i_nci1__ = 0;
    d_i_n1i1_d_i_nci2__ = 0;
    d_i_n1i1_d_temp_dtn2__ = 0;
    d_i_n1i1_d_v_i2i1__ = 0;
    d_i_n1i1_d_v_n1i1__ = 0;
    d_i_n1i1_d_v_n1n2__ = 0;
    d_i_n2i2_d_temp_dtn2__ = 0;
    d_i_n2i2_d_v_i2i1__ = 0;
    d_i_n2i2_d_v_n1i1__ = 0;
    d_i_n2i2_d_v_n1n2__ = 0;
    d_i_nci1_d_temp_dtn2__ = 0;
    d_i_nci1_d_v_i2i1__ = 0;
    d_i_nci1_d_v_n1i1__ = 0;
    d_i_nci1_d_v_n1n2__ = 0;
    d_i_nci1_d_v_ncn2__ = 0;
    d_i_nci2_d_temp_dtn2__ = 0;
    d_i_nci2_d_v_i2i1__ = 0;
    d_i_nci2_d_v_n1i1__ = 0;
    d_i_nci2_d_v_n1n2__ = 0;
    d_i_nci2_d_v_ncn2__ = 0;
    d_iecrit_d_temp_dtn2__ = 0;
    d_isa_t_d_temp_dtn2__ = 0;
    d_isp_t_d_temp_dtn2__ = 0;
    d_kfn_t_d_temp_dtn2__ = 0;
    d_lde_d_temp_dtn2__ = 0;
    d_mv0_d_temp_dtn2__ = 0;
    d_mv_d_temp_dtn2__ = 0;
    d_mv_d_v_i2i1__ = 0;
    d_mv_d_v_n1i1__ = 0;
    d_mv_d_v_n1n2__ = 0;
    d_mv_d_v_ncn2__ = 0;
    d_nbv_t_d_temp_dtn2__ = 0;
    d_pa_t_d_temp_dtn2__ = 0;
    d_pcjp_d_temp_dtn2__ = 0;
    d_phi_t_d_temp_dtn2__ = 0;
    d_pisp_d_temp_dtn2__ = 0;
    d_pnjIa_d_temp_dtn2__ = 0;
    d_pnjIa_d_v_i2i1__ = 0;
    d_pnjIa_d_v_n1i1__ = 0;
    d_pnjIa_d_v_n1n2__ = 0;
    d_pnjIa_d_v_ncn2__ = 0;
    d_pnjIp_d_temp_dtn2__ = 0;
    d_pnjIp_d_v_i2i1__ = 0;
    d_pnjIp_d_v_n1i1__ = 0;
    d_pnjIp_d_v_n1n2__ = 0;
    d_pnjIp_d_v_ncn2__ = 0;
    d_power_d_i_n2i2__ = 0;
    d_power_d_i_nci1__ = 0;
    d_power_d_i_nci2__ = 0;
    d_power_d_temp_dtn2__ = 0;
    d_power_d_v_i2i1__ = 0;
    d_power_d_v_n1i1__ = 0;
    d_power_d_v_n1n2__ = 0;
    d_power_d_v_ncn2__ = 0;
    d_pp_t_d_temp_dtn2__ = 0;
    d_psiin_d_temp_dtn2__ = 0;
    d_psiio_d_temp_dtn2__ = 0;
    d_pvar_d_temp_dtn2__ = 0;
    d_pvar_d_v_i2i1__ = 0;
    d_pvar_d_v_n1i1__ = 0;
    d_pvar_d_v_n1n2__ = 0;
    d_pvar_d_v_ncn2__ = 0;
    d_pwq_d_temp_dtn2__ = 0;
    d_pwq_d_v_i2i1__ = 0;
    d_pwq_d_v_n1i1__ = 0;
    d_pwq_d_v_n1n2__ = 0;
    d_pwq_d_v_ncn2__ = 0;
    d_q_i_i2i1_d_temp_dtn2__ = 0;
    d_q_i_i2i1_d_v_i2i1__ = 0;
    d_q_i_i2i1_d_v_n1i1__ = 0;
    d_q_i_i2i1_d_v_n1n2__ = 0;
    d_q_i_i2i1_d_v_ncn2__ = 0;
    d_q_i_n1i1_d_i_n2i2__ = 0;
    d_q_i_n1i1_d_i_nci1__ = 0;
    d_q_i_n1i1_d_i_nci2__ = 0;
    d_q_i_n1i1_d_temp_dtn2__ = 0;
    d_q_i_n1i1_d_v_i2i1__ = 0;
    d_q_i_n1i1_d_v_n1i1__ = 0;
    d_q_i_n1i1_d_v_n1n2__ = 0;
    d_q_i_n2i2_d_i_n2i2__ = 0;
    d_q_i_n2i2_d_temp_dtn2__ = 0;
    d_q_i_n2i2_d_v_i2i1__ = 0;
    d_q_i_n2i2_d_v_n1i1__ = 0;
    d_q_i_n2i2_d_v_n1n2__ = 0;
    d_q_i_nci1_d_i_nci1__ = 0;
    d_q_i_nci1_d_temp_dtn2__ = 0;
    d_q_i_nci1_d_v_i2i1__ = 0;
    d_q_i_nci1_d_v_n1i1__ = 0;
    d_q_i_nci1_d_v_n1n2__ = 0;
    d_q_i_nci1_d_v_ncn2__ = 0;
    d_q_i_nci2_d_i_nci2__ = 0;
    d_q_i_nci2_d_temp_dtn2__ = 0;
    d_q_i_nci2_d_v_i2i1__ = 0;
    d_q_i_nci2_d_v_n1i1__ = 0;
    d_q_i_nci2_d_v_n1n2__ = 0;
    d_q_i_nci2_d_v_ncn2__ = 0;
    d_q_pwr_dtn2_d_i_n2i2__ = 0;
    d_q_pwr_dtn2_d_i_nci1__ = 0;
    d_q_pwr_dtn2_d_i_nci2__ = 0;
    d_q_pwr_dtn2_d_temp_dtn2__ = 0;
    d_q_pwr_dtn2_d_v_i2i1__ = 0;
    d_q_pwr_dtn2_d_v_n1i1__ = 0;
    d_q_pwr_dtn2_d_v_n1n2__ = 0;
    d_q_pwr_dtn2_d_v_ncn2__ = 0;
    d_q_v_n1i1_d_i_n2i2__ = 0;
    d_q_v_n1i1_d_i_nci1__ = 0;
    d_q_v_n1i1_d_i_nci2__ = 0;
    d_q_v_n1i1_d_temp_dtn2__ = 0;
    d_q_v_n1i1_d_v_i2i1__ = 0;
    d_q_v_n1i1_d_v_n1i1__ = 0;
    d_q_v_n1i1_d_v_n1n2__ = 0;
    d_qhi_d_temp_dtn2__ = 0;
    d_qhi_d_v_i2i1__ = 0;
    d_qhi_d_v_n1i1__ = 0;
    d_qhi_d_v_n1n2__ = 0;
    d_qhi_d_v_ncn2__ = 0;
    d_qlo_d_temp_dtn2__ = 0;
    d_qlo_d_v_i2i1__ = 0;
    d_qlo_d_v_n1i1__ = 0;
    d_qlo_d_v_n1n2__ = 0;
    d_qlo_d_v_ncn2__ = 0;
    d_qvar_d_temp_dtn2__ = 0;
    d_qvar_d_v_i2i1__ = 0;
    d_qvar_d_v_n1i1__ = 0;
    d_qvar_d_v_n1n2__ = 0;
    d_qvar_d_v_ncn2__ = 0;
    d_rT_d_temp_dtn2__ = 0;
    d_rm_d_temp_dtn2__ = 0;
    d_rm_d_v_i2i1__ = 0;
    d_rm_d_v_n1i1__ = 0;
    d_rm_d_v_n1n2__ = 0;
    d_rm_d_v_ncn2__ = 0;
    d_rmu_d_temp_dtn2__ = 0;
    d_rmu_d_v_i2i1__ = 0;
    d_rmu_d_v_n1i1__ = 0;
    d_rmu_d_v_n1n2__ = 0;
    d_rmu_d_v_ncn2__ = 0;
    d_rp_d_temp_dtn2__ = 0;
    d_rp_d_v_i2i1__ = 0;
    d_rp_d_v_n1i1__ = 0;
    d_rp_d_v_n1n2__ = 0;
    d_rp_d_v_ncn2__ = 0;
    d_rvar_d_temp_dtn2__ = 0;
    d_rvar_d_v_i2i1__ = 0;
    d_rvar_d_v_n1i1__ = 0;
    d_rvar_d_v_n1n2__ = 0;
    d_rvar_d_v_ncn2__ = 0;
    d_sdFlip_d_v_i2i1__ = 0;
    d_sdFlip_d_v_n1n2__ = 0;
    d_sd_d_temp_dtn2__ = 0;
    d_sd_d_v_i2i1__ = 0;
    d_sd_d_v_n1i1__ = 0;
    d_sd_d_v_n1n2__ = 0;
    d_sd_d_v_ncn2__ = 0;
    d_sqrtm_d_temp_dtn2__ = 0;
    d_sqrtm_d_v_i2i1__ = 0;
    d_sqrtm_d_v_n1i1__ = 0;
    d_sqrtm_d_v_n1n2__ = 0;
    d_sqrtm_d_v_ncn2__ = 0;
    d_sqrtp_d_temp_dtn2__ = 0;
    d_sqrtp_d_v_i2i1__ = 0;
    d_sqrtp_d_v_n1i1__ = 0;
    d_sqrtp_d_v_n1n2__ = 0;
    d_sqrtp_d_v_ncn2__ = 0;
    d_tcr_d_temp_dtn2__ = 0;
    d_tcrc_d_temp_dtn2__ = 0;
    d_tcvsat_d_temp_dtn2__ = 0;
    d_tdevC_d_temp_dtn2__ = 0;
    d_tdevK_d_temp_dtn2__ = 0;
    d_tmp_d_temp_dtn2__ = 0;
    d_tmp_d_v_i2i1__ = 0;
    d_tmp_d_v_n1i1__ = 0;
    d_tmp_d_v_n1n2__ = 0;
    d_tmp_d_v_ncn2__ = 0;
    d_uoff_d_temp_dtn2__ = 0;
    d_v_i2i1_d_v_n1n2__ = 0;
    d_v_n1i1_d_i_n2i2__ = 0;
    d_v_n1i1_d_i_nci1__ = 0;
    d_v_n1i1_d_i_nci2__ = 0;
    d_v_n1i1_d_temp_dtn2__ = 0;
    d_v_n1i1_d_v_i2i1__ = 0;
    d_v_n1i1_d_v_n1n2__ = 0;
    d_v_n2i2_d_i_n2i2__ = 0;
    d_v_n2i2_d_temp_dtn2__ = 0;
    d_v_n2i2_d_v_i2i1__ = 0;
    d_v_n2i2_d_v_n1i1__ = 0;
    d_v_n2i2_d_v_n1n2__ = 0;
    d_v_nci1_d_v_i2i1__ = 0;
    d_v_nci1_d_v_n1i1__ = 0;
    d_v_nci1_d_v_n1n2__ = 0;
    d_v_nci1_d_v_ncn2__ = 0;
    d_v_nci2_d_v_i2i1__ = 0;
    d_v_nci2_d_v_n1i1__ = 0;
    d_v_nci2_d_v_n1n2__ = 0;
    d_v_nci2_d_v_ncn2__ = 0;
    d_val1_d_temp_dtn2__ = 0;
    d_val1_d_v_i2i1__ = 0;
    d_val1_d_v_n1i1__ = 0;
    d_val1_d_v_n1n2__ = 0;
    d_val1_d_v_ncn2__ = 0;
    d_val2_d_temp_dtn2__ = 0;
    d_val2_d_v_i2i1__ = 0;
    d_val2_d_v_n1i1__ = 0;
    d_val2_d_v_n1n2__ = 0;
    d_val2_d_v_ncn2__ = 0;
    d_vbv_t_d_temp_dtn2__ = 0;
    d_vl0_d_temp_dtn2__ = 0;
    d_vl_d_temp_dtn2__ = 0;
    d_vl_d_v_i2i1__ = 0;
    d_vl_d_v_n1i1__ = 0;
    d_vl_d_v_n1n2__ = 0;
    d_vl_d_v_ncn2__ = 0;
    d_vmax_a_d_temp_dtn2__ = 0;
    d_vmax_b_d_temp_dtn2__ = 0;
    d_vmax_p_d_temp_dtn2__ = 0;
    d_wn_d_temp_dtn2__ = 0;
    d_wn_d_v_i2i1__ = 0;
    d_wn_d_v_n1i1__ = 0;
    d_wn_d_v_n1n2__ = 0;
    d_wn_d_v_ncn2__ = 0;
    d_yvar_d_temp_dtn2__ = 0;
    d_yvar_d_v_i2i1__ = 0;
    d_yvar_d_v_n1i1__ = 0;
    d_yvar_d_v_n1n2__ = 0;
    d_yvar_d_v_ncn2__ = 0;
    mMod = 1;
    lFactor = ((1-0.01*parm_shrink)*parm_scale)*1000000;
    w_um = parm_w*lFactor;
    rc1_tnom = qmcol_vapp(parm_c1>0, (parm_rc+parm_rcw/w_um)/parm_c1, 0);
    rc2_tnom = qmcol_vapp(parm_c2>0, (parm_rc+parm_rcw/w_um)/parm_c2, 0);
    if ~(rc1_tnom>mMod*parm_rthresh)
        if 1
            %Collapse branch: n1i1
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                    % Initializing inputs
                    v_n1n2__ = vecX__(1);
                    v_ncn2__ = vecX__(2);
                    temp_dtn2__ = vecY__(1);
                else
                    % Initializing inputs
                    v_n1n2__ = vecX__(1);
                    v_ncn2__ = vecX__(2);
                    v_i2i1__ = vecY__(1);
                    temp_dtn2__ = vecY__(2);
                    i_n2i2__ = vecY__(3);
                end
            else
                % Initializing inputs
                v_n1n2__ = vecX__(1);
                v_ncn2__ = vecX__(2);
                v_i2i1__ = vecY__(1);
                temp_dtn2__ = vecY__(2);
                i_n2i2__ = vecY__(3);
            end
        else
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                    % Initializing inputs
                    v_n1n2__ = vecX__(1);
                    v_ncn2__ = vecX__(2);
                    v_i2i1__ = vecY__(1);
                    temp_dtn2__ = vecY__(2);
                    i_n1i1__ = vecY__(3);
                else
                    % Initializing inputs
                    v_n1n2__ = vecX__(1);
                    v_ncn2__ = vecX__(2);
                    v_i2i1__ = vecY__(1);
                    v_n1i1__ = vecY__(2);
                    temp_dtn2__ = vecY__(3);
                    i_n2i2__ = vecY__(4);
                    i_nci1__ = vecY__(5);
                    i_nci2__ = vecY__(6);
                end
            else
                % Initializing inputs
                v_n1n2__ = vecX__(1);
                v_ncn2__ = vecX__(2);
                v_i2i1__ = vecY__(1);
                v_n1i1__ = vecY__(2);
                temp_dtn2__ = vecY__(3);
                i_n2i2__ = vecY__(4);
                i_nci1__ = vecY__(5);
                i_nci2__ = vecY__(6);
            end
        end
    else
        if ~(rc2_tnom>mMod*parm_rthresh)
            if 1
                %Collapse branch: n2i2
                % Initializing inputs
                v_n1n2__ = vecX__(1);
                v_ncn2__ = vecX__(2);
                v_i2i1__ = vecY__(1);
                temp_dtn2__ = vecY__(2);
                i_n1i1__ = vecY__(3);
            else
                % Initializing inputs
                v_n1n2__ = vecX__(1);
                v_ncn2__ = vecX__(2);
                v_i2i1__ = vecY__(1);
                v_n1i1__ = vecY__(2);
                temp_dtn2__ = vecY__(3);
                i_n2i2__ = vecY__(4);
                i_nci1__ = vecY__(5);
                i_nci2__ = vecY__(6);
            end
        else
            % Initializing inputs
            v_n1n2__ = vecX__(1);
            v_ncn2__ = vecX__(2);
            v_i2i1__ = vecY__(1);
            v_n1i1__ = vecY__(2);
            temp_dtn2__ = vecY__(3);
            i_n2i2__ = vecY__(4);
            i_nci1__ = vecY__(5);
            i_nci2__ = vecY__(6);
        end
    end
    % Initializing remaining IOs and auxiliary IOs
    f_i_i2i1__ = 0;
    q_i_i2i1__ = 0;
    f_v_n1i1__ = 0;
    q_v_n1i1__ = 0;
    f_i_n1i1__ = 0;
    q_i_n1i1__ = 0;
    f_v_n2i2__ = 0;
    q_v_n2i2__ = 0;
    f_i_n2i2__ = 0;
    q_i_n2i2__ = 0;
    f_i_nci1__ = 0;
    q_i_nci1__ = 0;
    f_i_nci2__ = 0;
    q_i_nci2__ = 0;
    f_pwr_dtn2__ = 0;
    q_pwr_dtn2__ = 0;
    % module body
    if ~(rc1_tnom>mMod*parm_rthresh)
        if 1
            %Collapse branch: n1i1
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                    v_n1i1__ = 0;
                    i_n1i1__ = 0;
                    v_n2i2__ = 0;
                    i_n2i2__ = 0;
                        d_v_i2i1_d_v_n1n2__ = -1;
                    v_i2i1__ = -v_n1n2__;
                        d_v_nci1_d_v_n1n2__ = -1;
                        d_v_nci1_d_v_ncn2__ = 1;
                    v_nci1__ = -v_n1n2__+v_ncn2__;
                        d_v_nci2_d_v_ncn2__ = 1;
                    v_nci2__ = v_ncn2__;
                else
                    v_n1i1__ = 0;
                    i_n1i1__ = 0;
                        d_v_n2i2_d_v_n1n2__ = -1-d_v_i2i1_d_v_n1n2__;
                        d_v_n2i2_d_v_i2i1__ = -1;
                    v_n2i2__ = -v_n1n2__-v_i2i1__;
                        d_v_nci1_d_v_n1n2__ = -1;
                        d_v_nci1_d_v_ncn2__ = 1;
                    v_nci1__ = -v_n1n2__+v_ncn2__;
                        d_v_nci2_d_v_n1n2__ = (-1)-d_v_i2i1_d_v_n1n2__;
                        d_v_nci2_d_v_ncn2__ = (1);
                        d_v_nci2_d_v_i2i1__ = -1;
                    v_nci2__ = (-v_n1n2__+v_ncn2__)-v_i2i1__;
                end
            else
                v_n1i1__ = 0;
                i_n1i1__ = 0;
                    d_v_n2i2_d_v_n1n2__ = -1-d_v_i2i1_d_v_n1n2__;
                    d_v_n2i2_d_v_i2i1__ = -1;
                v_n2i2__ = -v_n1n2__-v_i2i1__;
                    d_v_nci1_d_v_n1n2__ = -1;
                    d_v_nci1_d_v_ncn2__ = 1;
                v_nci1__ = -v_n1n2__+v_ncn2__;
                    d_v_nci2_d_v_n1n2__ = (-1)-d_v_i2i1_d_v_n1n2__;
                    d_v_nci2_d_v_ncn2__ = (1);
                    d_v_nci2_d_v_i2i1__ = -1;
                v_nci2__ = (-v_n1n2__+v_ncn2__)-v_i2i1__;
            end
        else
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                        d_v_n2i2_d_v_n1n2__ = 0;
                        d_v_n2i2_d_v_i2i1__ = 0;
                    v_n2i2__ = 0;
                    i_n2i2__ = 0;
                        d_v_n1i1_d_v_n1n2__ = 1+d_v_i2i1_d_v_n1n2__;
                        d_v_n1i1_d_v_i2i1__ = 1;
                    v_n1i1__ = v_n1n2__+v_i2i1__;
                        d_v_nci1_d_v_n1n2__ = d_v_i2i1_d_v_n1n2__;
                        d_v_nci1_d_v_ncn2__ = 1;
                        d_v_nci1_d_v_i2i1__ = 1;
                    v_nci1__ = v_ncn2__+v_i2i1__;
                        d_v_nci2_d_v_n1n2__ = 0;
                        d_v_nci2_d_v_ncn2__ = 1;
                        d_v_nci2_d_v_i2i1__ = 0;
                    v_nci2__ = v_ncn2__;
                else
                        d_i_n1i1_d_i_n2i2__ = (-1);
                        d_i_n1i1_d_i_nci1__ = (-1);
                        d_i_n1i1_d_i_nci2__ = -1;
                    i_n1i1__ = (-i_n2i2__-i_nci1__)-i_nci2__;
                        d_v_n2i2_d_v_n1n2__ = (-1-d_v_i2i1_d_v_n1n2__)+d_v_n1i1_d_v_n1n2__;
                        d_v_n2i2_d_v_i2i1__ = (-1)+d_v_n1i1_d_v_i2i1__;
                        d_v_n2i2_d_v_n1i1__ = 1;
                    v_n2i2__ = (-v_n1n2__-v_i2i1__)+v_n1i1__;
                        d_v_nci1_d_v_n1n2__ = (-1)+d_v_n1i1_d_v_n1n2__;
                        d_v_nci1_d_v_ncn2__ = (1);
                        d_v_nci1_d_v_i2i1__ = d_v_n1i1_d_v_i2i1__;
                        d_v_nci1_d_v_n1i1__ = 1;
                    v_nci1__ = (-v_n1n2__+v_ncn2__)+v_n1i1__;
                        d_v_nci2_d_v_n1n2__ = ((-1)-d_v_i2i1_d_v_n1n2__)+d_v_n1i1_d_v_n1n2__;
                        d_v_nci2_d_v_ncn2__ = ((1));
                        d_v_nci2_d_v_i2i1__ = (-1)+d_v_n1i1_d_v_i2i1__;
                        d_v_nci2_d_v_n1i1__ = 1;
                    v_nci2__ = ((-v_n1n2__+v_ncn2__)-v_i2i1__)+v_n1i1__;
                end
            else
                    d_i_n1i1_d_i_n2i2__ = (-1);
                    d_i_n1i1_d_i_nci1__ = (-1);
                    d_i_n1i1_d_i_nci2__ = -1;
                i_n1i1__ = (-i_n2i2__-i_nci1__)-i_nci2__;
                    d_v_n2i2_d_v_n1n2__ = (-1-d_v_i2i1_d_v_n1n2__)+d_v_n1i1_d_v_n1n2__;
                    d_v_n2i2_d_v_i2i1__ = (-1)+d_v_n1i1_d_v_i2i1__;
                    d_v_n2i2_d_v_n1i1__ = 1;
                v_n2i2__ = (-v_n1n2__-v_i2i1__)+v_n1i1__;
                    d_v_nci1_d_v_n1n2__ = (-1)+d_v_n1i1_d_v_n1n2__;
                    d_v_nci1_d_v_ncn2__ = (1);
                    d_v_nci1_d_v_i2i1__ = d_v_n1i1_d_v_i2i1__;
                    d_v_nci1_d_v_n1i1__ = 1;
                v_nci1__ = (-v_n1n2__+v_ncn2__)+v_n1i1__;
                    d_v_nci2_d_v_n1n2__ = ((-1)-d_v_i2i1_d_v_n1n2__)+d_v_n1i1_d_v_n1n2__;
                    d_v_nci2_d_v_ncn2__ = ((1));
                    d_v_nci2_d_v_i2i1__ = (-1)+d_v_n1i1_d_v_i2i1__;
                    d_v_nci2_d_v_n1i1__ = 1;
                v_nci2__ = ((-v_n1n2__+v_ncn2__)-v_i2i1__)+v_n1i1__;
            end
        end
    else
        if ~(rc2_tnom>mMod*parm_rthresh)
            if 1
                %Collapse branch: n2i2
                    d_v_n2i2_d_v_n1n2__ = 0;
                    d_v_n2i2_d_v_i2i1__ = 0;
                    d_v_n2i2_d_v_n1i1__ = 0;
                v_n2i2__ = 0;
                i_n2i2__ = 0;
                    d_v_n1i1_d_v_n1n2__ = 1+d_v_i2i1_d_v_n1n2__;
                    d_v_n1i1_d_v_i2i1__ = 1;
                v_n1i1__ = v_n1n2__+v_i2i1__;
                    d_v_nci1_d_v_n1n2__ = d_v_i2i1_d_v_n1n2__;
                    d_v_nci1_d_v_ncn2__ = 1;
                    d_v_nci1_d_v_i2i1__ = 1;
                    d_v_nci1_d_v_n1i1__ = 0;
                v_nci1__ = v_ncn2__+v_i2i1__;
                    d_v_nci2_d_v_n1n2__ = 0;
                    d_v_nci2_d_v_ncn2__ = 1;
                    d_v_nci2_d_v_i2i1__ = 0;
                    d_v_nci2_d_v_n1i1__ = 0;
                v_nci2__ = v_ncn2__;
            else
                    d_i_n1i1_d_i_n2i2__ = (-1);
                    d_i_n1i1_d_i_nci1__ = (-1);
                    d_i_n1i1_d_i_nci2__ = -1;
                i_n1i1__ = (-i_n2i2__-i_nci1__)-i_nci2__;
                    d_v_n2i2_d_v_n1n2__ = (-1-d_v_i2i1_d_v_n1n2__)+d_v_n1i1_d_v_n1n2__;
                    d_v_n2i2_d_v_i2i1__ = (-1)+d_v_n1i1_d_v_i2i1__;
                    d_v_n2i2_d_v_n1i1__ = 1;
                v_n2i2__ = (-v_n1n2__-v_i2i1__)+v_n1i1__;
                    d_v_nci1_d_v_n1n2__ = (-1)+d_v_n1i1_d_v_n1n2__;
                    d_v_nci1_d_v_ncn2__ = (1);
                    d_v_nci1_d_v_i2i1__ = d_v_n1i1_d_v_i2i1__;
                    d_v_nci1_d_v_n1i1__ = 1;
                v_nci1__ = (-v_n1n2__+v_ncn2__)+v_n1i1__;
                    d_v_nci2_d_v_n1n2__ = ((-1)-d_v_i2i1_d_v_n1n2__)+d_v_n1i1_d_v_n1n2__;
                    d_v_nci2_d_v_ncn2__ = ((1));
                    d_v_nci2_d_v_i2i1__ = (-1)+d_v_n1i1_d_v_i2i1__;
                    d_v_nci2_d_v_n1i1__ = 1;
                v_nci2__ = ((-v_n1n2__+v_ncn2__)-v_i2i1__)+v_n1i1__;
            end
        else
                d_i_n1i1_d_i_n2i2__ = (-1);
                d_i_n1i1_d_i_nci1__ = (-1);
                d_i_n1i1_d_i_nci2__ = -1;
            i_n1i1__ = (-i_n2i2__-i_nci1__)-i_nci2__;
                d_v_n2i2_d_v_n1n2__ = (-1-d_v_i2i1_d_v_n1n2__)+d_v_n1i1_d_v_n1n2__;
                d_v_n2i2_d_v_i2i1__ = (-1)+d_v_n1i1_d_v_i2i1__;
                d_v_n2i2_d_v_n1i1__ = 1;
            v_n2i2__ = (-v_n1n2__-v_i2i1__)+v_n1i1__;
                d_v_nci1_d_v_n1n2__ = (-1)+d_v_n1i1_d_v_n1n2__;
                d_v_nci1_d_v_ncn2__ = (1);
                d_v_nci1_d_v_i2i1__ = d_v_n1i1_d_v_i2i1__;
                d_v_nci1_d_v_n1i1__ = 1;
            v_nci1__ = (-v_n1n2__+v_ncn2__)+v_n1i1__;
                d_v_nci2_d_v_n1n2__ = ((-1)-d_v_i2i1_d_v_n1n2__)+d_v_n1i1_d_v_n1n2__;
                d_v_nci2_d_v_ncn2__ = ((1));
                d_v_nci2_d_v_i2i1__ = (-1)+d_v_n1i1_d_v_i2i1__;
                d_v_nci2_d_v_n1i1__ = 1;
            v_nci2__ = ((-v_n1n2__+v_ncn2__)-v_i2i1__)+v_n1i1__;
        end
    end
    if 2~=parm_version
        sim_strobe_vapp('ERROR: r3 model version is inconsistent with the parameter set');

        sim_finish_vapp(0)
    end
    if 0<parm_subversion
        sim_strobe_vapp('ERROR: r3 model subversion is less than required for the parameter set');

        sim_finish_vapp(0)
    end
    mMod = 1;
    lFactor = ((1-0.01*parm_shrink)*parm_scale)*1000000;
    aFactor = lFactor*lFactor;
    tiniK = 273.15+parm_tnom;
        d_tdevC_d_temp_dtn2__ = 0;
    tdevC = (sim_temperature_vapp(MOD__)+parm_trise)-273.15;
    if tdevC<parm_tmin
        sim_strobe_vapp('WARNING: ambient temperature is lower than allowed minimum');

    end
    if tdevC>parm_tmax
        sim_strobe_vapp('WARNING: ambient temperature is higher than allowed maximum');

    end
    if tdevC<parm_tminclip+1
            d_tdevC_d_temp_dtn2__ = 0;
        tdevC = parm_tminclip+exp((tdevC-parm_tminclip)-1);
    else
        if tdevC>parm_tmaxclip-1
                d_tdevC_d_temp_dtn2__ = 0;
            tdevC = parm_tmaxclip-exp((parm_tmaxclip-tdevC)-1);
        else
                d_tdevC_d_temp_dtn2__ = 0;
            tdevC = tdevC;
        end
    end
        d_tdevK_d_temp_dtn2__ = 0;
    tdevK = tdevC+273.15;
    phi_t0 = (1.3807e-23*tdevK)/1.6022e-19;
        d_rT_d_temp_dtn2__ = 0;
    rT = tdevK/tiniK;
        d_dT_d_temp_dtn2__ = 0;
    dT = tdevK-tiniK;
    w_um = parm_w*lFactor;
    l_um = parm_l*lFactor;
    if w_um<parm_wmin
        sim_strobe_vapp('WARNING: drawn width is smaller than allowed minimum');

    end
    if w_um>parm_wmax
        sim_strobe_vapp('WARNING: drawn width is greater than allowed maximum');

    end
    if l_um<parm_lmin
        sim_strobe_vapp('WARNING: drawn length is smaller than allowed minimum');

    end
    if l_um>parm_lmax
        sim_strobe_vapp('WARNING: drawn length is greater than allowed maximum');

    end
    wd_um = parm_wd*lFactor;
    a1_um2 = parm_a1*aFactor;
    p1_um = parm_p1*lFactor;
    a2_um2 = parm_a2*aFactor;
    p2_um = parm_p2*lFactor;
    a_um2 = l_um*w_um;
    p_um = 2*l_um+((parm_c1>0)+(parm_c2>0))*w_um;
    xleff = (0.5*((parm_c1>0)+(parm_c2>0)))*(parm_xl+parm_xlw/w_um);
    weff_um = (((w_um+parm_xw)+parm_nwxw/w_um)+parm_fdxwinf*(1-exp(-w_um/parm_fdrw)))/(1-(parm_wexw*wd_um)/a_um2);
    leff_um = l_um+xleff;
    if parm_sw_mmgeo
        wid = weff_um;
        len = leff_um;
    else
        wid = w_um;
        len = l_um;
    end
    if parm_sw_mman
        weff_um = (weff_um+parm_nsig_w*parm_sig_w)+(parm_nsmm_w*parm_smm_w)/sqrt(mMod*len);
        leff_um = (leff_um+parm_nsig_l*parm_sig_l)+(parm_nsmm_l*parm_smm_l)/sqrt(mMod*wid);
        delr_rsh = exp(0.01*(parm_nsig_rsh*parm_sig_rsh+(parm_nsmm_rsh*parm_smm_rsh)/sqrt((mMod*len)*wid)));
    else
        if (parm_nsig_w~=0&&parm_smm_w>0)||parm_sig_w>0
            fctr1 = parm_smm_w/sqrt(mMod*len);
            weff_um = weff_um+parm_nsig_w*sqrt(parm_sig_w*parm_sig_w+fctr1*fctr1);
        end
        if (parm_nsig_l~=0&&parm_smm_l>0)||parm_sig_l>0
            fctr1 = parm_smm_l/sqrt(mMod*wid);
            leff_um = leff_um+parm_nsig_l*sqrt(parm_sig_l*parm_sig_l+fctr1*fctr1);
        end
        if (parm_nsig_rsh~=0&&parm_smm_rsh>0)||parm_sig_rsh>0
            fctr1 = parm_smm_rsh/sqrt((mMod*len)*wid);
            delr_rsh = exp((0.01*parm_nsig_rsh)*sqrt(parm_sig_rsh*parm_sig_rsh+fctr1*fctr1));
        else
            delr_rsh = 1;
        end
    end
    if weff_um<=0
        sim_strobe_vapp('ERROR: r3 model calculated effective width is <= 0.0');

        sim_finish_vapp(0)
    end
    if leff_um<=0
        sim_strobe_vapp('ERROR: r3 model calculated effective length is <= 0.0');

        sim_finish_vapp(0)
    end
    leffE_um = leff_um+parm_dxlsat;
    if leffE_um<=0
        sim_strobe_vapp('ERROR: r3 model calculated effective length for velocity saturation is <= 0.0');

        sim_finish_vapp(0)
    end
    if parm_sw_dfgeo
        wid = weff_um;
        len = leff_um;
    else
        wid = w_um;
        len = l_um;
    end
    iw_dpwe = 1/pow_vapp(wid, parm_dpwe);
    il_dple = 1/pow_vapp(len, parm_dple);
    dp = (((parm_dpinf*(1+parm_dpw*iw_dpwe))*(1+parm_dpl*il_dple))*(1+(parm_dpwl*iw_dpwe)*il_dple))*(1+dT*(parm_tc1dp+dT*parm_tc2dp));
    dp = qmcol_vapp(dp>0.1, dp, 0.1);
    dfmin = sqrt(dp)/(dp+10000);
    df = qmcol_vapp(parm_sw_lin, 0, parm_dfinf+((parm_dfw*len+parm_dfl*wid)+parm_dfwl)/(len*wid));
    if df<dfmin
        df = qmcol_vapp(df>0, df, 0);
        dfsq = dfmin*dfmin;
    else
        dfsq = df*df;
    end
    vpo = 0.5/dfsq-dp*0.5;
    if parm_sw_accpo
        vpoe = vpo-(2*parm_grpo)/dfsq;
        V1cx = 0.16667/dfsq-dp*0.5;
    else
        vpoe = vpo-sqrt((2*parm_grpo)/dfsq);
        V1cx = 0;
    end
    ats = parm_atsinf/(1+parm_atsl/leff_um);
    if parm_sw_accpo
        nsteff = parm_nst*phi_t0;
        atspo = qmcol_vapp(parm_sw_accpo>1, (0.55*phi_t0)*(1+exp(-ats/phi_t0)), 1.1*phi_t0);
    else
        nsteff = (2*parm_nst)*phi_t0;
        atspo = (4*ats)*ats;
    end
    dibl1 = parm_dibl1l/pow_vapp(leff_um, parm_dibl1le);
    dibl2 = parm_dibl2l/pow_vapp(leff_um, parm_dibl2le);
    dibl2o = pow_vapp(parm_dibl2v, parm_dibl2e);
    clm1 = parm_clm1l/pow_vapp(leff_um, parm_clm1le);
    clm2 = parm_clm2l/pow_vapp(leff_um, parm_clm2le);
    clm2o = pow_vapp(parm_clm2v, parm_clm2e);
    r0 = (parm_rsh*delr_rsh)*(leff_um/weff_um);
    if r0<=1e-99
        sim_strobe_vapp('ERROR: calculated zero bias resistance is too small');

        sim_finish_vapp(0)
    end
    rc1_tnom = qmcol_vapp(parm_c1>0, (parm_rc+parm_rcw/w_um)/parm_c1, 0);
    rc2_tnom = qmcol_vapp(parm_c2>0, (parm_rc+parm_rcw/w_um)/parm_c2, 0);
    if parm_sw_lin
        gth = 0;
        cth = 0;
    else
        gth = (((parm_gth0+parm_gthp*p_um)+parm_gtha*a_um2)+parm_gthc*(parm_c1+parm_c2))*pow_vapp(rT, parm_tegth);
        cth = ((parm_cth0+parm_cthp*p_um)+parm_ctha*a_um2)+parm_cthc*(parm_c1+parm_c2);
    end
    tc1e = (parm_tc1+parm_tc1w/weff_um)+((0.5*((parm_c1>0)+(parm_c2>0)))*(parm_tc1l+parm_tc1wl/weff_um))/leff_um;
    tc2e = (parm_tc2+parm_tc2w/weff_um)+((0.5*((parm_c1>0)+(parm_c2>0)))*(parm_tc2l+parm_tc2wl/weff_um))/leff_um;
    Cf1 = parm_ca*a1_um2+parm_cp*p1_um;
    Cf2 = parm_ca*a2_um2+parm_cp*p2_um;
    Cj1 = parm_cja*a1_um2+parm_cjp*p1_um;
    Cj2 = parm_cja*a2_um2+parm_cjp*p2_um;
        d_dt_et_d_temp_dtn2__ = 1;
    dt_et = temp_dtn2__;
        d_Vb_d_v_n1n2__ = -parm_type*d_v_i2i1_d_v_n1n2__;
        d_Vb_d_v_i2i1__ = -parm_type*1;
    Vb = -parm_type*v_i2i1__;
        d_Vc1_d_v_n1n2__ = -parm_type*d_v_nci1_d_v_n1n2__;
        d_Vc1_d_v_ncn2__ = -parm_type*d_v_nci1_d_v_ncn2__;
        d_Vc1_d_v_i2i1__ = -parm_type*d_v_nci1_d_v_i2i1__;
        d_Vc1_d_v_n1i1__ = -parm_type*d_v_nci1_d_v_n1i1__;
    Vc1 = -parm_type*v_nci1__;
        d_Vc2_d_v_n1n2__ = -parm_type*d_v_nci2_d_v_n1n2__;
        d_Vc2_d_v_ncn2__ = -parm_type*d_v_nci2_d_v_ncn2__;
        d_Vc2_d_v_i2i1__ = -parm_type*d_v_nci2_d_v_i2i1__;
        d_Vc2_d_v_n1i1__ = -parm_type*d_v_nci2_d_v_n1i1__;
    Vc2 = -parm_type*v_nci2__;
        d_tdevC_d_temp_dtn2__ = (d_dt_et_d_temp_dtn2__);
    tdevC = ((sim_temperature_vapp(MOD__)+parm_trise)+dt_et)-273.15;
    if tdevC<parm_tminclip+1
            d_tdevC_d_temp_dtn2__ = exp((tdevC-parm_tminclip)-1)*((d_tdevC_d_temp_dtn2__));
        tdevC = parm_tminclip+exp((tdevC-parm_tminclip)-1);
    else
        if tdevC>parm_tmaxclip-1
                d_tdevC_d_temp_dtn2__ = -exp((parm_tmaxclip-tdevC)-1)*((-d_tdevC_d_temp_dtn2__));
            tdevC = parm_tmaxclip-exp((parm_tmaxclip-tdevC)-1);
        else
                d_tdevC_d_temp_dtn2__ = d_tdevC_d_temp_dtn2__;
            tdevC = tdevC;
        end
    end
        d_tdevK_d_temp_dtn2__ = d_tdevC_d_temp_dtn2__;
    tdevK = tdevC+273.15;
        d_phi_t_d_temp_dtn2__ = (1.3807e-23*d_tdevK_d_temp_dtn2__)/1.6022e-19;
    phi_t = (1.3807e-23*tdevK)/1.6022e-19;
        d_rT_d_temp_dtn2__ = d_tdevK_d_temp_dtn2__/tiniK;
    rT = tdevK/tiniK;
        d_dT_d_temp_dtn2__ = d_tdevK_d_temp_dtn2__;
    dT = tdevK-tiniK;
        d_tcr_d_temp_dtn2__ = (dT*((d_dT_d_temp_dtn2__*tc2e))+d_dT_d_temp_dtn2__*(tc1e+dT*tc2e));
    tcr = 1+dT*(tc1e+dT*tc2e);
    if tcr<0.01+0.1
            d_tcr_d_temp_dtn2__ = (0.1*(exp(10*(tcr-0.01)-1)*((10*(d_tcr_d_temp_dtn2__)))));
        tcr = 0.01+0.1*exp(10*(tcr-0.01)-1);
    else
            d_tcr_d_temp_dtn2__ = d_tcr_d_temp_dtn2__;
        tcr = tcr;
    end
        d_gf_d_temp_dtn2__ = -(1*((r0*(1-df*sqrt(dp)))*d_tcr_d_temp_dtn2__))/((r0*(1-df*sqrt(dp)))*tcr)^2;
    gf = 1/((r0*(1-df*sqrt(dp)))*tcr);
        d_tcrc_d_temp_dtn2__ = (dT*((d_dT_d_temp_dtn2__*parm_tc2rc))+d_dT_d_temp_dtn2__*(parm_tc1rc+dT*parm_tc2rc));
    tcrc = 1+dT*(parm_tc1rc+dT*parm_tc2rc);
    if tcrc<0.01+0.1
            d_tcrc_d_temp_dtn2__ = (0.1*(exp(10*(tcrc-0.01)-1)*((10*(d_tcrc_d_temp_dtn2__)))));
        tcrc = 0.01+0.1*exp(10*(tcrc-0.01)-1);
    else
            d_tcrc_d_temp_dtn2__ = d_tcrc_d_temp_dtn2__;
        tcrc = tcrc;
    end
        d_tcvsat_d_temp_dtn2__ = d_pow_vapp_d_arg1__(rT, parm_xvsat)*d_rT_d_temp_dtn2__;
    tcvsat = pow_vapp(rT, parm_xvsat);
        d_kfn_t_d_temp_dtn2__ = ((d_dT_d_temp_dtn2__*parm_tc1kfn))*parm_kfn;
    kfn_t = (1+dT*parm_tc1kfn)*parm_kfn;
        d_kfn_t_d_temp_dtn2__ = qmcol_vapp(kfn_t>0, d_kfn_t_d_temp_dtn2__, 0);
    kfn_t = qmcol_vapp(kfn_t>0, kfn_t, 0);
    if parm_isa>0
            d_isa_t_d_temp_dtn2__ = parm_isa*(exp(((-parm_ea*(1-rT))/phi_t+parm_xis*log(rT))/parm_na)*((((-parm_ea*(-d_rT_d_temp_dtn2__))/phi_t-((-parm_ea*(1-rT))*d_phi_t_d_temp_dtn2__)/phi_t^2)+(parm_xis*((1/rT)*d_rT_d_temp_dtn2__)))/parm_na));
        isa_t = parm_isa*exp(((-parm_ea*(1-rT))/phi_t+parm_xis*log(rT))/parm_na);
            d_vmax_a_d_temp_dtn2__ = (parm_na*phi_t)*((1/(1+parm_imax/isa_t))*((-(parm_imax*d_isa_t_d_temp_dtn2__)/isa_t^2)))+(parm_na*d_phi_t_d_temp_dtn2__)*log(1+parm_imax/isa_t);
        vmax_a = (parm_na*phi_t)*log(1+parm_imax/isa_t);
    else
            d_isa_t_d_temp_dtn2__ = 0;
        isa_t = 0;
            d_vmax_a_d_temp_dtn2__ = 0;
        vmax_a = 0;
    end
    if parm_isp>0
            d_isp_t_d_temp_dtn2__ = parm_isp*(exp(((-parm_ea*(1-rT))/phi_t+parm_xis*log(rT))/parm_np)*((((-parm_ea*(-d_rT_d_temp_dtn2__))/phi_t-((-parm_ea*(1-rT))*d_phi_t_d_temp_dtn2__)/phi_t^2)+(parm_xis*((1/rT)*d_rT_d_temp_dtn2__)))/parm_np));
        isp_t = parm_isp*exp(((-parm_ea*(1-rT))/phi_t+parm_xis*log(rT))/parm_np);
            d_vmax_p_d_temp_dtn2__ = (parm_np*phi_t)*((1/(1+parm_imax/isp_t))*((-(parm_imax*d_isp_t_d_temp_dtn2__)/isp_t^2)))+(parm_np*d_phi_t_d_temp_dtn2__)*log(1+parm_imax/isp_t);
        vmax_p = (parm_np*phi_t)*log(1+parm_imax/isp_t);
    else
            d_isp_t_d_temp_dtn2__ = 0;
        isp_t = 0;
            d_vmax_p_d_temp_dtn2__ = 0;
        vmax_p = 0;
    end
        d_Is1_d_temp_dtn2__ = (a1_um2*d_isa_t_d_temp_dtn2__)+(p1_um*d_isp_t_d_temp_dtn2__);
    Is1 = a1_um2*isa_t+p1_um*isp_t;
        d_Is2_d_temp_dtn2__ = (a2_um2*d_isa_t_d_temp_dtn2__)+(p2_um*d_isp_t_d_temp_dtn2__);
    Is2 = a2_um2*isa_t+p2_um*isp_t;
    if parm_cja>0
            d_psiio_d_temp_dtn2__ = (2*(phi_t/rT))*((1/(exp(((0.5*parm_pa)*rT)/phi_t)-exp(((-0.5*parm_pa)*rT)/phi_t)))*(exp(((0.5*parm_pa)*rT)/phi_t)*(((0.5*parm_pa)*d_rT_d_temp_dtn2__)/phi_t-(((0.5*parm_pa)*rT)*d_phi_t_d_temp_dtn2__)/phi_t^2)-exp(((-0.5*parm_pa)*rT)/phi_t)*(((-0.5*parm_pa)*d_rT_d_temp_dtn2__)/phi_t-(((-0.5*parm_pa)*rT)*d_phi_t_d_temp_dtn2__)/phi_t^2)))+(2*(d_phi_t_d_temp_dtn2__/rT-(phi_t*d_rT_d_temp_dtn2__)/rT^2))*log(exp(((0.5*parm_pa)*rT)/phi_t)-exp(((-0.5*parm_pa)*rT)/phi_t));
        psiio = (2*(phi_t/rT))*log(exp(((0.5*parm_pa)*rT)/phi_t)-exp(((-0.5*parm_pa)*rT)/phi_t));
            d_psiin_d_temp_dtn2__ = ((psiio*d_rT_d_temp_dtn2__+d_psiio_d_temp_dtn2__*rT)-((3*phi_t)*((1/rT)*d_rT_d_temp_dtn2__)+(3*d_phi_t_d_temp_dtn2__)*log(rT)))-(parm_ea*(d_rT_d_temp_dtn2__));
        psiin = (psiio*rT-(3*phi_t)*log(rT))-parm_ea*(rT-1);
            d_pa_t_d_temp_dtn2__ = d_psiin_d_temp_dtn2__+((2*phi_t)*((1/(0.5*(1+sqrt(1+4*exp(-psiin/phi_t)))))*(0.5*((1/(2*sqrt(1+4*exp(-psiin/phi_t))))*((4*(exp(-psiin/phi_t)*(-d_psiin_d_temp_dtn2__/phi_t-(-psiin*d_phi_t_d_temp_dtn2__)/phi_t^2)))))))+(2*d_phi_t_d_temp_dtn2__)*log(0.5*(1+sqrt(1+4*exp(-psiin/phi_t)))));
        pa_t = psiin+(2*phi_t)*log(0.5*(1+sqrt(1+4*exp(-psiin/phi_t))));
            d_cja_t_d_temp_dtn2__ = parm_cja*(d_pow_vapp_d_arg1__(parm_pa/pa_t, parm_ma)*(-(parm_pa*d_pa_t_d_temp_dtn2__)/pa_t^2));
        cja_t = parm_cja*pow_vapp(parm_pa/pa_t, parm_ma);
    else
            d_pa_t_d_temp_dtn2__ = 0;
        pa_t = parm_pa;
            d_cja_t_d_temp_dtn2__ = 0;
        cja_t = 0;
    end
    if parm_cjp>0
            d_psiio_d_temp_dtn2__ = (2*(phi_t/rT))*((1/(exp(((0.5*parm_pp)*rT)/phi_t)-exp(((-0.5*parm_pp)*rT)/phi_t)))*(exp(((0.5*parm_pp)*rT)/phi_t)*(((0.5*parm_pp)*d_rT_d_temp_dtn2__)/phi_t-(((0.5*parm_pp)*rT)*d_phi_t_d_temp_dtn2__)/phi_t^2)-exp(((-0.5*parm_pp)*rT)/phi_t)*(((-0.5*parm_pp)*d_rT_d_temp_dtn2__)/phi_t-(((-0.5*parm_pp)*rT)*d_phi_t_d_temp_dtn2__)/phi_t^2)))+(2*(d_phi_t_d_temp_dtn2__/rT-(phi_t*d_rT_d_temp_dtn2__)/rT^2))*log(exp(((0.5*parm_pp)*rT)/phi_t)-exp(((-0.5*parm_pp)*rT)/phi_t));
        psiio = (2*(phi_t/rT))*log(exp(((0.5*parm_pp)*rT)/phi_t)-exp(((-0.5*parm_pp)*rT)/phi_t));
            d_psiin_d_temp_dtn2__ = ((psiio*d_rT_d_temp_dtn2__+d_psiio_d_temp_dtn2__*rT)-((3*phi_t)*((1/rT)*d_rT_d_temp_dtn2__)+(3*d_phi_t_d_temp_dtn2__)*log(rT)))-(parm_ea*(d_rT_d_temp_dtn2__));
        psiin = (psiio*rT-(3*phi_t)*log(rT))-parm_ea*(rT-1);
            d_pp_t_d_temp_dtn2__ = d_psiin_d_temp_dtn2__+((2*phi_t)*((1/(0.5*(1+sqrt(1+4*exp(-psiin/phi_t)))))*(0.5*((1/(2*sqrt(1+4*exp(-psiin/phi_t))))*((4*(exp(-psiin/phi_t)*(-d_psiin_d_temp_dtn2__/phi_t-(-psiin*d_phi_t_d_temp_dtn2__)/phi_t^2)))))))+(2*d_phi_t_d_temp_dtn2__)*log(0.5*(1+sqrt(1+4*exp(-psiin/phi_t)))));
        pp_t = psiin+(2*phi_t)*log(0.5*(1+sqrt(1+4*exp(-psiin/phi_t))));
            d_cjp_t_d_temp_dtn2__ = parm_cjp*(d_pow_vapp_d_arg1__(parm_pp/pp_t, parm_mp)*(-(parm_pp*d_pp_t_d_temp_dtn2__)/pp_t^2));
        cjp_t = parm_cjp*pow_vapp(parm_pp/pp_t, parm_mp);
    else
            d_pp_t_d_temp_dtn2__ = 0;
        pp_t = parm_pp;
            d_cjp_t_d_temp_dtn2__ = 0;
        cjp_t = 0;
    end
    if parm_vbv>0
            d_vbv_t_d_temp_dtn2__ = parm_vbv*((dT*((d_dT_d_temp_dtn2__*parm_tc2vbv))+d_dT_d_temp_dtn2__*(parm_tc1vbv+dT*parm_tc2vbv)));
        vbv_t = parm_vbv*(1+dT*(parm_tc1vbv+dT*parm_tc2vbv));
            d_vbv_t_d_temp_dtn2__ = qmcol_vapp(vbv_t>0, d_vbv_t_d_temp_dtn2__, 0);
        vbv_t = qmcol_vapp(vbv_t>0, vbv_t, 0);
            d_nbv_t_d_temp_dtn2__ = parm_nbv*((parm_tc1nbv*d_dT_d_temp_dtn2__));
        nbv_t = parm_nbv*(1+parm_tc1nbv*dT);
            d_vmax_b_d_temp_dtn2__ = (nbv_t*phi_t)*((1/(exp(-vbv_t/(nbv_t*phi_t))+parm_imax/parm_ibv))*(exp(-vbv_t/(nbv_t*phi_t))*(-d_vbv_t_d_temp_dtn2__/(nbv_t*phi_t)-(-vbv_t*(nbv_t*d_phi_t_d_temp_dtn2__+d_nbv_t_d_temp_dtn2__*phi_t))/(nbv_t*phi_t)^2)))+(nbv_t*d_phi_t_d_temp_dtn2__+d_nbv_t_d_temp_dtn2__*phi_t)*log(exp(-vbv_t/(nbv_t*phi_t))+parm_imax/parm_ibv);
        vmax_b = (nbv_t*phi_t)*log(exp(-vbv_t/(nbv_t*phi_t))+parm_imax/parm_ibv);
    else
            d_vbv_t_d_temp_dtn2__ = 0;
        vbv_t = parm_vbv;
            d_nbv_t_d_temp_dtn2__ = 0;
        nbv_t = parm_nbv;
            d_vmax_b_d_temp_dtn2__ = 0;
        vmax_b = 1;
    end
    if parm_ecrit>0&&~parm_sw_lin
            d_ecorn_t_d_temp_dtn2__ = (parm_ecorn*tcvsat)*d_tcr_d_temp_dtn2__+(parm_ecorn*d_tcvsat_d_temp_dtn2__)*tcr;
        ecorn_t = (parm_ecorn*tcvsat)*tcr;
            d_ecrit_t_d_temp_dtn2__ = (parm_ecrit*tcvsat)*d_tcr_d_temp_dtn2__+(parm_ecrit*d_tcvsat_d_temp_dtn2__)*tcr;
        ecrit_t = (parm_ecrit*tcvsat)*tcr;
            d_ecrneff_d_temp_dtn2__ = (1/(2*sqrt(ecorn_t*ecorn_t+(((4*parm_du)*parm_du)*ecrit_t)*ecrit_t)))*((ecorn_t*d_ecorn_t_d_temp_dtn2__+d_ecorn_t_d_temp_dtn2__*ecorn_t)+((((4*parm_du)*parm_du)*ecrit_t)*d_ecrit_t_d_temp_dtn2__+(((4*parm_du)*parm_du)*d_ecrit_t_d_temp_dtn2__)*ecrit_t))-((2*parm_du)*d_ecrit_t_d_temp_dtn2__);
        ecrneff = sqrt(ecorn_t*ecorn_t+(((4*parm_du)*parm_du)*ecrit_t)*ecrit_t)-(2*parm_du)*ecrit_t;
            d_dufctr_d_temp_dtn2__ = (parm_du*d_ecrneff_d_temp_dtn2__)/ecrit_t-((parm_du*ecrneff)*d_ecrit_t_d_temp_dtn2__)/ecrit_t^2;
        dufctr = (parm_du*ecrneff)/ecrit_t;
            d_uoff_d_temp_dtn2__ = (1/(2*sqrt((ecrneff*ecrneff)/(ecrit_t*ecrit_t)+4*dufctr)))*(((ecrneff*d_ecrneff_d_temp_dtn2__+d_ecrneff_d_temp_dtn2__*ecrneff)/(ecrit_t*ecrit_t)-((ecrneff*ecrneff)*(ecrit_t*d_ecrit_t_d_temp_dtn2__+d_ecrit_t_d_temp_dtn2__*ecrit_t))/(ecrit_t*ecrit_t)^2)+(4*d_dufctr_d_temp_dtn2__));
        uoff = sqrt((ecrneff*ecrneff)/(ecrit_t*ecrit_t)+4*dufctr);
            d_de_d_temp_dtn2__ = d_ecrit_t_d_temp_dtn2__-d_ecorn_t_d_temp_dtn2__;
        de = ecrit_t-ecorn_t;
            d_iecrit_d_temp_dtn2__ = -(1*d_ecrit_t_d_temp_dtn2__)/ecrit_t^2;
        iecrit = 1/ecrit_t;
    else
            d_ecrneff_d_temp_dtn2__ = 0;
        ecrneff = 0;
            d_dufctr_d_temp_dtn2__ = 0;
        dufctr = 0;
            d_uoff_d_temp_dtn2__ = 0;
        uoff = 0;
            d_de_d_temp_dtn2__ = 0;
        de = 1000;
            d_iecrit_d_temp_dtn2__ = 0;
        iecrit = 0;
    end
        d_lde_d_temp_dtn2__ = leffE_um*d_de_d_temp_dtn2__;
    lde = leffE_um*de;
    if lde>100000
            d_lde_d_temp_dtn2__ = 0;
        lde = 100000;
    end
    if Vb<0
            d_sdFlip_d_v_n1n2__ = 0;
            d_sdFlip_d_v_i2i1__ = 0;
        sdFlip = -1;
            d_V1ci_d_v_n1n2__ = -d_Vc2_d_v_n1n2__;
            d_V1ci_d_v_ncn2__ = -d_Vc2_d_v_ncn2__;
            d_V1ci_d_v_i2i1__ = -d_Vc2_d_v_i2i1__;
            d_V1ci_d_v_n1i1__ = -d_Vc2_d_v_n1i1__;
        V1ci = -Vc2;
            d_Vbi_d_v_n1n2__ = -d_Vb_d_v_n1n2__;
            d_Vbi_d_v_i2i1__ = -d_Vb_d_v_i2i1__;
        Vbi = -Vb;
    else
            d_sdFlip_d_v_n1n2__ = 0;
            d_sdFlip_d_v_i2i1__ = 0;
        sdFlip = 1;
            d_V1ci_d_v_n1n2__ = -d_Vc1_d_v_n1n2__;
            d_V1ci_d_v_ncn2__ = -d_Vc1_d_v_ncn2__;
            d_V1ci_d_v_i2i1__ = -d_Vc1_d_v_i2i1__;
            d_V1ci_d_v_n1i1__ = -d_Vc1_d_v_n1i1__;
        V1ci = -Vc1;
            d_Vbi_d_v_n1n2__ = d_Vb_d_v_n1n2__;
            d_Vbi_d_v_i2i1__ = d_Vb_d_v_i2i1__;
        Vbi = Vb;
    end
    if dibl1>0
            d_V1ci_d_v_n1n2__ = d_V1ci_d_v_n1n2__-(dibl1*d_Vbi_d_v_n1n2__);
            d_V1ci_d_v_ncn2__ = d_V1ci_d_v_ncn2__;
            d_V1ci_d_v_i2i1__ = d_V1ci_d_v_i2i1__-(dibl1*d_Vbi_d_v_i2i1__);
            d_V1ci_d_v_n1i1__ = d_V1ci_d_v_n1i1__;
        V1ci = V1ci-dibl1*Vbi;
    end
    if dibl2>0
            d_V1ci_d_v_n1n2__ = d_V1ci_d_v_n1n2__-(dibl2*(d_pow_vapp_d_arg1__(Vbi+parm_dibl2v, parm_dibl2e)*(d_Vbi_d_v_n1n2__)));
            d_V1ci_d_v_ncn2__ = d_V1ci_d_v_ncn2__;
            d_V1ci_d_v_i2i1__ = d_V1ci_d_v_i2i1__-(dibl2*(d_pow_vapp_d_arg1__(Vbi+parm_dibl2v, parm_dibl2e)*(d_Vbi_d_v_i2i1__)));
            d_V1ci_d_v_n1i1__ = d_V1ci_d_v_n1i1__;
        V1ci = V1ci-dibl2*(pow_vapp(Vbi+parm_dibl2v, parm_dibl2e)-dibl2o);
    end
    if V1ci>vpoe
            d_V1cl_d_v_n1n2__ = -(nsteff*((1/(1+exp((vpoe-V1ci)/nsteff)))*(exp((vpoe-V1ci)/nsteff)*((-d_V1ci_d_v_n1n2__)/nsteff))));
            d_V1cl_d_v_ncn2__ = -(nsteff*((1/(1+exp((vpoe-V1ci)/nsteff)))*(exp((vpoe-V1ci)/nsteff)*((-d_V1ci_d_v_ncn2__)/nsteff))));
            d_V1cl_d_v_i2i1__ = -(nsteff*((1/(1+exp((vpoe-V1ci)/nsteff)))*(exp((vpoe-V1ci)/nsteff)*((-d_V1ci_d_v_i2i1__)/nsteff))));
            d_V1cl_d_v_n1i1__ = -(nsteff*((1/(1+exp((vpoe-V1ci)/nsteff)))*(exp((vpoe-V1ci)/nsteff)*((-d_V1ci_d_v_n1i1__)/nsteff))));
        V1cl = vpoe-nsteff*log(1+exp((vpoe-V1ci)/nsteff));
    else
            d_V1cl_d_v_n1n2__ = d_V1ci_d_v_n1n2__-(nsteff*((1/(1+exp((V1ci-vpoe)/nsteff)))*(exp((V1ci-vpoe)/nsteff)*((d_V1ci_d_v_n1n2__)/nsteff))));
            d_V1cl_d_v_ncn2__ = d_V1ci_d_v_ncn2__-(nsteff*((1/(1+exp((V1ci-vpoe)/nsteff)))*(exp((V1ci-vpoe)/nsteff)*((d_V1ci_d_v_ncn2__)/nsteff))));
            d_V1cl_d_v_i2i1__ = d_V1ci_d_v_i2i1__-(nsteff*((1/(1+exp((V1ci-vpoe)/nsteff)))*(exp((V1ci-vpoe)/nsteff)*((d_V1ci_d_v_i2i1__)/nsteff))));
            d_V1cl_d_v_n1i1__ = d_V1ci_d_v_n1i1__-(nsteff*((1/(1+exp((V1ci-vpoe)/nsteff)))*(exp((V1ci-vpoe)/nsteff)*((d_V1ci_d_v_n1i1__)/nsteff))));
        V1cl = V1ci-nsteff*log(1+exp((V1ci-vpoe)/nsteff));
    end
    if V1cl<-0.4*(dp+qmcol_vapp(Vbi<vpoe-V1cl, Vbi, vpoe-V1cl))
            d_V1c_d_v_n1n2__ = -0.4*(qmcol_vapp(Vbi<vpoe-V1cl, d_Vbi_d_v_n1n2__, -d_V1cl_d_v_n1n2__));
            d_V1c_d_v_ncn2__ = -0.4*(qmcol_vapp(Vbi<vpoe-V1cl, 0, -d_V1cl_d_v_ncn2__));
            d_V1c_d_v_i2i1__ = -0.4*(qmcol_vapp(Vbi<vpoe-V1cl, d_Vbi_d_v_i2i1__, -d_V1cl_d_v_i2i1__));
            d_V1c_d_v_n1i1__ = -0.4*(qmcol_vapp(Vbi<vpoe-V1cl, 0, -d_V1cl_d_v_n1i1__));
        V1c = -0.4*(dp+qmcol_vapp(Vbi<vpoe-V1cl, Vbi, vpoe-V1cl));
    else
            d_V1c_d_v_n1n2__ = d_V1cl_d_v_n1n2__;
            d_V1c_d_v_ncn2__ = d_V1cl_d_v_ncn2__;
            d_V1c_d_v_i2i1__ = d_V1cl_d_v_i2i1__;
            d_V1c_d_v_n1i1__ = d_V1cl_d_v_n1i1__;
        V1c = V1cl;
    end
        d_dpe_d_v_n1n2__ = (2*d_V1c_d_v_n1n2__);
        d_dpe_d_v_ncn2__ = (2*d_V1c_d_v_ncn2__);
        d_dpe_d_v_i2i1__ = (2*d_V1c_d_v_i2i1__);
        d_dpe_d_v_n1i1__ = (2*d_V1c_d_v_n1i1__);
    dpe = dp+2*V1c;
    if iecrit>0
            d_a0_d_v_n1n2__ = ((dfsq*dpe)*d_dpe_d_v_n1n2__+(dfsq*d_dpe_d_v_n1n2__)*dpe)-d_dpe_d_v_n1n2__;
            d_a0_d_v_ncn2__ = ((dfsq*dpe)*d_dpe_d_v_ncn2__+(dfsq*d_dpe_d_v_ncn2__)*dpe)-d_dpe_d_v_ncn2__;
            d_a0_d_v_i2i1__ = ((dfsq*dpe)*d_dpe_d_v_i2i1__+(dfsq*d_dpe_d_v_i2i1__)*dpe)-d_dpe_d_v_i2i1__;
            d_a0_d_v_n1i1__ = ((dfsq*dpe)*d_dpe_d_v_n1i1__+(dfsq*d_dpe_d_v_n1i1__)*dpe)-d_dpe_d_v_n1i1__;
            d_a0_d_temp_dtn2__ = 0;
        a0 = (dfsq*dpe)*dpe-dpe;
            d_a11_d_v_n1n2__ = ((3*dfsq)*d_dpe_d_v_n1n2__);
            d_a11_d_v_ncn2__ = ((3*dfsq)*d_dpe_d_v_ncn2__);
            d_a11_d_v_i2i1__ = ((3*dfsq)*d_dpe_d_v_i2i1__);
            d_a11_d_v_n1i1__ = ((3*dfsq)*d_dpe_d_v_n1i1__);
            d_a11_d_temp_dtn2__ = 0;
        a11 = -1+(3*dfsq)*dpe;
            d_a22_d_v_n1n2__ = dfsq*((d_dpe_d_v_n1n2__/lde));
            d_a22_d_v_ncn2__ = dfsq*((d_dpe_d_v_ncn2__/lde));
            d_a22_d_v_i2i1__ = dfsq*((d_dpe_d_v_i2i1__/lde));
            d_a22_d_v_n1i1__ = dfsq*((d_dpe_d_v_n1i1__/lde));
            d_a22_d_temp_dtn2__ = dfsq*((-(dpe*d_lde_d_temp_dtn2__)/lde^2));
        a22 = dfsq*(9/4+dpe/lde);
            d_a3_d_temp_dtn2__ = -((1.5*dfsq)*d_lde_d_temp_dtn2__)/lde^2;
        a3 = (1.5*dfsq)/lde;
            d_a4_d_temp_dtn2__ = ((4*lde)*d_lde_d_temp_dtn2__+(4*d_lde_d_temp_dtn2__)*lde)/dfsq;
        a4 = ((4*lde)*lde)/dfsq;
            d_dvar_d_v_n1n2__ = d_a0_d_v_n1n2__*a4;
            d_dvar_d_v_ncn2__ = d_a0_d_v_ncn2__*a4;
            d_dvar_d_v_i2i1__ = d_a0_d_v_i2i1__*a4;
            d_dvar_d_v_n1i1__ = d_a0_d_v_n1i1__*a4;
            d_dvar_d_temp_dtn2__ = a0*d_a4_d_temp_dtn2__+d_a0_d_temp_dtn2__*a4;
        dvar = a0*a4;
            d_cvar_d_v_n1n2__ = d_a11_d_v_n1n2__*a4;
            d_cvar_d_v_ncn2__ = d_a11_d_v_ncn2__*a4;
            d_cvar_d_v_i2i1__ = d_a11_d_v_i2i1__*a4;
            d_cvar_d_v_n1i1__ = d_a11_d_v_n1i1__*a4;
            d_cvar_d_temp_dtn2__ = a11*d_a4_d_temp_dtn2__+d_a11_d_temp_dtn2__*a4;
        cvar = a11*a4;
            d_bvar_d_v_n1n2__ = d_a22_d_v_n1n2__*a4;
            d_bvar_d_v_ncn2__ = d_a22_d_v_ncn2__*a4;
            d_bvar_d_v_i2i1__ = d_a22_d_v_i2i1__*a4;
            d_bvar_d_v_n1i1__ = d_a22_d_v_n1i1__*a4;
            d_bvar_d_temp_dtn2__ = a22*d_a4_d_temp_dtn2__+d_a22_d_temp_dtn2__*a4;
        bvar = a22*a4;
            d_avar_d_temp_dtn2__ = a3*d_a4_d_temp_dtn2__+d_a3_d_temp_dtn2__*a4;
        avar = a3*a4;
            d_asq_d_temp_dtn2__ = avar*d_avar_d_temp_dtn2__+d_avar_d_temp_dtn2__*avar;
        asq = avar*avar;
            d_pvar_d_v_n1n2__ = -d_bvar_d_v_n1n2__;
            d_pvar_d_v_ncn2__ = -d_bvar_d_v_ncn2__;
            d_pvar_d_v_i2i1__ = -d_bvar_d_v_i2i1__;
            d_pvar_d_v_n1i1__ = -d_bvar_d_v_n1i1__;
            d_pvar_d_temp_dtn2__ = -d_bvar_d_temp_dtn2__;
        pvar = -bvar;
            d_qvar_d_v_n1n2__ = (avar*d_cvar_d_v_n1n2__)-(4*d_dvar_d_v_n1n2__);
            d_qvar_d_v_ncn2__ = (avar*d_cvar_d_v_ncn2__)-(4*d_dvar_d_v_ncn2__);
            d_qvar_d_v_i2i1__ = (avar*d_cvar_d_v_i2i1__)-(4*d_dvar_d_v_i2i1__);
            d_qvar_d_v_n1i1__ = (avar*d_cvar_d_v_n1i1__)-(4*d_dvar_d_v_n1i1__);
            d_qvar_d_temp_dtn2__ = (avar*d_cvar_d_temp_dtn2__+d_avar_d_temp_dtn2__*cvar)-(4*d_dvar_d_temp_dtn2__);
        qvar = avar*cvar-4*dvar;
            d_rvar_d_v_n1n2__ = (((4*bvar)*d_dvar_d_v_n1n2__+(4*d_bvar_d_v_n1n2__)*dvar)-(cvar*d_cvar_d_v_n1n2__+d_cvar_d_v_n1n2__*cvar))-(d_dvar_d_v_n1n2__*asq);
            d_rvar_d_v_ncn2__ = (((4*bvar)*d_dvar_d_v_ncn2__+(4*d_bvar_d_v_ncn2__)*dvar)-(cvar*d_cvar_d_v_ncn2__+d_cvar_d_v_ncn2__*cvar))-(d_dvar_d_v_ncn2__*asq);
            d_rvar_d_v_i2i1__ = (((4*bvar)*d_dvar_d_v_i2i1__+(4*d_bvar_d_v_i2i1__)*dvar)-(cvar*d_cvar_d_v_i2i1__+d_cvar_d_v_i2i1__*cvar))-(d_dvar_d_v_i2i1__*asq);
            d_rvar_d_v_n1i1__ = (((4*bvar)*d_dvar_d_v_n1i1__+(4*d_bvar_d_v_n1i1__)*dvar)-(cvar*d_cvar_d_v_n1i1__+d_cvar_d_v_n1i1__*cvar))-(d_dvar_d_v_n1i1__*asq);
            d_rvar_d_temp_dtn2__ = (((4*bvar)*d_dvar_d_temp_dtn2__+(4*d_bvar_d_temp_dtn2__)*dvar)-(cvar*d_cvar_d_temp_dtn2__+d_cvar_d_temp_dtn2__*cvar))-(dvar*d_asq_d_temp_dtn2__+d_dvar_d_temp_dtn2__*asq);
        rvar = ((4*bvar)*dvar-cvar*cvar)-dvar*asq;
            d_aa_d_v_n1n2__ = d_qvar_d_v_n1n2__-((pvar*d_pvar_d_v_n1n2__+d_pvar_d_v_n1n2__*pvar)*0.33333);
            d_aa_d_v_ncn2__ = d_qvar_d_v_ncn2__-((pvar*d_pvar_d_v_ncn2__+d_pvar_d_v_ncn2__*pvar)*0.33333);
            d_aa_d_v_i2i1__ = d_qvar_d_v_i2i1__-((pvar*d_pvar_d_v_i2i1__+d_pvar_d_v_i2i1__*pvar)*0.33333);
            d_aa_d_v_n1i1__ = d_qvar_d_v_n1i1__-((pvar*d_pvar_d_v_n1i1__+d_pvar_d_v_n1i1__*pvar)*0.33333);
            d_aa_d_temp_dtn2__ = d_qvar_d_temp_dtn2__-((pvar*d_pvar_d_temp_dtn2__+d_pvar_d_temp_dtn2__*pvar)*0.33333);
        aa = qvar-(pvar*pvar)*0.33333;
            d_bb_d_v_n1n2__ = d_rvar_d_v_n1n2__-((pvar*(d_qvar_d_v_n1n2__+(2*d_aa_d_v_n1n2__))+d_pvar_d_v_n1n2__*(qvar+2*aa))/9);
            d_bb_d_v_ncn2__ = d_rvar_d_v_ncn2__-((pvar*(d_qvar_d_v_ncn2__+(2*d_aa_d_v_ncn2__))+d_pvar_d_v_ncn2__*(qvar+2*aa))/9);
            d_bb_d_v_i2i1__ = d_rvar_d_v_i2i1__-((pvar*(d_qvar_d_v_i2i1__+(2*d_aa_d_v_i2i1__))+d_pvar_d_v_i2i1__*(qvar+2*aa))/9);
            d_bb_d_v_n1i1__ = d_rvar_d_v_n1i1__-((pvar*(d_qvar_d_v_n1i1__+(2*d_aa_d_v_n1i1__))+d_pvar_d_v_n1i1__*(qvar+2*aa))/9);
            d_bb_d_temp_dtn2__ = d_rvar_d_temp_dtn2__-((pvar*(d_qvar_d_temp_dtn2__+(2*d_aa_d_temp_dtn2__))+d_pvar_d_temp_dtn2__*(qvar+2*aa))/9);
        bb = rvar-(pvar*(qvar+2*aa))/9;
            d_aa3d27_d_v_n1n2__ = ((aa*aa)*d_aa_d_v_n1n2__+(aa*d_aa_d_v_n1n2__+d_aa_d_v_n1n2__*aa)*aa)/27;
            d_aa3d27_d_v_ncn2__ = ((aa*aa)*d_aa_d_v_ncn2__+(aa*d_aa_d_v_ncn2__+d_aa_d_v_ncn2__*aa)*aa)/27;
            d_aa3d27_d_v_i2i1__ = ((aa*aa)*d_aa_d_v_i2i1__+(aa*d_aa_d_v_i2i1__+d_aa_d_v_i2i1__*aa)*aa)/27;
            d_aa3d27_d_v_n1i1__ = ((aa*aa)*d_aa_d_v_n1i1__+(aa*d_aa_d_v_n1i1__+d_aa_d_v_n1i1__*aa)*aa)/27;
            d_aa3d27_d_temp_dtn2__ = ((aa*aa)*d_aa_d_temp_dtn2__+(aa*d_aa_d_temp_dtn2__+d_aa_d_temp_dtn2__*aa)*aa)/27;
        aa3d27 = ((aa*aa)*aa)/27;
            d_dd_d_v_n1n2__ = ((0.25*bb)*d_bb_d_v_n1n2__+(0.25*d_bb_d_v_n1n2__)*bb)+d_aa3d27_d_v_n1n2__;
            d_dd_d_v_ncn2__ = ((0.25*bb)*d_bb_d_v_ncn2__+(0.25*d_bb_d_v_ncn2__)*bb)+d_aa3d27_d_v_ncn2__;
            d_dd_d_v_i2i1__ = ((0.25*bb)*d_bb_d_v_i2i1__+(0.25*d_bb_d_v_i2i1__)*bb)+d_aa3d27_d_v_i2i1__;
            d_dd_d_v_n1i1__ = ((0.25*bb)*d_bb_d_v_n1i1__+(0.25*d_bb_d_v_n1i1__)*bb)+d_aa3d27_d_v_n1i1__;
            d_dd_d_temp_dtn2__ = ((0.25*bb)*d_bb_d_temp_dtn2__+(0.25*d_bb_d_temp_dtn2__)*bb)+d_aa3d27_d_temp_dtn2__;
        dd = (0.25*bb)*bb+aa3d27;
            d_sd_d_v_n1n2__ = (1/(2*sqrt(dd)))*d_dd_d_v_n1n2__;
            d_sd_d_v_ncn2__ = (1/(2*sqrt(dd)))*d_dd_d_v_ncn2__;
            d_sd_d_v_i2i1__ = (1/(2*sqrt(dd)))*d_dd_d_v_i2i1__;
            d_sd_d_v_n1i1__ = (1/(2*sqrt(dd)))*d_dd_d_v_n1i1__;
            d_sd_d_temp_dtn2__ = (1/(2*sqrt(dd)))*d_dd_d_temp_dtn2__;
        sd = sqrt(dd);
        if bb<0
                d_rp_d_v_n1n2__ = (-0.5*d_bb_d_v_n1n2__)+d_sd_d_v_n1n2__;
                d_rp_d_v_ncn2__ = (-0.5*d_bb_d_v_ncn2__)+d_sd_d_v_ncn2__;
                d_rp_d_v_i2i1__ = (-0.5*d_bb_d_v_i2i1__)+d_sd_d_v_i2i1__;
                d_rp_d_v_n1i1__ = (-0.5*d_bb_d_v_n1i1__)+d_sd_d_v_n1i1__;
                d_rp_d_temp_dtn2__ = (-0.5*d_bb_d_temp_dtn2__)+d_sd_d_temp_dtn2__;
            rp = -0.5*bb+sd;
                d_rm_d_v_n1n2__ = -d_aa3d27_d_v_n1n2__/rp-(-aa3d27*d_rp_d_v_n1n2__)/rp^2;
                d_rm_d_v_ncn2__ = -d_aa3d27_d_v_ncn2__/rp-(-aa3d27*d_rp_d_v_ncn2__)/rp^2;
                d_rm_d_v_i2i1__ = -d_aa3d27_d_v_i2i1__/rp-(-aa3d27*d_rp_d_v_i2i1__)/rp^2;
                d_rm_d_v_n1i1__ = -d_aa3d27_d_v_n1i1__/rp-(-aa3d27*d_rp_d_v_n1i1__)/rp^2;
                d_rm_d_temp_dtn2__ = -d_aa3d27_d_temp_dtn2__/rp-(-aa3d27*d_rp_d_temp_dtn2__)/rp^2;
            rm = -aa3d27/rp;
        else
                d_rm_d_v_n1n2__ = (-0.5*d_bb_d_v_n1n2__)-d_sd_d_v_n1n2__;
                d_rm_d_v_ncn2__ = (-0.5*d_bb_d_v_ncn2__)-d_sd_d_v_ncn2__;
                d_rm_d_v_i2i1__ = (-0.5*d_bb_d_v_i2i1__)-d_sd_d_v_i2i1__;
                d_rm_d_v_n1i1__ = (-0.5*d_bb_d_v_n1i1__)-d_sd_d_v_n1i1__;
                d_rm_d_temp_dtn2__ = (-0.5*d_bb_d_temp_dtn2__)-d_sd_d_temp_dtn2__;
            rm = -0.5*bb-sd;
                d_rp_d_v_n1n2__ = -d_aa3d27_d_v_n1n2__/rm-(-aa3d27*d_rm_d_v_n1n2__)/rm^2;
                d_rp_d_v_ncn2__ = -d_aa3d27_d_v_ncn2__/rm-(-aa3d27*d_rm_d_v_ncn2__)/rm^2;
                d_rp_d_v_i2i1__ = -d_aa3d27_d_v_i2i1__/rm-(-aa3d27*d_rm_d_v_i2i1__)/rm^2;
                d_rp_d_v_n1i1__ = -d_aa3d27_d_v_n1i1__/rm-(-aa3d27*d_rm_d_v_n1i1__)/rm^2;
                d_rp_d_temp_dtn2__ = -d_aa3d27_d_temp_dtn2__/rm-(-aa3d27*d_rm_d_temp_dtn2__)/rm^2;
            rp = -aa3d27/rm;
        end
        if rp>1e-06
                d_avar2_d_v_n1n2__ = d_pow_vapp_d_arg1__(rp, 0.33333)*d_rp_d_v_n1n2__;
                d_avar2_d_v_ncn2__ = d_pow_vapp_d_arg1__(rp, 0.33333)*d_rp_d_v_ncn2__;
                d_avar2_d_v_i2i1__ = d_pow_vapp_d_arg1__(rp, 0.33333)*d_rp_d_v_i2i1__;
                d_avar2_d_v_n1i1__ = d_pow_vapp_d_arg1__(rp, 0.33333)*d_rp_d_v_n1i1__;
                d_avar2_d_temp_dtn2__ = d_pow_vapp_d_arg1__(rp, 0.33333)*d_rp_d_temp_dtn2__;
            avar2 = pow_vapp(rp, 0.33333);
        else
            if rp<-1e-06
                    d_avar2_d_v_n1n2__ = -(d_pow_vapp_d_arg1__(-rp, 0.33333)*-d_rp_d_v_n1n2__);
                    d_avar2_d_v_ncn2__ = -(d_pow_vapp_d_arg1__(-rp, 0.33333)*-d_rp_d_v_ncn2__);
                    d_avar2_d_v_i2i1__ = -(d_pow_vapp_d_arg1__(-rp, 0.33333)*-d_rp_d_v_i2i1__);
                    d_avar2_d_v_n1i1__ = -(d_pow_vapp_d_arg1__(-rp, 0.33333)*-d_rp_d_v_n1i1__);
                    d_avar2_d_temp_dtn2__ = -(d_pow_vapp_d_arg1__(-rp, 0.33333)*-d_rp_d_temp_dtn2__);
                avar2 = -pow_vapp(-rp, 0.33333);
            else
                    d_avar2_d_v_n1n2__ = 10000*d_rp_d_v_n1n2__;
                    d_avar2_d_v_ncn2__ = 10000*d_rp_d_v_ncn2__;
                    d_avar2_d_v_i2i1__ = 10000*d_rp_d_v_i2i1__;
                    d_avar2_d_v_n1i1__ = 10000*d_rp_d_v_n1i1__;
                    d_avar2_d_temp_dtn2__ = 10000*d_rp_d_temp_dtn2__;
                avar2 = 10000*rp;
            end
        end
        if rm>1e-06
                d_bvar2_d_v_n1n2__ = d_pow_vapp_d_arg1__(rm, 0.33333)*d_rm_d_v_n1n2__;
                d_bvar2_d_v_ncn2__ = d_pow_vapp_d_arg1__(rm, 0.33333)*d_rm_d_v_ncn2__;
                d_bvar2_d_v_i2i1__ = d_pow_vapp_d_arg1__(rm, 0.33333)*d_rm_d_v_i2i1__;
                d_bvar2_d_v_n1i1__ = d_pow_vapp_d_arg1__(rm, 0.33333)*d_rm_d_v_n1i1__;
                d_bvar2_d_temp_dtn2__ = d_pow_vapp_d_arg1__(rm, 0.33333)*d_rm_d_temp_dtn2__;
            bvar2 = pow_vapp(rm, 0.33333);
        else
            if rm<-1e-06
                    d_bvar2_d_v_n1n2__ = -(d_pow_vapp_d_arg1__(-rm, 0.33333)*-d_rm_d_v_n1n2__);
                    d_bvar2_d_v_ncn2__ = -(d_pow_vapp_d_arg1__(-rm, 0.33333)*-d_rm_d_v_ncn2__);
                    d_bvar2_d_v_i2i1__ = -(d_pow_vapp_d_arg1__(-rm, 0.33333)*-d_rm_d_v_i2i1__);
                    d_bvar2_d_v_n1i1__ = -(d_pow_vapp_d_arg1__(-rm, 0.33333)*-d_rm_d_v_n1i1__);
                    d_bvar2_d_temp_dtn2__ = -(d_pow_vapp_d_arg1__(-rm, 0.33333)*-d_rm_d_temp_dtn2__);
                bvar2 = -pow_vapp(-rm, 0.33333);
            else
                    d_bvar2_d_v_n1n2__ = 10000*d_rm_d_v_n1n2__;
                    d_bvar2_d_v_ncn2__ = 10000*d_rm_d_v_ncn2__;
                    d_bvar2_d_v_i2i1__ = 10000*d_rm_d_v_i2i1__;
                    d_bvar2_d_v_n1i1__ = 10000*d_rm_d_v_n1i1__;
                    d_bvar2_d_temp_dtn2__ = 10000*d_rm_d_temp_dtn2__;
                bvar2 = 10000*rm;
            end
        end
            d_yvar_d_v_n1n2__ = (d_avar2_d_v_n1n2__+d_bvar2_d_v_n1n2__)-(d_pvar_d_v_n1n2__*0.33333);
            d_yvar_d_v_ncn2__ = (d_avar2_d_v_ncn2__+d_bvar2_d_v_ncn2__)-(d_pvar_d_v_ncn2__*0.33333);
            d_yvar_d_v_i2i1__ = (d_avar2_d_v_i2i1__+d_bvar2_d_v_i2i1__)-(d_pvar_d_v_i2i1__*0.33333);
            d_yvar_d_v_n1i1__ = (d_avar2_d_v_n1i1__+d_bvar2_d_v_n1i1__)-(d_pvar_d_v_n1i1__*0.33333);
            d_yvar_d_temp_dtn2__ = (d_avar2_d_temp_dtn2__+d_bvar2_d_temp_dtn2__)-(d_pvar_d_temp_dtn2__*0.33333);
        yvar = (avar2+bvar2)-pvar*0.33333;
            d_rvar_d_v_n1n2__ = (1/(2*sqrt((0.25*asq-bvar)+yvar)))*((-d_bvar_d_v_n1n2__)+d_yvar_d_v_n1n2__);
            d_rvar_d_v_ncn2__ = (1/(2*sqrt((0.25*asq-bvar)+yvar)))*((-d_bvar_d_v_ncn2__)+d_yvar_d_v_ncn2__);
            d_rvar_d_v_i2i1__ = (1/(2*sqrt((0.25*asq-bvar)+yvar)))*((-d_bvar_d_v_i2i1__)+d_yvar_d_v_i2i1__);
            d_rvar_d_v_n1i1__ = (1/(2*sqrt((0.25*asq-bvar)+yvar)))*((-d_bvar_d_v_n1i1__)+d_yvar_d_v_n1i1__);
            d_rvar_d_temp_dtn2__ = (1/(2*sqrt((0.25*asq-bvar)+yvar)))*(((0.25*d_asq_d_temp_dtn2__)-d_bvar_d_temp_dtn2__)+d_yvar_d_temp_dtn2__);
        rvar = sqrt((0.25*asq-bvar)+yvar);
            d_val1_d_v_n1n2__ = (-(rvar*d_rvar_d_v_n1n2__+d_rvar_d_v_n1n2__*rvar))-(2*d_bvar_d_v_n1n2__);
            d_val1_d_v_ncn2__ = (-(rvar*d_rvar_d_v_ncn2__+d_rvar_d_v_ncn2__*rvar))-(2*d_bvar_d_v_ncn2__);
            d_val1_d_v_i2i1__ = (-(rvar*d_rvar_d_v_i2i1__+d_rvar_d_v_i2i1__*rvar))-(2*d_bvar_d_v_i2i1__);
            d_val1_d_v_n1i1__ = (-(rvar*d_rvar_d_v_n1i1__+d_rvar_d_v_n1i1__*rvar))-(2*d_bvar_d_v_n1i1__);
            d_val1_d_temp_dtn2__ = ((0.75*d_asq_d_temp_dtn2__)-(rvar*d_rvar_d_temp_dtn2__+d_rvar_d_temp_dtn2__*rvar))-(2*d_bvar_d_temp_dtn2__);
        val1 = (0.75*asq-rvar*rvar)-2*bvar;
            d_val2_d_v_n1n2__ = (((avar*d_bvar_d_v_n1n2__)-(2*d_cvar_d_v_n1n2__)))/rvar-(((avar*bvar-2*cvar)-(0.25*asq)*avar)*d_rvar_d_v_n1n2__)/rvar^2;
            d_val2_d_v_ncn2__ = (((avar*d_bvar_d_v_ncn2__)-(2*d_cvar_d_v_ncn2__)))/rvar-(((avar*bvar-2*cvar)-(0.25*asq)*avar)*d_rvar_d_v_ncn2__)/rvar^2;
            d_val2_d_v_i2i1__ = (((avar*d_bvar_d_v_i2i1__)-(2*d_cvar_d_v_i2i1__)))/rvar-(((avar*bvar-2*cvar)-(0.25*asq)*avar)*d_rvar_d_v_i2i1__)/rvar^2;
            d_val2_d_v_n1i1__ = (((avar*d_bvar_d_v_n1i1__)-(2*d_cvar_d_v_n1i1__)))/rvar-(((avar*bvar-2*cvar)-(0.25*asq)*avar)*d_rvar_d_v_n1i1__)/rvar^2;
            d_val2_d_temp_dtn2__ = (((avar*d_bvar_d_temp_dtn2__+d_avar_d_temp_dtn2__*bvar)-(2*d_cvar_d_temp_dtn2__))-((0.25*asq)*d_avar_d_temp_dtn2__+(0.25*d_asq_d_temp_dtn2__)*avar))/rvar-(((avar*bvar-2*cvar)-(0.25*asq)*avar)*d_rvar_d_temp_dtn2__)/rvar^2;
        val2 = ((avar*bvar-2*cvar)-(0.25*asq)*avar)/rvar;
            d_arg1_d_v_n1n2__ = d_val1_d_v_n1n2__+d_val2_d_v_n1n2__;
            d_arg1_d_v_ncn2__ = d_val1_d_v_ncn2__+d_val2_d_v_ncn2__;
            d_arg1_d_v_i2i1__ = d_val1_d_v_i2i1__+d_val2_d_v_i2i1__;
            d_arg1_d_v_n1i1__ = d_val1_d_v_n1i1__+d_val2_d_v_n1i1__;
            d_arg1_d_temp_dtn2__ = d_val1_d_temp_dtn2__+d_val2_d_temp_dtn2__;
        arg1 = val1+val2;
        if arg1>0
                d_dore_d_v_n1n2__ = (1/(2*sqrt(arg1)))*d_arg1_d_v_n1n2__;
                d_dore_d_v_ncn2__ = (1/(2*sqrt(arg1)))*d_arg1_d_v_ncn2__;
                d_dore_d_v_i2i1__ = (1/(2*sqrt(arg1)))*d_arg1_d_v_i2i1__;
                d_dore_d_v_n1i1__ = (1/(2*sqrt(arg1)))*d_arg1_d_v_n1i1__;
                d_dore_d_temp_dtn2__ = (1/(2*sqrt(arg1)))*d_arg1_d_temp_dtn2__;
            dore = sqrt(arg1);
                d_Vsat_d_v_n1n2__ = (0.5*(d_dore_d_v_n1n2__+d_rvar_d_v_n1n2__));
                d_Vsat_d_v_ncn2__ = (0.5*(d_dore_d_v_ncn2__+d_rvar_d_v_ncn2__));
                d_Vsat_d_v_i2i1__ = (0.5*(d_dore_d_v_i2i1__+d_rvar_d_v_i2i1__));
                d_Vsat_d_v_n1i1__ = (0.5*(d_dore_d_v_n1i1__+d_rvar_d_v_n1i1__));
                d_Vsat_d_temp_dtn2__ = (-0.25*d_avar_d_temp_dtn2__)+(0.5*(d_dore_d_temp_dtn2__+d_rvar_d_temp_dtn2__));
            Vsat = -0.25*avar+0.5*(dore+rvar);
        else
                d_arg2_d_v_n1n2__ = d_val1_d_v_n1n2__-d_val2_d_v_n1n2__;
                d_arg2_d_v_ncn2__ = d_val1_d_v_ncn2__-d_val2_d_v_ncn2__;
                d_arg2_d_v_i2i1__ = d_val1_d_v_i2i1__-d_val2_d_v_i2i1__;
                d_arg2_d_v_n1i1__ = d_val1_d_v_n1i1__-d_val2_d_v_n1i1__;
                d_arg2_d_temp_dtn2__ = d_val1_d_temp_dtn2__-d_val2_d_temp_dtn2__;
            arg2 = val1-val2;
                d_dore_d_v_n1n2__ = (1/(2*sqrt(sqrt(arg2*arg2+0.0001))))*((1/(2*sqrt(arg2*arg2+0.0001)))*((arg2*d_arg2_d_v_n1n2__+d_arg2_d_v_n1n2__*arg2)));
                d_dore_d_v_ncn2__ = (1/(2*sqrt(sqrt(arg2*arg2+0.0001))))*((1/(2*sqrt(arg2*arg2+0.0001)))*((arg2*d_arg2_d_v_ncn2__+d_arg2_d_v_ncn2__*arg2)));
                d_dore_d_v_i2i1__ = (1/(2*sqrt(sqrt(arg2*arg2+0.0001))))*((1/(2*sqrt(arg2*arg2+0.0001)))*((arg2*d_arg2_d_v_i2i1__+d_arg2_d_v_i2i1__*arg2)));
                d_dore_d_v_n1i1__ = (1/(2*sqrt(sqrt(arg2*arg2+0.0001))))*((1/(2*sqrt(arg2*arg2+0.0001)))*((arg2*d_arg2_d_v_n1i1__+d_arg2_d_v_n1i1__*arg2)));
                d_dore_d_temp_dtn2__ = (1/(2*sqrt(sqrt(arg2*arg2+0.0001))))*((1/(2*sqrt(arg2*arg2+0.0001)))*((arg2*d_arg2_d_temp_dtn2__+d_arg2_d_temp_dtn2__*arg2)));
            dore = sqrt(sqrt(arg2*arg2+0.0001));
                d_Vsat_d_v_n1n2__ = (0.5*(d_dore_d_v_n1n2__-d_rvar_d_v_n1n2__));
                d_Vsat_d_v_ncn2__ = (0.5*(d_dore_d_v_ncn2__-d_rvar_d_v_ncn2__));
                d_Vsat_d_v_i2i1__ = (0.5*(d_dore_d_v_i2i1__-d_rvar_d_v_i2i1__));
                d_Vsat_d_v_n1i1__ = (0.5*(d_dore_d_v_n1i1__-d_rvar_d_v_n1i1__));
                d_Vsat_d_temp_dtn2__ = (-0.25*d_avar_d_temp_dtn2__)+(0.5*(d_dore_d_temp_dtn2__-d_rvar_d_temp_dtn2__));
            Vsat = -0.25*avar+0.5*(dore-rvar);
        end
    else
        if V1c>V1cx
                d_tmp_d_v_n1n2__ = dfsq*(-d_V1c_d_v_n1n2__);
                d_tmp_d_v_ncn2__ = dfsq*(-d_V1c_d_v_ncn2__);
                d_tmp_d_v_i2i1__ = dfsq*(-d_V1c_d_v_i2i1__);
                d_tmp_d_v_n1i1__ = dfsq*(-d_V1c_d_v_n1i1__);
                d_tmp_d_temp_dtn2__ = 0;
            tmp = dfsq*(vpo-V1c);
                d_Vsat_d_v_n1n2__ = ((2*(1-2*tmp))*(-d_V1c_d_v_n1n2__)+(2*(-(2*d_tmp_d_v_n1n2__)))*(vpo-V1c))/((1-3*tmp)+sqrt(1-1.5*tmp))-(((2*(1-2*tmp))*(vpo-V1c))*((-(3*d_tmp_d_v_n1n2__))+(1/(2*sqrt(1-1.5*tmp)))*(-(1.5*d_tmp_d_v_n1n2__))))/((1-3*tmp)+sqrt(1-1.5*tmp))^2;
                d_Vsat_d_v_ncn2__ = ((2*(1-2*tmp))*(-d_V1c_d_v_ncn2__)+(2*(-(2*d_tmp_d_v_ncn2__)))*(vpo-V1c))/((1-3*tmp)+sqrt(1-1.5*tmp))-(((2*(1-2*tmp))*(vpo-V1c))*((-(3*d_tmp_d_v_ncn2__))+(1/(2*sqrt(1-1.5*tmp)))*(-(1.5*d_tmp_d_v_ncn2__))))/((1-3*tmp)+sqrt(1-1.5*tmp))^2;
                d_Vsat_d_v_i2i1__ = ((2*(1-2*tmp))*(-d_V1c_d_v_i2i1__)+(2*(-(2*d_tmp_d_v_i2i1__)))*(vpo-V1c))/((1-3*tmp)+sqrt(1-1.5*tmp))-(((2*(1-2*tmp))*(vpo-V1c))*((-(3*d_tmp_d_v_i2i1__))+(1/(2*sqrt(1-1.5*tmp)))*(-(1.5*d_tmp_d_v_i2i1__))))/((1-3*tmp)+sqrt(1-1.5*tmp))^2;
                d_Vsat_d_v_n1i1__ = ((2*(1-2*tmp))*(-d_V1c_d_v_n1i1__)+(2*(-(2*d_tmp_d_v_n1i1__)))*(vpo-V1c))/((1-3*tmp)+sqrt(1-1.5*tmp))-(((2*(1-2*tmp))*(vpo-V1c))*((-(3*d_tmp_d_v_n1i1__))+(1/(2*sqrt(1-1.5*tmp)))*(-(1.5*d_tmp_d_v_n1i1__))))/((1-3*tmp)+sqrt(1-1.5*tmp))^2;
                d_Vsat_d_temp_dtn2__ = ((2*(-(2*d_tmp_d_temp_dtn2__)))*(vpo-V1c))/((1-3*tmp)+sqrt(1-1.5*tmp))-(((2*(1-2*tmp))*(vpo-V1c))*((-(3*d_tmp_d_temp_dtn2__))+(1/(2*sqrt(1-1.5*tmp)))*(-(1.5*d_tmp_d_temp_dtn2__))))/((1-3*tmp)+sqrt(1-1.5*tmp))^2;
            Vsat = ((2*(1-2*tmp))*(vpo-V1c))/((1-3*tmp)+sqrt(1-1.5*tmp));
        else
                d_tmp_d_v_n1n2__ = (3*dfsq)*d_dpe_d_v_n1n2__;
                d_tmp_d_v_ncn2__ = (3*dfsq)*d_dpe_d_v_ncn2__;
                d_tmp_d_v_i2i1__ = (3*dfsq)*d_dpe_d_v_i2i1__;
                d_tmp_d_v_n1i1__ = (3*dfsq)*d_dpe_d_v_n1i1__;
                d_tmp_d_temp_dtn2__ = 0;
            tmp = (3*dfsq)*dpe;
                d_Vsat_d_v_n1n2__ = ((-d_tmp_d_v_n1n2__)+(1/(2*sqrt(1+tmp)))*(d_tmp_d_v_n1n2__))/(4.5*dfsq);
                d_Vsat_d_v_ncn2__ = ((-d_tmp_d_v_ncn2__)+(1/(2*sqrt(1+tmp)))*(d_tmp_d_v_ncn2__))/(4.5*dfsq);
                d_Vsat_d_v_i2i1__ = ((-d_tmp_d_v_i2i1__)+(1/(2*sqrt(1+tmp)))*(d_tmp_d_v_i2i1__))/(4.5*dfsq);
                d_Vsat_d_v_n1i1__ = ((-d_tmp_d_v_n1i1__)+(1/(2*sqrt(1+tmp)))*(d_tmp_d_v_n1i1__))/(4.5*dfsq);
                d_Vsat_d_temp_dtn2__ = ((-d_tmp_d_temp_dtn2__)+(1/(2*sqrt(1+tmp)))*(d_tmp_d_temp_dtn2__))/(4.5*dfsq);
            Vsat = ((1-tmp)+sqrt(1+tmp))/(4.5*dfsq);
        end
    end
    if parm_sw_accpo
            d_Vsatphi_d_v_n1n2__ = d_Vsat_d_v_n1n2__;
            d_Vsatphi_d_v_ncn2__ = d_Vsat_d_v_ncn2__;
            d_Vsatphi_d_v_i2i1__ = d_Vsat_d_v_i2i1__;
            d_Vsatphi_d_v_n1i1__ = d_Vsat_d_v_n1i1__;
            d_Vsatphi_d_temp_dtn2__ = d_Vsat_d_temp_dtn2__;
        Vsatphi = Vsat+phi_t0;
            d_Fsatphi_d_v_n1n2__ = df*((1/(2*sqrt(dpe+Vsat)))*(d_dpe_d_v_n1n2__+d_Vsat_d_v_n1n2__));
            d_Fsatphi_d_v_ncn2__ = df*((1/(2*sqrt(dpe+Vsat)))*(d_dpe_d_v_ncn2__+d_Vsat_d_v_ncn2__));
            d_Fsatphi_d_v_i2i1__ = df*((1/(2*sqrt(dpe+Vsat)))*(d_dpe_d_v_i2i1__+d_Vsat_d_v_i2i1__));
            d_Fsatphi_d_v_n1i1__ = df*((1/(2*sqrt(dpe+Vsat)))*(d_dpe_d_v_n1i1__+d_Vsat_d_v_n1i1__));
            d_Fsatphi_d_temp_dtn2__ = df*((1/(2*sqrt(dpe+Vsat)))*(d_Vsat_d_temp_dtn2__));
        Fsatphi = df*sqrt(dpe+Vsat);
        if iecrit>0
                d_fctrm_d_v_n1n2__ = (0.5*((d_Vsatphi_d_v_n1n2__/leffE_um)))*iecrit;
                d_fctrm_d_v_ncn2__ = (0.5*((d_Vsatphi_d_v_ncn2__/leffE_um)))*iecrit;
                d_fctrm_d_v_i2i1__ = (0.5*((d_Vsatphi_d_v_i2i1__/leffE_um)))*iecrit;
                d_fctrm_d_v_n1i1__ = (0.5*((d_Vsatphi_d_v_n1i1__/leffE_um)))*iecrit;
                d_fctrm_d_temp_dtn2__ = (0.5*(Vsatphi/leffE_um-ecrneff))*d_iecrit_d_temp_dtn2__+(0.5*((d_Vsatphi_d_temp_dtn2__/leffE_um)-d_ecrneff_d_temp_dtn2__))*iecrit;
            fctrm = (0.5*(Vsatphi/leffE_um-ecrneff))*iecrit;
                d_fctrp_d_v_n1n2__ = (0.5*((d_Vsatphi_d_v_n1n2__/leffE_um)))*iecrit;
                d_fctrp_d_v_ncn2__ = (0.5*((d_Vsatphi_d_v_ncn2__/leffE_um)))*iecrit;
                d_fctrp_d_v_i2i1__ = (0.5*((d_Vsatphi_d_v_i2i1__/leffE_um)))*iecrit;
                d_fctrp_d_v_n1i1__ = (0.5*((d_Vsatphi_d_v_n1i1__/leffE_um)))*iecrit;
                d_fctrp_d_temp_dtn2__ = (0.5*(Vsatphi/leffE_um+ecrneff))*d_iecrit_d_temp_dtn2__+(0.5*((d_Vsatphi_d_temp_dtn2__/leffE_um)+d_ecrneff_d_temp_dtn2__))*iecrit;
            fctrp = (0.5*(Vsatphi/leffE_um+ecrneff))*iecrit;
                d_sqrtm_d_v_n1n2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_n1n2__+d_fctrm_d_v_n1n2__*fctrm));
                d_sqrtm_d_v_ncn2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_ncn2__+d_fctrm_d_v_ncn2__*fctrm));
                d_sqrtm_d_v_i2i1__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_i2i1__+d_fctrm_d_v_i2i1__*fctrm));
                d_sqrtm_d_v_n1i1__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_n1i1__+d_fctrm_d_v_n1i1__*fctrm));
                d_sqrtm_d_temp_dtn2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_temp_dtn2__+d_fctrm_d_temp_dtn2__*fctrm)+d_dufctr_d_temp_dtn2__);
            sqrtm = sqrt(fctrm*fctrm+dufctr);
                d_sqrtp_d_v_n1n2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_n1n2__+d_fctrp_d_v_n1n2__*fctrp));
                d_sqrtp_d_v_ncn2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_ncn2__+d_fctrp_d_v_ncn2__*fctrp));
                d_sqrtp_d_v_i2i1__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_i2i1__+d_fctrp_d_v_i2i1__*fctrp));
                d_sqrtp_d_v_n1i1__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_n1i1__+d_fctrp_d_v_n1i1__*fctrp));
                d_sqrtp_d_temp_dtn2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_temp_dtn2__+d_fctrp_d_temp_dtn2__*fctrp)+d_dufctr_d_temp_dtn2__);
            sqrtp = sqrt(fctrp*fctrp+dufctr);
                d_rmu_d_v_n1n2__ = (d_sqrtm_d_v_n1n2__+d_sqrtp_d_v_n1n2__);
                d_rmu_d_v_ncn2__ = (d_sqrtm_d_v_ncn2__+d_sqrtp_d_v_ncn2__);
                d_rmu_d_v_i2i1__ = (d_sqrtm_d_v_i2i1__+d_sqrtp_d_v_i2i1__);
                d_rmu_d_v_n1i1__ = (d_sqrtm_d_v_n1i1__+d_sqrtp_d_v_n1i1__);
                d_rmu_d_temp_dtn2__ = (d_sqrtm_d_temp_dtn2__+d_sqrtp_d_temp_dtn2__)-d_uoff_d_temp_dtn2__;
            rmu = (sqrtm+sqrtp)-uoff;
                d_drmu_d_v_n1n2__ = ((0.5*((d_fctrm_d_v_n1n2__/sqrtm-(fctrm*d_sqrtm_d_v_n1n2__)/sqrtm^2)+(d_fctrp_d_v_n1n2__/sqrtp-(fctrp*d_sqrtp_d_v_n1n2__)/sqrtp^2)))*iecrit)/leffE_um;
                d_drmu_d_v_ncn2__ = ((0.5*((d_fctrm_d_v_ncn2__/sqrtm-(fctrm*d_sqrtm_d_v_ncn2__)/sqrtm^2)+(d_fctrp_d_v_ncn2__/sqrtp-(fctrp*d_sqrtp_d_v_ncn2__)/sqrtp^2)))*iecrit)/leffE_um;
                d_drmu_d_v_i2i1__ = ((0.5*((d_fctrm_d_v_i2i1__/sqrtm-(fctrm*d_sqrtm_d_v_i2i1__)/sqrtm^2)+(d_fctrp_d_v_i2i1__/sqrtp-(fctrp*d_sqrtp_d_v_i2i1__)/sqrtp^2)))*iecrit)/leffE_um;
                d_drmu_d_v_n1i1__ = ((0.5*((d_fctrm_d_v_n1i1__/sqrtm-(fctrm*d_sqrtm_d_v_n1i1__)/sqrtm^2)+(d_fctrp_d_v_n1i1__/sqrtp-(fctrp*d_sqrtp_d_v_n1i1__)/sqrtp^2)))*iecrit)/leffE_um;
                d_drmu_d_temp_dtn2__ = ((0.5*(fctrm/sqrtm+fctrp/sqrtp))*d_iecrit_d_temp_dtn2__+(0.5*((d_fctrm_d_temp_dtn2__/sqrtm-(fctrm*d_sqrtm_d_temp_dtn2__)/sqrtm^2)+(d_fctrp_d_temp_dtn2__/sqrtp-(fctrp*d_sqrtp_d_temp_dtn2__)/sqrtp^2)))*iecrit)/leffE_um;
            drmu = ((0.5*(fctrm/sqrtm+fctrp/sqrtp))*iecrit)/leffE_um;
                d_dfe_d_v_n1n2__ = (1/(2*sqrt((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi)))*((((2*Fsatphi)*(1-Fsatphi))*(-((drmu*d_Vsatphi_d_v_n1n2__+d_drmu_d_v_n1n2__*Vsatphi)/(1+rmu)-((drmu*Vsatphi)*(d_rmu_d_v_n1n2__))/(1+rmu)^2))+((2*Fsatphi)*(-d_Fsatphi_d_v_n1n2__)+(2*d_Fsatphi_d_v_n1n2__)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi-((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))*d_Vsatphi_d_v_n1n2__)/Vsatphi^2);
                d_dfe_d_v_ncn2__ = (1/(2*sqrt((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi)))*((((2*Fsatphi)*(1-Fsatphi))*(-((drmu*d_Vsatphi_d_v_ncn2__+d_drmu_d_v_ncn2__*Vsatphi)/(1+rmu)-((drmu*Vsatphi)*(d_rmu_d_v_ncn2__))/(1+rmu)^2))+((2*Fsatphi)*(-d_Fsatphi_d_v_ncn2__)+(2*d_Fsatphi_d_v_ncn2__)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi-((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))*d_Vsatphi_d_v_ncn2__)/Vsatphi^2);
                d_dfe_d_v_i2i1__ = (1/(2*sqrt((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi)))*((((2*Fsatphi)*(1-Fsatphi))*(-((drmu*d_Vsatphi_d_v_i2i1__+d_drmu_d_v_i2i1__*Vsatphi)/(1+rmu)-((drmu*Vsatphi)*(d_rmu_d_v_i2i1__))/(1+rmu)^2))+((2*Fsatphi)*(-d_Fsatphi_d_v_i2i1__)+(2*d_Fsatphi_d_v_i2i1__)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi-((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))*d_Vsatphi_d_v_i2i1__)/Vsatphi^2);
                d_dfe_d_v_n1i1__ = (1/(2*sqrt((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi)))*((((2*Fsatphi)*(1-Fsatphi))*(-((drmu*d_Vsatphi_d_v_n1i1__+d_drmu_d_v_n1i1__*Vsatphi)/(1+rmu)-((drmu*Vsatphi)*(d_rmu_d_v_n1i1__))/(1+rmu)^2))+((2*Fsatphi)*(-d_Fsatphi_d_v_n1i1__)+(2*d_Fsatphi_d_v_n1i1__)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi-((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))*d_Vsatphi_d_v_n1i1__)/Vsatphi^2);
                d_dfe_d_temp_dtn2__ = (1/(2*sqrt((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi)))*((((2*Fsatphi)*(1-Fsatphi))*(-((drmu*d_Vsatphi_d_temp_dtn2__+d_drmu_d_temp_dtn2__*Vsatphi)/(1+rmu)-((drmu*Vsatphi)*(d_rmu_d_temp_dtn2__))/(1+rmu)^2))+((2*Fsatphi)*(-d_Fsatphi_d_temp_dtn2__)+(2*d_Fsatphi_d_temp_dtn2__)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi-((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))*d_Vsatphi_d_temp_dtn2__)/Vsatphi^2);
            dfe = sqrt((((2*Fsatphi)*(1-Fsatphi))*(1-(drmu*Vsatphi)/(1+rmu)))/Vsatphi);
        else
                d_dfe_d_v_n1n2__ = (1/(2*sqrt(((2*Fsatphi)*(1-Fsatphi))/Vsatphi)))*(((2*Fsatphi)*(-d_Fsatphi_d_v_n1n2__)+(2*d_Fsatphi_d_v_n1n2__)*(1-Fsatphi))/Vsatphi-(((2*Fsatphi)*(1-Fsatphi))*d_Vsatphi_d_v_n1n2__)/Vsatphi^2);
                d_dfe_d_v_ncn2__ = (1/(2*sqrt(((2*Fsatphi)*(1-Fsatphi))/Vsatphi)))*(((2*Fsatphi)*(-d_Fsatphi_d_v_ncn2__)+(2*d_Fsatphi_d_v_ncn2__)*(1-Fsatphi))/Vsatphi-(((2*Fsatphi)*(1-Fsatphi))*d_Vsatphi_d_v_ncn2__)/Vsatphi^2);
                d_dfe_d_v_i2i1__ = (1/(2*sqrt(((2*Fsatphi)*(1-Fsatphi))/Vsatphi)))*(((2*Fsatphi)*(-d_Fsatphi_d_v_i2i1__)+(2*d_Fsatphi_d_v_i2i1__)*(1-Fsatphi))/Vsatphi-(((2*Fsatphi)*(1-Fsatphi))*d_Vsatphi_d_v_i2i1__)/Vsatphi^2);
                d_dfe_d_v_n1i1__ = (1/(2*sqrt(((2*Fsatphi)*(1-Fsatphi))/Vsatphi)))*(((2*Fsatphi)*(-d_Fsatphi_d_v_n1i1__)+(2*d_Fsatphi_d_v_n1i1__)*(1-Fsatphi))/Vsatphi-(((2*Fsatphi)*(1-Fsatphi))*d_Vsatphi_d_v_n1i1__)/Vsatphi^2);
                d_dfe_d_temp_dtn2__ = (1/(2*sqrt(((2*Fsatphi)*(1-Fsatphi))/Vsatphi)))*(((2*Fsatphi)*(-d_Fsatphi_d_temp_dtn2__)+(2*d_Fsatphi_d_temp_dtn2__)*(1-Fsatphi))/Vsatphi-(((2*Fsatphi)*(1-Fsatphi))*d_Vsatphi_d_temp_dtn2__)/Vsatphi^2);
            dfe = sqrt(((2*Fsatphi)*(1-Fsatphi))/Vsatphi);
        end
            d_dpee_d_v_n1n2__ = ((dfsq*(d_dpe_d_v_n1n2__+d_Vsat_d_v_n1n2__))/(dfe*dfe)-((dfsq*(dpe+Vsat))*(dfe*d_dfe_d_v_n1n2__+d_dfe_d_v_n1n2__*dfe))/(dfe*dfe)^2)-d_Vsatphi_d_v_n1n2__;
            d_dpee_d_v_ncn2__ = ((dfsq*(d_dpe_d_v_ncn2__+d_Vsat_d_v_ncn2__))/(dfe*dfe)-((dfsq*(dpe+Vsat))*(dfe*d_dfe_d_v_ncn2__+d_dfe_d_v_ncn2__*dfe))/(dfe*dfe)^2)-d_Vsatphi_d_v_ncn2__;
            d_dpee_d_v_i2i1__ = ((dfsq*(d_dpe_d_v_i2i1__+d_Vsat_d_v_i2i1__))/(dfe*dfe)-((dfsq*(dpe+Vsat))*(dfe*d_dfe_d_v_i2i1__+d_dfe_d_v_i2i1__*dfe))/(dfe*dfe)^2)-d_Vsatphi_d_v_i2i1__;
            d_dpee_d_v_n1i1__ = ((dfsq*(d_dpe_d_v_n1i1__+d_Vsat_d_v_n1i1__))/(dfe*dfe)-((dfsq*(dpe+Vsat))*(dfe*d_dfe_d_v_n1i1__+d_dfe_d_v_n1i1__*dfe))/(dfe*dfe)^2)-d_Vsatphi_d_v_n1i1__;
            d_dpee_d_temp_dtn2__ = ((dfsq*(d_Vsat_d_temp_dtn2__))/(dfe*dfe)-((dfsq*(dpe+Vsat))*(dfe*d_dfe_d_temp_dtn2__+d_dfe_d_temp_dtn2__*dfe))/(dfe*dfe)^2)-d_Vsatphi_d_temp_dtn2__;
        dpee = (dfsq*(dpe+Vsat))/(dfe*dfe)-Vsatphi;
            d_atseff_d_v_n1n2__ = ((ats*d_Vsat_d_v_n1n2__)/(ats+Vsatphi)-((ats*Vsat)*(d_Vsatphi_d_v_n1n2__))/(ats+Vsatphi)^2);
            d_atseff_d_v_ncn2__ = ((ats*d_Vsat_d_v_ncn2__)/(ats+Vsatphi)-((ats*Vsat)*(d_Vsatphi_d_v_ncn2__))/(ats+Vsatphi)^2);
            d_atseff_d_v_i2i1__ = ((ats*d_Vsat_d_v_i2i1__)/(ats+Vsatphi)-((ats*Vsat)*(d_Vsatphi_d_v_i2i1__))/(ats+Vsatphi)^2);
            d_atseff_d_v_n1i1__ = ((ats*d_Vsat_d_v_n1i1__)/(ats+Vsatphi)-((ats*Vsat)*(d_Vsatphi_d_v_n1i1__))/(ats+Vsatphi)^2);
            d_atseff_d_temp_dtn2__ = ((ats*d_Vsat_d_temp_dtn2__)/(ats+Vsatphi)-((ats*Vsat)*(d_Vsatphi_d_temp_dtn2__))/(ats+Vsatphi)^2);
        atseff = atspo+(ats*Vsat)/(ats+Vsatphi);
            d_fouratsq_d_v_n1n2__ = (4*atseff)*d_atseff_d_v_n1n2__+(4*d_atseff_d_v_n1n2__)*atseff;
            d_fouratsq_d_v_ncn2__ = (4*atseff)*d_atseff_d_v_ncn2__+(4*d_atseff_d_v_ncn2__)*atseff;
            d_fouratsq_d_v_i2i1__ = (4*atseff)*d_atseff_d_v_i2i1__+(4*d_atseff_d_v_i2i1__)*atseff;
            d_fouratsq_d_v_n1i1__ = (4*atseff)*d_atseff_d_v_n1i1__+(4*d_atseff_d_v_n1i1__)*atseff;
            d_fouratsq_d_temp_dtn2__ = (4*atseff)*d_atseff_d_temp_dtn2__+(4*d_atseff_d_temp_dtn2__)*atseff;
        fouratsq = (4*atseff)*atseff;
            d_Vbeff_d_v_n1n2__ = ((2*Vbi)*d_Vsatphi_d_v_n1n2__+(2*d_Vbi_d_v_n1n2__)*Vsatphi)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(d_Vbi_d_v_n1n2__-d_Vsatphi_d_v_n1n2__)+(d_Vbi_d_v_n1n2__-d_Vsatphi_d_v_n1n2__)*(Vbi-Vsatphi))+d_fouratsq_d_v_n1n2__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vbi_d_v_n1n2__+d_Vsatphi_d_v_n1n2__)+(d_Vbi_d_v_n1n2__+d_Vsatphi_d_v_n1n2__)*(Vbi+Vsatphi))+d_fouratsq_d_v_n1n2__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
            d_Vbeff_d_v_ncn2__ = ((2*Vbi)*d_Vsatphi_d_v_ncn2__)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(-d_Vsatphi_d_v_ncn2__)+(-d_Vsatphi_d_v_ncn2__)*(Vbi-Vsatphi))+d_fouratsq_d_v_ncn2__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vsatphi_d_v_ncn2__)+(d_Vsatphi_d_v_ncn2__)*(Vbi+Vsatphi))+d_fouratsq_d_v_ncn2__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
            d_Vbeff_d_v_i2i1__ = ((2*Vbi)*d_Vsatphi_d_v_i2i1__+(2*d_Vbi_d_v_i2i1__)*Vsatphi)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(d_Vbi_d_v_i2i1__-d_Vsatphi_d_v_i2i1__)+(d_Vbi_d_v_i2i1__-d_Vsatphi_d_v_i2i1__)*(Vbi-Vsatphi))+d_fouratsq_d_v_i2i1__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vbi_d_v_i2i1__+d_Vsatphi_d_v_i2i1__)+(d_Vbi_d_v_i2i1__+d_Vsatphi_d_v_i2i1__)*(Vbi+Vsatphi))+d_fouratsq_d_v_i2i1__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
            d_Vbeff_d_v_n1i1__ = ((2*Vbi)*d_Vsatphi_d_v_n1i1__)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(-d_Vsatphi_d_v_n1i1__)+(-d_Vsatphi_d_v_n1i1__)*(Vbi-Vsatphi))+d_fouratsq_d_v_n1i1__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vsatphi_d_v_n1i1__)+(d_Vsatphi_d_v_n1i1__)*(Vbi+Vsatphi))+d_fouratsq_d_v_n1i1__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
            d_Vbeff_d_temp_dtn2__ = ((2*Vbi)*d_Vsatphi_d_temp_dtn2__)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(-d_Vsatphi_d_temp_dtn2__)+(-d_Vsatphi_d_temp_dtn2__)*(Vbi-Vsatphi))+d_fouratsq_d_temp_dtn2__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vsatphi_d_temp_dtn2__)+(d_Vsatphi_d_temp_dtn2__)*(Vbi+Vsatphi))+d_fouratsq_d_temp_dtn2__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
        Vbeff = ((2*Vbi)*Vsatphi)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq));
        if parm_sw_accpo>1
                d_atseff_d_v_n1n2__ = ((ats*d_Vbeff_d_v_n1n2__)/(ats+Vsatphi)-((ats*Vbeff)*(d_Vsatphi_d_v_n1n2__))/(ats+Vsatphi)^2);
                d_atseff_d_v_ncn2__ = ((ats*d_Vbeff_d_v_ncn2__)/(ats+Vsatphi)-((ats*Vbeff)*(d_Vsatphi_d_v_ncn2__))/(ats+Vsatphi)^2);
                d_atseff_d_v_i2i1__ = ((ats*d_Vbeff_d_v_i2i1__)/(ats+Vsatphi)-((ats*Vbeff)*(d_Vsatphi_d_v_i2i1__))/(ats+Vsatphi)^2);
                d_atseff_d_v_n1i1__ = ((ats*d_Vbeff_d_v_n1i1__)/(ats+Vsatphi)-((ats*Vbeff)*(d_Vsatphi_d_v_n1i1__))/(ats+Vsatphi)^2);
                d_atseff_d_temp_dtn2__ = ((ats*d_Vbeff_d_temp_dtn2__)/(ats+Vsatphi)-((ats*Vbeff)*(d_Vsatphi_d_temp_dtn2__))/(ats+Vsatphi)^2);
            atseff = atspo+(ats*Vbeff)/(ats+Vsatphi);
                d_fouratsq_d_v_n1n2__ = (4*atseff)*d_atseff_d_v_n1n2__+(4*d_atseff_d_v_n1n2__)*atseff;
                d_fouratsq_d_v_ncn2__ = (4*atseff)*d_atseff_d_v_ncn2__+(4*d_atseff_d_v_ncn2__)*atseff;
                d_fouratsq_d_v_i2i1__ = (4*atseff)*d_atseff_d_v_i2i1__+(4*d_atseff_d_v_i2i1__)*atseff;
                d_fouratsq_d_v_n1i1__ = (4*atseff)*d_atseff_d_v_n1i1__+(4*d_atseff_d_v_n1i1__)*atseff;
                d_fouratsq_d_temp_dtn2__ = (4*atseff)*d_atseff_d_temp_dtn2__+(4*d_atseff_d_temp_dtn2__)*atseff;
            fouratsq = (4*atseff)*atseff;
                d_Vbeff_d_v_n1n2__ = ((2*Vbi)*d_Vsatphi_d_v_n1n2__+(2*d_Vbi_d_v_n1n2__)*Vsatphi)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(d_Vbi_d_v_n1n2__-d_Vsatphi_d_v_n1n2__)+(d_Vbi_d_v_n1n2__-d_Vsatphi_d_v_n1n2__)*(Vbi-Vsatphi))+d_fouratsq_d_v_n1n2__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vbi_d_v_n1n2__+d_Vsatphi_d_v_n1n2__)+(d_Vbi_d_v_n1n2__+d_Vsatphi_d_v_n1n2__)*(Vbi+Vsatphi))+d_fouratsq_d_v_n1n2__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
                d_Vbeff_d_v_ncn2__ = ((2*Vbi)*d_Vsatphi_d_v_ncn2__)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(-d_Vsatphi_d_v_ncn2__)+(-d_Vsatphi_d_v_ncn2__)*(Vbi-Vsatphi))+d_fouratsq_d_v_ncn2__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vsatphi_d_v_ncn2__)+(d_Vsatphi_d_v_ncn2__)*(Vbi+Vsatphi))+d_fouratsq_d_v_ncn2__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
                d_Vbeff_d_v_i2i1__ = ((2*Vbi)*d_Vsatphi_d_v_i2i1__+(2*d_Vbi_d_v_i2i1__)*Vsatphi)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(d_Vbi_d_v_i2i1__-d_Vsatphi_d_v_i2i1__)+(d_Vbi_d_v_i2i1__-d_Vsatphi_d_v_i2i1__)*(Vbi-Vsatphi))+d_fouratsq_d_v_i2i1__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vbi_d_v_i2i1__+d_Vsatphi_d_v_i2i1__)+(d_Vbi_d_v_i2i1__+d_Vsatphi_d_v_i2i1__)*(Vbi+Vsatphi))+d_fouratsq_d_v_i2i1__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
                d_Vbeff_d_v_n1i1__ = ((2*Vbi)*d_Vsatphi_d_v_n1i1__)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(-d_Vsatphi_d_v_n1i1__)+(-d_Vsatphi_d_v_n1i1__)*(Vbi-Vsatphi))+d_fouratsq_d_v_n1i1__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vsatphi_d_v_n1i1__)+(d_Vsatphi_d_v_n1i1__)*(Vbi+Vsatphi))+d_fouratsq_d_v_n1i1__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
                d_Vbeff_d_temp_dtn2__ = ((2*Vbi)*d_Vsatphi_d_temp_dtn2__)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))-(((2*Vbi)*Vsatphi)*((1/(2*sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)))*(((Vbi-Vsatphi)*(-d_Vsatphi_d_temp_dtn2__)+(-d_Vsatphi_d_temp_dtn2__)*(Vbi-Vsatphi))+d_fouratsq_d_temp_dtn2__)+(1/(2*sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq)))*(((Vbi+Vsatphi)*(d_Vsatphi_d_temp_dtn2__)+(d_Vsatphi_d_temp_dtn2__)*(Vbi+Vsatphi))+d_fouratsq_d_temp_dtn2__)))/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq))^2;
            Vbeff = ((2*Vbi)*Vsatphi)/(sqrt((Vbi-Vsatphi)*(Vbi-Vsatphi)+fouratsq)+sqrt((Vbi+Vsatphi)*(Vbi+Vsatphi)+fouratsq));
        end
            d_dpfctr_d_v_n1n2__ = -(dfe*((1/(2*sqrt(dpee+Vbeff)))*(d_dpee_d_v_n1n2__+d_Vbeff_d_v_n1n2__))+d_dfe_d_v_n1n2__*sqrt(dpee+Vbeff));
            d_dpfctr_d_v_ncn2__ = -(dfe*((1/(2*sqrt(dpee+Vbeff)))*(d_dpee_d_v_ncn2__+d_Vbeff_d_v_ncn2__))+d_dfe_d_v_ncn2__*sqrt(dpee+Vbeff));
            d_dpfctr_d_v_i2i1__ = -(dfe*((1/(2*sqrt(dpee+Vbeff)))*(d_dpee_d_v_i2i1__+d_Vbeff_d_v_i2i1__))+d_dfe_d_v_i2i1__*sqrt(dpee+Vbeff));
            d_dpfctr_d_v_n1i1__ = -(dfe*((1/(2*sqrt(dpee+Vbeff)))*(d_dpee_d_v_n1i1__+d_Vbeff_d_v_n1i1__))+d_dfe_d_v_n1i1__*sqrt(dpee+Vbeff));
            d_dpfctr_d_temp_dtn2__ = -(dfe*((1/(2*sqrt(dpee+Vbeff)))*(d_dpee_d_temp_dtn2__+d_Vbeff_d_temp_dtn2__))+d_dfe_d_temp_dtn2__*sqrt(dpee+Vbeff));
        dpfctr = 1-dfe*sqrt(dpee+Vbeff);
        if iecrit>0
                d_fctrm_d_v_n1n2__ = (0.5*((d_Vbeff_d_v_n1n2__/leffE_um)))*iecrit;
                d_fctrm_d_v_ncn2__ = (0.5*((d_Vbeff_d_v_ncn2__/leffE_um)))*iecrit;
                d_fctrm_d_v_i2i1__ = (0.5*((d_Vbeff_d_v_i2i1__/leffE_um)))*iecrit;
                d_fctrm_d_v_n1i1__ = (0.5*((d_Vbeff_d_v_n1i1__/leffE_um)))*iecrit;
                d_fctrm_d_temp_dtn2__ = (0.5*(Vbeff/leffE_um-ecrneff))*d_iecrit_d_temp_dtn2__+(0.5*((d_Vbeff_d_temp_dtn2__/leffE_um)-d_ecrneff_d_temp_dtn2__))*iecrit;
            fctrm = (0.5*(Vbeff/leffE_um-ecrneff))*iecrit;
                d_fctrp_d_v_n1n2__ = (0.5*((d_Vbeff_d_v_n1n2__/leffE_um)))*iecrit;
                d_fctrp_d_v_ncn2__ = (0.5*((d_Vbeff_d_v_ncn2__/leffE_um)))*iecrit;
                d_fctrp_d_v_i2i1__ = (0.5*((d_Vbeff_d_v_i2i1__/leffE_um)))*iecrit;
                d_fctrp_d_v_n1i1__ = (0.5*((d_Vbeff_d_v_n1i1__/leffE_um)))*iecrit;
                d_fctrp_d_temp_dtn2__ = (0.5*(Vbeff/leffE_um+ecrneff))*d_iecrit_d_temp_dtn2__+(0.5*((d_Vbeff_d_temp_dtn2__/leffE_um)+d_ecrneff_d_temp_dtn2__))*iecrit;
            fctrp = (0.5*(Vbeff/leffE_um+ecrneff))*iecrit;
                d_sqrtm_d_v_n1n2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_n1n2__+d_fctrm_d_v_n1n2__*fctrm));
                d_sqrtm_d_v_ncn2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_ncn2__+d_fctrm_d_v_ncn2__*fctrm));
                d_sqrtm_d_v_i2i1__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_i2i1__+d_fctrm_d_v_i2i1__*fctrm));
                d_sqrtm_d_v_n1i1__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_n1i1__+d_fctrm_d_v_n1i1__*fctrm));
                d_sqrtm_d_temp_dtn2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_temp_dtn2__+d_fctrm_d_temp_dtn2__*fctrm)+d_dufctr_d_temp_dtn2__);
            sqrtm = sqrt(fctrm*fctrm+dufctr);
                d_sqrtp_d_v_n1n2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_n1n2__+d_fctrp_d_v_n1n2__*fctrp));
                d_sqrtp_d_v_ncn2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_ncn2__+d_fctrp_d_v_ncn2__*fctrp));
                d_sqrtp_d_v_i2i1__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_i2i1__+d_fctrp_d_v_i2i1__*fctrp));
                d_sqrtp_d_v_n1i1__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_n1i1__+d_fctrp_d_v_n1i1__*fctrp));
                d_sqrtp_d_temp_dtn2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_temp_dtn2__+d_fctrp_d_temp_dtn2__*fctrp)+d_dufctr_d_temp_dtn2__);
            sqrtp = sqrt(fctrp*fctrp+dufctr);
                d_rmu_d_v_n1n2__ = (d_sqrtm_d_v_n1n2__+d_sqrtp_d_v_n1n2__);
                d_rmu_d_v_ncn2__ = (d_sqrtm_d_v_ncn2__+d_sqrtp_d_v_ncn2__);
                d_rmu_d_v_i2i1__ = (d_sqrtm_d_v_i2i1__+d_sqrtp_d_v_i2i1__);
                d_rmu_d_v_n1i1__ = (d_sqrtm_d_v_n1i1__+d_sqrtp_d_v_n1i1__);
                d_rmu_d_temp_dtn2__ = (d_sqrtm_d_temp_dtn2__+d_sqrtp_d_temp_dtn2__)-d_uoff_d_temp_dtn2__;
            rmu = (sqrtm+sqrtp)-uoff;
        else
                d_rmu_d_v_n1n2__ = 0;
                d_rmu_d_v_ncn2__ = 0;
                d_rmu_d_v_i2i1__ = 0;
                d_rmu_d_v_n1i1__ = 0;
                d_rmu_d_temp_dtn2__ = 0;
            rmu = 0;
        end
    else
            d_Vbeff_d_v_n1n2__ = ((2*Vbi)*d_Vsat_d_v_n1n2__+(2*d_Vbi_d_v_n1n2__)*Vsat)/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))-(((2*Vbi)*Vsat)*((1/(2*sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)))*(((Vbi-Vsat)*(d_Vbi_d_v_n1n2__-d_Vsat_d_v_n1n2__)+(d_Vbi_d_v_n1n2__-d_Vsat_d_v_n1n2__)*(Vbi-Vsat)))+(1/(2*sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo)))*(((Vbi+Vsat)*(d_Vbi_d_v_n1n2__+d_Vsat_d_v_n1n2__)+(d_Vbi_d_v_n1n2__+d_Vsat_d_v_n1n2__)*(Vbi+Vsat)))))/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))^2;
            d_Vbeff_d_v_ncn2__ = ((2*Vbi)*d_Vsat_d_v_ncn2__)/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))-(((2*Vbi)*Vsat)*((1/(2*sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)))*(((Vbi-Vsat)*(-d_Vsat_d_v_ncn2__)+(-d_Vsat_d_v_ncn2__)*(Vbi-Vsat)))+(1/(2*sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo)))*(((Vbi+Vsat)*(d_Vsat_d_v_ncn2__)+(d_Vsat_d_v_ncn2__)*(Vbi+Vsat)))))/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))^2;
            d_Vbeff_d_v_i2i1__ = ((2*Vbi)*d_Vsat_d_v_i2i1__+(2*d_Vbi_d_v_i2i1__)*Vsat)/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))-(((2*Vbi)*Vsat)*((1/(2*sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)))*(((Vbi-Vsat)*(d_Vbi_d_v_i2i1__-d_Vsat_d_v_i2i1__)+(d_Vbi_d_v_i2i1__-d_Vsat_d_v_i2i1__)*(Vbi-Vsat)))+(1/(2*sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo)))*(((Vbi+Vsat)*(d_Vbi_d_v_i2i1__+d_Vsat_d_v_i2i1__)+(d_Vbi_d_v_i2i1__+d_Vsat_d_v_i2i1__)*(Vbi+Vsat)))))/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))^2;
            d_Vbeff_d_v_n1i1__ = ((2*Vbi)*d_Vsat_d_v_n1i1__)/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))-(((2*Vbi)*Vsat)*((1/(2*sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)))*(((Vbi-Vsat)*(-d_Vsat_d_v_n1i1__)+(-d_Vsat_d_v_n1i1__)*(Vbi-Vsat)))+(1/(2*sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo)))*(((Vbi+Vsat)*(d_Vsat_d_v_n1i1__)+(d_Vsat_d_v_n1i1__)*(Vbi+Vsat)))))/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))^2;
            d_Vbeff_d_temp_dtn2__ = ((2*Vbi)*d_Vsat_d_temp_dtn2__)/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))-(((2*Vbi)*Vsat)*((1/(2*sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)))*(((Vbi-Vsat)*(-d_Vsat_d_temp_dtn2__)+(-d_Vsat_d_temp_dtn2__)*(Vbi-Vsat)))+(1/(2*sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo)))*(((Vbi+Vsat)*(d_Vsat_d_temp_dtn2__)+(d_Vsat_d_temp_dtn2__)*(Vbi+Vsat)))))/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo))^2;
        Vbeff = ((2*Vbi)*Vsat)/(sqrt((Vbi-Vsat)*(Vbi-Vsat)+atspo)+sqrt((Vbi+Vsat)*(Vbi+Vsat)+atspo));
        if iecrit>0
                d_fctrm_d_v_n1n2__ = (0.5*((d_Vbeff_d_v_n1n2__/leffE_um)))*iecrit;
                d_fctrm_d_v_ncn2__ = (0.5*((d_Vbeff_d_v_ncn2__/leffE_um)))*iecrit;
                d_fctrm_d_v_i2i1__ = (0.5*((d_Vbeff_d_v_i2i1__/leffE_um)))*iecrit;
                d_fctrm_d_v_n1i1__ = (0.5*((d_Vbeff_d_v_n1i1__/leffE_um)))*iecrit;
                d_fctrm_d_temp_dtn2__ = (0.5*(Vbeff/leffE_um-ecrneff))*d_iecrit_d_temp_dtn2__+(0.5*((d_Vbeff_d_temp_dtn2__/leffE_um)-d_ecrneff_d_temp_dtn2__))*iecrit;
            fctrm = (0.5*(Vbeff/leffE_um-ecrneff))*iecrit;
                d_fctrp_d_v_n1n2__ = (0.5*((d_Vbeff_d_v_n1n2__/leffE_um)))*iecrit;
                d_fctrp_d_v_ncn2__ = (0.5*((d_Vbeff_d_v_ncn2__/leffE_um)))*iecrit;
                d_fctrp_d_v_i2i1__ = (0.5*((d_Vbeff_d_v_i2i1__/leffE_um)))*iecrit;
                d_fctrp_d_v_n1i1__ = (0.5*((d_Vbeff_d_v_n1i1__/leffE_um)))*iecrit;
                d_fctrp_d_temp_dtn2__ = (0.5*(Vbeff/leffE_um+ecrneff))*d_iecrit_d_temp_dtn2__+(0.5*((d_Vbeff_d_temp_dtn2__/leffE_um)+d_ecrneff_d_temp_dtn2__))*iecrit;
            fctrp = (0.5*(Vbeff/leffE_um+ecrneff))*iecrit;
                d_sqrtm_d_v_n1n2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_n1n2__+d_fctrm_d_v_n1n2__*fctrm));
                d_sqrtm_d_v_ncn2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_ncn2__+d_fctrm_d_v_ncn2__*fctrm));
                d_sqrtm_d_v_i2i1__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_i2i1__+d_fctrm_d_v_i2i1__*fctrm));
                d_sqrtm_d_v_n1i1__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_v_n1i1__+d_fctrm_d_v_n1i1__*fctrm));
                d_sqrtm_d_temp_dtn2__ = (1/(2*sqrt(fctrm*fctrm+dufctr)))*((fctrm*d_fctrm_d_temp_dtn2__+d_fctrm_d_temp_dtn2__*fctrm)+d_dufctr_d_temp_dtn2__);
            sqrtm = sqrt(fctrm*fctrm+dufctr);
                d_sqrtp_d_v_n1n2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_n1n2__+d_fctrp_d_v_n1n2__*fctrp));
                d_sqrtp_d_v_ncn2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_ncn2__+d_fctrp_d_v_ncn2__*fctrp));
                d_sqrtp_d_v_i2i1__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_i2i1__+d_fctrp_d_v_i2i1__*fctrp));
                d_sqrtp_d_v_n1i1__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_v_n1i1__+d_fctrp_d_v_n1i1__*fctrp));
                d_sqrtp_d_temp_dtn2__ = (1/(2*sqrt(fctrp*fctrp+dufctr)))*((fctrp*d_fctrp_d_temp_dtn2__+d_fctrp_d_temp_dtn2__*fctrp)+d_dufctr_d_temp_dtn2__);
            sqrtp = sqrt(fctrp*fctrp+dufctr);
                d_rmu_d_v_n1n2__ = (d_sqrtm_d_v_n1n2__+d_sqrtp_d_v_n1n2__);
                d_rmu_d_v_ncn2__ = (d_sqrtm_d_v_ncn2__+d_sqrtp_d_v_ncn2__);
                d_rmu_d_v_i2i1__ = (d_sqrtm_d_v_i2i1__+d_sqrtp_d_v_i2i1__);
                d_rmu_d_v_n1i1__ = (d_sqrtm_d_v_n1i1__+d_sqrtp_d_v_n1i1__);
                d_rmu_d_temp_dtn2__ = (d_sqrtm_d_temp_dtn2__+d_sqrtp_d_temp_dtn2__)-d_uoff_d_temp_dtn2__;
            rmu = (sqrtm+sqrtp)-uoff;
        else
                d_rmu_d_v_n1n2__ = 0;
                d_rmu_d_v_ncn2__ = 0;
                d_rmu_d_v_i2i1__ = 0;
                d_rmu_d_v_n1i1__ = 0;
                d_rmu_d_temp_dtn2__ = 0;
            rmu = 0;
        end
            d_dpfctr_d_v_n1n2__ = -(df*((1/(2*sqrt(dpe+Vbeff)))*(d_dpe_d_v_n1n2__+d_Vbeff_d_v_n1n2__)));
            d_dpfctr_d_v_ncn2__ = -(df*((1/(2*sqrt(dpe+Vbeff)))*(d_dpe_d_v_ncn2__+d_Vbeff_d_v_ncn2__)));
            d_dpfctr_d_v_i2i1__ = -(df*((1/(2*sqrt(dpe+Vbeff)))*(d_dpe_d_v_i2i1__+d_Vbeff_d_v_i2i1__)));
            d_dpfctr_d_v_n1i1__ = -(df*((1/(2*sqrt(dpe+Vbeff)))*(d_dpe_d_v_n1i1__+d_Vbeff_d_v_n1i1__)));
            d_dpfctr_d_temp_dtn2__ = -(df*((1/(2*sqrt(dpe+Vbeff)))*(d_Vbeff_d_temp_dtn2__)));
        dpfctr = 1-df*sqrt(dpe+Vbeff);
    end
    if dpfctr<parm_grpo
            d_dpfctr_d_v_n1n2__ = 0;
            d_dpfctr_d_v_ncn2__ = 0;
            d_dpfctr_d_v_i2i1__ = 0;
            d_dpfctr_d_v_n1i1__ = 0;
            d_dpfctr_d_temp_dtn2__ = 0;
        dpfctr = parm_grpo;
    end
        d_geff_d_v_n1n2__ = (gf*d_dpfctr_d_v_n1n2__)/(1+rmu)-((gf*dpfctr)*(d_rmu_d_v_n1n2__))/(1+rmu)^2;
        d_geff_d_v_ncn2__ = (gf*d_dpfctr_d_v_ncn2__)/(1+rmu)-((gf*dpfctr)*(d_rmu_d_v_ncn2__))/(1+rmu)^2;
        d_geff_d_v_i2i1__ = (gf*d_dpfctr_d_v_i2i1__)/(1+rmu)-((gf*dpfctr)*(d_rmu_d_v_i2i1__))/(1+rmu)^2;
        d_geff_d_v_n1i1__ = (gf*d_dpfctr_d_v_n1i1__)/(1+rmu)-((gf*dpfctr)*(d_rmu_d_v_n1i1__))/(1+rmu)^2;
        d_geff_d_temp_dtn2__ = (gf*d_dpfctr_d_temp_dtn2__+d_gf_d_temp_dtn2__*dpfctr)/(1+rmu)-((gf*dpfctr)*(d_rmu_d_temp_dtn2__))/(1+rmu)^2;
    geff = (gf*dpfctr)/(1+rmu);
        d_Ib_d_v_n1n2__ = (sdFlip*geff)*d_Vbeff_d_v_n1n2__+(sdFlip*d_geff_d_v_n1n2__+d_sdFlip_d_v_n1n2__*geff)*Vbeff;
        d_Ib_d_v_ncn2__ = (sdFlip*geff)*d_Vbeff_d_v_ncn2__+(sdFlip*d_geff_d_v_ncn2__)*Vbeff;
        d_Ib_d_v_i2i1__ = (sdFlip*geff)*d_Vbeff_d_v_i2i1__+(sdFlip*d_geff_d_v_i2i1__+d_sdFlip_d_v_i2i1__*geff)*Vbeff;
        d_Ib_d_v_n1i1__ = (sdFlip*geff)*d_Vbeff_d_v_n1i1__+(sdFlip*d_geff_d_v_n1i1__)*Vbeff;
        d_Ib_d_temp_dtn2__ = (sdFlip*geff)*d_Vbeff_d_temp_dtn2__+(sdFlip*d_geff_d_temp_dtn2__)*Vbeff;
    Ib = (sdFlip*geff)*Vbeff;
    if clm1>0
            d_Ib_d_v_n1n2__ = Ib*(((clm1*(1+parm_clm1c*(vpoe-V1cl)))*d_Vbi_d_v_n1n2__+(clm1*((parm_clm1c*(-d_V1cl_d_v_n1n2__))))*Vbi))+d_Ib_d_v_n1n2__*(1+(clm1*(1+parm_clm1c*(vpoe-V1cl)))*Vbi);
            d_Ib_d_v_ncn2__ = Ib*(((clm1*((parm_clm1c*(-d_V1cl_d_v_ncn2__))))*Vbi))+d_Ib_d_v_ncn2__*(1+(clm1*(1+parm_clm1c*(vpoe-V1cl)))*Vbi);
            d_Ib_d_v_i2i1__ = Ib*(((clm1*(1+parm_clm1c*(vpoe-V1cl)))*d_Vbi_d_v_i2i1__+(clm1*((parm_clm1c*(-d_V1cl_d_v_i2i1__))))*Vbi))+d_Ib_d_v_i2i1__*(1+(clm1*(1+parm_clm1c*(vpoe-V1cl)))*Vbi);
            d_Ib_d_v_n1i1__ = Ib*(((clm1*((parm_clm1c*(-d_V1cl_d_v_n1i1__))))*Vbi))+d_Ib_d_v_n1i1__*(1+(clm1*(1+parm_clm1c*(vpoe-V1cl)))*Vbi);
            d_Ib_d_temp_dtn2__ = d_Ib_d_temp_dtn2__*(1+(clm1*(1+parm_clm1c*(vpoe-V1cl)))*Vbi);
        Ib = Ib*(1+(clm1*(1+parm_clm1c*(vpoe-V1cl)))*Vbi);
    end
    if clm2>0
            d_Ib_d_v_n1n2__ = Ib*((clm2*(d_pow_vapp_d_arg1__(Vbi+parm_clm2v, parm_clm2e)*(d_Vbi_d_v_n1n2__))))+d_Ib_d_v_n1n2__*(1+clm2*(pow_vapp(Vbi+parm_clm2v, parm_clm2e)-clm2o));
            d_Ib_d_v_ncn2__ = d_Ib_d_v_ncn2__*(1+clm2*(pow_vapp(Vbi+parm_clm2v, parm_clm2e)-clm2o));
            d_Ib_d_v_i2i1__ = Ib*((clm2*(d_pow_vapp_d_arg1__(Vbi+parm_clm2v, parm_clm2e)*(d_Vbi_d_v_i2i1__))))+d_Ib_d_v_i2i1__*(1+clm2*(pow_vapp(Vbi+parm_clm2v, parm_clm2e)-clm2o));
            d_Ib_d_v_n1i1__ = d_Ib_d_v_n1i1__*(1+clm2*(pow_vapp(Vbi+parm_clm2v, parm_clm2e)-clm2o));
            d_Ib_d_temp_dtn2__ = d_Ib_d_temp_dtn2__*(1+clm2*(pow_vapp(Vbi+parm_clm2v, parm_clm2e)-clm2o));
        Ib = Ib*(1+clm2*(pow_vapp(Vbi+parm_clm2v, parm_clm2e)-clm2o));
    end
    if Is1>0
            d_aisa_d_temp_dtn2__ = a1_um2*d_isa_t_d_temp_dtn2__;
        aisa = a1_um2*isa_t;
            d_pisp_d_temp_dtn2__ = p1_um*d_isp_t_d_temp_dtn2__;
        pisp = p1_um*isp_t;
        if aisa>0
                d_argx_d_temp_dtn2__ = -(1*(parm_na*d_phi_t_d_temp_dtn2__))/(parm_na*phi_t)^2;
            argx = 1/(parm_na*phi_t);
            if Vc1<vmax_a
                    d_expx_d_v_n1n2__ = exp(Vc1*argx)*(d_Vc1_d_v_n1n2__*argx);
                    d_expx_d_v_ncn2__ = exp(Vc1*argx)*(d_Vc1_d_v_ncn2__*argx);
                    d_expx_d_v_i2i1__ = exp(Vc1*argx)*(d_Vc1_d_v_i2i1__*argx);
                    d_expx_d_v_n1i1__ = exp(Vc1*argx)*(d_Vc1_d_v_n1i1__*argx);
                    d_expx_d_temp_dtn2__ = exp(Vc1*argx)*(Vc1*d_argx_d_temp_dtn2__);
                expx = exp(Vc1*argx);
            else
                    d_expx_d_v_n1n2__ = exp(vmax_a*argx)*(((d_Vc1_d_v_n1n2__)*argx));
                    d_expx_d_v_ncn2__ = exp(vmax_a*argx)*(((d_Vc1_d_v_ncn2__)*argx));
                    d_expx_d_v_i2i1__ = exp(vmax_a*argx)*(((d_Vc1_d_v_i2i1__)*argx));
                    d_expx_d_v_n1i1__ = exp(vmax_a*argx)*(((d_Vc1_d_v_n1i1__)*argx));
                    d_expx_d_temp_dtn2__ = exp(vmax_a*argx)*(((Vc1-vmax_a)*d_argx_d_temp_dtn2__+(-d_vmax_a_d_temp_dtn2__)*argx))+(exp(vmax_a*argx)*(vmax_a*d_argx_d_temp_dtn2__+d_vmax_a_d_temp_dtn2__*argx))*(1+(Vc1-vmax_a)*argx);
                expx = exp(vmax_a*argx)*(1+(Vc1-vmax_a)*argx);
            end
                d_pnjIa_d_v_n1n2__ = aisa*(d_expx_d_v_n1n2__);
                d_pnjIa_d_v_ncn2__ = aisa*(d_expx_d_v_ncn2__);
                d_pnjIa_d_v_i2i1__ = aisa*(d_expx_d_v_i2i1__);
                d_pnjIa_d_v_n1i1__ = aisa*(d_expx_d_v_n1i1__);
                d_pnjIa_d_temp_dtn2__ = aisa*(d_expx_d_temp_dtn2__)+d_aisa_d_temp_dtn2__*(expx-1);
            pnjIa = aisa*(expx-1);
        else
                d_pnjIa_d_v_n1n2__ = 0;
                d_pnjIa_d_v_ncn2__ = 0;
                d_pnjIa_d_v_i2i1__ = 0;
                d_pnjIa_d_v_n1i1__ = 0;
                d_pnjIa_d_temp_dtn2__ = 0;
            pnjIa = 0;
        end
        if pisp>0
                d_argx_d_temp_dtn2__ = -(1*(parm_np*d_phi_t_d_temp_dtn2__))/(parm_np*phi_t)^2;
            argx = 1/(parm_np*phi_t);
            if Vc1<vmax_p
                    d_expx_d_v_n1n2__ = exp(Vc1*argx)*(d_Vc1_d_v_n1n2__*argx);
                    d_expx_d_v_ncn2__ = exp(Vc1*argx)*(d_Vc1_d_v_ncn2__*argx);
                    d_expx_d_v_i2i1__ = exp(Vc1*argx)*(d_Vc1_d_v_i2i1__*argx);
                    d_expx_d_v_n1i1__ = exp(Vc1*argx)*(d_Vc1_d_v_n1i1__*argx);
                    d_expx_d_temp_dtn2__ = exp(Vc1*argx)*(Vc1*d_argx_d_temp_dtn2__);
                expx = exp(Vc1*argx);
            else
                    d_expx_d_v_n1n2__ = exp(vmax_p*argx)*(((d_Vc1_d_v_n1n2__)*argx));
                    d_expx_d_v_ncn2__ = exp(vmax_p*argx)*(((d_Vc1_d_v_ncn2__)*argx));
                    d_expx_d_v_i2i1__ = exp(vmax_p*argx)*(((d_Vc1_d_v_i2i1__)*argx));
                    d_expx_d_v_n1i1__ = exp(vmax_p*argx)*(((d_Vc1_d_v_n1i1__)*argx));
                    d_expx_d_temp_dtn2__ = exp(vmax_p*argx)*(((Vc1-vmax_p)*d_argx_d_temp_dtn2__+(-d_vmax_p_d_temp_dtn2__)*argx))+(exp(vmax_p*argx)*(vmax_p*d_argx_d_temp_dtn2__+d_vmax_p_d_temp_dtn2__*argx))*(1+(Vc1-vmax_p)*argx);
                expx = exp(vmax_p*argx)*(1+(Vc1-vmax_p)*argx);
            end
                d_pnjIp_d_v_n1n2__ = pisp*(d_expx_d_v_n1n2__);
                d_pnjIp_d_v_ncn2__ = pisp*(d_expx_d_v_ncn2__);
                d_pnjIp_d_v_i2i1__ = pisp*(d_expx_d_v_i2i1__);
                d_pnjIp_d_v_n1i1__ = pisp*(d_expx_d_v_n1i1__);
                d_pnjIp_d_temp_dtn2__ = pisp*(d_expx_d_temp_dtn2__)+d_pisp_d_temp_dtn2__*(expx-1);
            pnjIp = pisp*(expx-1);
        else
                d_pnjIp_d_v_n1n2__ = 0;
                d_pnjIp_d_v_ncn2__ = 0;
                d_pnjIp_d_v_i2i1__ = 0;
                d_pnjIp_d_v_n1i1__ = 0;
                d_pnjIp_d_temp_dtn2__ = 0;
            pnjIp = 0;
        end
            d_Id1_d_v_n1n2__ = d_pnjIa_d_v_n1n2__+d_pnjIp_d_v_n1n2__;
            d_Id1_d_v_ncn2__ = d_pnjIa_d_v_ncn2__+d_pnjIp_d_v_ncn2__;
            d_Id1_d_v_i2i1__ = d_pnjIa_d_v_i2i1__+d_pnjIp_d_v_i2i1__;
            d_Id1_d_v_n1i1__ = d_pnjIa_d_v_n1i1__+d_pnjIp_d_v_n1i1__;
            d_Id1_d_temp_dtn2__ = d_pnjIa_d_temp_dtn2__+d_pnjIp_d_temp_dtn2__;
        Id1 = pnjIa+pnjIp;
        if vbv_t>0
                d_Vbkd_d_v_n1n2__ = -d_Vc1_d_v_n1n2__;
                d_Vbkd_d_v_ncn2__ = -d_Vc1_d_v_ncn2__;
                d_Vbkd_d_v_i2i1__ = -d_Vc1_d_v_i2i1__;
                d_Vbkd_d_v_n1i1__ = -d_Vc1_d_v_n1i1__;
                d_Vbkd_d_temp_dtn2__ = -d_vbv_t_d_temp_dtn2__;
            Vbkd = -vbv_t-Vc1;
                d_argx_d_temp_dtn2__ = -(1*(nbv_t*d_phi_t_d_temp_dtn2__+d_nbv_t_d_temp_dtn2__*phi_t))/(nbv_t*phi_t)^2;
            argx = 1/(nbv_t*phi_t);
            if Vbkd<vmax_b
                    d_expx_d_v_n1n2__ = exp(Vbkd*argx)*(d_Vbkd_d_v_n1n2__*argx);
                    d_expx_d_v_ncn2__ = exp(Vbkd*argx)*(d_Vbkd_d_v_ncn2__*argx);
                    d_expx_d_v_i2i1__ = exp(Vbkd*argx)*(d_Vbkd_d_v_i2i1__*argx);
                    d_expx_d_v_n1i1__ = exp(Vbkd*argx)*(d_Vbkd_d_v_n1i1__*argx);
                    d_expx_d_temp_dtn2__ = exp(Vbkd*argx)*(Vbkd*d_argx_d_temp_dtn2__+d_Vbkd_d_temp_dtn2__*argx);
                expx = exp(Vbkd*argx);
            else
                    d_expx_d_v_n1n2__ = exp(vmax_b*argx)*(((d_Vbkd_d_v_n1n2__)*argx));
                    d_expx_d_v_ncn2__ = exp(vmax_b*argx)*(((d_Vbkd_d_v_ncn2__)*argx));
                    d_expx_d_v_i2i1__ = exp(vmax_b*argx)*(((d_Vbkd_d_v_i2i1__)*argx));
                    d_expx_d_v_n1i1__ = exp(vmax_b*argx)*(((d_Vbkd_d_v_n1i1__)*argx));
                    d_expx_d_temp_dtn2__ = exp(vmax_b*argx)*(((Vbkd-vmax_b)*d_argx_d_temp_dtn2__+(d_Vbkd_d_temp_dtn2__-d_vmax_b_d_temp_dtn2__)*argx))+(exp(vmax_b*argx)*(vmax_b*d_argx_d_temp_dtn2__+d_vmax_b_d_temp_dtn2__*argx))*(1+(Vbkd-vmax_b)*argx);
                expx = exp(vmax_b*argx)*(1+(Vbkd-vmax_b)*argx);
            end
                d_Ib1_d_v_n1n2__ = -parm_ibv*(d_expx_d_v_n1n2__);
                d_Ib1_d_v_ncn2__ = -parm_ibv*(d_expx_d_v_ncn2__);
                d_Ib1_d_v_i2i1__ = -parm_ibv*(d_expx_d_v_i2i1__);
                d_Ib1_d_v_n1i1__ = -parm_ibv*(d_expx_d_v_n1i1__);
                d_Ib1_d_temp_dtn2__ = -parm_ibv*(d_expx_d_temp_dtn2__-exp(-vbv_t*argx)*(-vbv_t*d_argx_d_temp_dtn2__+-d_vbv_t_d_temp_dtn2__*argx));
            Ib1 = -parm_ibv*(expx-exp(-vbv_t*argx));
        else
                d_Ib1_d_v_n1n2__ = 0;
                d_Ib1_d_v_ncn2__ = 0;
                d_Ib1_d_v_i2i1__ = 0;
                d_Ib1_d_v_n1i1__ = 0;
                d_Ib1_d_temp_dtn2__ = 0;
            Ib1 = 0;
        end
            d_Ip1_d_v_n1n2__ = (d_Id1_d_v_n1n2__+d_Ib1_d_v_n1n2__)+(parm_gmin*d_Vc1_d_v_n1n2__);
            d_Ip1_d_v_ncn2__ = (d_Id1_d_v_ncn2__+d_Ib1_d_v_ncn2__)+(parm_gmin*d_Vc1_d_v_ncn2__);
            d_Ip1_d_v_i2i1__ = (d_Id1_d_v_i2i1__+d_Ib1_d_v_i2i1__)+(parm_gmin*d_Vc1_d_v_i2i1__);
            d_Ip1_d_v_n1i1__ = (d_Id1_d_v_n1i1__+d_Ib1_d_v_n1i1__)+(parm_gmin*d_Vc1_d_v_n1i1__);
            d_Ip1_d_temp_dtn2__ = (d_Id1_d_temp_dtn2__+d_Ib1_d_temp_dtn2__);
        Ip1 = (Id1+Ib1)+parm_gmin*Vc1;
    else
            d_Id1_d_v_n1n2__ = 0;
            d_Id1_d_v_ncn2__ = 0;
            d_Id1_d_v_i2i1__ = 0;
            d_Id1_d_v_n1i1__ = 0;
            d_Id1_d_temp_dtn2__ = 0;
        Id1 = 0;
            d_Ib1_d_v_n1n2__ = 0;
            d_Ib1_d_v_ncn2__ = 0;
            d_Ib1_d_v_i2i1__ = 0;
            d_Ib1_d_v_n1i1__ = 0;
            d_Ib1_d_temp_dtn2__ = 0;
        Ib1 = 0;
            d_Ip1_d_v_n1n2__ = 0;
            d_Ip1_d_v_ncn2__ = 0;
            d_Ip1_d_v_i2i1__ = 0;
            d_Ip1_d_v_n1i1__ = 0;
            d_Ip1_d_temp_dtn2__ = 0;
        Ip1 = 0;
    end
    if Is2>0
            d_aisa_d_temp_dtn2__ = a2_um2*d_isa_t_d_temp_dtn2__;
        aisa = a2_um2*isa_t;
            d_pisp_d_temp_dtn2__ = p2_um*d_isp_t_d_temp_dtn2__;
        pisp = p2_um*isp_t;
        if aisa>0
                d_argx_d_temp_dtn2__ = -(1*(parm_na*d_phi_t_d_temp_dtn2__))/(parm_na*phi_t)^2;
            argx = 1/(parm_na*phi_t);
            if Vc2<vmax_a
                    d_expx_d_v_n1n2__ = exp(Vc2*argx)*(d_Vc2_d_v_n1n2__*argx);
                    d_expx_d_v_ncn2__ = exp(Vc2*argx)*(d_Vc2_d_v_ncn2__*argx);
                    d_expx_d_v_i2i1__ = exp(Vc2*argx)*(d_Vc2_d_v_i2i1__*argx);
                    d_expx_d_v_n1i1__ = exp(Vc2*argx)*(d_Vc2_d_v_n1i1__*argx);
                    d_expx_d_temp_dtn2__ = exp(Vc2*argx)*(Vc2*d_argx_d_temp_dtn2__);
                expx = exp(Vc2*argx);
            else
                    d_expx_d_v_n1n2__ = exp(vmax_a*argx)*(((d_Vc2_d_v_n1n2__)*argx));
                    d_expx_d_v_ncn2__ = exp(vmax_a*argx)*(((d_Vc2_d_v_ncn2__)*argx));
                    d_expx_d_v_i2i1__ = exp(vmax_a*argx)*(((d_Vc2_d_v_i2i1__)*argx));
                    d_expx_d_v_n1i1__ = exp(vmax_a*argx)*(((d_Vc2_d_v_n1i1__)*argx));
                    d_expx_d_temp_dtn2__ = exp(vmax_a*argx)*(((Vc2-vmax_a)*d_argx_d_temp_dtn2__+(-d_vmax_a_d_temp_dtn2__)*argx))+(exp(vmax_a*argx)*(vmax_a*d_argx_d_temp_dtn2__+d_vmax_a_d_temp_dtn2__*argx))*(1+(Vc2-vmax_a)*argx);
                expx = exp(vmax_a*argx)*(1+(Vc2-vmax_a)*argx);
            end
                d_pnjIa_d_v_n1n2__ = aisa*(d_expx_d_v_n1n2__);
                d_pnjIa_d_v_ncn2__ = aisa*(d_expx_d_v_ncn2__);
                d_pnjIa_d_v_i2i1__ = aisa*(d_expx_d_v_i2i1__);
                d_pnjIa_d_v_n1i1__ = aisa*(d_expx_d_v_n1i1__);
                d_pnjIa_d_temp_dtn2__ = aisa*(d_expx_d_temp_dtn2__)+d_aisa_d_temp_dtn2__*(expx-1);
            pnjIa = aisa*(expx-1);
        else
                d_pnjIa_d_v_n1n2__ = 0;
                d_pnjIa_d_v_ncn2__ = 0;
                d_pnjIa_d_v_i2i1__ = 0;
                d_pnjIa_d_v_n1i1__ = 0;
                d_pnjIa_d_temp_dtn2__ = 0;
            pnjIa = 0;
        end
        if pisp>0
                d_argx_d_temp_dtn2__ = -(1*(parm_np*d_phi_t_d_temp_dtn2__))/(parm_np*phi_t)^2;
            argx = 1/(parm_np*phi_t);
            if Vc2<vmax_p
                    d_expx_d_v_n1n2__ = exp(Vc2*argx)*(d_Vc2_d_v_n1n2__*argx);
                    d_expx_d_v_ncn2__ = exp(Vc2*argx)*(d_Vc2_d_v_ncn2__*argx);
                    d_expx_d_v_i2i1__ = exp(Vc2*argx)*(d_Vc2_d_v_i2i1__*argx);
                    d_expx_d_v_n1i1__ = exp(Vc2*argx)*(d_Vc2_d_v_n1i1__*argx);
                    d_expx_d_temp_dtn2__ = exp(Vc2*argx)*(Vc2*d_argx_d_temp_dtn2__);
                expx = exp(Vc2*argx);
            else
                    d_expx_d_v_n1n2__ = exp(vmax_p*argx)*(((d_Vc2_d_v_n1n2__)*argx));
                    d_expx_d_v_ncn2__ = exp(vmax_p*argx)*(((d_Vc2_d_v_ncn2__)*argx));
                    d_expx_d_v_i2i1__ = exp(vmax_p*argx)*(((d_Vc2_d_v_i2i1__)*argx));
                    d_expx_d_v_n1i1__ = exp(vmax_p*argx)*(((d_Vc2_d_v_n1i1__)*argx));
                    d_expx_d_temp_dtn2__ = exp(vmax_p*argx)*(((Vc2-vmax_p)*d_argx_d_temp_dtn2__+(-d_vmax_p_d_temp_dtn2__)*argx))+(exp(vmax_p*argx)*(vmax_p*d_argx_d_temp_dtn2__+d_vmax_p_d_temp_dtn2__*argx))*(1+(Vc2-vmax_p)*argx);
                expx = exp(vmax_p*argx)*(1+(Vc2-vmax_p)*argx);
            end
                d_pnjIp_d_v_n1n2__ = pisp*(d_expx_d_v_n1n2__);
                d_pnjIp_d_v_ncn2__ = pisp*(d_expx_d_v_ncn2__);
                d_pnjIp_d_v_i2i1__ = pisp*(d_expx_d_v_i2i1__);
                d_pnjIp_d_v_n1i1__ = pisp*(d_expx_d_v_n1i1__);
                d_pnjIp_d_temp_dtn2__ = pisp*(d_expx_d_temp_dtn2__)+d_pisp_d_temp_dtn2__*(expx-1);
            pnjIp = pisp*(expx-1);
        else
                d_pnjIp_d_v_n1n2__ = 0;
                d_pnjIp_d_v_ncn2__ = 0;
                d_pnjIp_d_v_i2i1__ = 0;
                d_pnjIp_d_v_n1i1__ = 0;
                d_pnjIp_d_temp_dtn2__ = 0;
            pnjIp = 0;
        end
            d_Id2_d_v_n1n2__ = d_pnjIa_d_v_n1n2__+d_pnjIp_d_v_n1n2__;
            d_Id2_d_v_ncn2__ = d_pnjIa_d_v_ncn2__+d_pnjIp_d_v_ncn2__;
            d_Id2_d_v_i2i1__ = d_pnjIa_d_v_i2i1__+d_pnjIp_d_v_i2i1__;
            d_Id2_d_v_n1i1__ = d_pnjIa_d_v_n1i1__+d_pnjIp_d_v_n1i1__;
            d_Id2_d_temp_dtn2__ = d_pnjIa_d_temp_dtn2__+d_pnjIp_d_temp_dtn2__;
        Id2 = pnjIa+pnjIp;
        if vbv_t>0
                d_Vbkd_d_v_n1n2__ = -d_Vc2_d_v_n1n2__;
                d_Vbkd_d_v_ncn2__ = -d_Vc2_d_v_ncn2__;
                d_Vbkd_d_v_i2i1__ = -d_Vc2_d_v_i2i1__;
                d_Vbkd_d_v_n1i1__ = -d_Vc2_d_v_n1i1__;
                d_Vbkd_d_temp_dtn2__ = -d_vbv_t_d_temp_dtn2__;
            Vbkd = -vbv_t-Vc2;
                d_argx_d_temp_dtn2__ = -(1*(nbv_t*d_phi_t_d_temp_dtn2__+d_nbv_t_d_temp_dtn2__*phi_t))/(nbv_t*phi_t)^2;
            argx = 1/(nbv_t*phi_t);
            if Vbkd<vmax_b
                    d_expx_d_v_n1n2__ = exp(Vbkd*argx)*(d_Vbkd_d_v_n1n2__*argx);
                    d_expx_d_v_ncn2__ = exp(Vbkd*argx)*(d_Vbkd_d_v_ncn2__*argx);
                    d_expx_d_v_i2i1__ = exp(Vbkd*argx)*(d_Vbkd_d_v_i2i1__*argx);
                    d_expx_d_v_n1i1__ = exp(Vbkd*argx)*(d_Vbkd_d_v_n1i1__*argx);
                    d_expx_d_temp_dtn2__ = exp(Vbkd*argx)*(Vbkd*d_argx_d_temp_dtn2__+d_Vbkd_d_temp_dtn2__*argx);
                expx = exp(Vbkd*argx);
            else
                    d_expx_d_v_n1n2__ = exp(vmax_b*argx)*(((d_Vbkd_d_v_n1n2__)*argx));
                    d_expx_d_v_ncn2__ = exp(vmax_b*argx)*(((d_Vbkd_d_v_ncn2__)*argx));
                    d_expx_d_v_i2i1__ = exp(vmax_b*argx)*(((d_Vbkd_d_v_i2i1__)*argx));
                    d_expx_d_v_n1i1__ = exp(vmax_b*argx)*(((d_Vbkd_d_v_n1i1__)*argx));
                    d_expx_d_temp_dtn2__ = exp(vmax_b*argx)*(((Vbkd-vmax_b)*d_argx_d_temp_dtn2__+(d_Vbkd_d_temp_dtn2__-d_vmax_b_d_temp_dtn2__)*argx))+(exp(vmax_b*argx)*(vmax_b*d_argx_d_temp_dtn2__+d_vmax_b_d_temp_dtn2__*argx))*(1+(Vbkd-vmax_b)*argx);
                expx = exp(vmax_b*argx)*(1+(Vbkd-vmax_b)*argx);
            end
                d_Ib2_d_v_n1n2__ = -parm_ibv*(d_expx_d_v_n1n2__);
                d_Ib2_d_v_ncn2__ = -parm_ibv*(d_expx_d_v_ncn2__);
                d_Ib2_d_v_i2i1__ = -parm_ibv*(d_expx_d_v_i2i1__);
                d_Ib2_d_v_n1i1__ = -parm_ibv*(d_expx_d_v_n1i1__);
                d_Ib2_d_temp_dtn2__ = -parm_ibv*(d_expx_d_temp_dtn2__-exp(-vbv_t*argx)*(-vbv_t*d_argx_d_temp_dtn2__+-d_vbv_t_d_temp_dtn2__*argx));
            Ib2 = -parm_ibv*(expx-exp(-vbv_t*argx));
        else
                d_Ib2_d_v_n1n2__ = 0;
                d_Ib2_d_v_ncn2__ = 0;
                d_Ib2_d_v_i2i1__ = 0;
                d_Ib2_d_v_n1i1__ = 0;
                d_Ib2_d_temp_dtn2__ = 0;
            Ib2 = 0;
        end
            d_Ip2_d_v_n1n2__ = (d_Id2_d_v_n1n2__+d_Ib2_d_v_n1n2__)+(parm_gmin*d_Vc2_d_v_n1n2__);
            d_Ip2_d_v_ncn2__ = (d_Id2_d_v_ncn2__+d_Ib2_d_v_ncn2__)+(parm_gmin*d_Vc2_d_v_ncn2__);
            d_Ip2_d_v_i2i1__ = (d_Id2_d_v_i2i1__+d_Ib2_d_v_i2i1__)+(parm_gmin*d_Vc2_d_v_i2i1__);
            d_Ip2_d_v_n1i1__ = (d_Id2_d_v_n1i1__+d_Ib2_d_v_n1i1__)+(parm_gmin*d_Vc2_d_v_n1i1__);
            d_Ip2_d_temp_dtn2__ = (d_Id2_d_temp_dtn2__+d_Ib2_d_temp_dtn2__);
        Ip2 = (Id2+Ib2)+parm_gmin*Vc2;
    else
            d_Id2_d_v_n1n2__ = 0;
            d_Id2_d_v_ncn2__ = 0;
            d_Id2_d_v_i2i1__ = 0;
            d_Id2_d_v_n1i1__ = 0;
            d_Id2_d_temp_dtn2__ = 0;
        Id2 = 0;
            d_Ib2_d_v_n1n2__ = 0;
            d_Ib2_d_v_ncn2__ = 0;
            d_Ib2_d_v_i2i1__ = 0;
            d_Ib2_d_v_n1i1__ = 0;
            d_Ib2_d_temp_dtn2__ = 0;
        Ib2 = 0;
            d_Ip2_d_v_n1n2__ = 0;
            d_Ip2_d_v_ncn2__ = 0;
            d_Ip2_d_v_i2i1__ = 0;
            d_Ip2_d_v_n1i1__ = 0;
            d_Ip2_d_temp_dtn2__ = 0;
        Ip2 = 0;
    end
    if (gth>0&&parm_sw_et)&&~parm_sw_lin
            d_power_d_v_n1n2__ = ((((Ib*d_Vb_d_v_n1n2__+d_Ib_d_v_n1n2__*Vb)+(Ip1*d_Vc1_d_v_n1n2__+d_Ip1_d_v_n1n2__*Vc1))+(Ip2*d_Vc2_d_v_n1n2__+d_Ip2_d_v_n1n2__*Vc2))+(i_n1i1__*d_v_n1i1_d_v_n1n2__+d_i_n1i1_d_v_n1n2__*v_n1i1__))+(i_n2i2__*d_v_n2i2_d_v_n1n2__+d_i_n2i2_d_v_n1n2__*v_n2i2__);
            d_power_d_v_ncn2__ = ((((d_Ib_d_v_ncn2__*Vb)+(Ip1*d_Vc1_d_v_ncn2__+d_Ip1_d_v_ncn2__*Vc1))+(Ip2*d_Vc2_d_v_ncn2__+d_Ip2_d_v_ncn2__*Vc2)));
            d_power_d_v_i2i1__ = ((((Ib*d_Vb_d_v_i2i1__+d_Ib_d_v_i2i1__*Vb)+(Ip1*d_Vc1_d_v_i2i1__+d_Ip1_d_v_i2i1__*Vc1))+(Ip2*d_Vc2_d_v_i2i1__+d_Ip2_d_v_i2i1__*Vc2))+(i_n1i1__*d_v_n1i1_d_v_i2i1__+d_i_n1i1_d_v_i2i1__*v_n1i1__))+(i_n2i2__*d_v_n2i2_d_v_i2i1__+d_i_n2i2_d_v_i2i1__*v_n2i2__);
            d_power_d_v_n1i1__ = ((((d_Ib_d_v_n1i1__*Vb)+(Ip1*d_Vc1_d_v_n1i1__+d_Ip1_d_v_n1i1__*Vc1))+(Ip2*d_Vc2_d_v_n1i1__+d_Ip2_d_v_n1i1__*Vc2))+(i_n1i1__*1+d_i_n1i1_d_v_n1i1__*v_n1i1__))+(i_n2i2__*d_v_n2i2_d_v_n1i1__+d_i_n2i2_d_v_n1i1__*v_n2i2__);
            d_power_d_temp_dtn2__ = ((((d_Ib_d_temp_dtn2__*Vb)+(d_Ip1_d_temp_dtn2__*Vc1))+(d_Ip2_d_temp_dtn2__*Vc2))+(i_n1i1__*d_v_n1i1_d_temp_dtn2__+d_i_n1i1_d_temp_dtn2__*v_n1i1__))+(i_n2i2__*d_v_n2i2_d_temp_dtn2__+d_i_n2i2_d_temp_dtn2__*v_n2i2__);
            d_power_d_i_n2i2__ = ((i_n1i1__*d_v_n1i1_d_i_n2i2__+d_i_n1i1_d_i_n2i2__*v_n1i1__))+(i_n2i2__*d_v_n2i2_d_i_n2i2__+1*v_n2i2__);
            d_power_d_i_nci1__ = ((i_n1i1__*d_v_n1i1_d_i_nci1__+d_i_n1i1_d_i_nci1__*v_n1i1__));
            d_power_d_i_nci2__ = ((i_n1i1__*d_v_n1i1_d_i_nci2__+d_i_n1i1_d_i_nci2__*v_n1i1__));
        power = (((Ib*Vb+Ip1*Vc1)+Ip2*Vc2)+i_n1i1__*v_n1i1__)+i_n2i2__*v_n2i2__;
            d_Ith_d_v_n1n2__ = -d_power_d_v_n1n2__;
            d_Ith_d_v_ncn2__ = -d_power_d_v_ncn2__;
            d_Ith_d_v_i2i1__ = -d_power_d_v_i2i1__;
            d_Ith_d_v_n1i1__ = -d_power_d_v_n1i1__;
            d_Ith_d_temp_dtn2__ = -d_power_d_temp_dtn2__;
            d_Ith_d_i_n2i2__ = -d_power_d_i_n2i2__;
            d_Ith_d_i_nci1__ = -d_power_d_i_nci1__;
            d_Ith_d_i_nci2__ = -d_power_d_i_nci2__;
        Ith = -power;
        if parm_tegth==0
                d_Irth_d_temp_dtn2__ = gth*d_dt_et_d_temp_dtn2__;
            Irth = gth*dt_et;
        else
            tambC = (sim_temperature_vapp(MOD__)+parm_trise)-273.15;
            if tambC<parm_tminclip+1
                tambC = parm_tminclip+exp((tambC-parm_tminclip)-1);
            else
                if tambC>parm_tmaxclip-1
                    tambC = parm_tmaxclip-exp((parm_tmaxclip-tambC)-1);
                else
                    tambC = tambC;
                end
            end
            tambK = tambC+273.15;
            if abs(parm_tegth+1)>0.1
                    d_Irth_d_temp_dtn2__ = ((gth*tambK)*(d_pow_vapp_d_arg1__(1+dt_et/tambK, 1+parm_tegth)*((d_dt_et_d_temp_dtn2__/tambK))))/(1+parm_tegth);
                Irth = ((gth*tambK)*(pow_vapp(1+dt_et/tambK, 1+parm_tegth)-1))/(1+parm_tegth);
            else
                    d_Irth_d_temp_dtn2__ = (gth*dt_et)*((((0.5*parm_tegth)*d_dt_et_d_temp_dtn2__)/tambK))+(gth*d_dt_et_d_temp_dtn2__)*(1+((0.5*parm_tegth)*dt_et)/tambK);
                Irth = (gth*dt_et)*(1+((0.5*parm_tegth)*dt_et)/tambK);
            end
        end
    else
            d_power_d_v_n1n2__ = 0;
            d_power_d_v_ncn2__ = 0;
            d_power_d_v_i2i1__ = 0;
            d_power_d_v_n1i1__ = 0;
            d_power_d_temp_dtn2__ = 0;
            d_power_d_i_n2i2__ = 0;
            d_power_d_i_nci1__ = 0;
            d_power_d_i_nci2__ = 0;
        power = 0;
            d_Ith_d_v_n1n2__ = 0;
            d_Ith_d_v_ncn2__ = 0;
            d_Ith_d_v_i2i1__ = 0;
            d_Ith_d_v_n1i1__ = 0;
            d_Ith_d_temp_dtn2__ = 0;
            d_Ith_d_i_n2i2__ = 0;
            d_Ith_d_i_nci1__ = 0;
            d_Ith_d_i_nci2__ = 0;
        Ith = 0;
            d_Irth_d_temp_dtn2__ = 1000000*d_dt_et_d_temp_dtn2__;
        Irth = 1000000*dt_et;
    end
        d_Ib_d_v_n1n2__ = -parm_type*d_Ib_d_v_n1n2__;
        d_Ib_d_v_ncn2__ = -parm_type*d_Ib_d_v_ncn2__;
        d_Ib_d_v_i2i1__ = -parm_type*d_Ib_d_v_i2i1__;
        d_Ib_d_v_n1i1__ = -parm_type*d_Ib_d_v_n1i1__;
        d_Ib_d_temp_dtn2__ = -parm_type*d_Ib_d_temp_dtn2__;
    Ib = -parm_type*Ib;
        d_Ip1_d_v_n1n2__ = -parm_type*d_Ip1_d_v_n1n2__;
        d_Ip1_d_v_ncn2__ = -parm_type*d_Ip1_d_v_ncn2__;
        d_Ip1_d_v_i2i1__ = -parm_type*d_Ip1_d_v_i2i1__;
        d_Ip1_d_v_n1i1__ = -parm_type*d_Ip1_d_v_n1i1__;
        d_Ip1_d_temp_dtn2__ = -parm_type*d_Ip1_d_temp_dtn2__;
    Ip1 = -parm_type*Ip1;
        d_Ip2_d_v_n1n2__ = -parm_type*d_Ip2_d_v_n1n2__;
        d_Ip2_d_v_ncn2__ = -parm_type*d_Ip2_d_v_ncn2__;
        d_Ip2_d_v_i2i1__ = -parm_type*d_Ip2_d_v_i2i1__;
        d_Ip2_d_v_n1i1__ = -parm_type*d_Ip2_d_v_n1i1__;
        d_Ip2_d_temp_dtn2__ = -parm_type*d_Ip2_d_temp_dtn2__;
    Ip2 = -parm_type*Ip2;
    if abs(Ib/weff_um)>parm_jmax
        sim_strobe_vapp('WARNING: Ib current density is greater than specified by jmax');

    end
    if abs(Ip1/weff_um)>parm_jmax
        sim_strobe_vapp('WARNING: Ip1 current density is greater than specified by jmax');

    end
    if abs(Vc1)>parm_vmax
        sim_strobe_vapp('WARNING: V(i1,c) voltage is greater than specified by vmax');

    end
    if abs(Ip2/weff_um)>parm_jmax
        sim_strobe_vapp('WARNING: Ip2 current density is greater than specified by jmax');

    end
    if abs(Vc2)>parm_vmax
        sim_strobe_vapp('WARNING: V(i2,c) voltage is greater than specified by vmax');

    end
    if Cj1>0
            d_Vcl_d_v_n1n2__ = 0.5*((d_Vc1_d_v_n1n2__)+(1/(2*sqrt((Vc1+vpo)*(Vc1+vpo)+0.04)))*(((Vc1+vpo)*(d_Vc1_d_v_n1n2__)+(d_Vc1_d_v_n1n2__)*(Vc1+vpo))));
            d_Vcl_d_v_ncn2__ = 0.5*((d_Vc1_d_v_ncn2__)+(1/(2*sqrt((Vc1+vpo)*(Vc1+vpo)+0.04)))*(((Vc1+vpo)*(d_Vc1_d_v_ncn2__)+(d_Vc1_d_v_ncn2__)*(Vc1+vpo))));
            d_Vcl_d_v_i2i1__ = 0.5*((d_Vc1_d_v_i2i1__)+(1/(2*sqrt((Vc1+vpo)*(Vc1+vpo)+0.04)))*(((Vc1+vpo)*(d_Vc1_d_v_i2i1__)+(d_Vc1_d_v_i2i1__)*(Vc1+vpo))));
            d_Vcl_d_v_n1i1__ = 0.5*((d_Vc1_d_v_n1i1__)+(1/(2*sqrt((Vc1+vpo)*(Vc1+vpo)+0.04)))*(((Vc1+vpo)*(d_Vc1_d_v_n1i1__)+(d_Vc1_d_v_n1i1__)*(Vc1+vpo))));
        Vcl = 0.5*((Vc1-vpo)+sqrt((Vc1+vpo)*(Vc1+vpo)+0.04));
            d_acja_d_temp_dtn2__ = a1_um2*d_cja_t_d_temp_dtn2__;
        acja = a1_um2*cja_t;
            d_pcjp_d_temp_dtn2__ = p1_um*d_cjp_t_d_temp_dtn2__;
        pcjp = p1_um*cjp_t;
        if acja>0
                d_dv0_d_temp_dtn2__ = -d_pa_t_d_temp_dtn2__*parm_fc;
            dv0 = -pa_t*parm_fc;
            if parm_aja<=0
                    d_dvh_d_v_n1n2__ = d_Vcl_d_v_n1n2__;
                    d_dvh_d_v_ncn2__ = d_Vcl_d_v_ncn2__;
                    d_dvh_d_v_i2i1__ = d_Vcl_d_v_i2i1__;
                    d_dvh_d_v_n1i1__ = d_Vcl_d_v_n1i1__;
                    d_dvh_d_temp_dtn2__ = d_dv0_d_temp_dtn2__;
                dvh = Vcl+dv0;
                if dvh>0
                        d_pwq_d_v_n1n2__ = 0;
                        d_pwq_d_v_ncn2__ = 0;
                        d_pwq_d_v_i2i1__ = 0;
                        d_pwq_d_v_n1i1__ = 0;
                        d_pwq_d_temp_dtn2__ = 0;
                    pwq = pow_vapp(1-parm_fc, -parm_ma);
                        d_qlo_d_v_n1n2__ = (pa_t*(-(d_pwq_d_v_n1n2__*(1-parm_fc))))/(1-parm_ma);
                        d_qlo_d_v_ncn2__ = (pa_t*(-(d_pwq_d_v_ncn2__*(1-parm_fc))))/(1-parm_ma);
                        d_qlo_d_v_i2i1__ = (pa_t*(-(d_pwq_d_v_i2i1__*(1-parm_fc))))/(1-parm_ma);
                        d_qlo_d_v_n1i1__ = (pa_t*(-(d_pwq_d_v_n1i1__*(1-parm_fc))))/(1-parm_ma);
                        d_qlo_d_temp_dtn2__ = (pa_t*(-(d_pwq_d_temp_dtn2__*(1-parm_fc)))+d_pa_t_d_temp_dtn2__*(1-pwq*(1-parm_fc)))/(1-parm_ma);
                    qlo = (pa_t*(1-pwq*(1-parm_fc)))/(1-parm_ma);
                        d_qhi_d_v_n1n2__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_v_n1n2__+(dvh*((((0.5*parm_ma)*d_dvh_d_v_n1n2__)/(pa_t*(1-parm_fc))))+d_dvh_d_v_n1n2__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_ncn2__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_v_ncn2__+(dvh*((((0.5*parm_ma)*d_dvh_d_v_ncn2__)/(pa_t*(1-parm_fc))))+d_dvh_d_v_ncn2__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_i2i1__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_v_i2i1__+(dvh*((((0.5*parm_ma)*d_dvh_d_v_i2i1__)/(pa_t*(1-parm_fc))))+d_dvh_d_v_i2i1__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_n1i1__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_v_n1i1__+(dvh*((((0.5*parm_ma)*d_dvh_d_v_n1i1__)/(pa_t*(1-parm_fc))))+d_dvh_d_v_n1i1__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                        d_qhi_d_temp_dtn2__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_temp_dtn2__+(dvh*((((0.5*parm_ma)*d_dvh_d_temp_dtn2__)/(pa_t*(1-parm_fc))-(((0.5*parm_ma)*dvh)*(d_pa_t_d_temp_dtn2__*(1-parm_fc)))/(pa_t*(1-parm_fc))^2))+d_dvh_d_temp_dtn2__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                    qhi = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                else
                        d_qlo_d_v_n1n2__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(d_Vcl_d_v_n1n2__/pa_t))))/(1-parm_ma);
                        d_qlo_d_v_ncn2__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(d_Vcl_d_v_ncn2__/pa_t))))/(1-parm_ma);
                        d_qlo_d_v_i2i1__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(d_Vcl_d_v_i2i1__/pa_t))))/(1-parm_ma);
                        d_qlo_d_v_n1i1__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(d_Vcl_d_v_n1i1__/pa_t))))/(1-parm_ma);
                        d_qlo_d_temp_dtn2__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(-(Vcl*d_pa_t_d_temp_dtn2__)/pa_t^2)))+d_pa_t_d_temp_dtn2__*(1-pow_vapp(1-Vcl/pa_t, 1-parm_ma)))/(1-parm_ma);
                    qlo = (pa_t*(1-pow_vapp(1-Vcl/pa_t, 1-parm_ma)))/(1-parm_ma);
                        d_qhi_d_v_n1n2__ = 0;
                        d_qhi_d_v_ncn2__ = 0;
                        d_qhi_d_v_i2i1__ = 0;
                        d_qhi_d_v_n1i1__ = 0;
                        d_qhi_d_temp_dtn2__ = 0;
                    qhi = 0;
                end
                    d_arga_d_v_n1n2__ = d_qlo_d_v_n1n2__+d_qhi_d_v_n1n2__;
                    d_arga_d_v_ncn2__ = d_qlo_d_v_ncn2__+d_qhi_d_v_ncn2__;
                    d_arga_d_v_i2i1__ = d_qlo_d_v_i2i1__+d_qhi_d_v_i2i1__;
                    d_arga_d_v_n1i1__ = d_qlo_d_v_n1i1__+d_qhi_d_v_n1i1__;
                    d_arga_d_temp_dtn2__ = d_qlo_d_temp_dtn2__+d_qhi_d_temp_dtn2__;
                arga = qlo+qhi;
            else
                    d_mv0_d_temp_dtn2__ = (1/(2*sqrt(dv0*dv0+(4*parm_aja)*parm_aja)))*((dv0*d_dv0_d_temp_dtn2__+d_dv0_d_temp_dtn2__*dv0));
                mv0 = sqrt(dv0*dv0+(4*parm_aja)*parm_aja);
                    d_vl0_d_temp_dtn2__ = -0.5*(d_dv0_d_temp_dtn2__+d_mv0_d_temp_dtn2__);
                vl0 = -0.5*(dv0+mv0);
                    d_dv_d_v_n1n2__ = d_Vcl_d_v_n1n2__;
                    d_dv_d_v_ncn2__ = d_Vcl_d_v_ncn2__;
                    d_dv_d_v_i2i1__ = d_Vcl_d_v_i2i1__;
                    d_dv_d_v_n1i1__ = d_Vcl_d_v_n1i1__;
                    d_dv_d_temp_dtn2__ = d_dv0_d_temp_dtn2__;
                dv = Vcl+dv0;
                    d_mv_d_v_n1n2__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_v_n1n2__+d_dv_d_v_n1n2__*dv));
                    d_mv_d_v_ncn2__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_v_ncn2__+d_dv_d_v_ncn2__*dv));
                    d_mv_d_v_i2i1__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_v_i2i1__+d_dv_d_v_i2i1__*dv));
                    d_mv_d_v_n1i1__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_v_n1i1__+d_dv_d_v_n1i1__*dv));
                    d_mv_d_temp_dtn2__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_temp_dtn2__+d_dv_d_temp_dtn2__*dv));
                mv = sqrt(dv*dv+(4*parm_aja)*parm_aja);
                    d_vl_d_v_n1n2__ = (0.5*(d_dv_d_v_n1n2__-d_mv_d_v_n1n2__));
                    d_vl_d_v_ncn2__ = (0.5*(d_dv_d_v_ncn2__-d_mv_d_v_ncn2__));
                    d_vl_d_v_i2i1__ = (0.5*(d_dv_d_v_i2i1__-d_mv_d_v_i2i1__));
                    d_vl_d_v_n1i1__ = (0.5*(d_dv_d_v_n1i1__-d_mv_d_v_n1i1__));
                    d_vl_d_temp_dtn2__ = (0.5*(d_dv_d_temp_dtn2__-d_mv_d_temp_dtn2__))-d_dv0_d_temp_dtn2__;
                vl = 0.5*(dv-mv)-dv0;
                    d_qlo_d_v_n1n2__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_v_n1n2__/pa_t))))/(1-parm_ma);
                    d_qlo_d_v_ncn2__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_v_ncn2__/pa_t))))/(1-parm_ma);
                    d_qlo_d_v_i2i1__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_v_i2i1__/pa_t))))/(1-parm_ma);
                    d_qlo_d_v_n1i1__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_v_n1i1__/pa_t))))/(1-parm_ma);
                    d_qlo_d_temp_dtn2__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_temp_dtn2__/pa_t-(vl*d_pa_t_d_temp_dtn2__)/pa_t^2)))+-d_pa_t_d_temp_dtn2__*pow_vapp(1-vl/pa_t, 1-parm_ma))/(1-parm_ma);
                qlo = (-pa_t*pow_vapp(1-vl/pa_t, 1-parm_ma))/(1-parm_ma);
                    d_arga_d_v_n1n2__ = d_qlo_d_v_n1n2__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((d_Vcl_d_v_n1n2__-d_vl_d_v_n1n2__)))/(pa_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_ma)*((d_Vcl_d_v_n1n2__-d_vl_d_v_n1n2__)))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                    d_arga_d_v_ncn2__ = d_qlo_d_v_ncn2__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((d_Vcl_d_v_ncn2__-d_vl_d_v_ncn2__)))/(pa_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_ma)*((d_Vcl_d_v_ncn2__-d_vl_d_v_ncn2__)))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                    d_arga_d_v_i2i1__ = d_qlo_d_v_i2i1__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((d_Vcl_d_v_i2i1__-d_vl_d_v_i2i1__)))/(pa_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_ma)*((d_Vcl_d_v_i2i1__-d_vl_d_v_i2i1__)))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                    d_arga_d_v_n1i1__ = d_qlo_d_v_n1i1__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((d_Vcl_d_v_n1i1__-d_vl_d_v_n1i1__)))/(pa_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_ma)*((d_Vcl_d_v_n1i1__-d_vl_d_v_n1i1__)))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                    d_arga_d_temp_dtn2__ = d_qlo_d_temp_dtn2__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((-d_vl_d_temp_dtn2__)+d_vl0_d_temp_dtn2__))/(pa_t*(1-parm_fc))-(((0.5*parm_ma)*((Vcl-vl)+vl0))*(d_pa_t_d_temp_dtn2__*(1-parm_fc)))/(pa_t*(1-parm_fc))^2))+(pow_vapp(1-parm_fc, -parm_ma)*((-d_vl_d_temp_dtn2__)+d_vl0_d_temp_dtn2__))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                arga = qlo+(pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc)));
            end
        else
                d_arga_d_v_n1n2__ = 0;
                d_arga_d_v_ncn2__ = 0;
                d_arga_d_v_i2i1__ = 0;
                d_arga_d_v_n1i1__ = 0;
                d_arga_d_temp_dtn2__ = 0;
            arga = 0;
        end
        if pcjp>0
                d_dv0_d_temp_dtn2__ = -d_pp_t_d_temp_dtn2__*parm_fc;
            dv0 = -pp_t*parm_fc;
            if parm_ajp<=0
                    d_dvh_d_v_n1n2__ = d_Vcl_d_v_n1n2__;
                    d_dvh_d_v_ncn2__ = d_Vcl_d_v_ncn2__;
                    d_dvh_d_v_i2i1__ = d_Vcl_d_v_i2i1__;
                    d_dvh_d_v_n1i1__ = d_Vcl_d_v_n1i1__;
                    d_dvh_d_temp_dtn2__ = d_dv0_d_temp_dtn2__;
                dvh = Vcl+dv0;
                if dvh>0
                        d_pwq_d_v_n1n2__ = 0;
                        d_pwq_d_v_ncn2__ = 0;
                        d_pwq_d_v_i2i1__ = 0;
                        d_pwq_d_v_n1i1__ = 0;
                        d_pwq_d_temp_dtn2__ = 0;
                    pwq = pow_vapp(1-parm_fc, -parm_mp);
                        d_qlo_d_v_n1n2__ = (pp_t*(-(d_pwq_d_v_n1n2__*(1-parm_fc))))/(1-parm_mp);
                        d_qlo_d_v_ncn2__ = (pp_t*(-(d_pwq_d_v_ncn2__*(1-parm_fc))))/(1-parm_mp);
                        d_qlo_d_v_i2i1__ = (pp_t*(-(d_pwq_d_v_i2i1__*(1-parm_fc))))/(1-parm_mp);
                        d_qlo_d_v_n1i1__ = (pp_t*(-(d_pwq_d_v_n1i1__*(1-parm_fc))))/(1-parm_mp);
                        d_qlo_d_temp_dtn2__ = (pp_t*(-(d_pwq_d_temp_dtn2__*(1-parm_fc)))+d_pp_t_d_temp_dtn2__*(1-pwq*(1-parm_fc)))/(1-parm_mp);
                    qlo = (pp_t*(1-pwq*(1-parm_fc)))/(1-parm_mp);
                        d_qhi_d_v_n1n2__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_v_n1n2__+(dvh*((((0.5*parm_mp)*d_dvh_d_v_n1n2__)/(pp_t*(1-parm_fc))))+d_dvh_d_v_n1n2__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_ncn2__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_v_ncn2__+(dvh*((((0.5*parm_mp)*d_dvh_d_v_ncn2__)/(pp_t*(1-parm_fc))))+d_dvh_d_v_ncn2__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_i2i1__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_v_i2i1__+(dvh*((((0.5*parm_mp)*d_dvh_d_v_i2i1__)/(pp_t*(1-parm_fc))))+d_dvh_d_v_i2i1__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_n1i1__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_v_n1i1__+(dvh*((((0.5*parm_mp)*d_dvh_d_v_n1i1__)/(pp_t*(1-parm_fc))))+d_dvh_d_v_n1i1__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                        d_qhi_d_temp_dtn2__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_temp_dtn2__+(dvh*((((0.5*parm_mp)*d_dvh_d_temp_dtn2__)/(pp_t*(1-parm_fc))-(((0.5*parm_mp)*dvh)*(d_pp_t_d_temp_dtn2__*(1-parm_fc)))/(pp_t*(1-parm_fc))^2))+d_dvh_d_temp_dtn2__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                    qhi = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                else
                        d_qlo_d_v_n1n2__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(d_Vcl_d_v_n1n2__/pp_t))))/(1-parm_mp);
                        d_qlo_d_v_ncn2__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(d_Vcl_d_v_ncn2__/pp_t))))/(1-parm_mp);
                        d_qlo_d_v_i2i1__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(d_Vcl_d_v_i2i1__/pp_t))))/(1-parm_mp);
                        d_qlo_d_v_n1i1__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(d_Vcl_d_v_n1i1__/pp_t))))/(1-parm_mp);
                        d_qlo_d_temp_dtn2__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(-(Vcl*d_pp_t_d_temp_dtn2__)/pp_t^2)))+d_pp_t_d_temp_dtn2__*(1-pow_vapp(1-Vcl/pp_t, 1-parm_mp)))/(1-parm_mp);
                    qlo = (pp_t*(1-pow_vapp(1-Vcl/pp_t, 1-parm_mp)))/(1-parm_mp);
                        d_qhi_d_v_n1n2__ = 0;
                        d_qhi_d_v_ncn2__ = 0;
                        d_qhi_d_v_i2i1__ = 0;
                        d_qhi_d_v_n1i1__ = 0;
                        d_qhi_d_temp_dtn2__ = 0;
                    qhi = 0;
                end
                    d_argp_d_v_n1n2__ = d_qlo_d_v_n1n2__+d_qhi_d_v_n1n2__;
                    d_argp_d_v_ncn2__ = d_qlo_d_v_ncn2__+d_qhi_d_v_ncn2__;
                    d_argp_d_v_i2i1__ = d_qlo_d_v_i2i1__+d_qhi_d_v_i2i1__;
                    d_argp_d_v_n1i1__ = d_qlo_d_v_n1i1__+d_qhi_d_v_n1i1__;
                    d_argp_d_temp_dtn2__ = d_qlo_d_temp_dtn2__+d_qhi_d_temp_dtn2__;
                argp = qlo+qhi;
            else
                    d_mv0_d_temp_dtn2__ = (1/(2*sqrt(dv0*dv0+(4*parm_ajp)*parm_ajp)))*((dv0*d_dv0_d_temp_dtn2__+d_dv0_d_temp_dtn2__*dv0));
                mv0 = sqrt(dv0*dv0+(4*parm_ajp)*parm_ajp);
                    d_vl0_d_temp_dtn2__ = -0.5*(d_dv0_d_temp_dtn2__+d_mv0_d_temp_dtn2__);
                vl0 = -0.5*(dv0+mv0);
                    d_dv_d_v_n1n2__ = d_Vcl_d_v_n1n2__;
                    d_dv_d_v_ncn2__ = d_Vcl_d_v_ncn2__;
                    d_dv_d_v_i2i1__ = d_Vcl_d_v_i2i1__;
                    d_dv_d_v_n1i1__ = d_Vcl_d_v_n1i1__;
                    d_dv_d_temp_dtn2__ = d_dv0_d_temp_dtn2__;
                dv = Vcl+dv0;
                    d_mv_d_v_n1n2__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_v_n1n2__+d_dv_d_v_n1n2__*dv));
                    d_mv_d_v_ncn2__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_v_ncn2__+d_dv_d_v_ncn2__*dv));
                    d_mv_d_v_i2i1__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_v_i2i1__+d_dv_d_v_i2i1__*dv));
                    d_mv_d_v_n1i1__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_v_n1i1__+d_dv_d_v_n1i1__*dv));
                    d_mv_d_temp_dtn2__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_temp_dtn2__+d_dv_d_temp_dtn2__*dv));
                mv = sqrt(dv*dv+(4*parm_ajp)*parm_ajp);
                    d_vl_d_v_n1n2__ = (0.5*(d_dv_d_v_n1n2__-d_mv_d_v_n1n2__));
                    d_vl_d_v_ncn2__ = (0.5*(d_dv_d_v_ncn2__-d_mv_d_v_ncn2__));
                    d_vl_d_v_i2i1__ = (0.5*(d_dv_d_v_i2i1__-d_mv_d_v_i2i1__));
                    d_vl_d_v_n1i1__ = (0.5*(d_dv_d_v_n1i1__-d_mv_d_v_n1i1__));
                    d_vl_d_temp_dtn2__ = (0.5*(d_dv_d_temp_dtn2__-d_mv_d_temp_dtn2__))-d_dv0_d_temp_dtn2__;
                vl = 0.5*(dv-mv)-dv0;
                    d_qlo_d_v_n1n2__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_v_n1n2__/pp_t))))/(1-parm_mp);
                    d_qlo_d_v_ncn2__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_v_ncn2__/pp_t))))/(1-parm_mp);
                    d_qlo_d_v_i2i1__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_v_i2i1__/pp_t))))/(1-parm_mp);
                    d_qlo_d_v_n1i1__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_v_n1i1__/pp_t))))/(1-parm_mp);
                    d_qlo_d_temp_dtn2__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_temp_dtn2__/pp_t-(vl*d_pp_t_d_temp_dtn2__)/pp_t^2)))+-d_pp_t_d_temp_dtn2__*pow_vapp(1-vl/pp_t, 1-parm_mp))/(1-parm_mp);
                qlo = (-pp_t*pow_vapp(1-vl/pp_t, 1-parm_mp))/(1-parm_mp);
                    d_argp_d_v_n1n2__ = d_qlo_d_v_n1n2__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((d_Vcl_d_v_n1n2__-d_vl_d_v_n1n2__)))/(pp_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_mp)*((d_Vcl_d_v_n1n2__-d_vl_d_v_n1n2__)))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                    d_argp_d_v_ncn2__ = d_qlo_d_v_ncn2__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((d_Vcl_d_v_ncn2__-d_vl_d_v_ncn2__)))/(pp_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_mp)*((d_Vcl_d_v_ncn2__-d_vl_d_v_ncn2__)))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                    d_argp_d_v_i2i1__ = d_qlo_d_v_i2i1__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((d_Vcl_d_v_i2i1__-d_vl_d_v_i2i1__)))/(pp_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_mp)*((d_Vcl_d_v_i2i1__-d_vl_d_v_i2i1__)))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                    d_argp_d_v_n1i1__ = d_qlo_d_v_n1i1__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((d_Vcl_d_v_n1i1__-d_vl_d_v_n1i1__)))/(pp_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_mp)*((d_Vcl_d_v_n1i1__-d_vl_d_v_n1i1__)))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                    d_argp_d_temp_dtn2__ = d_qlo_d_temp_dtn2__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((-d_vl_d_temp_dtn2__)+d_vl0_d_temp_dtn2__))/(pp_t*(1-parm_fc))-(((0.5*parm_mp)*((Vcl-vl)+vl0))*(d_pp_t_d_temp_dtn2__*(1-parm_fc)))/(pp_t*(1-parm_fc))^2))+(pow_vapp(1-parm_fc, -parm_mp)*((-d_vl_d_temp_dtn2__)+d_vl0_d_temp_dtn2__))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                argp = qlo+(pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc)));
            end
        else
                d_argp_d_v_n1n2__ = 0;
                d_argp_d_v_ncn2__ = 0;
                d_argp_d_v_i2i1__ = 0;
                d_argp_d_v_n1i1__ = 0;
                d_argp_d_temp_dtn2__ = 0;
            argp = 0;
        end
            d_Qcp1_d_v_n1n2__ = (acja*d_arga_d_v_n1n2__)+(pcjp*d_argp_d_v_n1n2__);
            d_Qcp1_d_v_ncn2__ = (acja*d_arga_d_v_ncn2__)+(pcjp*d_argp_d_v_ncn2__);
            d_Qcp1_d_v_i2i1__ = (acja*d_arga_d_v_i2i1__)+(pcjp*d_argp_d_v_i2i1__);
            d_Qcp1_d_v_n1i1__ = (acja*d_arga_d_v_n1i1__)+(pcjp*d_argp_d_v_n1i1__);
            d_Qcp1_d_temp_dtn2__ = (acja*d_arga_d_temp_dtn2__+d_acja_d_temp_dtn2__*arga)+(pcjp*d_argp_d_temp_dtn2__+d_pcjp_d_temp_dtn2__*argp);
        Qcp1 = acja*arga+pcjp*argp;
    else
            d_Qcp1_d_v_n1n2__ = 0;
            d_Qcp1_d_v_ncn2__ = 0;
            d_Qcp1_d_v_i2i1__ = 0;
            d_Qcp1_d_v_n1i1__ = 0;
            d_Qcp1_d_temp_dtn2__ = 0;
        Qcp1 = 0;
    end
    if Cj2>0
            d_Vcl_d_v_n1n2__ = 0.5*((d_Vc2_d_v_n1n2__)+(1/(2*sqrt((Vc2+vpo)*(Vc2+vpo)+0.04)))*(((Vc2+vpo)*(d_Vc2_d_v_n1n2__)+(d_Vc2_d_v_n1n2__)*(Vc2+vpo))));
            d_Vcl_d_v_ncn2__ = 0.5*((d_Vc2_d_v_ncn2__)+(1/(2*sqrt((Vc2+vpo)*(Vc2+vpo)+0.04)))*(((Vc2+vpo)*(d_Vc2_d_v_ncn2__)+(d_Vc2_d_v_ncn2__)*(Vc2+vpo))));
            d_Vcl_d_v_i2i1__ = 0.5*((d_Vc2_d_v_i2i1__)+(1/(2*sqrt((Vc2+vpo)*(Vc2+vpo)+0.04)))*(((Vc2+vpo)*(d_Vc2_d_v_i2i1__)+(d_Vc2_d_v_i2i1__)*(Vc2+vpo))));
            d_Vcl_d_v_n1i1__ = 0.5*((d_Vc2_d_v_n1i1__)+(1/(2*sqrt((Vc2+vpo)*(Vc2+vpo)+0.04)))*(((Vc2+vpo)*(d_Vc2_d_v_n1i1__)+(d_Vc2_d_v_n1i1__)*(Vc2+vpo))));
        Vcl = 0.5*((Vc2-vpo)+sqrt((Vc2+vpo)*(Vc2+vpo)+0.04));
            d_acja_d_temp_dtn2__ = a2_um2*d_cja_t_d_temp_dtn2__;
        acja = a2_um2*cja_t;
            d_pcjp_d_temp_dtn2__ = p2_um*d_cjp_t_d_temp_dtn2__;
        pcjp = p2_um*cjp_t;
        if acja>0
                d_dv0_d_temp_dtn2__ = -d_pa_t_d_temp_dtn2__*parm_fc;
            dv0 = -pa_t*parm_fc;
            if parm_aja<=0
                    d_dvh_d_v_n1n2__ = d_Vcl_d_v_n1n2__;
                    d_dvh_d_v_ncn2__ = d_Vcl_d_v_ncn2__;
                    d_dvh_d_v_i2i1__ = d_Vcl_d_v_i2i1__;
                    d_dvh_d_v_n1i1__ = d_Vcl_d_v_n1i1__;
                    d_dvh_d_temp_dtn2__ = d_dv0_d_temp_dtn2__;
                dvh = Vcl+dv0;
                if dvh>0
                        d_pwq_d_v_n1n2__ = 0;
                        d_pwq_d_v_ncn2__ = 0;
                        d_pwq_d_v_i2i1__ = 0;
                        d_pwq_d_v_n1i1__ = 0;
                        d_pwq_d_temp_dtn2__ = 0;
                    pwq = pow_vapp(1-parm_fc, -parm_ma);
                        d_qlo_d_v_n1n2__ = (pa_t*(-(d_pwq_d_v_n1n2__*(1-parm_fc))))/(1-parm_ma);
                        d_qlo_d_v_ncn2__ = (pa_t*(-(d_pwq_d_v_ncn2__*(1-parm_fc))))/(1-parm_ma);
                        d_qlo_d_v_i2i1__ = (pa_t*(-(d_pwq_d_v_i2i1__*(1-parm_fc))))/(1-parm_ma);
                        d_qlo_d_v_n1i1__ = (pa_t*(-(d_pwq_d_v_n1i1__*(1-parm_fc))))/(1-parm_ma);
                        d_qlo_d_temp_dtn2__ = (pa_t*(-(d_pwq_d_temp_dtn2__*(1-parm_fc)))+d_pa_t_d_temp_dtn2__*(1-pwq*(1-parm_fc)))/(1-parm_ma);
                    qlo = (pa_t*(1-pwq*(1-parm_fc)))/(1-parm_ma);
                        d_qhi_d_v_n1n2__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_v_n1n2__+(dvh*((((0.5*parm_ma)*d_dvh_d_v_n1n2__)/(pa_t*(1-parm_fc))))+d_dvh_d_v_n1n2__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_ncn2__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_v_ncn2__+(dvh*((((0.5*parm_ma)*d_dvh_d_v_ncn2__)/(pa_t*(1-parm_fc))))+d_dvh_d_v_ncn2__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_i2i1__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_v_i2i1__+(dvh*((((0.5*parm_ma)*d_dvh_d_v_i2i1__)/(pa_t*(1-parm_fc))))+d_dvh_d_v_i2i1__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_n1i1__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_v_n1i1__+(dvh*((((0.5*parm_ma)*d_dvh_d_v_n1i1__)/(pa_t*(1-parm_fc))))+d_dvh_d_v_n1i1__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                        d_qhi_d_temp_dtn2__ = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*d_pwq_d_temp_dtn2__+(dvh*((((0.5*parm_ma)*d_dvh_d_temp_dtn2__)/(pa_t*(1-parm_fc))-(((0.5*parm_ma)*dvh)*(d_pa_t_d_temp_dtn2__*(1-parm_fc)))/(pa_t*(1-parm_fc))^2))+d_dvh_d_temp_dtn2__*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                    qhi = (dvh*(1+((0.5*parm_ma)*dvh)/(pa_t*(1-parm_fc))))*pwq;
                else
                        d_qlo_d_v_n1n2__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(d_Vcl_d_v_n1n2__/pa_t))))/(1-parm_ma);
                        d_qlo_d_v_ncn2__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(d_Vcl_d_v_ncn2__/pa_t))))/(1-parm_ma);
                        d_qlo_d_v_i2i1__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(d_Vcl_d_v_i2i1__/pa_t))))/(1-parm_ma);
                        d_qlo_d_v_n1i1__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(d_Vcl_d_v_n1i1__/pa_t))))/(1-parm_ma);
                        d_qlo_d_temp_dtn2__ = (pa_t*(-d_pow_vapp_d_arg1__(1-Vcl/pa_t, 1-parm_ma)*(-(-(Vcl*d_pa_t_d_temp_dtn2__)/pa_t^2)))+d_pa_t_d_temp_dtn2__*(1-pow_vapp(1-Vcl/pa_t, 1-parm_ma)))/(1-parm_ma);
                    qlo = (pa_t*(1-pow_vapp(1-Vcl/pa_t, 1-parm_ma)))/(1-parm_ma);
                        d_qhi_d_v_n1n2__ = 0;
                        d_qhi_d_v_ncn2__ = 0;
                        d_qhi_d_v_i2i1__ = 0;
                        d_qhi_d_v_n1i1__ = 0;
                        d_qhi_d_temp_dtn2__ = 0;
                    qhi = 0;
                end
                    d_arga_d_v_n1n2__ = d_qlo_d_v_n1n2__+d_qhi_d_v_n1n2__;
                    d_arga_d_v_ncn2__ = d_qlo_d_v_ncn2__+d_qhi_d_v_ncn2__;
                    d_arga_d_v_i2i1__ = d_qlo_d_v_i2i1__+d_qhi_d_v_i2i1__;
                    d_arga_d_v_n1i1__ = d_qlo_d_v_n1i1__+d_qhi_d_v_n1i1__;
                    d_arga_d_temp_dtn2__ = d_qlo_d_temp_dtn2__+d_qhi_d_temp_dtn2__;
                arga = qlo+qhi;
            else
                    d_mv0_d_temp_dtn2__ = (1/(2*sqrt(dv0*dv0+(4*parm_aja)*parm_aja)))*((dv0*d_dv0_d_temp_dtn2__+d_dv0_d_temp_dtn2__*dv0));
                mv0 = sqrt(dv0*dv0+(4*parm_aja)*parm_aja);
                    d_vl0_d_temp_dtn2__ = -0.5*(d_dv0_d_temp_dtn2__+d_mv0_d_temp_dtn2__);
                vl0 = -0.5*(dv0+mv0);
                    d_dv_d_v_n1n2__ = d_Vcl_d_v_n1n2__;
                    d_dv_d_v_ncn2__ = d_Vcl_d_v_ncn2__;
                    d_dv_d_v_i2i1__ = d_Vcl_d_v_i2i1__;
                    d_dv_d_v_n1i1__ = d_Vcl_d_v_n1i1__;
                    d_dv_d_temp_dtn2__ = d_dv0_d_temp_dtn2__;
                dv = Vcl+dv0;
                    d_mv_d_v_n1n2__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_v_n1n2__+d_dv_d_v_n1n2__*dv));
                    d_mv_d_v_ncn2__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_v_ncn2__+d_dv_d_v_ncn2__*dv));
                    d_mv_d_v_i2i1__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_v_i2i1__+d_dv_d_v_i2i1__*dv));
                    d_mv_d_v_n1i1__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_v_n1i1__+d_dv_d_v_n1i1__*dv));
                    d_mv_d_temp_dtn2__ = (1/(2*sqrt(dv*dv+(4*parm_aja)*parm_aja)))*((dv*d_dv_d_temp_dtn2__+d_dv_d_temp_dtn2__*dv));
                mv = sqrt(dv*dv+(4*parm_aja)*parm_aja);
                    d_vl_d_v_n1n2__ = (0.5*(d_dv_d_v_n1n2__-d_mv_d_v_n1n2__));
                    d_vl_d_v_ncn2__ = (0.5*(d_dv_d_v_ncn2__-d_mv_d_v_ncn2__));
                    d_vl_d_v_i2i1__ = (0.5*(d_dv_d_v_i2i1__-d_mv_d_v_i2i1__));
                    d_vl_d_v_n1i1__ = (0.5*(d_dv_d_v_n1i1__-d_mv_d_v_n1i1__));
                    d_vl_d_temp_dtn2__ = (0.5*(d_dv_d_temp_dtn2__-d_mv_d_temp_dtn2__))-d_dv0_d_temp_dtn2__;
                vl = 0.5*(dv-mv)-dv0;
                    d_qlo_d_v_n1n2__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_v_n1n2__/pa_t))))/(1-parm_ma);
                    d_qlo_d_v_ncn2__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_v_ncn2__/pa_t))))/(1-parm_ma);
                    d_qlo_d_v_i2i1__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_v_i2i1__/pa_t))))/(1-parm_ma);
                    d_qlo_d_v_n1i1__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_v_n1i1__/pa_t))))/(1-parm_ma);
                    d_qlo_d_temp_dtn2__ = (-pa_t*(d_pow_vapp_d_arg1__(1-vl/pa_t, 1-parm_ma)*(-(d_vl_d_temp_dtn2__/pa_t-(vl*d_pa_t_d_temp_dtn2__)/pa_t^2)))+-d_pa_t_d_temp_dtn2__*pow_vapp(1-vl/pa_t, 1-parm_ma))/(1-parm_ma);
                qlo = (-pa_t*pow_vapp(1-vl/pa_t, 1-parm_ma))/(1-parm_ma);
                    d_arga_d_v_n1n2__ = d_qlo_d_v_n1n2__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((d_Vcl_d_v_n1n2__-d_vl_d_v_n1n2__)))/(pa_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_ma)*((d_Vcl_d_v_n1n2__-d_vl_d_v_n1n2__)))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                    d_arga_d_v_ncn2__ = d_qlo_d_v_ncn2__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((d_Vcl_d_v_ncn2__-d_vl_d_v_ncn2__)))/(pa_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_ma)*((d_Vcl_d_v_ncn2__-d_vl_d_v_ncn2__)))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                    d_arga_d_v_i2i1__ = d_qlo_d_v_i2i1__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((d_Vcl_d_v_i2i1__-d_vl_d_v_i2i1__)))/(pa_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_ma)*((d_Vcl_d_v_i2i1__-d_vl_d_v_i2i1__)))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                    d_arga_d_v_n1i1__ = d_qlo_d_v_n1i1__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((d_Vcl_d_v_n1i1__-d_vl_d_v_n1i1__)))/(pa_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_ma)*((d_Vcl_d_v_n1i1__-d_vl_d_v_n1i1__)))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                    d_arga_d_temp_dtn2__ = d_qlo_d_temp_dtn2__+((pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*((((0.5*parm_ma)*((-d_vl_d_temp_dtn2__)+d_vl0_d_temp_dtn2__))/(pa_t*(1-parm_fc))-(((0.5*parm_ma)*((Vcl-vl)+vl0))*(d_pa_t_d_temp_dtn2__*(1-parm_fc)))/(pa_t*(1-parm_fc))^2))+(pow_vapp(1-parm_fc, -parm_ma)*((-d_vl_d_temp_dtn2__)+d_vl0_d_temp_dtn2__))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc))));
                arga = qlo+(pow_vapp(1-parm_fc, -parm_ma)*((Vcl-vl)+vl0))*(1+((0.5*parm_ma)*((Vcl-vl)+vl0))/(pa_t*(1-parm_fc)));
            end
        else
                d_arga_d_v_n1n2__ = 0;
                d_arga_d_v_ncn2__ = 0;
                d_arga_d_v_i2i1__ = 0;
                d_arga_d_v_n1i1__ = 0;
                d_arga_d_temp_dtn2__ = 0;
            arga = 0;
        end
        if pcjp>0
                d_dv0_d_temp_dtn2__ = -d_pp_t_d_temp_dtn2__*parm_fc;
            dv0 = -pp_t*parm_fc;
            if parm_ajp<=0
                    d_dvh_d_v_n1n2__ = d_Vcl_d_v_n1n2__;
                    d_dvh_d_v_ncn2__ = d_Vcl_d_v_ncn2__;
                    d_dvh_d_v_i2i1__ = d_Vcl_d_v_i2i1__;
                    d_dvh_d_v_n1i1__ = d_Vcl_d_v_n1i1__;
                    d_dvh_d_temp_dtn2__ = d_dv0_d_temp_dtn2__;
                dvh = Vcl+dv0;
                if dvh>0
                        d_pwq_d_v_n1n2__ = 0;
                        d_pwq_d_v_ncn2__ = 0;
                        d_pwq_d_v_i2i1__ = 0;
                        d_pwq_d_v_n1i1__ = 0;
                        d_pwq_d_temp_dtn2__ = 0;
                    pwq = pow_vapp(1-parm_fc, -parm_mp);
                        d_qlo_d_v_n1n2__ = (pp_t*(-(d_pwq_d_v_n1n2__*(1-parm_fc))))/(1-parm_mp);
                        d_qlo_d_v_ncn2__ = (pp_t*(-(d_pwq_d_v_ncn2__*(1-parm_fc))))/(1-parm_mp);
                        d_qlo_d_v_i2i1__ = (pp_t*(-(d_pwq_d_v_i2i1__*(1-parm_fc))))/(1-parm_mp);
                        d_qlo_d_v_n1i1__ = (pp_t*(-(d_pwq_d_v_n1i1__*(1-parm_fc))))/(1-parm_mp);
                        d_qlo_d_temp_dtn2__ = (pp_t*(-(d_pwq_d_temp_dtn2__*(1-parm_fc)))+d_pp_t_d_temp_dtn2__*(1-pwq*(1-parm_fc)))/(1-parm_mp);
                    qlo = (pp_t*(1-pwq*(1-parm_fc)))/(1-parm_mp);
                        d_qhi_d_v_n1n2__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_v_n1n2__+(dvh*((((0.5*parm_mp)*d_dvh_d_v_n1n2__)/(pp_t*(1-parm_fc))))+d_dvh_d_v_n1n2__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_ncn2__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_v_ncn2__+(dvh*((((0.5*parm_mp)*d_dvh_d_v_ncn2__)/(pp_t*(1-parm_fc))))+d_dvh_d_v_ncn2__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_i2i1__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_v_i2i1__+(dvh*((((0.5*parm_mp)*d_dvh_d_v_i2i1__)/(pp_t*(1-parm_fc))))+d_dvh_d_v_i2i1__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                        d_qhi_d_v_n1i1__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_v_n1i1__+(dvh*((((0.5*parm_mp)*d_dvh_d_v_n1i1__)/(pp_t*(1-parm_fc))))+d_dvh_d_v_n1i1__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                        d_qhi_d_temp_dtn2__ = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*d_pwq_d_temp_dtn2__+(dvh*((((0.5*parm_mp)*d_dvh_d_temp_dtn2__)/(pp_t*(1-parm_fc))-(((0.5*parm_mp)*dvh)*(d_pp_t_d_temp_dtn2__*(1-parm_fc)))/(pp_t*(1-parm_fc))^2))+d_dvh_d_temp_dtn2__*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                    qhi = (dvh*(1+((0.5*parm_mp)*dvh)/(pp_t*(1-parm_fc))))*pwq;
                else
                        d_qlo_d_v_n1n2__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(d_Vcl_d_v_n1n2__/pp_t))))/(1-parm_mp);
                        d_qlo_d_v_ncn2__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(d_Vcl_d_v_ncn2__/pp_t))))/(1-parm_mp);
                        d_qlo_d_v_i2i1__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(d_Vcl_d_v_i2i1__/pp_t))))/(1-parm_mp);
                        d_qlo_d_v_n1i1__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(d_Vcl_d_v_n1i1__/pp_t))))/(1-parm_mp);
                        d_qlo_d_temp_dtn2__ = (pp_t*(-d_pow_vapp_d_arg1__(1-Vcl/pp_t, 1-parm_mp)*(-(-(Vcl*d_pp_t_d_temp_dtn2__)/pp_t^2)))+d_pp_t_d_temp_dtn2__*(1-pow_vapp(1-Vcl/pp_t, 1-parm_mp)))/(1-parm_mp);
                    qlo = (pp_t*(1-pow_vapp(1-Vcl/pp_t, 1-parm_mp)))/(1-parm_mp);
                        d_qhi_d_v_n1n2__ = 0;
                        d_qhi_d_v_ncn2__ = 0;
                        d_qhi_d_v_i2i1__ = 0;
                        d_qhi_d_v_n1i1__ = 0;
                        d_qhi_d_temp_dtn2__ = 0;
                    qhi = 0;
                end
                    d_argp_d_v_n1n2__ = d_qlo_d_v_n1n2__+d_qhi_d_v_n1n2__;
                    d_argp_d_v_ncn2__ = d_qlo_d_v_ncn2__+d_qhi_d_v_ncn2__;
                    d_argp_d_v_i2i1__ = d_qlo_d_v_i2i1__+d_qhi_d_v_i2i1__;
                    d_argp_d_v_n1i1__ = d_qlo_d_v_n1i1__+d_qhi_d_v_n1i1__;
                    d_argp_d_temp_dtn2__ = d_qlo_d_temp_dtn2__+d_qhi_d_temp_dtn2__;
                argp = qlo+qhi;
            else
                    d_mv0_d_temp_dtn2__ = (1/(2*sqrt(dv0*dv0+(4*parm_ajp)*parm_ajp)))*((dv0*d_dv0_d_temp_dtn2__+d_dv0_d_temp_dtn2__*dv0));
                mv0 = sqrt(dv0*dv0+(4*parm_ajp)*parm_ajp);
                    d_vl0_d_temp_dtn2__ = -0.5*(d_dv0_d_temp_dtn2__+d_mv0_d_temp_dtn2__);
                vl0 = -0.5*(dv0+mv0);
                    d_dv_d_v_n1n2__ = d_Vcl_d_v_n1n2__;
                    d_dv_d_v_ncn2__ = d_Vcl_d_v_ncn2__;
                    d_dv_d_v_i2i1__ = d_Vcl_d_v_i2i1__;
                    d_dv_d_v_n1i1__ = d_Vcl_d_v_n1i1__;
                    d_dv_d_temp_dtn2__ = d_dv0_d_temp_dtn2__;
                dv = Vcl+dv0;
                    d_mv_d_v_n1n2__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_v_n1n2__+d_dv_d_v_n1n2__*dv));
                    d_mv_d_v_ncn2__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_v_ncn2__+d_dv_d_v_ncn2__*dv));
                    d_mv_d_v_i2i1__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_v_i2i1__+d_dv_d_v_i2i1__*dv));
                    d_mv_d_v_n1i1__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_v_n1i1__+d_dv_d_v_n1i1__*dv));
                    d_mv_d_temp_dtn2__ = (1/(2*sqrt(dv*dv+(4*parm_ajp)*parm_ajp)))*((dv*d_dv_d_temp_dtn2__+d_dv_d_temp_dtn2__*dv));
                mv = sqrt(dv*dv+(4*parm_ajp)*parm_ajp);
                    d_vl_d_v_n1n2__ = (0.5*(d_dv_d_v_n1n2__-d_mv_d_v_n1n2__));
                    d_vl_d_v_ncn2__ = (0.5*(d_dv_d_v_ncn2__-d_mv_d_v_ncn2__));
                    d_vl_d_v_i2i1__ = (0.5*(d_dv_d_v_i2i1__-d_mv_d_v_i2i1__));
                    d_vl_d_v_n1i1__ = (0.5*(d_dv_d_v_n1i1__-d_mv_d_v_n1i1__));
                    d_vl_d_temp_dtn2__ = (0.5*(d_dv_d_temp_dtn2__-d_mv_d_temp_dtn2__))-d_dv0_d_temp_dtn2__;
                vl = 0.5*(dv-mv)-dv0;
                    d_qlo_d_v_n1n2__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_v_n1n2__/pp_t))))/(1-parm_mp);
                    d_qlo_d_v_ncn2__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_v_ncn2__/pp_t))))/(1-parm_mp);
                    d_qlo_d_v_i2i1__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_v_i2i1__/pp_t))))/(1-parm_mp);
                    d_qlo_d_v_n1i1__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_v_n1i1__/pp_t))))/(1-parm_mp);
                    d_qlo_d_temp_dtn2__ = (-pp_t*(d_pow_vapp_d_arg1__(1-vl/pp_t, 1-parm_mp)*(-(d_vl_d_temp_dtn2__/pp_t-(vl*d_pp_t_d_temp_dtn2__)/pp_t^2)))+-d_pp_t_d_temp_dtn2__*pow_vapp(1-vl/pp_t, 1-parm_mp))/(1-parm_mp);
                qlo = (-pp_t*pow_vapp(1-vl/pp_t, 1-parm_mp))/(1-parm_mp);
                    d_argp_d_v_n1n2__ = d_qlo_d_v_n1n2__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((d_Vcl_d_v_n1n2__-d_vl_d_v_n1n2__)))/(pp_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_mp)*((d_Vcl_d_v_n1n2__-d_vl_d_v_n1n2__)))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                    d_argp_d_v_ncn2__ = d_qlo_d_v_ncn2__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((d_Vcl_d_v_ncn2__-d_vl_d_v_ncn2__)))/(pp_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_mp)*((d_Vcl_d_v_ncn2__-d_vl_d_v_ncn2__)))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                    d_argp_d_v_i2i1__ = d_qlo_d_v_i2i1__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((d_Vcl_d_v_i2i1__-d_vl_d_v_i2i1__)))/(pp_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_mp)*((d_Vcl_d_v_i2i1__-d_vl_d_v_i2i1__)))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                    d_argp_d_v_n1i1__ = d_qlo_d_v_n1i1__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((d_Vcl_d_v_n1i1__-d_vl_d_v_n1i1__)))/(pp_t*(1-parm_fc))))+(pow_vapp(1-parm_fc, -parm_mp)*((d_Vcl_d_v_n1i1__-d_vl_d_v_n1i1__)))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                    d_argp_d_temp_dtn2__ = d_qlo_d_temp_dtn2__+((pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*((((0.5*parm_mp)*((-d_vl_d_temp_dtn2__)+d_vl0_d_temp_dtn2__))/(pp_t*(1-parm_fc))-(((0.5*parm_mp)*((Vcl-vl)+vl0))*(d_pp_t_d_temp_dtn2__*(1-parm_fc)))/(pp_t*(1-parm_fc))^2))+(pow_vapp(1-parm_fc, -parm_mp)*((-d_vl_d_temp_dtn2__)+d_vl0_d_temp_dtn2__))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc))));
                argp = qlo+(pow_vapp(1-parm_fc, -parm_mp)*((Vcl-vl)+vl0))*(1+((0.5*parm_mp)*((Vcl-vl)+vl0))/(pp_t*(1-parm_fc)));
            end
        else
                d_argp_d_v_n1n2__ = 0;
                d_argp_d_v_ncn2__ = 0;
                d_argp_d_v_i2i1__ = 0;
                d_argp_d_v_n1i1__ = 0;
                d_argp_d_temp_dtn2__ = 0;
            argp = 0;
        end
            d_Qcp2_d_v_n1n2__ = (acja*d_arga_d_v_n1n2__)+(pcjp*d_argp_d_v_n1n2__);
            d_Qcp2_d_v_ncn2__ = (acja*d_arga_d_v_ncn2__)+(pcjp*d_argp_d_v_ncn2__);
            d_Qcp2_d_v_i2i1__ = (acja*d_arga_d_v_i2i1__)+(pcjp*d_argp_d_v_i2i1__);
            d_Qcp2_d_v_n1i1__ = (acja*d_arga_d_v_n1i1__)+(pcjp*d_argp_d_v_n1i1__);
            d_Qcp2_d_temp_dtn2__ = (acja*d_arga_d_temp_dtn2__+d_acja_d_temp_dtn2__*arga)+(pcjp*d_argp_d_temp_dtn2__+d_pcjp_d_temp_dtn2__*argp);
        Qcp2 = acja*arga+pcjp*argp;
    else
            d_Qcp2_d_v_n1n2__ = 0;
            d_Qcp2_d_v_ncn2__ = 0;
            d_Qcp2_d_v_i2i1__ = 0;
            d_Qcp2_d_v_n1i1__ = 0;
            d_Qcp2_d_temp_dtn2__ = 0;
        Qcp2 = 0;
    end
        d_Qcp1_d_v_n1n2__ = d_Qcp1_d_v_n1n2__+(Cf1*d_Vc1_d_v_n1n2__);
        d_Qcp1_d_v_ncn2__ = d_Qcp1_d_v_ncn2__+(Cf1*d_Vc1_d_v_ncn2__);
        d_Qcp1_d_v_i2i1__ = d_Qcp1_d_v_i2i1__+(Cf1*d_Vc1_d_v_i2i1__);
        d_Qcp1_d_v_n1i1__ = d_Qcp1_d_v_n1i1__+(Cf1*d_Vc1_d_v_n1i1__);
        d_Qcp1_d_temp_dtn2__ = d_Qcp1_d_temp_dtn2__;
    Qcp1 = Qcp1+Cf1*Vc1;
        d_Qcp2_d_v_n1n2__ = d_Qcp2_d_v_n1n2__+(Cf2*d_Vc2_d_v_n1n2__);
        d_Qcp2_d_v_ncn2__ = d_Qcp2_d_v_ncn2__+(Cf2*d_Vc2_d_v_ncn2__);
        d_Qcp2_d_v_i2i1__ = d_Qcp2_d_v_i2i1__+(Cf2*d_Vc2_d_v_i2i1__);
        d_Qcp2_d_v_n1i1__ = d_Qcp2_d_v_n1i1__+(Cf2*d_Vc2_d_v_n1i1__);
        d_Qcp2_d_temp_dtn2__ = d_Qcp2_d_temp_dtn2__;
    Qcp2 = Qcp2+Cf2*Vc2;
        d_Qcp1_d_v_n1n2__ = -parm_type*d_Qcp1_d_v_n1n2__;
        d_Qcp1_d_v_ncn2__ = -parm_type*d_Qcp1_d_v_ncn2__;
        d_Qcp1_d_v_i2i1__ = -parm_type*d_Qcp1_d_v_i2i1__;
        d_Qcp1_d_v_n1i1__ = -parm_type*d_Qcp1_d_v_n1i1__;
        d_Qcp1_d_temp_dtn2__ = -parm_type*d_Qcp1_d_temp_dtn2__;
    Qcp1 = -parm_type*Qcp1;
        d_Qcp2_d_v_n1n2__ = -parm_type*d_Qcp2_d_v_n1n2__;
        d_Qcp2_d_v_ncn2__ = -parm_type*d_Qcp2_d_v_ncn2__;
        d_Qcp2_d_v_i2i1__ = -parm_type*d_Qcp2_d_v_i2i1__;
        d_Qcp2_d_v_n1i1__ = -parm_type*d_Qcp2_d_v_n1i1__;
        d_Qcp2_d_temp_dtn2__ = -parm_type*d_Qcp2_d_temp_dtn2__;
    Qcp2 = -parm_type*Qcp2;
        d_Qcth_d_temp_dtn2__ = d_dt_et_d_temp_dtn2__*cth;
    Qcth = dt_et*cth;
        d_f_i_i2i1_d_v_n1n2__ = d_f_i_i2i1_d_v_n1n2__+d_Ib_d_v_n1n2__;
        d_f_i_i2i1_d_v_ncn2__ = d_f_i_i2i1_d_v_ncn2__+d_Ib_d_v_ncn2__;
        d_f_i_i2i1_d_v_i2i1__ = d_f_i_i2i1_d_v_i2i1__+d_Ib_d_v_i2i1__;
        d_f_i_i2i1_d_v_n1i1__ = d_f_i_i2i1_d_v_n1i1__+d_Ib_d_v_n1i1__;
        d_f_i_i2i1_d_temp_dtn2__ = d_f_i_i2i1_d_temp_dtn2__+d_Ib_d_temp_dtn2__;
    % contribution for i_i2i1;
    f_i_i2i1__ = f_i_i2i1__ + Ib;
        d_f_i_nci1_d_v_n1n2__ = d_f_i_nci1_d_v_n1n2__+d_Ip1_d_v_n1n2__;
        d_f_i_nci1_d_v_ncn2__ = d_f_i_nci1_d_v_ncn2__+d_Ip1_d_v_ncn2__;
        d_f_i_nci1_d_v_i2i1__ = d_f_i_nci1_d_v_i2i1__+d_Ip1_d_v_i2i1__;
        d_f_i_nci1_d_v_n1i1__ = d_f_i_nci1_d_v_n1i1__+d_Ip1_d_v_n1i1__;
        d_f_i_nci1_d_temp_dtn2__ = d_f_i_nci1_d_temp_dtn2__+d_Ip1_d_temp_dtn2__;
    % contribution for i_nci1;
    f_i_nci1__ = f_i_nci1__ + Ip1;
        d_f_i_nci2_d_v_n1n2__ = d_f_i_nci2_d_v_n1n2__+d_Ip2_d_v_n1n2__;
        d_f_i_nci2_d_v_ncn2__ = d_f_i_nci2_d_v_ncn2__+d_Ip2_d_v_ncn2__;
        d_f_i_nci2_d_v_i2i1__ = d_f_i_nci2_d_v_i2i1__+d_Ip2_d_v_i2i1__;
        d_f_i_nci2_d_v_n1i1__ = d_f_i_nci2_d_v_n1i1__+d_Ip2_d_v_n1i1__;
        d_f_i_nci2_d_temp_dtn2__ = d_f_i_nci2_d_temp_dtn2__+d_Ip2_d_temp_dtn2__;
    % contribution for i_nci2;
    f_i_nci2__ = f_i_nci2__ + Ip2;
        d_f_pwr_dtn2_d_temp_dtn2__ = d_f_pwr_dtn2_d_temp_dtn2__+d_Irth_d_temp_dtn2__;
    % contribution for pwr_dtn2;
    f_pwr_dtn2__ = f_pwr_dtn2__ + Irth;
        d_f_pwr_dtn2_d_v_n1n2__ = d_f_pwr_dtn2_d_v_n1n2__+d_Ith_d_v_n1n2__;
        d_f_pwr_dtn2_d_v_ncn2__ = d_f_pwr_dtn2_d_v_ncn2__+d_Ith_d_v_ncn2__;
        d_f_pwr_dtn2_d_v_i2i1__ = d_f_pwr_dtn2_d_v_i2i1__+d_Ith_d_v_i2i1__;
        d_f_pwr_dtn2_d_v_n1i1__ = d_f_pwr_dtn2_d_v_n1i1__+d_Ith_d_v_n1i1__;
        d_f_pwr_dtn2_d_temp_dtn2__ = d_f_pwr_dtn2_d_temp_dtn2__+d_Ith_d_temp_dtn2__;
        d_f_pwr_dtn2_d_i_n2i2__ = d_f_pwr_dtn2_d_i_n2i2__+d_Ith_d_i_n2i2__;
        d_f_pwr_dtn2_d_i_nci1__ = d_f_pwr_dtn2_d_i_nci1__+d_Ith_d_i_nci1__;
        d_f_pwr_dtn2_d_i_nci2__ = d_f_pwr_dtn2_d_i_nci2__+d_Ith_d_i_nci2__;
    % contribution for pwr_dtn2;
    f_pwr_dtn2__ = f_pwr_dtn2__ + Ith;
    if rc1_tnom>mMod*parm_rthresh
            d_f_i_n1i1_d_v_n1n2__ = d_f_i_n1i1_d_v_n1n2__+(d_v_n1i1_d_v_n1n2__/(rc1_tnom*tcrc));
            d_f_i_n1i1_d_v_i2i1__ = d_f_i_n1i1_d_v_i2i1__+(d_v_n1i1_d_v_i2i1__/(rc1_tnom*tcrc));
            d_f_i_n1i1_d_v_n1i1__ = d_f_i_n1i1_d_v_n1i1__+(1/(rc1_tnom*tcrc));
            d_f_i_n1i1_d_temp_dtn2__ = d_f_i_n1i1_d_temp_dtn2__+(d_v_n1i1_d_temp_dtn2__/(rc1_tnom*tcrc)-(v_n1i1__*(rc1_tnom*d_tcrc_d_temp_dtn2__))/(rc1_tnom*tcrc)^2);
            d_f_i_n1i1_d_i_n2i2__ = d_f_i_n1i1_d_i_n2i2__+(d_v_n1i1_d_i_n2i2__/(rc1_tnom*tcrc));
            d_f_i_n1i1_d_i_nci1__ = d_f_i_n1i1_d_i_nci1__+(d_v_n1i1_d_i_nci1__/(rc1_tnom*tcrc));
            d_f_i_n1i1_d_i_nci2__ = d_f_i_n1i1_d_i_nci2__+(d_v_n1i1_d_i_nci2__/(rc1_tnom*tcrc));
        % contribution for i_n1i1;
        f_i_n1i1__ = f_i_n1i1__ + v_n1i1__/(rc1_tnom*tcrc);
        if parm_sw_noise
            % contribution for i_n1i1;
            f_i_n1i1__ = f_i_n1i1__ + sim_white_noise_vapp(((4*1.3807e-23)*tdevK)/(rc1_tnom*tcrc));
        end
    else
        if 1
        else
                d_f_v_n1i1_d_v_n1n2__ = d_f_v_n1i1_d_v_n1n2__+(qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*tcrc, 0)*d_i_n1i1_d_v_n1n2__+qmcol_vapp(rc1_tnom*tcrc>0, 0, 0)*i_n1i1__);
                d_f_v_n1i1_d_v_i2i1__ = d_f_v_n1i1_d_v_i2i1__+(qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*tcrc, 0)*d_i_n1i1_d_v_i2i1__+qmcol_vapp(rc1_tnom*tcrc>0, 0, 0)*i_n1i1__);
                d_f_v_n1i1_d_temp_dtn2__ = d_f_v_n1i1_d_temp_dtn2__+(qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*tcrc, 0)*d_i_n1i1_d_temp_dtn2__+qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*d_tcrc_d_temp_dtn2__, 0)*i_n1i1__);
                d_f_v_n1i1_d_i_n2i2__ = d_f_v_n1i1_d_i_n2i2__+(qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*tcrc, 0)*d_i_n1i1_d_i_n2i2__+qmcol_vapp(rc1_tnom*tcrc>0, 0, 0)*i_n1i1__);
                d_f_v_n1i1_d_i_nci1__ = d_f_v_n1i1_d_i_nci1__+(qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*tcrc, 0)*d_i_n1i1_d_i_nci1__+qmcol_vapp(rc1_tnom*tcrc>0, 0, 0)*i_n1i1__);
                d_f_v_n1i1_d_i_nci2__ = d_f_v_n1i1_d_i_nci2__+(qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*tcrc, 0)*d_i_n1i1_d_i_nci2__+qmcol_vapp(rc1_tnom*tcrc>0, 0, 0)*i_n1i1__);
            % contribution for v_n1i1;
            f_v_n1i1__ = f_v_n1i1__ + qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*tcrc, 0)*i_n1i1__;
            if parm_sw_noise
                % contribution for v_n1i1;
                f_v_n1i1__ = f_v_n1i1__ + sim_white_noise_vapp(((4*1.3807e-23)*tdevK)*qmcol_vapp(rc1_tnom*tcrc>0, rc1_tnom*tcrc, 0));
            end
        end
    end
    if rc2_tnom>mMod*parm_rthresh
            d_f_i_n2i2_d_v_n1n2__ = d_f_i_n2i2_d_v_n1n2__+(d_v_n2i2_d_v_n1n2__/(rc2_tnom*tcrc));
            d_f_i_n2i2_d_v_i2i1__ = d_f_i_n2i2_d_v_i2i1__+(d_v_n2i2_d_v_i2i1__/(rc2_tnom*tcrc));
            d_f_i_n2i2_d_v_n1i1__ = d_f_i_n2i2_d_v_n1i1__+(d_v_n2i2_d_v_n1i1__/(rc2_tnom*tcrc));
            d_f_i_n2i2_d_temp_dtn2__ = d_f_i_n2i2_d_temp_dtn2__+(d_v_n2i2_d_temp_dtn2__/(rc2_tnom*tcrc)-(v_n2i2__*(rc2_tnom*d_tcrc_d_temp_dtn2__))/(rc2_tnom*tcrc)^2);
        % contribution for i_n2i2;
        f_i_n2i2__ = f_i_n2i2__ + v_n2i2__/(rc2_tnom*tcrc);
        if parm_sw_noise
            % contribution for i_n2i2;
            f_i_n2i2__ = f_i_n2i2__ + sim_white_noise_vapp(((4*1.3807e-23)*tdevK)/(rc2_tnom*tcrc));
        end
    else
        if 1
        else
                d_f_v_n2i2_d_v_n1n2__ = d_f_v_n2i2_d_v_n1n2__+(qmcol_vapp(rc2_tnom*tcrc>0, rc2_tnom*tcrc, 0)*d_i_n2i2_d_v_n1n2__+qmcol_vapp(rc2_tnom*tcrc>0, 0, 0)*i_n2i2__);
                d_f_v_n2i2_d_v_i2i1__ = d_f_v_n2i2_d_v_i2i1__+(qmcol_vapp(rc2_tnom*tcrc>0, rc2_tnom*tcrc, 0)*d_i_n2i2_d_v_i2i1__+qmcol_vapp(rc2_tnom*tcrc>0, 0, 0)*i_n2i2__);
                d_f_v_n2i2_d_v_n1i1__ = d_f_v_n2i2_d_v_n1i1__+(qmcol_vapp(rc2_tnom*tcrc>0, rc2_tnom*tcrc, 0)*d_i_n2i2_d_v_n1i1__+qmcol_vapp(rc2_tnom*tcrc>0, 0, 0)*i_n2i2__);
                d_f_v_n2i2_d_temp_dtn2__ = d_f_v_n2i2_d_temp_dtn2__+(qmcol_vapp(rc2_tnom*tcrc>0, rc2_tnom*tcrc, 0)*d_i_n2i2_d_temp_dtn2__+qmcol_vapp(rc2_tnom*tcrc>0, rc2_tnom*d_tcrc_d_temp_dtn2__, 0)*i_n2i2__);
                d_f_v_n2i2_d_i_n2i2__ = d_f_v_n2i2_d_i_n2i2__+(qmcol_vapp(rc2_tnom*tcrc>0, rc2_tnom*tcrc, 0)*1+qmcol_vapp(rc2_tnom*tcrc>0, 0, 0)*i_n2i2__);
            % contribution for v_n2i2;
            f_v_n2i2__ = f_v_n2i2__ + qmcol_vapp(rc2_tnom*tcrc>0, rc2_tnom*tcrc, 0)*i_n2i2__;
            if parm_sw_noise
                % contribution for v_n2i2;
                f_v_n2i2__ = f_v_n2i2__ + sim_white_noise_vapp(((4*1.3807e-23)*tdevK)*qmcol_vapp(rc2_tnom*tcrc>0, rc2_tnom*tcrc, 0));
            end
        end
    end
        d_q_i_nci1_d_v_n1n2__ = d_q_i_nci1_d_v_n1n2__+d_Qcp1_d_v_n1n2__;
        d_q_i_nci1_d_v_ncn2__ = d_q_i_nci1_d_v_ncn2__+d_Qcp1_d_v_ncn2__;
        d_q_i_nci1_d_v_i2i1__ = d_q_i_nci1_d_v_i2i1__+d_Qcp1_d_v_i2i1__;
        d_q_i_nci1_d_v_n1i1__ = d_q_i_nci1_d_v_n1i1__+d_Qcp1_d_v_n1i1__;
        d_q_i_nci1_d_temp_dtn2__ = d_q_i_nci1_d_temp_dtn2__+d_Qcp1_d_temp_dtn2__;
    % contribution for i_nci1;
    q_i_nci1__ = q_i_nci1__ + Qcp1;
        d_q_i_nci2_d_v_n1n2__ = d_q_i_nci2_d_v_n1n2__+d_Qcp2_d_v_n1n2__;
        d_q_i_nci2_d_v_ncn2__ = d_q_i_nci2_d_v_ncn2__+d_Qcp2_d_v_ncn2__;
        d_q_i_nci2_d_v_i2i1__ = d_q_i_nci2_d_v_i2i1__+d_Qcp2_d_v_i2i1__;
        d_q_i_nci2_d_v_n1i1__ = d_q_i_nci2_d_v_n1i1__+d_Qcp2_d_v_n1i1__;
        d_q_i_nci2_d_temp_dtn2__ = d_q_i_nci2_d_temp_dtn2__+d_Qcp2_d_temp_dtn2__;
    % contribution for i_nci2;
    q_i_nci2__ = q_i_nci2__ + Qcp2;
        d_q_pwr_dtn2_d_v_n1n2__ = d_q_pwr_dtn2_d_v_n1n2__;
        d_q_pwr_dtn2_d_v_ncn2__ = d_q_pwr_dtn2_d_v_ncn2__;
        d_q_pwr_dtn2_d_v_i2i1__ = d_q_pwr_dtn2_d_v_i2i1__;
        d_q_pwr_dtn2_d_v_n1i1__ = d_q_pwr_dtn2_d_v_n1i1__;
        d_q_pwr_dtn2_d_temp_dtn2__ = d_q_pwr_dtn2_d_temp_dtn2__+d_Qcth_d_temp_dtn2__;
        d_q_pwr_dtn2_d_i_n2i2__ = d_q_pwr_dtn2_d_i_n2i2__;
        d_q_pwr_dtn2_d_i_nci1__ = d_q_pwr_dtn2_d_i_nci1__;
        d_q_pwr_dtn2_d_i_nci2__ = d_q_pwr_dtn2_d_i_nci2__;
    % contribution for pwr_dtn2;
    q_pwr_dtn2__ = q_pwr_dtn2__ + Qcth;
    if parm_sw_noise
        if parm_sw_fngeo
            len = leff_um;
            wid = weff_um;
        else
            len = l_um;
            wid = w_um;
        end
            d_wn_d_v_n1n2__ = ((4*1.3807e-23)*tdevK)*d_geff_d_v_n1n2__;
            d_wn_d_v_ncn2__ = ((4*1.3807e-23)*tdevK)*d_geff_d_v_ncn2__;
            d_wn_d_v_i2i1__ = ((4*1.3807e-23)*tdevK)*d_geff_d_v_i2i1__;
            d_wn_d_v_n1i1__ = ((4*1.3807e-23)*tdevK)*d_geff_d_v_n1i1__;
            d_wn_d_temp_dtn2__ = ((4*1.3807e-23)*tdevK)*d_geff_d_temp_dtn2__+((4*1.3807e-23)*d_tdevK_d_temp_dtn2__)*geff;
        wn = ((4*1.3807e-23)*tdevK)*geff;
            d_fn_d_v_n1n2__ = ((kfn_t*(d_pow_vapp_d_arg1__(abs(Ib/wid), parm_afn)*(sign(Ib/wid)*(d_Ib_d_v_n1n2__/wid))))*wid)/len;
            d_fn_d_v_ncn2__ = ((kfn_t*(d_pow_vapp_d_arg1__(abs(Ib/wid), parm_afn)*(sign(Ib/wid)*(d_Ib_d_v_ncn2__/wid))))*wid)/len;
            d_fn_d_v_i2i1__ = ((kfn_t*(d_pow_vapp_d_arg1__(abs(Ib/wid), parm_afn)*(sign(Ib/wid)*(d_Ib_d_v_i2i1__/wid))))*wid)/len;
            d_fn_d_v_n1i1__ = ((kfn_t*(d_pow_vapp_d_arg1__(abs(Ib/wid), parm_afn)*(sign(Ib/wid)*(d_Ib_d_v_n1i1__/wid))))*wid)/len;
            d_fn_d_temp_dtn2__ = ((kfn_t*(d_pow_vapp_d_arg1__(abs(Ib/wid), parm_afn)*(sign(Ib/wid)*(d_Ib_d_temp_dtn2__/wid)))+d_kfn_t_d_temp_dtn2__*pow_vapp(abs(Ib/wid), parm_afn))*wid)/len;
        fn = ((kfn_t*pow_vapp(abs(Ib/wid), parm_afn))*wid)/len;
        % contribution for i_i2i1;
        f_i_i2i1__ = f_i_i2i1__ + sim_white_noise_vapp(wn, 'body thermal noise');
        % contribution for i_i2i1;
        f_i_i2i1__ = f_i_i2i1__ + sim_flicker_noise_vapp(fn, parm_bfn, 'body 1/f noise');
        if Is1>0
            % contribution for i_nci1;
            f_i_nci1__ = f_i_nci1__ + sim_white_noise_vapp((2*1.6022e-19)*(abs(Id1+2*Is1)+abs(Ib1)), 'end 1 parasitic shot noise');
        end
        if Is2>0
            % contribution for i_nci2;
            f_i_nci2__ = f_i_nci2__ + sim_white_noise_vapp((2*1.6022e-19)*(abs(Id2+2*Is2)+abs(Ib2)), 'end 2 parasitic shot noise');
        end
    end
    if ~(rc1_tnom>mMod*parm_rthresh)
        if 1
            %Collapse branch: n1i1
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                        d_fe_d_X__(1,1) = -d_f_i_i2i1_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__;
                        d_qe_d_X__(1,1) = -d_q_i_i2i1_d_v_n1n2__-d_q_i_nci1_d_v_n1n2__;
                        d_fe_d_X__(1,2) = -d_f_i_i2i1_d_v_ncn2__-d_f_i_nci1_d_v_ncn2__;
                        d_qe_d_X__(1,2) = -d_q_i_i2i1_d_v_ncn2__-d_q_i_nci1_d_v_ncn2__;
                        d_fe_d_Y__(1,1) = -d_f_i_i2i1_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__;
                        d_qe_d_Y__(1,1) = -d_q_i_i2i1_d_temp_dtn2__-d_q_i_nci1_d_temp_dtn2__;
                    % output for terminalFlow_n1 (explicit out)
                    fe__(1) = -f_i_i2i1__-f_i_nci1__;
                    qe__(1) = -q_i_i2i1__-q_i_nci1__;
                        d_fe_d_X__(2,1) = d_f_i_nci1_d_v_n1n2__+d_f_i_nci2_d_v_n1n2__;
                        d_qe_d_X__(2,1) = d_q_i_nci1_d_v_n1n2__+d_q_i_nci2_d_v_n1n2__;
                        d_fe_d_X__(2,2) = d_f_i_nci1_d_v_ncn2__+d_f_i_nci2_d_v_ncn2__;
                        d_qe_d_X__(2,2) = d_q_i_nci1_d_v_ncn2__+d_q_i_nci2_d_v_ncn2__;
                        d_fe_d_Y__(2,1) = d_f_i_nci1_d_temp_dtn2__+d_f_i_nci2_d_temp_dtn2__;
                        d_qe_d_Y__(2,1) = d_q_i_nci1_d_temp_dtn2__+d_q_i_nci2_d_temp_dtn2__;
                    % output for terminalFlow_nc (explicit out)
                    fe__(2) = +f_i_nci1__+f_i_nci2__;
                    qe__(2) = +q_i_nci1__+q_i_nci2__;
                        d_fi_d_X__(1,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                        d_qi_d_X__(1,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                        d_fi_d_X__(1,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                        d_qi_d_X__(1,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                        d_fi_d_Y__(1,1) = -d_f_pwr_dtn2_d_temp_dtn2__;
                        d_qi_d_Y__(1,1) = -d_q_pwr_dtn2_d_temp_dtn2__;
                    % output for temp_dtn2 (internal unknown)
                    fi__(1) = 0 - f_pwr_dtn2__;
                    qi__(1) = 0 - q_pwr_dtn2__;
                else
                        d_fe_d_X__(1,1) = (-d_i_n2i2_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__)-d_f_i_nci2_d_v_n1n2__;
                        d_qe_d_X__(1,1) = (-d_q_i_nci1_d_v_n1n2__)-d_q_i_nci2_d_v_n1n2__;
                        d_fe_d_X__(1,2) = (-d_f_i_nci1_d_v_ncn2__)-d_f_i_nci2_d_v_ncn2__;
                        d_qe_d_X__(1,2) = (-d_q_i_nci1_d_v_ncn2__)-d_q_i_nci2_d_v_ncn2__;
                        d_fe_d_Y__(1,1) = (-d_i_n2i2_d_v_i2i1__-d_f_i_nci1_d_v_i2i1__)-d_f_i_nci2_d_v_i2i1__;
                        d_qe_d_Y__(1,1) = (-d_q_i_nci1_d_v_i2i1__)-d_q_i_nci2_d_v_i2i1__;
                        d_fe_d_Y__(1,2) = (-d_i_n2i2_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__)-d_f_i_nci2_d_temp_dtn2__;
                        d_qe_d_Y__(1,2) = (-d_q_i_nci1_d_temp_dtn2__)-d_q_i_nci2_d_temp_dtn2__;
                        d_fe_d_Y__(1,3) = (-1);
                    % output for terminalFlow_n1 (explicit out)
                    fe__(1) = -i_n2i2__-f_i_nci1__-f_i_nci2__;
                    qe__(1) = -q_i_nci1__-q_i_nci2__;
                        d_fe_d_X__(2,1) = d_f_i_nci1_d_v_n1n2__+d_f_i_nci2_d_v_n1n2__;
                        d_qe_d_X__(2,1) = d_q_i_nci1_d_v_n1n2__+d_q_i_nci2_d_v_n1n2__;
                        d_fe_d_X__(2,2) = d_f_i_nci1_d_v_ncn2__+d_f_i_nci2_d_v_ncn2__;
                        d_qe_d_X__(2,2) = d_q_i_nci1_d_v_ncn2__+d_q_i_nci2_d_v_ncn2__;
                        d_fe_d_Y__(2,1) = d_f_i_nci1_d_v_i2i1__+d_f_i_nci2_d_v_i2i1__;
                        d_qe_d_Y__(2,1) = d_q_i_nci1_d_v_i2i1__+d_q_i_nci2_d_v_i2i1__;
                        d_fe_d_Y__(2,2) = d_f_i_nci1_d_temp_dtn2__+d_f_i_nci2_d_temp_dtn2__;
                        d_qe_d_Y__(2,2) = d_q_i_nci1_d_temp_dtn2__+d_q_i_nci2_d_temp_dtn2__;
                    % output for terminalFlow_nc (explicit out)
                    fe__(2) = +f_i_nci1__+f_i_nci2__;
                    qe__(2) = +q_i_nci1__+q_i_nci2__;
                        d_fi_d_X__(1,1) = (d_i_n2i2_d_v_n1n2__+d_f_i_nci2_d_v_n1n2__)-d_f_i_i2i1_d_v_n1n2__;
                        d_qi_d_X__(1,1) = (d_q_i_nci2_d_v_n1n2__)-d_q_i_i2i1_d_v_n1n2__;
                        d_fi_d_X__(1,2) = (d_f_i_nci2_d_v_ncn2__)-d_f_i_i2i1_d_v_ncn2__;
                        d_qi_d_X__(1,2) = (d_q_i_nci2_d_v_ncn2__)-d_q_i_i2i1_d_v_ncn2__;
                        d_fi_d_Y__(1,1) = (d_i_n2i2_d_v_i2i1__+d_f_i_nci2_d_v_i2i1__)-d_f_i_i2i1_d_v_i2i1__;
                        d_qi_d_Y__(1,1) = (d_q_i_nci2_d_v_i2i1__)-d_q_i_i2i1_d_v_i2i1__;
                        d_fi_d_Y__(1,2) = (d_i_n2i2_d_temp_dtn2__+d_f_i_nci2_d_temp_dtn2__)-d_f_i_i2i1_d_temp_dtn2__;
                        d_qi_d_Y__(1,2) = (d_q_i_nci2_d_temp_dtn2__)-d_q_i_i2i1_d_temp_dtn2__;
                        d_fi_d_Y__(1,3) = (1);
                    % output for v_i2i1 (internal unknown)
                    fi__(1) = +i_n2i2__+f_i_nci2__ - f_i_i2i1__;
                    qi__(1) = +q_i_nci2__ - q_i_i2i1__;
                        d_fi_d_X__(2,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                        d_qi_d_X__(2,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                        d_fi_d_X__(2,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                        d_qi_d_X__(2,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                        d_fi_d_Y__(2,1) = -d_f_pwr_dtn2_d_v_i2i1__;
                        d_qi_d_Y__(2,1) = -d_q_pwr_dtn2_d_v_i2i1__;
                        d_fi_d_Y__(2,2) = -d_f_pwr_dtn2_d_temp_dtn2__;
                        d_qi_d_Y__(2,2) = -d_q_pwr_dtn2_d_temp_dtn2__;
                        d_fi_d_Y__(2,3) = -d_f_pwr_dtn2_d_i_n2i2__;
                        d_qi_d_Y__(2,3) = -d_q_pwr_dtn2_d_i_n2i2__;
                    % output for temp_dtn2 (internal unknown)
                    fi__(2) = 0 - f_pwr_dtn2__;
                    qi__(2) = 0 - q_pwr_dtn2__;
                        d_fi_d_X__(3,1) = d_i_n2i2_d_v_n1n2__-d_f_i_n2i2_d_v_n1n2__;
                        d_qi_d_X__(3,1) = -d_q_i_n2i2_d_v_n1n2__;
                        d_fi_d_Y__(3,1) = d_i_n2i2_d_v_i2i1__-d_f_i_n2i2_d_v_i2i1__;
                        d_qi_d_Y__(3,1) = -d_q_i_n2i2_d_v_i2i1__;
                        d_fi_d_Y__(3,2) = d_i_n2i2_d_temp_dtn2__-d_f_i_n2i2_d_temp_dtn2__;
                        d_qi_d_Y__(3,2) = -d_q_i_n2i2_d_temp_dtn2__;
                        d_fi_d_Y__(3,3) = 1-d_f_i_n2i2_d_i_n2i2__;
                        d_qi_d_Y__(3,3) = -d_q_i_n2i2_d_i_n2i2__;
                    % output for i_n2i2 (internal unknown)
                    fi__(3) = +i_n2i2__ - f_i_n2i2__;
                    qi__(3) = 0 - q_i_n2i2__;
                end
            else
                    d_fe_d_X__(1,1) = (-d_i_n2i2_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__)-d_f_i_nci2_d_v_n1n2__;
                    d_qe_d_X__(1,1) = (-d_q_i_nci1_d_v_n1n2__)-d_q_i_nci2_d_v_n1n2__;
                    d_fe_d_X__(1,2) = (-d_f_i_nci1_d_v_ncn2__)-d_f_i_nci2_d_v_ncn2__;
                    d_qe_d_X__(1,2) = (-d_q_i_nci1_d_v_ncn2__)-d_q_i_nci2_d_v_ncn2__;
                    d_fe_d_Y__(1,1) = (-d_i_n2i2_d_v_i2i1__-d_f_i_nci1_d_v_i2i1__)-d_f_i_nci2_d_v_i2i1__;
                    d_qe_d_Y__(1,1) = (-d_q_i_nci1_d_v_i2i1__)-d_q_i_nci2_d_v_i2i1__;
                    d_fe_d_Y__(1,2) = (-d_i_n2i2_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__)-d_f_i_nci2_d_temp_dtn2__;
                    d_qe_d_Y__(1,2) = (-d_q_i_nci1_d_temp_dtn2__)-d_q_i_nci2_d_temp_dtn2__;
                    d_fe_d_Y__(1,3) = (-1);
                % output for terminalFlow_n1 (explicit out)
                fe__(1) = -i_n2i2__-f_i_nci1__-f_i_nci2__;
                qe__(1) = -q_i_nci1__-q_i_nci2__;
                    d_fe_d_X__(2,1) = d_f_i_nci1_d_v_n1n2__+d_f_i_nci2_d_v_n1n2__;
                    d_qe_d_X__(2,1) = d_q_i_nci1_d_v_n1n2__+d_q_i_nci2_d_v_n1n2__;
                    d_fe_d_X__(2,2) = d_f_i_nci1_d_v_ncn2__+d_f_i_nci2_d_v_ncn2__;
                    d_qe_d_X__(2,2) = d_q_i_nci1_d_v_ncn2__+d_q_i_nci2_d_v_ncn2__;
                    d_fe_d_Y__(2,1) = d_f_i_nci1_d_v_i2i1__+d_f_i_nci2_d_v_i2i1__;
                    d_qe_d_Y__(2,1) = d_q_i_nci1_d_v_i2i1__+d_q_i_nci2_d_v_i2i1__;
                    d_fe_d_Y__(2,2) = d_f_i_nci1_d_temp_dtn2__+d_f_i_nci2_d_temp_dtn2__;
                    d_qe_d_Y__(2,2) = d_q_i_nci1_d_temp_dtn2__+d_q_i_nci2_d_temp_dtn2__;
                % output for terminalFlow_nc (explicit out)
                fe__(2) = +f_i_nci1__+f_i_nci2__;
                qe__(2) = +q_i_nci1__+q_i_nci2__;
                    d_fi_d_X__(1,1) = (d_i_n2i2_d_v_n1n2__+d_f_i_nci2_d_v_n1n2__)-d_f_i_i2i1_d_v_n1n2__;
                    d_qi_d_X__(1,1) = (d_q_i_nci2_d_v_n1n2__)-d_q_i_i2i1_d_v_n1n2__;
                    d_fi_d_X__(1,2) = (d_f_i_nci2_d_v_ncn2__)-d_f_i_i2i1_d_v_ncn2__;
                    d_qi_d_X__(1,2) = (d_q_i_nci2_d_v_ncn2__)-d_q_i_i2i1_d_v_ncn2__;
                    d_fi_d_Y__(1,1) = (d_i_n2i2_d_v_i2i1__+d_f_i_nci2_d_v_i2i1__)-d_f_i_i2i1_d_v_i2i1__;
                    d_qi_d_Y__(1,1) = (d_q_i_nci2_d_v_i2i1__)-d_q_i_i2i1_d_v_i2i1__;
                    d_fi_d_Y__(1,2) = (d_i_n2i2_d_temp_dtn2__+d_f_i_nci2_d_temp_dtn2__)-d_f_i_i2i1_d_temp_dtn2__;
                    d_qi_d_Y__(1,2) = (d_q_i_nci2_d_temp_dtn2__)-d_q_i_i2i1_d_temp_dtn2__;
                    d_fi_d_Y__(1,3) = (1);
                % output for v_i2i1 (internal unknown)
                fi__(1) = +i_n2i2__+f_i_nci2__ - f_i_i2i1__;
                qi__(1) = +q_i_nci2__ - q_i_i2i1__;
                    d_fi_d_X__(2,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                    d_qi_d_X__(2,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                    d_fi_d_X__(2,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                    d_qi_d_X__(2,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                    d_fi_d_Y__(2,1) = -d_f_pwr_dtn2_d_v_i2i1__;
                    d_qi_d_Y__(2,1) = -d_q_pwr_dtn2_d_v_i2i1__;
                    d_fi_d_Y__(2,2) = -d_f_pwr_dtn2_d_temp_dtn2__;
                    d_qi_d_Y__(2,2) = -d_q_pwr_dtn2_d_temp_dtn2__;
                    d_fi_d_Y__(2,3) = -d_f_pwr_dtn2_d_i_n2i2__;
                    d_qi_d_Y__(2,3) = -d_q_pwr_dtn2_d_i_n2i2__;
                % output for temp_dtn2 (internal unknown)
                fi__(2) = 0 - f_pwr_dtn2__;
                qi__(2) = 0 - q_pwr_dtn2__;
                    d_fi_d_X__(3,1) = d_i_n2i2_d_v_n1n2__-d_f_i_n2i2_d_v_n1n2__;
                    d_qi_d_X__(3,1) = -d_q_i_n2i2_d_v_n1n2__;
                    d_fi_d_Y__(3,1) = d_i_n2i2_d_v_i2i1__-d_f_i_n2i2_d_v_i2i1__;
                    d_qi_d_Y__(3,1) = -d_q_i_n2i2_d_v_i2i1__;
                    d_fi_d_Y__(3,2) = d_i_n2i2_d_temp_dtn2__-d_f_i_n2i2_d_temp_dtn2__;
                    d_qi_d_Y__(3,2) = -d_q_i_n2i2_d_temp_dtn2__;
                    d_fi_d_Y__(3,3) = 1-d_f_i_n2i2_d_i_n2i2__;
                    d_qi_d_Y__(3,3) = -d_q_i_n2i2_d_i_n2i2__;
                % output for i_n2i2 (internal unknown)
                fi__(3) = +i_n2i2__ - f_i_n2i2__;
                qi__(3) = 0 - q_i_n2i2__;
            end
        else
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                        d_fe_d_X__(1,1) = d_i_n1i1_d_v_n1n2__;
                        d_fe_d_Y__(1,1) = d_i_n1i1_d_v_i2i1__;
                        d_fe_d_Y__(1,2) = d_i_n1i1_d_temp_dtn2__;
                    % output for terminalFlow_n1 (explicit out)
                    fe__(1) = +i_n1i1__;
                    qe__(1) = 0;
                        d_fe_d_X__(2,1) = d_f_i_nci1_d_v_n1n2__+d_f_i_nci2_d_v_n1n2__;
                        d_qe_d_X__(2,1) = d_q_i_nci1_d_v_n1n2__+d_q_i_nci2_d_v_n1n2__;
                        d_fe_d_X__(2,2) = d_f_i_nci1_d_v_ncn2__+d_f_i_nci2_d_v_ncn2__;
                        d_qe_d_X__(2,2) = d_q_i_nci1_d_v_ncn2__+d_q_i_nci2_d_v_ncn2__;
                        d_fe_d_Y__(2,1) = d_f_i_nci1_d_v_i2i1__+d_f_i_nci2_d_v_i2i1__;
                        d_qe_d_Y__(2,1) = d_q_i_nci1_d_v_i2i1__+d_q_i_nci2_d_v_i2i1__;
                        d_fe_d_Y__(2,2) = d_f_i_nci1_d_temp_dtn2__+d_f_i_nci2_d_temp_dtn2__;
                        d_qe_d_Y__(2,2) = d_q_i_nci1_d_temp_dtn2__+d_q_i_nci2_d_temp_dtn2__;
                    % output for terminalFlow_nc (explicit out)
                    fe__(2) = +f_i_nci1__+f_i_nci2__;
                    qe__(2) = +q_i_nci1__+q_i_nci2__;
                        d_fi_d_X__(1,1) = (-d_i_n1i1_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__)-d_f_i_i2i1_d_v_n1n2__;
                        d_qi_d_X__(1,1) = (-d_q_i_nci1_d_v_n1n2__)-d_q_i_i2i1_d_v_n1n2__;
                        d_fi_d_X__(1,2) = (-d_f_i_nci1_d_v_ncn2__)-d_f_i_i2i1_d_v_ncn2__;
                        d_qi_d_X__(1,2) = (-d_q_i_nci1_d_v_ncn2__)-d_q_i_i2i1_d_v_ncn2__;
                        d_fi_d_Y__(1,1) = (-d_i_n1i1_d_v_i2i1__-d_f_i_nci1_d_v_i2i1__)-d_f_i_i2i1_d_v_i2i1__;
                        d_qi_d_Y__(1,1) = (-d_q_i_nci1_d_v_i2i1__)-d_q_i_i2i1_d_v_i2i1__;
                        d_fi_d_Y__(1,2) = (-d_i_n1i1_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__)-d_f_i_i2i1_d_temp_dtn2__;
                        d_qi_d_Y__(1,2) = (-d_q_i_nci1_d_temp_dtn2__)-d_q_i_i2i1_d_temp_dtn2__;
                    % output for v_i2i1 (internal unknown)
                    fi__(1) = -i_n1i1__-f_i_nci1__ - f_i_i2i1__;
                    qi__(1) = -q_i_nci1__ - q_i_i2i1__;
                        d_fi_d_X__(2,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                        d_qi_d_X__(2,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                        d_fi_d_X__(2,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                        d_qi_d_X__(2,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                        d_fi_d_Y__(2,1) = -d_f_pwr_dtn2_d_v_i2i1__;
                        d_qi_d_Y__(2,1) = -d_q_pwr_dtn2_d_v_i2i1__;
                        d_fi_d_Y__(2,2) = -d_f_pwr_dtn2_d_temp_dtn2__;
                        d_qi_d_Y__(2,2) = -d_q_pwr_dtn2_d_temp_dtn2__;
                    % output for temp_dtn2 (internal unknown)
                    fi__(2) = 0 - f_pwr_dtn2__;
                    qi__(2) = 0 - q_pwr_dtn2__;
                        d_fi_d_X__(3,1) = d_i_n1i1_d_v_n1n2__-d_f_i_n1i1_d_v_n1n2__;
                        d_qi_d_X__(3,1) = -d_q_i_n1i1_d_v_n1n2__;
                        d_fi_d_Y__(3,1) = d_i_n1i1_d_v_i2i1__-d_f_i_n1i1_d_v_i2i1__;
                        d_qi_d_Y__(3,1) = -d_q_i_n1i1_d_v_i2i1__;
                        d_fi_d_Y__(3,2) = d_i_n1i1_d_temp_dtn2__-d_f_i_n1i1_d_temp_dtn2__;
                        d_qi_d_Y__(3,2) = -d_q_i_n1i1_d_temp_dtn2__;
                    % output for i_n1i1 (internal unknown)
                    fi__(3) = +i_n1i1__ - f_i_n1i1__;
                    qi__(3) = 0 - q_i_n1i1__;
                else
                        d_fe_d_X__(1,1) = (-d_i_n2i2_d_v_n1n2__-d_i_nci1_d_v_n1n2__)-d_i_nci2_d_v_n1n2__;
                        d_fe_d_X__(1,2) = (-d_i_nci1_d_v_ncn2__)-d_i_nci2_d_v_ncn2__;
                        d_fe_d_Y__(1,1) = (-d_i_n2i2_d_v_i2i1__-d_i_nci1_d_v_i2i1__)-d_i_nci2_d_v_i2i1__;
                        d_fe_d_Y__(1,2) = (-d_i_n2i2_d_v_n1i1__-d_i_nci1_d_v_n1i1__)-d_i_nci2_d_v_n1i1__;
                        d_fe_d_Y__(1,3) = (-d_i_n2i2_d_temp_dtn2__-d_i_nci1_d_temp_dtn2__)-d_i_nci2_d_temp_dtn2__;
                        d_fe_d_Y__(1,4) = (-1);
                        d_fe_d_Y__(1,5) = (-1);
                        d_fe_d_Y__(1,6) = -1;
                    % output for terminalFlow_n1 (explicit out)
                    fe__(1) = -i_n2i2__-i_nci1__-i_nci2__;
                    qe__(1) = 0;
                        d_fe_d_X__(2,1) = d_i_nci1_d_v_n1n2__+d_i_nci2_d_v_n1n2__;
                        d_fe_d_X__(2,2) = d_i_nci1_d_v_ncn2__+d_i_nci2_d_v_ncn2__;
                        d_fe_d_Y__(2,1) = d_i_nci1_d_v_i2i1__+d_i_nci2_d_v_i2i1__;
                        d_fe_d_Y__(2,2) = d_i_nci1_d_v_n1i1__+d_i_nci2_d_v_n1i1__;
                        d_fe_d_Y__(2,3) = d_i_nci1_d_temp_dtn2__+d_i_nci2_d_temp_dtn2__;
                        d_fe_d_Y__(2,5) = 1;
                        d_fe_d_Y__(2,6) = 1;
                    % output for terminalFlow_nc (explicit out)
                    fe__(2) = +i_nci1__+i_nci2__;
                    qe__(2) = 0;
                        d_fi_d_X__(1,1) = (d_i_n2i2_d_v_n1n2__+d_i_nci2_d_v_n1n2__)-d_f_i_i2i1_d_v_n1n2__;
                        d_qi_d_X__(1,1) = -d_q_i_i2i1_d_v_n1n2__;
                        d_fi_d_X__(1,2) = (d_i_nci2_d_v_ncn2__)-d_f_i_i2i1_d_v_ncn2__;
                        d_qi_d_X__(1,2) = -d_q_i_i2i1_d_v_ncn2__;
                        d_fi_d_Y__(1,1) = (d_i_n2i2_d_v_i2i1__+d_i_nci2_d_v_i2i1__)-d_f_i_i2i1_d_v_i2i1__;
                        d_qi_d_Y__(1,1) = -d_q_i_i2i1_d_v_i2i1__;
                        d_fi_d_Y__(1,2) = (d_i_n2i2_d_v_n1i1__+d_i_nci2_d_v_n1i1__)-d_f_i_i2i1_d_v_n1i1__;
                        d_qi_d_Y__(1,2) = -d_q_i_i2i1_d_v_n1i1__;
                        d_fi_d_Y__(1,3) = (d_i_n2i2_d_temp_dtn2__+d_i_nci2_d_temp_dtn2__)-d_f_i_i2i1_d_temp_dtn2__;
                        d_qi_d_Y__(1,3) = -d_q_i_i2i1_d_temp_dtn2__;
                        d_fi_d_Y__(1,4) = (1);
                        d_fi_d_Y__(1,6) = (1);
                    % output for v_i2i1 (internal unknown)
                    fi__(1) = +i_n2i2__+i_nci2__ - f_i_i2i1__;
                    qi__(1) = 0 - q_i_i2i1__;
                        d_fi_d_X__(2,1) = d_v_n1i1_d_v_n1n2__-d_f_v_n1i1_d_v_n1n2__;
                        d_qi_d_X__(2,1) = -d_q_v_n1i1_d_v_n1n2__;
                        d_fi_d_Y__(2,1) = d_v_n1i1_d_v_i2i1__-d_f_v_n1i1_d_v_i2i1__;
                        d_qi_d_Y__(2,1) = -d_q_v_n1i1_d_v_i2i1__;
                        d_fi_d_Y__(2,2) = 1-d_f_v_n1i1_d_v_n1i1__;
                        d_qi_d_Y__(2,2) = -d_q_v_n1i1_d_v_n1i1__;
                        d_fi_d_Y__(2,3) = d_v_n1i1_d_temp_dtn2__-d_f_v_n1i1_d_temp_dtn2__;
                        d_qi_d_Y__(2,3) = -d_q_v_n1i1_d_temp_dtn2__;
                        d_fi_d_Y__(2,4) = d_v_n1i1_d_i_n2i2__-d_f_v_n1i1_d_i_n2i2__;
                        d_qi_d_Y__(2,4) = -d_q_v_n1i1_d_i_n2i2__;
                        d_fi_d_Y__(2,5) = d_v_n1i1_d_i_nci1__-d_f_v_n1i1_d_i_nci1__;
                        d_qi_d_Y__(2,5) = -d_q_v_n1i1_d_i_nci1__;
                        d_fi_d_Y__(2,6) = d_v_n1i1_d_i_nci2__-d_f_v_n1i1_d_i_nci2__;
                        d_qi_d_Y__(2,6) = -d_q_v_n1i1_d_i_nci2__;
                    % output for v_n1i1 (internal unknown)
                    fi__(2) = +v_n1i1__ - f_v_n1i1__;
                    qi__(2) = 0 - q_v_n1i1__;
                        d_fi_d_X__(3,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                        d_qi_d_X__(3,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                        d_fi_d_X__(3,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                        d_qi_d_X__(3,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                        d_fi_d_Y__(3,1) = -d_f_pwr_dtn2_d_v_i2i1__;
                        d_qi_d_Y__(3,1) = -d_q_pwr_dtn2_d_v_i2i1__;
                        d_fi_d_Y__(3,2) = -d_f_pwr_dtn2_d_v_n1i1__;
                        d_qi_d_Y__(3,2) = -d_q_pwr_dtn2_d_v_n1i1__;
                        d_fi_d_Y__(3,3) = -d_f_pwr_dtn2_d_temp_dtn2__;
                        d_qi_d_Y__(3,3) = -d_q_pwr_dtn2_d_temp_dtn2__;
                        d_fi_d_Y__(3,4) = -d_f_pwr_dtn2_d_i_n2i2__;
                        d_qi_d_Y__(3,4) = -d_q_pwr_dtn2_d_i_n2i2__;
                        d_fi_d_Y__(3,5) = -d_f_pwr_dtn2_d_i_nci1__;
                        d_qi_d_Y__(3,5) = -d_q_pwr_dtn2_d_i_nci1__;
                        d_fi_d_Y__(3,6) = -d_f_pwr_dtn2_d_i_nci2__;
                        d_qi_d_Y__(3,6) = -d_q_pwr_dtn2_d_i_nci2__;
                    % output for temp_dtn2 (internal unknown)
                    fi__(3) = 0 - f_pwr_dtn2__;
                    qi__(3) = 0 - q_pwr_dtn2__;
                        d_fi_d_X__(4,1) = d_i_n2i2_d_v_n1n2__-d_f_i_n2i2_d_v_n1n2__;
                        d_qi_d_X__(4,1) = -d_q_i_n2i2_d_v_n1n2__;
                        d_fi_d_Y__(4,1) = d_i_n2i2_d_v_i2i1__-d_f_i_n2i2_d_v_i2i1__;
                        d_qi_d_Y__(4,1) = -d_q_i_n2i2_d_v_i2i1__;
                        d_fi_d_Y__(4,2) = d_i_n2i2_d_v_n1i1__-d_f_i_n2i2_d_v_n1i1__;
                        d_qi_d_Y__(4,2) = -d_q_i_n2i2_d_v_n1i1__;
                        d_fi_d_Y__(4,3) = d_i_n2i2_d_temp_dtn2__-d_f_i_n2i2_d_temp_dtn2__;
                        d_qi_d_Y__(4,3) = -d_q_i_n2i2_d_temp_dtn2__;
                        d_fi_d_Y__(4,4) = 1-d_f_i_n2i2_d_i_n2i2__;
                        d_qi_d_Y__(4,4) = -d_q_i_n2i2_d_i_n2i2__;
                    % output for i_n2i2 (internal unknown)
                    fi__(4) = +i_n2i2__ - f_i_n2i2__;
                    qi__(4) = 0 - q_i_n2i2__;
                        d_fi_d_X__(5,1) = d_i_nci1_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__;
                        d_qi_d_X__(5,1) = -d_q_i_nci1_d_v_n1n2__;
                        d_fi_d_X__(5,2) = d_i_nci1_d_v_ncn2__-d_f_i_nci1_d_v_ncn2__;
                        d_qi_d_X__(5,2) = -d_q_i_nci1_d_v_ncn2__;
                        d_fi_d_Y__(5,1) = d_i_nci1_d_v_i2i1__-d_f_i_nci1_d_v_i2i1__;
                        d_qi_d_Y__(5,1) = -d_q_i_nci1_d_v_i2i1__;
                        d_fi_d_Y__(5,2) = d_i_nci1_d_v_n1i1__-d_f_i_nci1_d_v_n1i1__;
                        d_qi_d_Y__(5,2) = -d_q_i_nci1_d_v_n1i1__;
                        d_fi_d_Y__(5,3) = d_i_nci1_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__;
                        d_qi_d_Y__(5,3) = -d_q_i_nci1_d_temp_dtn2__;
                        d_fi_d_Y__(5,5) = 1-d_f_i_nci1_d_i_nci1__;
                        d_qi_d_Y__(5,5) = -d_q_i_nci1_d_i_nci1__;
                    % output for i_nci1 (internal unknown)
                    fi__(5) = +i_nci1__ - f_i_nci1__;
                    qi__(5) = 0 - q_i_nci1__;
                        d_fi_d_X__(6,1) = d_i_nci2_d_v_n1n2__-d_f_i_nci2_d_v_n1n2__;
                        d_qi_d_X__(6,1) = -d_q_i_nci2_d_v_n1n2__;
                        d_fi_d_X__(6,2) = d_i_nci2_d_v_ncn2__-d_f_i_nci2_d_v_ncn2__;
                        d_qi_d_X__(6,2) = -d_q_i_nci2_d_v_ncn2__;
                        d_fi_d_Y__(6,1) = d_i_nci2_d_v_i2i1__-d_f_i_nci2_d_v_i2i1__;
                        d_qi_d_Y__(6,1) = -d_q_i_nci2_d_v_i2i1__;
                        d_fi_d_Y__(6,2) = d_i_nci2_d_v_n1i1__-d_f_i_nci2_d_v_n1i1__;
                        d_qi_d_Y__(6,2) = -d_q_i_nci2_d_v_n1i1__;
                        d_fi_d_Y__(6,3) = d_i_nci2_d_temp_dtn2__-d_f_i_nci2_d_temp_dtn2__;
                        d_qi_d_Y__(6,3) = -d_q_i_nci2_d_temp_dtn2__;
                        d_fi_d_Y__(6,6) = 1-d_f_i_nci2_d_i_nci2__;
                        d_qi_d_Y__(6,6) = -d_q_i_nci2_d_i_nci2__;
                    % output for i_nci2 (internal unknown)
                    fi__(6) = +i_nci2__ - f_i_nci2__;
                    qi__(6) = 0 - q_i_nci2__;
                end
            else
                    d_fe_d_X__(1,1) = (-d_i_n2i2_d_v_n1n2__-d_i_nci1_d_v_n1n2__)-d_i_nci2_d_v_n1n2__;
                    d_fe_d_X__(1,2) = (-d_i_nci1_d_v_ncn2__)-d_i_nci2_d_v_ncn2__;
                    d_fe_d_Y__(1,1) = (-d_i_n2i2_d_v_i2i1__-d_i_nci1_d_v_i2i1__)-d_i_nci2_d_v_i2i1__;
                    d_fe_d_Y__(1,2) = (-d_i_n2i2_d_v_n1i1__-d_i_nci1_d_v_n1i1__)-d_i_nci2_d_v_n1i1__;
                    d_fe_d_Y__(1,3) = (-d_i_n2i2_d_temp_dtn2__-d_i_nci1_d_temp_dtn2__)-d_i_nci2_d_temp_dtn2__;
                    d_fe_d_Y__(1,4) = (-1);
                    d_fe_d_Y__(1,5) = (-1);
                    d_fe_d_Y__(1,6) = -1;
                % output for terminalFlow_n1 (explicit out)
                fe__(1) = -i_n2i2__-i_nci1__-i_nci2__;
                qe__(1) = 0;
                    d_fe_d_X__(2,1) = d_i_nci1_d_v_n1n2__+d_i_nci2_d_v_n1n2__;
                    d_fe_d_X__(2,2) = d_i_nci1_d_v_ncn2__+d_i_nci2_d_v_ncn2__;
                    d_fe_d_Y__(2,1) = d_i_nci1_d_v_i2i1__+d_i_nci2_d_v_i2i1__;
                    d_fe_d_Y__(2,2) = d_i_nci1_d_v_n1i1__+d_i_nci2_d_v_n1i1__;
                    d_fe_d_Y__(2,3) = d_i_nci1_d_temp_dtn2__+d_i_nci2_d_temp_dtn2__;
                    d_fe_d_Y__(2,5) = 1;
                    d_fe_d_Y__(2,6) = 1;
                % output for terminalFlow_nc (explicit out)
                fe__(2) = +i_nci1__+i_nci2__;
                qe__(2) = 0;
                    d_fi_d_X__(1,1) = (d_i_n2i2_d_v_n1n2__+d_i_nci2_d_v_n1n2__)-d_f_i_i2i1_d_v_n1n2__;
                    d_qi_d_X__(1,1) = -d_q_i_i2i1_d_v_n1n2__;
                    d_fi_d_X__(1,2) = (d_i_nci2_d_v_ncn2__)-d_f_i_i2i1_d_v_ncn2__;
                    d_qi_d_X__(1,2) = -d_q_i_i2i1_d_v_ncn2__;
                    d_fi_d_Y__(1,1) = (d_i_n2i2_d_v_i2i1__+d_i_nci2_d_v_i2i1__)-d_f_i_i2i1_d_v_i2i1__;
                    d_qi_d_Y__(1,1) = -d_q_i_i2i1_d_v_i2i1__;
                    d_fi_d_Y__(1,2) = (d_i_n2i2_d_v_n1i1__+d_i_nci2_d_v_n1i1__)-d_f_i_i2i1_d_v_n1i1__;
                    d_qi_d_Y__(1,2) = -d_q_i_i2i1_d_v_n1i1__;
                    d_fi_d_Y__(1,3) = (d_i_n2i2_d_temp_dtn2__+d_i_nci2_d_temp_dtn2__)-d_f_i_i2i1_d_temp_dtn2__;
                    d_qi_d_Y__(1,3) = -d_q_i_i2i1_d_temp_dtn2__;
                    d_fi_d_Y__(1,4) = (1);
                    d_fi_d_Y__(1,6) = (1);
                % output for v_i2i1 (internal unknown)
                fi__(1) = +i_n2i2__+i_nci2__ - f_i_i2i1__;
                qi__(1) = 0 - q_i_i2i1__;
                    d_fi_d_X__(2,1) = d_v_n1i1_d_v_n1n2__-d_f_v_n1i1_d_v_n1n2__;
                    d_qi_d_X__(2,1) = -d_q_v_n1i1_d_v_n1n2__;
                    d_fi_d_Y__(2,1) = d_v_n1i1_d_v_i2i1__-d_f_v_n1i1_d_v_i2i1__;
                    d_qi_d_Y__(2,1) = -d_q_v_n1i1_d_v_i2i1__;
                    d_fi_d_Y__(2,2) = 1-d_f_v_n1i1_d_v_n1i1__;
                    d_qi_d_Y__(2,2) = -d_q_v_n1i1_d_v_n1i1__;
                    d_fi_d_Y__(2,3) = d_v_n1i1_d_temp_dtn2__-d_f_v_n1i1_d_temp_dtn2__;
                    d_qi_d_Y__(2,3) = -d_q_v_n1i1_d_temp_dtn2__;
                    d_fi_d_Y__(2,4) = d_v_n1i1_d_i_n2i2__-d_f_v_n1i1_d_i_n2i2__;
                    d_qi_d_Y__(2,4) = -d_q_v_n1i1_d_i_n2i2__;
                    d_fi_d_Y__(2,5) = d_v_n1i1_d_i_nci1__-d_f_v_n1i1_d_i_nci1__;
                    d_qi_d_Y__(2,5) = -d_q_v_n1i1_d_i_nci1__;
                    d_fi_d_Y__(2,6) = d_v_n1i1_d_i_nci2__-d_f_v_n1i1_d_i_nci2__;
                    d_qi_d_Y__(2,6) = -d_q_v_n1i1_d_i_nci2__;
                % output for v_n1i1 (internal unknown)
                fi__(2) = +v_n1i1__ - f_v_n1i1__;
                qi__(2) = 0 - q_v_n1i1__;
                    d_fi_d_X__(3,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                    d_qi_d_X__(3,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                    d_fi_d_X__(3,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                    d_qi_d_X__(3,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                    d_fi_d_Y__(3,1) = -d_f_pwr_dtn2_d_v_i2i1__;
                    d_qi_d_Y__(3,1) = -d_q_pwr_dtn2_d_v_i2i1__;
                    d_fi_d_Y__(3,2) = -d_f_pwr_dtn2_d_v_n1i1__;
                    d_qi_d_Y__(3,2) = -d_q_pwr_dtn2_d_v_n1i1__;
                    d_fi_d_Y__(3,3) = -d_f_pwr_dtn2_d_temp_dtn2__;
                    d_qi_d_Y__(3,3) = -d_q_pwr_dtn2_d_temp_dtn2__;
                    d_fi_d_Y__(3,4) = -d_f_pwr_dtn2_d_i_n2i2__;
                    d_qi_d_Y__(3,4) = -d_q_pwr_dtn2_d_i_n2i2__;
                    d_fi_d_Y__(3,5) = -d_f_pwr_dtn2_d_i_nci1__;
                    d_qi_d_Y__(3,5) = -d_q_pwr_dtn2_d_i_nci1__;
                    d_fi_d_Y__(3,6) = -d_f_pwr_dtn2_d_i_nci2__;
                    d_qi_d_Y__(3,6) = -d_q_pwr_dtn2_d_i_nci2__;
                % output for temp_dtn2 (internal unknown)
                fi__(3) = 0 - f_pwr_dtn2__;
                qi__(3) = 0 - q_pwr_dtn2__;
                    d_fi_d_X__(4,1) = d_i_n2i2_d_v_n1n2__-d_f_i_n2i2_d_v_n1n2__;
                    d_qi_d_X__(4,1) = -d_q_i_n2i2_d_v_n1n2__;
                    d_fi_d_Y__(4,1) = d_i_n2i2_d_v_i2i1__-d_f_i_n2i2_d_v_i2i1__;
                    d_qi_d_Y__(4,1) = -d_q_i_n2i2_d_v_i2i1__;
                    d_fi_d_Y__(4,2) = d_i_n2i2_d_v_n1i1__-d_f_i_n2i2_d_v_n1i1__;
                    d_qi_d_Y__(4,2) = -d_q_i_n2i2_d_v_n1i1__;
                    d_fi_d_Y__(4,3) = d_i_n2i2_d_temp_dtn2__-d_f_i_n2i2_d_temp_dtn2__;
                    d_qi_d_Y__(4,3) = -d_q_i_n2i2_d_temp_dtn2__;
                    d_fi_d_Y__(4,4) = 1-d_f_i_n2i2_d_i_n2i2__;
                    d_qi_d_Y__(4,4) = -d_q_i_n2i2_d_i_n2i2__;
                % output for i_n2i2 (internal unknown)
                fi__(4) = +i_n2i2__ - f_i_n2i2__;
                qi__(4) = 0 - q_i_n2i2__;
                    d_fi_d_X__(5,1) = d_i_nci1_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__;
                    d_qi_d_X__(5,1) = -d_q_i_nci1_d_v_n1n2__;
                    d_fi_d_X__(5,2) = d_i_nci1_d_v_ncn2__-d_f_i_nci1_d_v_ncn2__;
                    d_qi_d_X__(5,2) = -d_q_i_nci1_d_v_ncn2__;
                    d_fi_d_Y__(5,1) = d_i_nci1_d_v_i2i1__-d_f_i_nci1_d_v_i2i1__;
                    d_qi_d_Y__(5,1) = -d_q_i_nci1_d_v_i2i1__;
                    d_fi_d_Y__(5,2) = d_i_nci1_d_v_n1i1__-d_f_i_nci1_d_v_n1i1__;
                    d_qi_d_Y__(5,2) = -d_q_i_nci1_d_v_n1i1__;
                    d_fi_d_Y__(5,3) = d_i_nci1_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__;
                    d_qi_d_Y__(5,3) = -d_q_i_nci1_d_temp_dtn2__;
                    d_fi_d_Y__(5,5) = 1-d_f_i_nci1_d_i_nci1__;
                    d_qi_d_Y__(5,5) = -d_q_i_nci1_d_i_nci1__;
                % output for i_nci1 (internal unknown)
                fi__(5) = +i_nci1__ - f_i_nci1__;
                qi__(5) = 0 - q_i_nci1__;
                    d_fi_d_X__(6,1) = d_i_nci2_d_v_n1n2__-d_f_i_nci2_d_v_n1n2__;
                    d_qi_d_X__(6,1) = -d_q_i_nci2_d_v_n1n2__;
                    d_fi_d_X__(6,2) = d_i_nci2_d_v_ncn2__-d_f_i_nci2_d_v_ncn2__;
                    d_qi_d_X__(6,2) = -d_q_i_nci2_d_v_ncn2__;
                    d_fi_d_Y__(6,1) = d_i_nci2_d_v_i2i1__-d_f_i_nci2_d_v_i2i1__;
                    d_qi_d_Y__(6,1) = -d_q_i_nci2_d_v_i2i1__;
                    d_fi_d_Y__(6,2) = d_i_nci2_d_v_n1i1__-d_f_i_nci2_d_v_n1i1__;
                    d_qi_d_Y__(6,2) = -d_q_i_nci2_d_v_n1i1__;
                    d_fi_d_Y__(6,3) = d_i_nci2_d_temp_dtn2__-d_f_i_nci2_d_temp_dtn2__;
                    d_qi_d_Y__(6,3) = -d_q_i_nci2_d_temp_dtn2__;
                    d_fi_d_Y__(6,6) = 1-d_f_i_nci2_d_i_nci2__;
                    d_qi_d_Y__(6,6) = -d_q_i_nci2_d_i_nci2__;
                % output for i_nci2 (internal unknown)
                fi__(6) = +i_nci2__ - f_i_nci2__;
                qi__(6) = 0 - q_i_nci2__;
            end
        end
    else
        if ~(rc2_tnom>mMod*parm_rthresh)
            if 1
                %Collapse branch: n2i2
                    d_fe_d_X__(1,1) = d_i_n1i1_d_v_n1n2__;
                    d_fe_d_Y__(1,1) = d_i_n1i1_d_v_i2i1__;
                    d_fe_d_Y__(1,2) = d_i_n1i1_d_temp_dtn2__;
                % output for terminalFlow_n1 (explicit out)
                fe__(1) = +i_n1i1__;
                qe__(1) = 0;
                    d_fe_d_X__(2,1) = d_f_i_nci1_d_v_n1n2__+d_f_i_nci2_d_v_n1n2__;
                    d_qe_d_X__(2,1) = d_q_i_nci1_d_v_n1n2__+d_q_i_nci2_d_v_n1n2__;
                    d_fe_d_X__(2,2) = d_f_i_nci1_d_v_ncn2__+d_f_i_nci2_d_v_ncn2__;
                    d_qe_d_X__(2,2) = d_q_i_nci1_d_v_ncn2__+d_q_i_nci2_d_v_ncn2__;
                    d_fe_d_Y__(2,1) = d_f_i_nci1_d_v_i2i1__+d_f_i_nci2_d_v_i2i1__;
                    d_qe_d_Y__(2,1) = d_q_i_nci1_d_v_i2i1__+d_q_i_nci2_d_v_i2i1__;
                    d_fe_d_Y__(2,2) = d_f_i_nci1_d_temp_dtn2__+d_f_i_nci2_d_temp_dtn2__;
                    d_qe_d_Y__(2,2) = d_q_i_nci1_d_temp_dtn2__+d_q_i_nci2_d_temp_dtn2__;
                % output for terminalFlow_nc (explicit out)
                fe__(2) = +f_i_nci1__+f_i_nci2__;
                qe__(2) = +q_i_nci1__+q_i_nci2__;
                    d_fi_d_X__(1,1) = (-d_i_n1i1_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__)-d_f_i_i2i1_d_v_n1n2__;
                    d_qi_d_X__(1,1) = (-d_q_i_nci1_d_v_n1n2__)-d_q_i_i2i1_d_v_n1n2__;
                    d_fi_d_X__(1,2) = (-d_f_i_nci1_d_v_ncn2__)-d_f_i_i2i1_d_v_ncn2__;
                    d_qi_d_X__(1,2) = (-d_q_i_nci1_d_v_ncn2__)-d_q_i_i2i1_d_v_ncn2__;
                    d_fi_d_Y__(1,1) = (-d_i_n1i1_d_v_i2i1__-d_f_i_nci1_d_v_i2i1__)-d_f_i_i2i1_d_v_i2i1__;
                    d_qi_d_Y__(1,1) = (-d_q_i_nci1_d_v_i2i1__)-d_q_i_i2i1_d_v_i2i1__;
                    d_fi_d_Y__(1,2) = (-d_i_n1i1_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__)-d_f_i_i2i1_d_temp_dtn2__;
                    d_qi_d_Y__(1,2) = (-d_q_i_nci1_d_temp_dtn2__)-d_q_i_i2i1_d_temp_dtn2__;
                % output for v_i2i1 (internal unknown)
                fi__(1) = -i_n1i1__-f_i_nci1__ - f_i_i2i1__;
                qi__(1) = -q_i_nci1__ - q_i_i2i1__;
                    d_fi_d_X__(2,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                    d_qi_d_X__(2,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                    d_fi_d_X__(2,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                    d_qi_d_X__(2,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                    d_fi_d_Y__(2,1) = -d_f_pwr_dtn2_d_v_i2i1__;
                    d_qi_d_Y__(2,1) = -d_q_pwr_dtn2_d_v_i2i1__;
                    d_fi_d_Y__(2,2) = -d_f_pwr_dtn2_d_temp_dtn2__;
                    d_qi_d_Y__(2,2) = -d_q_pwr_dtn2_d_temp_dtn2__;
                % output for temp_dtn2 (internal unknown)
                fi__(2) = 0 - f_pwr_dtn2__;
                qi__(2) = 0 - q_pwr_dtn2__;
                    d_fi_d_X__(3,1) = d_i_n1i1_d_v_n1n2__-d_f_i_n1i1_d_v_n1n2__;
                    d_qi_d_X__(3,1) = -d_q_i_n1i1_d_v_n1n2__;
                    d_fi_d_Y__(3,1) = d_i_n1i1_d_v_i2i1__-d_f_i_n1i1_d_v_i2i1__;
                    d_qi_d_Y__(3,1) = -d_q_i_n1i1_d_v_i2i1__;
                    d_fi_d_Y__(3,2) = d_i_n1i1_d_temp_dtn2__-d_f_i_n1i1_d_temp_dtn2__;
                    d_qi_d_Y__(3,2) = -d_q_i_n1i1_d_temp_dtn2__;
                % output for i_n1i1 (internal unknown)
                fi__(3) = +i_n1i1__ - f_i_n1i1__;
                qi__(3) = 0 - q_i_n1i1__;
            else
                    d_fe_d_X__(1,1) = (-d_i_n2i2_d_v_n1n2__-d_i_nci1_d_v_n1n2__)-d_i_nci2_d_v_n1n2__;
                    d_fe_d_X__(1,2) = (-d_i_nci1_d_v_ncn2__)-d_i_nci2_d_v_ncn2__;
                    d_fe_d_Y__(1,1) = (-d_i_n2i2_d_v_i2i1__-d_i_nci1_d_v_i2i1__)-d_i_nci2_d_v_i2i1__;
                    d_fe_d_Y__(1,2) = (-d_i_n2i2_d_v_n1i1__-d_i_nci1_d_v_n1i1__)-d_i_nci2_d_v_n1i1__;
                    d_fe_d_Y__(1,3) = (-d_i_n2i2_d_temp_dtn2__-d_i_nci1_d_temp_dtn2__)-d_i_nci2_d_temp_dtn2__;
                    d_fe_d_Y__(1,4) = (-1);
                    d_fe_d_Y__(1,5) = (-1);
                    d_fe_d_Y__(1,6) = -1;
                % output for terminalFlow_n1 (explicit out)
                fe__(1) = -i_n2i2__-i_nci1__-i_nci2__;
                qe__(1) = 0;
                    d_fe_d_X__(2,1) = d_i_nci1_d_v_n1n2__+d_i_nci2_d_v_n1n2__;
                    d_fe_d_X__(2,2) = d_i_nci1_d_v_ncn2__+d_i_nci2_d_v_ncn2__;
                    d_fe_d_Y__(2,1) = d_i_nci1_d_v_i2i1__+d_i_nci2_d_v_i2i1__;
                    d_fe_d_Y__(2,2) = d_i_nci1_d_v_n1i1__+d_i_nci2_d_v_n1i1__;
                    d_fe_d_Y__(2,3) = d_i_nci1_d_temp_dtn2__+d_i_nci2_d_temp_dtn2__;
                    d_fe_d_Y__(2,5) = 1;
                    d_fe_d_Y__(2,6) = 1;
                % output for terminalFlow_nc (explicit out)
                fe__(2) = +i_nci1__+i_nci2__;
                qe__(2) = 0;
                    d_fi_d_X__(1,1) = (d_i_n2i2_d_v_n1n2__+d_i_nci2_d_v_n1n2__)-d_f_i_i2i1_d_v_n1n2__;
                    d_qi_d_X__(1,1) = -d_q_i_i2i1_d_v_n1n2__;
                    d_fi_d_X__(1,2) = (d_i_nci2_d_v_ncn2__)-d_f_i_i2i1_d_v_ncn2__;
                    d_qi_d_X__(1,2) = -d_q_i_i2i1_d_v_ncn2__;
                    d_fi_d_Y__(1,1) = (d_i_n2i2_d_v_i2i1__+d_i_nci2_d_v_i2i1__)-d_f_i_i2i1_d_v_i2i1__;
                    d_qi_d_Y__(1,1) = -d_q_i_i2i1_d_v_i2i1__;
                    d_fi_d_Y__(1,2) = (d_i_n2i2_d_v_n1i1__+d_i_nci2_d_v_n1i1__)-d_f_i_i2i1_d_v_n1i1__;
                    d_qi_d_Y__(1,2) = -d_q_i_i2i1_d_v_n1i1__;
                    d_fi_d_Y__(1,3) = (d_i_n2i2_d_temp_dtn2__+d_i_nci2_d_temp_dtn2__)-d_f_i_i2i1_d_temp_dtn2__;
                    d_qi_d_Y__(1,3) = -d_q_i_i2i1_d_temp_dtn2__;
                    d_fi_d_Y__(1,4) = (1);
                    d_fi_d_Y__(1,6) = (1);
                % output for v_i2i1 (internal unknown)
                fi__(1) = +i_n2i2__+i_nci2__ - f_i_i2i1__;
                qi__(1) = 0 - q_i_i2i1__;
                    d_fi_d_X__(2,1) = d_v_n1i1_d_v_n1n2__-d_f_v_n1i1_d_v_n1n2__;
                    d_qi_d_X__(2,1) = -d_q_v_n1i1_d_v_n1n2__;
                    d_fi_d_Y__(2,1) = d_v_n1i1_d_v_i2i1__-d_f_v_n1i1_d_v_i2i1__;
                    d_qi_d_Y__(2,1) = -d_q_v_n1i1_d_v_i2i1__;
                    d_fi_d_Y__(2,2) = 1-d_f_v_n1i1_d_v_n1i1__;
                    d_qi_d_Y__(2,2) = -d_q_v_n1i1_d_v_n1i1__;
                    d_fi_d_Y__(2,3) = d_v_n1i1_d_temp_dtn2__-d_f_v_n1i1_d_temp_dtn2__;
                    d_qi_d_Y__(2,3) = -d_q_v_n1i1_d_temp_dtn2__;
                    d_fi_d_Y__(2,4) = d_v_n1i1_d_i_n2i2__-d_f_v_n1i1_d_i_n2i2__;
                    d_qi_d_Y__(2,4) = -d_q_v_n1i1_d_i_n2i2__;
                    d_fi_d_Y__(2,5) = d_v_n1i1_d_i_nci1__-d_f_v_n1i1_d_i_nci1__;
                    d_qi_d_Y__(2,5) = -d_q_v_n1i1_d_i_nci1__;
                    d_fi_d_Y__(2,6) = d_v_n1i1_d_i_nci2__-d_f_v_n1i1_d_i_nci2__;
                    d_qi_d_Y__(2,6) = -d_q_v_n1i1_d_i_nci2__;
                % output for v_n1i1 (internal unknown)
                fi__(2) = +v_n1i1__ - f_v_n1i1__;
                qi__(2) = 0 - q_v_n1i1__;
                    d_fi_d_X__(3,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                    d_qi_d_X__(3,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                    d_fi_d_X__(3,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                    d_qi_d_X__(3,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                    d_fi_d_Y__(3,1) = -d_f_pwr_dtn2_d_v_i2i1__;
                    d_qi_d_Y__(3,1) = -d_q_pwr_dtn2_d_v_i2i1__;
                    d_fi_d_Y__(3,2) = -d_f_pwr_dtn2_d_v_n1i1__;
                    d_qi_d_Y__(3,2) = -d_q_pwr_dtn2_d_v_n1i1__;
                    d_fi_d_Y__(3,3) = -d_f_pwr_dtn2_d_temp_dtn2__;
                    d_qi_d_Y__(3,3) = -d_q_pwr_dtn2_d_temp_dtn2__;
                    d_fi_d_Y__(3,4) = -d_f_pwr_dtn2_d_i_n2i2__;
                    d_qi_d_Y__(3,4) = -d_q_pwr_dtn2_d_i_n2i2__;
                    d_fi_d_Y__(3,5) = -d_f_pwr_dtn2_d_i_nci1__;
                    d_qi_d_Y__(3,5) = -d_q_pwr_dtn2_d_i_nci1__;
                    d_fi_d_Y__(3,6) = -d_f_pwr_dtn2_d_i_nci2__;
                    d_qi_d_Y__(3,6) = -d_q_pwr_dtn2_d_i_nci2__;
                % output for temp_dtn2 (internal unknown)
                fi__(3) = 0 - f_pwr_dtn2__;
                qi__(3) = 0 - q_pwr_dtn2__;
                    d_fi_d_X__(4,1) = d_i_n2i2_d_v_n1n2__-d_f_i_n2i2_d_v_n1n2__;
                    d_qi_d_X__(4,1) = -d_q_i_n2i2_d_v_n1n2__;
                    d_fi_d_Y__(4,1) = d_i_n2i2_d_v_i2i1__-d_f_i_n2i2_d_v_i2i1__;
                    d_qi_d_Y__(4,1) = -d_q_i_n2i2_d_v_i2i1__;
                    d_fi_d_Y__(4,2) = d_i_n2i2_d_v_n1i1__-d_f_i_n2i2_d_v_n1i1__;
                    d_qi_d_Y__(4,2) = -d_q_i_n2i2_d_v_n1i1__;
                    d_fi_d_Y__(4,3) = d_i_n2i2_d_temp_dtn2__-d_f_i_n2i2_d_temp_dtn2__;
                    d_qi_d_Y__(4,3) = -d_q_i_n2i2_d_temp_dtn2__;
                    d_fi_d_Y__(4,4) = 1-d_f_i_n2i2_d_i_n2i2__;
                    d_qi_d_Y__(4,4) = -d_q_i_n2i2_d_i_n2i2__;
                % output for i_n2i2 (internal unknown)
                fi__(4) = +i_n2i2__ - f_i_n2i2__;
                qi__(4) = 0 - q_i_n2i2__;
                    d_fi_d_X__(5,1) = d_i_nci1_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__;
                    d_qi_d_X__(5,1) = -d_q_i_nci1_d_v_n1n2__;
                    d_fi_d_X__(5,2) = d_i_nci1_d_v_ncn2__-d_f_i_nci1_d_v_ncn2__;
                    d_qi_d_X__(5,2) = -d_q_i_nci1_d_v_ncn2__;
                    d_fi_d_Y__(5,1) = d_i_nci1_d_v_i2i1__-d_f_i_nci1_d_v_i2i1__;
                    d_qi_d_Y__(5,1) = -d_q_i_nci1_d_v_i2i1__;
                    d_fi_d_Y__(5,2) = d_i_nci1_d_v_n1i1__-d_f_i_nci1_d_v_n1i1__;
                    d_qi_d_Y__(5,2) = -d_q_i_nci1_d_v_n1i1__;
                    d_fi_d_Y__(5,3) = d_i_nci1_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__;
                    d_qi_d_Y__(5,3) = -d_q_i_nci1_d_temp_dtn2__;
                    d_fi_d_Y__(5,5) = 1-d_f_i_nci1_d_i_nci1__;
                    d_qi_d_Y__(5,5) = -d_q_i_nci1_d_i_nci1__;
                % output for i_nci1 (internal unknown)
                fi__(5) = +i_nci1__ - f_i_nci1__;
                qi__(5) = 0 - q_i_nci1__;
                    d_fi_d_X__(6,1) = d_i_nci2_d_v_n1n2__-d_f_i_nci2_d_v_n1n2__;
                    d_qi_d_X__(6,1) = -d_q_i_nci2_d_v_n1n2__;
                    d_fi_d_X__(6,2) = d_i_nci2_d_v_ncn2__-d_f_i_nci2_d_v_ncn2__;
                    d_qi_d_X__(6,2) = -d_q_i_nci2_d_v_ncn2__;
                    d_fi_d_Y__(6,1) = d_i_nci2_d_v_i2i1__-d_f_i_nci2_d_v_i2i1__;
                    d_qi_d_Y__(6,1) = -d_q_i_nci2_d_v_i2i1__;
                    d_fi_d_Y__(6,2) = d_i_nci2_d_v_n1i1__-d_f_i_nci2_d_v_n1i1__;
                    d_qi_d_Y__(6,2) = -d_q_i_nci2_d_v_n1i1__;
                    d_fi_d_Y__(6,3) = d_i_nci2_d_temp_dtn2__-d_f_i_nci2_d_temp_dtn2__;
                    d_qi_d_Y__(6,3) = -d_q_i_nci2_d_temp_dtn2__;
                    d_fi_d_Y__(6,6) = 1-d_f_i_nci2_d_i_nci2__;
                    d_qi_d_Y__(6,6) = -d_q_i_nci2_d_i_nci2__;
                % output for i_nci2 (internal unknown)
                fi__(6) = +i_nci2__ - f_i_nci2__;
                qi__(6) = 0 - q_i_nci2__;
            end
        else
                d_fe_d_X__(1,1) = (-d_i_n2i2_d_v_n1n2__-d_i_nci1_d_v_n1n2__)-d_i_nci2_d_v_n1n2__;
                d_fe_d_X__(1,2) = (-d_i_nci1_d_v_ncn2__)-d_i_nci2_d_v_ncn2__;
                d_fe_d_Y__(1,1) = (-d_i_n2i2_d_v_i2i1__-d_i_nci1_d_v_i2i1__)-d_i_nci2_d_v_i2i1__;
                d_fe_d_Y__(1,2) = (-d_i_n2i2_d_v_n1i1__-d_i_nci1_d_v_n1i1__)-d_i_nci2_d_v_n1i1__;
                d_fe_d_Y__(1,3) = (-d_i_n2i2_d_temp_dtn2__-d_i_nci1_d_temp_dtn2__)-d_i_nci2_d_temp_dtn2__;
                d_fe_d_Y__(1,4) = (-1);
                d_fe_d_Y__(1,5) = (-1);
                d_fe_d_Y__(1,6) = -1;
            % output for terminalFlow_n1 (explicit out)
            fe__(1) = -i_n2i2__-i_nci1__-i_nci2__;
            qe__(1) = 0;
                d_fe_d_X__(2,1) = d_i_nci1_d_v_n1n2__+d_i_nci2_d_v_n1n2__;
                d_fe_d_X__(2,2) = d_i_nci1_d_v_ncn2__+d_i_nci2_d_v_ncn2__;
                d_fe_d_Y__(2,1) = d_i_nci1_d_v_i2i1__+d_i_nci2_d_v_i2i1__;
                d_fe_d_Y__(2,2) = d_i_nci1_d_v_n1i1__+d_i_nci2_d_v_n1i1__;
                d_fe_d_Y__(2,3) = d_i_nci1_d_temp_dtn2__+d_i_nci2_d_temp_dtn2__;
                d_fe_d_Y__(2,5) = 1;
                d_fe_d_Y__(2,6) = 1;
            % output for terminalFlow_nc (explicit out)
            fe__(2) = +i_nci1__+i_nci2__;
            qe__(2) = 0;
                d_fi_d_X__(1,1) = (d_i_n2i2_d_v_n1n2__+d_i_nci2_d_v_n1n2__)-d_f_i_i2i1_d_v_n1n2__;
                d_qi_d_X__(1,1) = -d_q_i_i2i1_d_v_n1n2__;
                d_fi_d_X__(1,2) = (d_i_nci2_d_v_ncn2__)-d_f_i_i2i1_d_v_ncn2__;
                d_qi_d_X__(1,2) = -d_q_i_i2i1_d_v_ncn2__;
                d_fi_d_Y__(1,1) = (d_i_n2i2_d_v_i2i1__+d_i_nci2_d_v_i2i1__)-d_f_i_i2i1_d_v_i2i1__;
                d_qi_d_Y__(1,1) = -d_q_i_i2i1_d_v_i2i1__;
                d_fi_d_Y__(1,2) = (d_i_n2i2_d_v_n1i1__+d_i_nci2_d_v_n1i1__)-d_f_i_i2i1_d_v_n1i1__;
                d_qi_d_Y__(1,2) = -d_q_i_i2i1_d_v_n1i1__;
                d_fi_d_Y__(1,3) = (d_i_n2i2_d_temp_dtn2__+d_i_nci2_d_temp_dtn2__)-d_f_i_i2i1_d_temp_dtn2__;
                d_qi_d_Y__(1,3) = -d_q_i_i2i1_d_temp_dtn2__;
                d_fi_d_Y__(1,4) = (1);
                d_fi_d_Y__(1,6) = (1);
            % output for v_i2i1 (internal unknown)
            fi__(1) = +i_n2i2__+i_nci2__ - f_i_i2i1__;
            qi__(1) = 0 - q_i_i2i1__;
                d_fi_d_X__(2,1) = d_v_n1i1_d_v_n1n2__-d_f_v_n1i1_d_v_n1n2__;
                d_qi_d_X__(2,1) = -d_q_v_n1i1_d_v_n1n2__;
                d_fi_d_Y__(2,1) = d_v_n1i1_d_v_i2i1__-d_f_v_n1i1_d_v_i2i1__;
                d_qi_d_Y__(2,1) = -d_q_v_n1i1_d_v_i2i1__;
                d_fi_d_Y__(2,2) = 1-d_f_v_n1i1_d_v_n1i1__;
                d_qi_d_Y__(2,2) = -d_q_v_n1i1_d_v_n1i1__;
                d_fi_d_Y__(2,3) = d_v_n1i1_d_temp_dtn2__-d_f_v_n1i1_d_temp_dtn2__;
                d_qi_d_Y__(2,3) = -d_q_v_n1i1_d_temp_dtn2__;
                d_fi_d_Y__(2,4) = d_v_n1i1_d_i_n2i2__-d_f_v_n1i1_d_i_n2i2__;
                d_qi_d_Y__(2,4) = -d_q_v_n1i1_d_i_n2i2__;
                d_fi_d_Y__(2,5) = d_v_n1i1_d_i_nci1__-d_f_v_n1i1_d_i_nci1__;
                d_qi_d_Y__(2,5) = -d_q_v_n1i1_d_i_nci1__;
                d_fi_d_Y__(2,6) = d_v_n1i1_d_i_nci2__-d_f_v_n1i1_d_i_nci2__;
                d_qi_d_Y__(2,6) = -d_q_v_n1i1_d_i_nci2__;
            % output for v_n1i1 (internal unknown)
            fi__(2) = +v_n1i1__ - f_v_n1i1__;
            qi__(2) = 0 - q_v_n1i1__;
                d_fi_d_X__(3,1) = -d_f_pwr_dtn2_d_v_n1n2__;
                d_qi_d_X__(3,1) = -d_q_pwr_dtn2_d_v_n1n2__;
                d_fi_d_X__(3,2) = -d_f_pwr_dtn2_d_v_ncn2__;
                d_qi_d_X__(3,2) = -d_q_pwr_dtn2_d_v_ncn2__;
                d_fi_d_Y__(3,1) = -d_f_pwr_dtn2_d_v_i2i1__;
                d_qi_d_Y__(3,1) = -d_q_pwr_dtn2_d_v_i2i1__;
                d_fi_d_Y__(3,2) = -d_f_pwr_dtn2_d_v_n1i1__;
                d_qi_d_Y__(3,2) = -d_q_pwr_dtn2_d_v_n1i1__;
                d_fi_d_Y__(3,3) = -d_f_pwr_dtn2_d_temp_dtn2__;
                d_qi_d_Y__(3,3) = -d_q_pwr_dtn2_d_temp_dtn2__;
                d_fi_d_Y__(3,4) = -d_f_pwr_dtn2_d_i_n2i2__;
                d_qi_d_Y__(3,4) = -d_q_pwr_dtn2_d_i_n2i2__;
                d_fi_d_Y__(3,5) = -d_f_pwr_dtn2_d_i_nci1__;
                d_qi_d_Y__(3,5) = -d_q_pwr_dtn2_d_i_nci1__;
                d_fi_d_Y__(3,6) = -d_f_pwr_dtn2_d_i_nci2__;
                d_qi_d_Y__(3,6) = -d_q_pwr_dtn2_d_i_nci2__;
            % output for temp_dtn2 (internal unknown)
            fi__(3) = 0 - f_pwr_dtn2__;
            qi__(3) = 0 - q_pwr_dtn2__;
                d_fi_d_X__(4,1) = d_i_n2i2_d_v_n1n2__-d_f_i_n2i2_d_v_n1n2__;
                d_qi_d_X__(4,1) = -d_q_i_n2i2_d_v_n1n2__;
                d_fi_d_Y__(4,1) = d_i_n2i2_d_v_i2i1__-d_f_i_n2i2_d_v_i2i1__;
                d_qi_d_Y__(4,1) = -d_q_i_n2i2_d_v_i2i1__;
                d_fi_d_Y__(4,2) = d_i_n2i2_d_v_n1i1__-d_f_i_n2i2_d_v_n1i1__;
                d_qi_d_Y__(4,2) = -d_q_i_n2i2_d_v_n1i1__;
                d_fi_d_Y__(4,3) = d_i_n2i2_d_temp_dtn2__-d_f_i_n2i2_d_temp_dtn2__;
                d_qi_d_Y__(4,3) = -d_q_i_n2i2_d_temp_dtn2__;
                d_fi_d_Y__(4,4) = 1-d_f_i_n2i2_d_i_n2i2__;
                d_qi_d_Y__(4,4) = -d_q_i_n2i2_d_i_n2i2__;
            % output for i_n2i2 (internal unknown)
            fi__(4) = +i_n2i2__ - f_i_n2i2__;
            qi__(4) = 0 - q_i_n2i2__;
                d_fi_d_X__(5,1) = d_i_nci1_d_v_n1n2__-d_f_i_nci1_d_v_n1n2__;
                d_qi_d_X__(5,1) = -d_q_i_nci1_d_v_n1n2__;
                d_fi_d_X__(5,2) = d_i_nci1_d_v_ncn2__-d_f_i_nci1_d_v_ncn2__;
                d_qi_d_X__(5,2) = -d_q_i_nci1_d_v_ncn2__;
                d_fi_d_Y__(5,1) = d_i_nci1_d_v_i2i1__-d_f_i_nci1_d_v_i2i1__;
                d_qi_d_Y__(5,1) = -d_q_i_nci1_d_v_i2i1__;
                d_fi_d_Y__(5,2) = d_i_nci1_d_v_n1i1__-d_f_i_nci1_d_v_n1i1__;
                d_qi_d_Y__(5,2) = -d_q_i_nci1_d_v_n1i1__;
                d_fi_d_Y__(5,3) = d_i_nci1_d_temp_dtn2__-d_f_i_nci1_d_temp_dtn2__;
                d_qi_d_Y__(5,3) = -d_q_i_nci1_d_temp_dtn2__;
                d_fi_d_Y__(5,5) = 1-d_f_i_nci1_d_i_nci1__;
                d_qi_d_Y__(5,5) = -d_q_i_nci1_d_i_nci1__;
            % output for i_nci1 (internal unknown)
            fi__(5) = +i_nci1__ - f_i_nci1__;
            qi__(5) = 0 - q_i_nci1__;
                d_fi_d_X__(6,1) = d_i_nci2_d_v_n1n2__-d_f_i_nci2_d_v_n1n2__;
                d_qi_d_X__(6,1) = -d_q_i_nci2_d_v_n1n2__;
                d_fi_d_X__(6,2) = d_i_nci2_d_v_ncn2__-d_f_i_nci2_d_v_ncn2__;
                d_qi_d_X__(6,2) = -d_q_i_nci2_d_v_ncn2__;
                d_fi_d_Y__(6,1) = d_i_nci2_d_v_i2i1__-d_f_i_nci2_d_v_i2i1__;
                d_qi_d_Y__(6,1) = -d_q_i_nci2_d_v_i2i1__;
                d_fi_d_Y__(6,2) = d_i_nci2_d_v_n1i1__-d_f_i_nci2_d_v_n1i1__;
                d_qi_d_Y__(6,2) = -d_q_i_nci2_d_v_n1i1__;
                d_fi_d_Y__(6,3) = d_i_nci2_d_temp_dtn2__-d_f_i_nci2_d_temp_dtn2__;
                d_qi_d_Y__(6,3) = -d_q_i_nci2_d_temp_dtn2__;
                d_fi_d_Y__(6,6) = 1-d_f_i_nci2_d_i_nci2__;
                d_qi_d_Y__(6,6) = -d_q_i_nci2_d_i_nci2__;
            % output for i_nci2 (internal unknown)
            fi__(6) = +i_nci2__ - f_i_nci2__;
            qi__(6) = 0 - q_i_nci2__;
        end
    end
end

function [eonames, iunames, ienames] = get_oui_names__(MOD__)
    parm_w = MOD__.parm_vals{1};
    parm_c1 = MOD__.parm_vals{6};
    parm_c2 = MOD__.parm_vals{9};
    parm_scale = MOD__.parm_vals{25};
    parm_shrink = MOD__.parm_vals{26};
    parm_rthresh = MOD__.parm_vals{27};
    parm_rc = MOD__.parm_vals{79};
    parm_rcw = MOD__.parm_vals{80};
    mMod = 1;
    lFactor = ((1-0.01*parm_shrink)*parm_scale)*1000000;
    w_um = parm_w*lFactor;
    rc1_tnom = qmcol_vapp(parm_c1>0, (parm_rc+parm_rcw/w_um)/parm_c1, 0);
    rc2_tnom = qmcol_vapp(parm_c2>0, (parm_rc+parm_rcw/w_um)/parm_c2, 0);
    if ~(rc1_tnom>mMod*parm_rthresh)
        if 1
            %Collapse branch: n1i1
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                    eonames = {'in1n2', 'incn2'};
                    iunames = {'temp_dtn2'};
                    ienames = {'KCL for pwr_dtn2'};
                else
                    eonames = {'in1n2', 'incn2'};
                    iunames = {'v_i2i1', 'temp_dtn2', 'i_n2i2'};
                    ienames = {'KCL for i_i2i1', 'KCL for pwr_dtn2', 'constitutive equation for i_n2i2'};
                end
            else
                eonames = {'in1n2', 'incn2'};
                iunames = {'v_i2i1', 'temp_dtn2', 'i_n2i2'};
                ienames = {'KCL for i_i2i1', 'KCL for pwr_dtn2', 'constitutive equation for i_n2i2'};
            end
        else
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                    eonames = {'in1n2', 'incn2'};
                    iunames = {'v_i2i1', 'temp_dtn2', 'i_n1i1'};
                    ienames = {'KCL for i_i2i1', 'KCL for pwr_dtn2', 'constitutive equation for i_n1i1'};
                else
                    eonames = {'in1n2', 'incn2'};
                    iunames = {'v_i2i1', 'v_n1i1', 'temp_dtn2', 'i_n2i2', 'i_nci1', 'i_nci2'};
                    ienames = {'KCL for i_i2i1', 'constitutive equation for v_n1i1', 'KCL for pwr_dtn2', 'constitutive equation for i_n2i2', 'constitutive equation for i_nci1', 'constitutive equation for i_nci2'};
                end
            else
                eonames = {'in1n2', 'incn2'};
                iunames = {'v_i2i1', 'v_n1i1', 'temp_dtn2', 'i_n2i2', 'i_nci1', 'i_nci2'};
                ienames = {'KCL for i_i2i1', 'constitutive equation for v_n1i1', 'KCL for pwr_dtn2', 'constitutive equation for i_n2i2', 'constitutive equation for i_nci1', 'constitutive equation for i_nci2'};
            end
        end
    else
        if ~(rc2_tnom>mMod*parm_rthresh)
            if 1
                %Collapse branch: n2i2
                eonames = {'in1n2', 'incn2'};
                iunames = {'v_i2i1', 'temp_dtn2', 'i_n1i1'};
                ienames = {'KCL for i_i2i1', 'KCL for pwr_dtn2', 'constitutive equation for i_n1i1'};
            else
                eonames = {'in1n2', 'incn2'};
                iunames = {'v_i2i1', 'v_n1i1', 'temp_dtn2', 'i_n2i2', 'i_nci1', 'i_nci2'};
                ienames = {'KCL for i_i2i1', 'constitutive equation for v_n1i1', 'KCL for pwr_dtn2', 'constitutive equation for i_n2i2', 'constitutive equation for i_nci1', 'constitutive equation for i_nci2'};
            end
        else
            eonames = {'in1n2', 'incn2'};
            iunames = {'v_i2i1', 'v_n1i1', 'temp_dtn2', 'i_n2i2', 'i_nci1', 'i_nci2'};
            ienames = {'KCL for i_i2i1', 'constitutive equation for v_n1i1', 'KCL for pwr_dtn2', 'constitutive equation for i_n2i2', 'constitutive equation for i_nci1', 'constitutive equation for i_nci2'};
        end
    end
end

function [nFeQe, nFiQi, nOtherIo, nIntUnk] = get_nfq__(MOD__)
    parm_w = MOD__.parm_vals{1};
    parm_c1 = MOD__.parm_vals{6};
    parm_c2 = MOD__.parm_vals{9};
    parm_scale = MOD__.parm_vals{25};
    parm_shrink = MOD__.parm_vals{26};
    parm_rthresh = MOD__.parm_vals{27};
    parm_rc = MOD__.parm_vals{79};
    parm_rcw = MOD__.parm_vals{80};
    mMod = 1;
    lFactor = ((1-0.01*parm_shrink)*parm_scale)*1000000;
    w_um = parm_w*lFactor;
    rc1_tnom = qmcol_vapp(parm_c1>0, (parm_rc+parm_rcw/w_um)/parm_c1, 0);
    rc2_tnom = qmcol_vapp(parm_c2>0, (parm_rc+parm_rcw/w_um)/parm_c2, 0);
    if ~(rc1_tnom>mMod*parm_rthresh)
        if 1
            %Collapse branch: n1i1
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                    nFeQe = 2;
                    nFiQi = 1;
                    nOtherIo = 2;
                    nIntUnk = 1;
                else
                    nFeQe = 2;
                    nFiQi = 3;
                    nOtherIo = 2;
                    nIntUnk = 3;
                end
            else
                nFeQe = 2;
                nFiQi = 3;
                nOtherIo = 2;
                nIntUnk = 3;
            end
        else
            if ~(rc2_tnom>mMod*parm_rthresh)
                if 1
                    %Collapse branch: n2i2
                    nFeQe = 2;
                    nFiQi = 3;
                    nOtherIo = 2;
                    nIntUnk = 3;
                else
                    nFeQe = 2;
                    nFiQi = 6;
                    nOtherIo = 2;
                    nIntUnk = 6;
                end
            else
                nFeQe = 2;
                nFiQi = 6;
                nOtherIo = 2;
                nIntUnk = 6;
            end
        end
    else
        if ~(rc2_tnom>mMod*parm_rthresh)
            if 1
                %Collapse branch: n2i2
                nFeQe = 2;
                nFiQi = 3;
                nOtherIo = 2;
                nIntUnk = 3;
            else
                nFeQe = 2;
                nFiQi = 6;
                nOtherIo = 2;
                nIntUnk = 6;
            end
        else
            nFeQe = 2;
            nFiQi = 6;
            nOtherIo = 2;
            nIntUnk = 6;
        end
    end
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
