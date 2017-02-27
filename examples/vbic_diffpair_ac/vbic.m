function MOD = vbic(uniqID)

%===============================================================================
% This file was created using VAPP, the Berkeley Verilog-A Parser and Processor.   
% Last modified: 23-Feb-2017 13:36:06
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

    MOD.model_name = 'vbic';
    MOD.NIL.node_names = {'c', 'b', 'e'};
    MOD.NIL.refnode_name = 'e';

    parmNameDefValArr = {'parm_TNOM', 27,...
                         'parm_RCX', 0,...
                         'parm_RCI', 0,...
                         'parm_VO', 0,...
                         'parm_GAMM', 0,...
                         'parm_HRCF', 0,...
                         'parm_RBX', 0,...
                         'parm_RBI', 0,...
                         'parm_RE', 0,...
                         'parm_RS', 0,...
                         'parm_RBP', 0,...
                         'parm_IS', 1e-16,...
                         'parm_NF', 1,...
                         'parm_NR', 1,...
                         'parm_FC', 0.9,...
                         'parm_CBEO', 0,...
                         'parm_CJE', 0,...
                         'parm_PE', 0.75,...
                         'parm_ME', 0.33,...
                         'parm_AJE', -0.5,...
                         'parm_CBCO', 0,...
                         'parm_CJC', 0,...
                         'parm_QCO', 0,...
                         'parm_CJEP', 0,...
                         'parm_PC', 0.75,...
                         'parm_MC', 0.33,...
                         'parm_AJC', -0.5,...
                         'parm_CJCP', 0,...
                         'parm_PS', 0.75,...
                         'parm_MS', 0.33,...
                         'parm_AJS', -0.5,...
                         'parm_IBEI', 1e-18,...
                         'parm_WBE', 1,...
                         'parm_NEI', 1,...
                         'parm_IBEN', 0,...
                         'parm_NEN', 2,...
                         'parm_IBCI', 1e-16,...
                         'parm_NCI', 1,...
                         'parm_IBCN', 0,...
                         'parm_NCN', 2,...
                         'parm_AVC1', 0,...
                         'parm_AVC2', 0,...
                         'parm_ISP', 0,...
                         'parm_WSP', 1,...
                         'parm_NFP', 1,...
                         'parm_IBEIP', 0,...
                         'parm_IBENP', 0,...
                         'parm_IBCIP', 0,...
                         'parm_NCIP', 1,...
                         'parm_IBCNP', 0,...
                         'parm_NCNP', 2,...
                         'parm_VEF', 0,...
                         'parm_VER', 0,...
                         'parm_IKF', 0,...
                         'parm_IKR', 0,...
                         'parm_IKP', 0,...
                         'parm_TF', 0,...
                         'parm_QTF', 0,...
                         'parm_XTF', 0,...
                         'parm_VTF', 0,...
                         'parm_ITF', 0,...
                         'parm_TR', 0,...
                         'parm_TD', 0,...
                         'parm_KFN', 0,...
                         'parm_AFN', 1,...
                         'parm_BFN', 1,...
                         'parm_XRE', 0,...
                         'parm_XRBI', 0,...
                         'parm_XRCI', 0,...
                         'parm_XRS', 0,...
                         'parm_XVO', 0,...
                         'parm_EA', 1.12,...
                         'parm_EAIE', 1.12,...
                         'parm_EAIC', 1.12,...
                         'parm_EAIS', 1.12,...
                         'parm_EANE', 1.12,...
                         'parm_EANC', 1.12,...
                         'parm_EANS', 1.12,...
                         'parm_XIS', 3,...
                         'parm_XII', 3,...
                         'parm_XIN', 3,...
                         'parm_TNF', 0,...
                         'parm_TAVC', 0,...
                         'parm_RTH', 0,...
                         'parm_CTH', 0,...
                         'parm_VRT', 0,...
                         'parm_ART', 0.1,...
                         'parm_CCSO', 0,...
                         'parm_QBM', 0,...
                         'parm_NKF', 0.5,...
                         'parm_XIKF', 0,...
                         'parm_XRCX', 0,...
                         'parm_XRBX', 0,...
                         'parm_XRBP', 0,...
                         'parm_ISRR', 1,...
                         'parm_XISR', 0,...
                         'parm_DEAR', 0,...
                         'parm_EAP', 1.12,...
                         'parm_VBBE', 0,...
                         'parm_NBBE', 1,...
                         'parm_IBBE', 1e-06,...
                         'parm_TVBBE1', 0,...
                         'parm_TVBBE2', 0,...
                         'parm_TNBBE', 0,...
                         'parm_EBBE', 0,...
                         'parm_DTEMP', 0,...
                         'parm_VERS', 1.2,...
                         'parm_VREV', 0};

    nParm = 108;
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
    parm_TNOM = MOD__.parm_vals{1};
    parm_RCX = MOD__.parm_vals{2};
    parm_RCI = MOD__.parm_vals{3};
    parm_VO = MOD__.parm_vals{4};
    parm_GAMM = MOD__.parm_vals{5};
    parm_HRCF = MOD__.parm_vals{6};
    parm_RBX = MOD__.parm_vals{7};
    parm_RBI = MOD__.parm_vals{8};
    parm_RE = MOD__.parm_vals{9};
    parm_RS = MOD__.parm_vals{10};
    parm_RBP = MOD__.parm_vals{11};
    parm_IS = MOD__.parm_vals{12};
    parm_NF = MOD__.parm_vals{13};
    parm_NR = MOD__.parm_vals{14};
    parm_FC = MOD__.parm_vals{15};
    parm_CBEO = MOD__.parm_vals{16};
    parm_CJE = MOD__.parm_vals{17};
    parm_PE = MOD__.parm_vals{18};
    parm_ME = MOD__.parm_vals{19};
    parm_AJE = MOD__.parm_vals{20};
    parm_CBCO = MOD__.parm_vals{21};
    parm_CJC = MOD__.parm_vals{22};
    parm_QCO = MOD__.parm_vals{23};
    parm_CJEP = MOD__.parm_vals{24};
    parm_PC = MOD__.parm_vals{25};
    parm_MC = MOD__.parm_vals{26};
    parm_AJC = MOD__.parm_vals{27};
    parm_CJCP = MOD__.parm_vals{28};
    parm_PS = MOD__.parm_vals{29};
    parm_MS = MOD__.parm_vals{30};
    parm_AJS = MOD__.parm_vals{31};
    parm_IBEI = MOD__.parm_vals{32};
    parm_WBE = MOD__.parm_vals{33};
    parm_NEI = MOD__.parm_vals{34};
    parm_IBEN = MOD__.parm_vals{35};
    parm_NEN = MOD__.parm_vals{36};
    parm_IBCI = MOD__.parm_vals{37};
    parm_NCI = MOD__.parm_vals{38};
    parm_IBCN = MOD__.parm_vals{39};
    parm_NCN = MOD__.parm_vals{40};
    parm_AVC1 = MOD__.parm_vals{41};
    parm_AVC2 = MOD__.parm_vals{42};
    parm_ISP = MOD__.parm_vals{43};
    parm_WSP = MOD__.parm_vals{44};
    parm_NFP = MOD__.parm_vals{45};
    parm_IBEIP = MOD__.parm_vals{46};
    parm_IBENP = MOD__.parm_vals{47};
    parm_IBCIP = MOD__.parm_vals{48};
    parm_NCIP = MOD__.parm_vals{49};
    parm_IBCNP = MOD__.parm_vals{50};
    parm_NCNP = MOD__.parm_vals{51};
    parm_VEF = MOD__.parm_vals{52};
    parm_VER = MOD__.parm_vals{53};
    parm_IKF = MOD__.parm_vals{54};
    parm_IKR = MOD__.parm_vals{55};
    parm_IKP = MOD__.parm_vals{56};
    parm_TF = MOD__.parm_vals{57};
    parm_QTF = MOD__.parm_vals{58};
    parm_XTF = MOD__.parm_vals{59};
    parm_VTF = MOD__.parm_vals{60};
    parm_ITF = MOD__.parm_vals{61};
    parm_TR = MOD__.parm_vals{62};
    parm_TD = MOD__.parm_vals{63};
    parm_KFN = MOD__.parm_vals{64};
    parm_AFN = MOD__.parm_vals{65};
    parm_BFN = MOD__.parm_vals{66};
    parm_XRE = MOD__.parm_vals{67};
    parm_XRBI = MOD__.parm_vals{68};
    parm_XRCI = MOD__.parm_vals{69};
    parm_XRS = MOD__.parm_vals{70};
    parm_XVO = MOD__.parm_vals{71};
    parm_EA = MOD__.parm_vals{72};
    parm_EAIE = MOD__.parm_vals{73};
    parm_EAIC = MOD__.parm_vals{74};
    parm_EAIS = MOD__.parm_vals{75};
    parm_EANE = MOD__.parm_vals{76};
    parm_EANC = MOD__.parm_vals{77};
    parm_EANS = MOD__.parm_vals{78};
    parm_XIS = MOD__.parm_vals{79};
    parm_XII = MOD__.parm_vals{80};
    parm_XIN = MOD__.parm_vals{81};
    parm_TNF = MOD__.parm_vals{82};
    parm_TAVC = MOD__.parm_vals{83};
    parm_RTH = MOD__.parm_vals{84};
    parm_CTH = MOD__.parm_vals{85};
    parm_VRT = MOD__.parm_vals{86};
    parm_ART = MOD__.parm_vals{87};
    parm_CCSO = MOD__.parm_vals{88};
    parm_QBM = MOD__.parm_vals{89};
    parm_NKF = MOD__.parm_vals{90};
    parm_XIKF = MOD__.parm_vals{91};
    parm_XRCX = MOD__.parm_vals{92};
    parm_XRBX = MOD__.parm_vals{93};
    parm_XRBP = MOD__.parm_vals{94};
    parm_ISRR = MOD__.parm_vals{95};
    parm_XISR = MOD__.parm_vals{96};
    parm_DEAR = MOD__.parm_vals{97};
    parm_EAP = MOD__.parm_vals{98};
    parm_VBBE = MOD__.parm_vals{99};
    parm_NBBE = MOD__.parm_vals{100};
    parm_IBBE = MOD__.parm_vals{101};
    parm_TVBBE1 = MOD__.parm_vals{102};
    parm_TVBBE2 = MOD__.parm_vals{103};
    parm_TNBBE = MOD__.parm_vals{104};
    parm_EBBE = MOD__.parm_vals{105};
    parm_DTEMP = MOD__.parm_vals{106};
    parm_VERS = MOD__.parm_vals{107};
    parm_VREV = MOD__.parm_vals{108};

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
    d_Ibc_d_v_bici__ = 0;
    d_Ibc_d_v_biei__ = 0;
    d_Ibc_d_v_bxbp__ = 0;
    d_Ibc_d_v_bxei__ = 0;
    d_Ibcj_d_v_bici__ = 0;
    d_Ibcj_d_v_biei__ = 0;
    d_Ibcj_d_v_bxbp__ = 0;
    d_Ibcj_d_v_bxei__ = 0;
    d_Ibe_d_v_bici__ = 0;
    d_Ibe_d_v_biei__ = 0;
    d_Ibe_d_v_bxbp__ = 0;
    d_Ibe_d_v_bxei__ = 0;
    d_Ibep_d_v_bici__ = 0;
    d_Ibep_d_v_biei__ = 0;
    d_Ibep_d_v_bxbp__ = 0;
    d_Ibep_d_v_bxei__ = 0;
    d_Ibex_d_v_bici__ = 0;
    d_Ibex_d_v_biei__ = 0;
    d_Ibex_d_v_bxbp__ = 0;
    d_Ibex_d_v_bxei__ = 0;
    d_Ifi_d_v_biei__ = 0;
    d_Ifp_d_v_bici__ = 0;
    d_Ifp_d_v_biei__ = 0;
    d_Ifp_d_v_bxbp__ = 0;
    d_Igc_d_v_bici__ = 0;
    d_Igc_d_v_biei__ = 0;
    d_Igc_d_v_bxbp__ = 0;
    d_Igc_d_v_bxei__ = 0;
    d_Iohm_d_v_bici__ = 0;
    d_Iohm_d_v_bicx__ = 0;
    d_Iohm_d_v_biei__ = 0;
    d_Iohm_d_v_bxbp__ = 0;
    d_Iohm_d_v_bxei__ = 0;
    d_Irbi_d_v_bici__ = 0;
    d_Irbi_d_v_biei__ = 0;
    d_Irbi_d_v_bxei__ = 0;
    d_Irbp_d_v_bici__ = 0;
    d_Irbp_d_v_bicx__ = 0;
    d_Irbp_d_v_biei__ = 0;
    d_Irbp_d_v_bxbp__ = 0;
    d_Irbp_d_v_bxei__ = 0;
    d_Irbx_d_v_be__ = 0;
    d_Irbx_d_v_bxei__ = 0;
    d_Irbx_d_v_eei__ = 0;
    d_Irci_d_v_bici__ = 0;
    d_Irci_d_v_bicx__ = 0;
    d_Irci_d_v_biei__ = 0;
    d_Irci_d_v_bxbp__ = 0;
    d_Irci_d_v_bxei__ = 0;
    d_Ircx_d_v_bicx__ = 0;
    d_Ircx_d_v_biei__ = 0;
    d_Ircx_d_v_ce__ = 0;
    d_Ircx_d_v_eei__ = 0;
    d_Ire_d_v_eei__ = 0;
    d_Iri_d_v_bici__ = 0;
    d_Iri_d_v_biei__ = 0;
    d_Itzf_d_v_bici__ = 0;
    d_Itzf_d_v_biei__ = 0;
    d_Itzf_d_v_bxei__ = 0;
    d_Itzr_d_v_bici__ = 0;
    d_Itzr_d_v_biei__ = 0;
    d_Itzr_d_v_bxei__ = 0;
    d_Kbci_d_v_bici__ = 0;
    d_Kbci_d_v_biei__ = 0;
    d_Kbci_d_v_bxbp__ = 0;
    d_Kbci_d_v_bxei__ = 0;
    d_Kbcx_d_v_bici__ = 0;
    d_Kbcx_d_v_bicx__ = 0;
    d_Kbcx_d_v_biei__ = 0;
    d_Kbcx_d_v_bxei__ = 0;
    d_Qbc_d_v_bici__ = 0;
    d_Qbc_d_v_biei__ = 0;
    d_Qbc_d_v_bxbp__ = 0;
    d_Qbc_d_v_bxei__ = 0;
    d_Qbco_d_v_be__ = 0;
    d_Qbco_d_v_ce__ = 0;
    d_Qbcx_d_v_bici__ = 0;
    d_Qbcx_d_v_bicx__ = 0;
    d_Qbcx_d_v_biei__ = 0;
    d_Qbcx_d_v_bxei__ = 0;
    d_Qbe_d_v_bici__ = 0;
    d_Qbe_d_v_biei__ = 0;
    d_Qbe_d_v_bxei__ = 0;
    d_Qbeo_d_v_be__ = 0;
    d_Qbep_d_v_bici__ = 0;
    d_Qbep_d_v_biei__ = 0;
    d_Qbep_d_v_bxbp__ = 0;
    d_Qbep_d_v_bxei__ = 0;
    d_Qbex_d_v_biei__ = 0;
    d_Qbex_d_v_bxei__ = 0;
    d_argi_d_v_bici__ = 0;
    d_argi_d_v_biei__ = 0;
    d_argi_d_v_bxbp__ = 0;
    d_argi_d_v_bxei__ = 0;
    d_argn_d_v_bici__ = 0;
    d_argn_d_v_biei__ = 0;
    d_argn_d_v_bxbp__ = 0;
    d_argn_d_v_bxei__ = 0;
    d_argx_d_v_bici__ = 0;
    d_argx_d_v_bicx__ = 0;
    d_argx_d_v_biei__ = 0;
    d_argx_d_v_bxei__ = 0;
    d_avalf_d_v_bici__ = 0;
    d_avalf_d_v_biei__ = 0;
    d_avalf_d_v_bxbp__ = 0;
    d_avalf_d_v_bxei__ = 0;
    d_cl_d_v_bici__ = 0;
    d_cl_d_v_bxbp__ = 0;
    d_derf_d_v_bici__ = 0;
    d_derf_d_v_bicx__ = 0;
    d_derf_d_v_biei__ = 0;
    d_derf_d_v_bxbp__ = 0;
    d_derf_d_v_bxei__ = 0;
    d_dv_d_v_bici__ = 0;
    d_dv_d_v_biei__ = 0;
    d_dv_d_v_bxbp__ = 0;
    d_dv_d_v_bxei__ = 0;
    d_dvh_d_v_bici__ = 0;
    d_dvh_d_v_biei__ = 0;
    d_dvh_d_v_bxbp__ = 0;
    d_dvh_d_v_bxei__ = 0;
    d_expi_d_v_bici__ = 0;
    d_expi_d_v_biei__ = 0;
    d_expi_d_v_bxbp__ = 0;
    d_expi_d_v_bxei__ = 0;
    d_expn_d_v_bici__ = 0;
    d_expn_d_v_biei__ = 0;
    d_expn_d_v_bxbp__ = 0;
    d_expn_d_v_bxei__ = 0;
    d_expx_d_v_bici__ = 0;
    d_expx_d_v_bicx__ = 0;
    d_expx_d_v_biei__ = 0;
    d_expx_d_v_bxei__ = 0;
    d_f_i_bbx_d_v_be__ = 0;
    d_f_i_bbx_d_v_bxei__ = 0;
    d_f_i_bbx_d_v_eei__ = 0;
    d_f_i_bc_d_v_be__ = 0;
    d_f_i_bc_d_v_ce__ = 0;
    d_f_i_be_d_v_be__ = 0;
    d_f_i_bici_d_v_bici__ = 0;
    d_f_i_bici_d_v_biei__ = 0;
    d_f_i_bici_d_v_bxbp__ = 0;
    d_f_i_bici_d_v_bxei__ = 0;
    d_f_i_bicx_d_v_bici__ = 0;
    d_f_i_bicx_d_v_bicx__ = 0;
    d_f_i_bicx_d_v_biei__ = 0;
    d_f_i_bicx_d_v_bxei__ = 0;
    d_f_i_biei_d_v_bici__ = 0;
    d_f_i_biei_d_v_biei__ = 0;
    d_f_i_biei_d_v_bxbp__ = 0;
    d_f_i_biei_d_v_bxei__ = 0;
    d_f_i_bpcx_d_v_bici__ = 0;
    d_f_i_bpcx_d_v_bicx__ = 0;
    d_f_i_bpcx_d_v_biei__ = 0;
    d_f_i_bpcx_d_v_bxbp__ = 0;
    d_f_i_bpcx_d_v_bxei__ = 0;
    d_f_i_bxbi_d_v_bici__ = 0;
    d_f_i_bxbi_d_v_biei__ = 0;
    d_f_i_bxbi_d_v_bxei__ = 0;
    d_f_i_bxbp_d_v_bici__ = 0;
    d_f_i_bxbp_d_v_biei__ = 0;
    d_f_i_bxbp_d_v_bxbp__ = 0;
    d_f_i_bxbp_d_v_bxei__ = 0;
    d_f_i_bxei_d_v_bici__ = 0;
    d_f_i_bxei_d_v_biei__ = 0;
    d_f_i_bxei_d_v_bxbp__ = 0;
    d_f_i_bxei_d_v_bxei__ = 0;
    d_f_i_ccx_d_v_bicx__ = 0;
    d_f_i_ccx_d_v_biei__ = 0;
    d_f_i_ccx_d_v_ce__ = 0;
    d_f_i_ccx_d_v_eei__ = 0;
    d_f_i_ciei_d_v_bici__ = 0;
    d_f_i_ciei_d_v_biei__ = 0;
    d_f_i_ciei_d_v_bxei__ = 0;
    d_f_i_cxci_d_v_bici__ = 0;
    d_f_i_cxci_d_v_bicx__ = 0;
    d_f_i_cxci_d_v_biei__ = 0;
    d_f_i_cxci_d_v_bxbp__ = 0;
    d_f_i_cxci_d_v_bxei__ = 0;
    d_f_i_eei_d_v_eei__ = 0;
    d_mIf_d_v_biei__ = 0;
    d_mv_d_v_bici__ = 0;
    d_mv_d_v_biei__ = 0;
    d_mv_d_v_bxbp__ = 0;
    d_mv_d_v_bxei__ = 0;
    d_pwq_d_v_bici__ = 0;
    d_pwq_d_v_biei__ = 0;
    d_pwq_d_v_bxbp__ = 0;
    d_pwq_d_v_bxei__ = 0;
    d_q1_d_v_bici__ = 0;
    d_q1_d_v_biei__ = 0;
    d_q1_d_v_bxei__ = 0;
    d_q1z_d_v_bici__ = 0;
    d_q1z_d_v_biei__ = 0;
    d_q1z_d_v_bxei__ = 0;
    d_q2_d_v_bici__ = 0;
    d_q2_d_v_biei__ = 0;
    d_q2p_d_v_bici__ = 0;
    d_q2p_d_v_biei__ = 0;
    d_q2p_d_v_bxbp__ = 0;
    d_q_i_bbx_d_v_be__ = 0;
    d_q_i_bbx_d_v_bxei__ = 0;
    d_q_i_bbx_d_v_eei__ = 0;
    d_q_i_bc_d_v_be__ = 0;
    d_q_i_bc_d_v_ce__ = 0;
    d_q_i_be_d_v_be__ = 0;
    d_q_i_bici_d_v_bici__ = 0;
    d_q_i_bici_d_v_biei__ = 0;
    d_q_i_bici_d_v_bxbp__ = 0;
    d_q_i_bici_d_v_bxei__ = 0;
    d_q_i_bicx_d_v_bici__ = 0;
    d_q_i_bicx_d_v_bicx__ = 0;
    d_q_i_bicx_d_v_biei__ = 0;
    d_q_i_bicx_d_v_bxei__ = 0;
    d_q_i_biei_d_v_bici__ = 0;
    d_q_i_biei_d_v_biei__ = 0;
    d_q_i_biei_d_v_bxbp__ = 0;
    d_q_i_biei_d_v_bxei__ = 0;
    d_q_i_bpcx_d_v_bici__ = 0;
    d_q_i_bpcx_d_v_bicx__ = 0;
    d_q_i_bpcx_d_v_biei__ = 0;
    d_q_i_bpcx_d_v_bxbp__ = 0;
    d_q_i_bpcx_d_v_bxei__ = 0;
    d_q_i_bxbi_d_v_bici__ = 0;
    d_q_i_bxbi_d_v_biei__ = 0;
    d_q_i_bxbi_d_v_bxei__ = 0;
    d_q_i_bxbp_d_v_bici__ = 0;
    d_q_i_bxbp_d_v_biei__ = 0;
    d_q_i_bxbp_d_v_bxbp__ = 0;
    d_q_i_bxbp_d_v_bxei__ = 0;
    d_q_i_bxei_d_v_bici__ = 0;
    d_q_i_bxei_d_v_biei__ = 0;
    d_q_i_bxei_d_v_bxbp__ = 0;
    d_q_i_bxei_d_v_bxei__ = 0;
    d_q_i_ccx_d_v_bicx__ = 0;
    d_q_i_ccx_d_v_biei__ = 0;
    d_q_i_ccx_d_v_ce__ = 0;
    d_q_i_ccx_d_v_eei__ = 0;
    d_q_i_ciei_d_v_bici__ = 0;
    d_q_i_ciei_d_v_biei__ = 0;
    d_q_i_ciei_d_v_bxei__ = 0;
    d_q_i_cxci_d_v_bici__ = 0;
    d_q_i_cxci_d_v_bicx__ = 0;
    d_q_i_cxci_d_v_biei__ = 0;
    d_q_i_cxci_d_v_bxbp__ = 0;
    d_q_i_cxci_d_v_bxei__ = 0;
    d_q_i_eei_d_v_eei__ = 0;
    d_qb_d_v_bici__ = 0;
    d_qb_d_v_biei__ = 0;
    d_qb_d_v_bxei__ = 0;
    d_qbp_d_v_bici__ = 0;
    d_qbp_d_v_biei__ = 0;
    d_qbp_d_v_bxbp__ = 0;
    d_qdbc_d_v_bici__ = 0;
    d_qdbc_d_v_biei__ = 0;
    d_qdbc_d_v_bxei__ = 0;
    d_qdbe_d_v_biei__ = 0;
    d_qdbep_d_v_bici__ = 0;
    d_qdbep_d_v_biei__ = 0;
    d_qdbep_d_v_bxbp__ = 0;
    d_qdbep_d_v_bxei__ = 0;
    d_qdbex_d_v_biei__ = 0;
    d_qdbex_d_v_bxei__ = 0;
    d_qhi_d_v_bici__ = 0;
    d_qhi_d_v_biei__ = 0;
    d_qhi_d_v_bxbp__ = 0;
    d_qhi_d_v_bxei__ = 0;
    d_ql_d_v_bici__ = 0;
    d_ql_d_v_biei__ = 0;
    d_ql_d_v_bxbp__ = 0;
    d_ql_d_v_bxei__ = 0;
    d_qlo_d_v_bici__ = 0;
    d_qlo_d_v_biei__ = 0;
    d_qlo_d_v_bxbp__ = 0;
    d_qlo_d_v_bxei__ = 0;
    d_rIf_d_v_biei__ = 0;
    d_rKp1_d_v_bici__ = 0;
    d_rKp1_d_v_bicx__ = 0;
    d_rKp1_d_v_biei__ = 0;
    d_rKp1_d_v_bxbp__ = 0;
    d_rKp1_d_v_bxei__ = 0;
    d_sel_d_v_bici__ = 0;
    d_sel_d_v_bxbp__ = 0;
    d_sgIf_d_v_biei__ = 0;
    d_tff_d_v_bici__ = 0;
    d_tff_d_v_biei__ = 0;
    d_tff_d_v_bxei__ = 0;
    d_v_bbx_d_v_be__ = 0;
    d_v_bbx_d_v_bxei__ = 0;
    d_v_bbx_d_v_eei__ = 0;
    d_v_bc_d_v_be__ = 0;
    d_v_bc_d_v_ce__ = 0;
    d_v_bpcx_d_v_bicx__ = 0;
    d_v_bpcx_d_v_biei__ = 0;
    d_v_bpcx_d_v_bxbp__ = 0;
    d_v_bpcx_d_v_bxei__ = 0;
    d_v_bxbi_d_v_biei__ = 0;
    d_v_bxbi_d_v_bxei__ = 0;
    d_v_ccx_d_v_bicx__ = 0;
    d_v_ccx_d_v_biei__ = 0;
    d_v_ccx_d_v_ce__ = 0;
    d_v_ccx_d_v_eei__ = 0;
    d_v_cxci_d_v_bici__ = 0;
    d_v_cxci_d_v_bicx__ = 0;
    d_vl_d_v_bici__ = 0;
    d_vl_d_v_biei__ = 0;
    d_vl_d_v_bxbp__ = 0;
    d_vl_d_v_bxei__ = 0;
    d_vn_d_v_bici__ = 0;
    d_vn_d_v_bxbp__ = 0;
    d_vnl_d_v_bici__ = 0;
    d_vnl_d_v_bxbp__ = 0;
    % Initializing inputs
    v_ce__ = vecX__(1);
    v_be__ = vecX__(2);
    v_biei__ = vecY__(1);
    v_bxei__ = vecY__(2);
    v_bici__ = vecY__(3);
    v_bicx__ = vecY__(4);
    v_bxbp__ = vecY__(5);
    v_eei__ = vecY__(6);
    % Initializing remaining IOs and auxiliary IOs
    f_i_be__ = 0;
    q_i_be__ = 0;
    f_i_bc__ = 0;
    q_i_bc__ = 0;
    f_i_biei__ = 0;
    q_i_biei__ = 0;
    f_i_bxei__ = 0;
    q_i_bxei__ = 0;
    f_i_bici__ = 0;
    q_i_bici__ = 0;
    f_i_bicx__ = 0;
    q_i_bicx__ = 0;
    f_i_ciei__ = 0;
    q_i_ciei__ = 0;
    f_i_bxbp__ = 0;
    q_i_bxbp__ = 0;
    f_i_eei__ = 0;
    q_i_eei__ = 0;
    f_i_ccx__ = 0;
    q_i_ccx__ = 0;
    f_i_cxci__ = 0;
    q_i_cxci__ = 0;
    f_i_bbx__ = 0;
    q_i_bbx__ = 0;
    f_i_bxbi__ = 0;
    q_i_bxbi__ = 0;
    f_i_bpcx__ = 0;
    q_i_bpcx__ = 0;
    % module body
        d_v_bc_d_v_ce__ = -1;
        d_v_bc_d_v_be__ = 1;
    v_bc__ = v_be__-v_ce__;
        d_v_ccx_d_v_ce__ = ((1));
        d_v_ccx_d_v_biei__ = ((-1));
        d_v_ccx_d_v_bicx__ = (1);
        d_v_ccx_d_v_eei__ = 1;
    v_ccx__ = ((v_ce__-v_biei__)+v_bicx__)+v_eei__;
        d_v_cxci_d_v_bici__ = 1;
        d_v_cxci_d_v_bicx__ = -1;
    v_cxci__ = v_bici__-v_bicx__;
        d_v_bbx_d_v_be__ = (1);
        d_v_bbx_d_v_bxei__ = (-1);
        d_v_bbx_d_v_eei__ = 1;
    v_bbx__ = (v_be__-v_bxei__)+v_eei__;
        d_v_bxbi_d_v_biei__ = -1;
        d_v_bxbi_d_v_bxei__ = 1;
    v_bxbi__ = -v_biei__+v_bxei__;
        d_v_bpcx_d_v_biei__ = ((-1));
        d_v_bpcx_d_v_bxei__ = ((1));
        d_v_bpcx_d_v_bicx__ = (1);
        d_v_bpcx_d_v_bxbp__ = -1;
    v_bpcx__ = ((-v_biei__+v_bxei__)+v_bicx__)-v_bxbp__;
    Tini = 273.15+parm_TNOM;
    Tdev = sim_temperature_vapp(MOD__)+parm_DTEMP;
    Vtv = (1.3807e-23*Tdev)/1.6022e-19;
    rT = Tdev/Tini;
    dT = Tdev-Tini;
    IKFatT = parm_IKF*pow_vapp(rT, parm_XIKF);
    RCXatT = parm_RCX*pow_vapp(rT, parm_XRCX);
    RCIatT = parm_RCI*pow_vapp(rT, parm_XRCI);
    RBXatT = parm_RBX*pow_vapp(rT, parm_XRBX);
    RBIatT = parm_RBI*pow_vapp(rT, parm_XRBI);
    REatT = parm_RE*pow_vapp(rT, parm_XRE);
    RSatT = parm_RS*pow_vapp(rT, parm_XRS);
    RBPatT = parm_RBP*pow_vapp(rT, parm_XRBP);
    ISatT = parm_IS*pow_vapp(pow_vapp(rT, parm_XIS)*exp((-parm_EA*(1-rT))/Vtv), 1/parm_NF);
    ISRRatT = parm_ISRR*pow_vapp(pow_vapp(rT, parm_XISR)*exp((-parm_DEAR*(1-rT))/Vtv), 1/parm_NR);
    ISPatT = parm_ISP*pow_vapp(pow_vapp(rT, parm_XIS)*exp((-parm_EAP*(1-rT))/Vtv), 1/parm_NFP);
    IBEIatT = parm_IBEI*pow_vapp(pow_vapp(rT, parm_XII)*exp((-parm_EAIE*(1-rT))/Vtv), 1/parm_NEI);
    IBENatT = parm_IBEN*pow_vapp(pow_vapp(rT, parm_XIN)*exp((-parm_EANE*(1-rT))/Vtv), 1/parm_NEN);
    IBCIatT = parm_IBCI*pow_vapp(pow_vapp(rT, parm_XII)*exp((-parm_EAIC*(1-rT))/Vtv), 1/parm_NCI);
    IBCNatT = parm_IBCN*pow_vapp(pow_vapp(rT, parm_XIN)*exp((-parm_EANC*(1-rT))/Vtv), 1/parm_NCN);
    IBEIPatT = parm_IBEIP*pow_vapp(pow_vapp(rT, parm_XII)*exp((-parm_EAIC*(1-rT))/Vtv), 1/parm_NCI);
    IBENPatT = parm_IBENP*pow_vapp(pow_vapp(rT, parm_XIN)*exp((-parm_EANC*(1-rT))/Vtv), 1/parm_NCN);
    IBCIPatT = parm_IBCIP*pow_vapp(pow_vapp(rT, parm_XII)*exp((-parm_EAIS*(1-rT))/Vtv), 1/parm_NCIP);
    IBCNPatT = parm_IBCNP*pow_vapp(pow_vapp(rT, parm_XIN)*exp((-parm_EANS*(1-rT))/Vtv), 1/parm_NCNP);
    NFatT = parm_NF*(1+dT*parm_TNF);
    NRatT = parm_NR*(1+dT*parm_TNF);
    AVC2atT = parm_AVC2*(1+dT*parm_TAVC);
    VBBEatT = parm_VBBE*(1+dT*(parm_TVBBE1+dT*parm_TVBBE2));
    NBBEatT = parm_NBBE*(1+dT*parm_TNBBE);
    psiio = (2*(Vtv/rT))*log10(exp(((0.5*parm_PE)*rT)/Vtv)-exp(((-0.5*parm_PE)*rT)/Vtv));
    psiin = (psiio*rT-(3*Vtv)*log10(rT))-parm_EAIE*(rT-1);
    PEatT = psiin+(2*Vtv)*log10(0.5*(1+sqrt(1+4*exp(-psiin/Vtv))));
    psiio = (2*(Vtv/rT))*log10(exp(((0.5*parm_PC)*rT)/Vtv)-exp(((-0.5*parm_PC)*rT)/Vtv));
    psiin = (psiio*rT-(3*Vtv)*log10(rT))-parm_EAIC*(rT-1);
    PCatT = psiin+(2*Vtv)*log10(0.5*(1+sqrt(1+4*exp(-psiin/Vtv))));
    psiio = (2*(Vtv/rT))*log10(exp(((0.5*parm_PS)*rT)/Vtv)-exp(((-0.5*parm_PS)*rT)/Vtv));
    psiin = (psiio*rT-(3*Vtv)*log10(rT))-parm_EAIS*(rT-1);
    PSatT = psiin+(2*Vtv)*log10(0.5*(1+sqrt(1+4*exp(-psiin/Vtv))));
    CJEatT = parm_CJE*pow_vapp(parm_PE/PEatT, parm_ME);
    CJCatT = parm_CJC*pow_vapp(parm_PC/PCatT, parm_MC);
    CJEPatT = parm_CJEP*pow_vapp(parm_PC/PCatT, parm_MC);
    CJCPatT = parm_CJCP*pow_vapp(parm_PS/PSatT, parm_MS);
    GAMMatT = (parm_GAMM*pow_vapp(rT, parm_XIS))*exp((-parm_EA*(1-rT))/Vtv);
    VOatT = parm_VO*pow_vapp(rT, parm_XVO);
    EBBEatT = exp(-VBBEatT/(NBBEatT*Vtv));
    IVEF = qmcol_vapp(parm_VEF>0, 1/parm_VEF, 0);
    IVER = qmcol_vapp(parm_VER>0, 1/parm_VER, 0);
    IIKF = qmcol_vapp(parm_IKF>0, 1/IKFatT, 0);
    IIKR = qmcol_vapp(parm_IKR>0, 1/parm_IKR, 0);
    IIKP = qmcol_vapp(parm_IKP>0, 1/parm_IKP, 0);
    IVO = qmcol_vapp(parm_VO>0, 1/VOatT, 0);
    IHRCF = qmcol_vapp(parm_HRCF>0, 1/parm_HRCF, 0);
    IVTF = qmcol_vapp(parm_VTF>0, 1/parm_VTF, 0);
    IITF = qmcol_vapp(parm_ITF>0, 1/parm_ITF, 0);
    slTF = qmcol_vapp(parm_ITF>0, 0, 1);
    dv0 = -PEatT*parm_FC;
    if parm_AJE<=0
            d_dvh_d_v_biei__ = 1;
            d_dvh_d_v_bxei__ = 0;
            d_dvh_d_v_bici__ = 0;
            d_dvh_d_v_bxbp__ = 0;
        dvh = v_biei__+dv0;
        if dvh>0
                d_pwq_d_v_biei__ = 0;
                d_pwq_d_v_bxei__ = 0;
                d_pwq_d_v_bici__ = 0;
                d_pwq_d_v_bxbp__ = 0;
            pwq = pow_vapp(1-parm_FC, -1-parm_ME);
                d_qlo_d_v_biei__ = (PEatT*(-((d_pwq_d_v_biei__*(1-parm_FC))*(1-parm_FC))))/(1-parm_ME);
                d_qlo_d_v_bxei__ = 0;
                d_qlo_d_v_bici__ = 0;
                d_qlo_d_v_bxbp__ = 0;
            qlo = (PEatT*(1-(pwq*(1-parm_FC))*(1-parm_FC)))/(1-parm_ME);
                d_qhi_d_v_biei__ = (dvh*((1-parm_FC)+((0.5*parm_ME)*dvh)/PEatT))*d_pwq_d_v_biei__+(dvh*((((0.5*parm_ME)*d_dvh_d_v_biei__)/PEatT))+d_dvh_d_v_biei__*((1-parm_FC)+((0.5*parm_ME)*dvh)/PEatT))*pwq;
                d_qhi_d_v_bxei__ = 0;
                d_qhi_d_v_bici__ = 0;
                d_qhi_d_v_bxbp__ = 0;
            qhi = (dvh*((1-parm_FC)+((0.5*parm_ME)*dvh)/PEatT))*pwq;
        else
                d_qlo_d_v_biei__ = (PEatT*(-d_pow_vapp_d_arg1__(1-v_biei__/PEatT, 1-parm_ME)*(-(1/PEatT))))/(1-parm_ME);
                d_qlo_d_v_bxei__ = 0;
                d_qlo_d_v_bici__ = 0;
                d_qlo_d_v_bxbp__ = 0;
            qlo = (PEatT*(1-pow_vapp(1-v_biei__/PEatT, 1-parm_ME)))/(1-parm_ME);
                d_qhi_d_v_biei__ = 0;
                d_qhi_d_v_bxei__ = 0;
                d_qhi_d_v_bici__ = 0;
                d_qhi_d_v_bxbp__ = 0;
            qhi = 0;
        end
            d_qdbe_d_v_biei__ = d_qlo_d_v_biei__+d_qhi_d_v_biei__;
        qdbe = qlo+qhi;
    else
        mv0 = sqrt(dv0*dv0+(4*parm_AJE)*parm_AJE);
        vl0 = -0.5*(dv0+mv0);
        q0 = (-PEatT*pow_vapp(1-vl0/PEatT, 1-parm_ME))/(1-parm_ME);
            d_dv_d_v_biei__ = 1;
            d_dv_d_v_bxei__ = 0;
            d_dv_d_v_bici__ = 0;
            d_dv_d_v_bxbp__ = 0;
        dv = v_biei__+dv0;
            d_mv_d_v_biei__ = (1/(2*sqrt(dv*dv+(4*parm_AJE)*parm_AJE)))*((dv*d_dv_d_v_biei__+d_dv_d_v_biei__*dv));
            d_mv_d_v_bxei__ = 0;
            d_mv_d_v_bici__ = 0;
            d_mv_d_v_bxbp__ = 0;
        mv = sqrt(dv*dv+(4*parm_AJE)*parm_AJE);
            d_vl_d_v_biei__ = (0.5*(d_dv_d_v_biei__-d_mv_d_v_biei__));
            d_vl_d_v_bxei__ = 0;
            d_vl_d_v_bici__ = 0;
            d_vl_d_v_bxbp__ = 0;
        vl = 0.5*(dv-mv)-dv0;
            d_qlo_d_v_biei__ = (-PEatT*(d_pow_vapp_d_arg1__(1-vl/PEatT, 1-parm_ME)*(-(d_vl_d_v_biei__/PEatT))))/(1-parm_ME);
            d_qlo_d_v_bxei__ = 0;
            d_qlo_d_v_bici__ = 0;
            d_qlo_d_v_bxbp__ = 0;
        qlo = (-PEatT*pow_vapp(1-vl/PEatT, 1-parm_ME))/(1-parm_ME);
            d_qdbe_d_v_biei__ = (d_qlo_d_v_biei__+(pow_vapp(1-parm_FC, -parm_ME)*((1-d_vl_d_v_biei__))));
        qdbe = (qlo+pow_vapp(1-parm_FC, -parm_ME)*((v_biei__-vl)+vl0))-q0;
    end
    dv0 = -PEatT*parm_FC;
    if parm_AJE<=0
            d_dvh_d_v_biei__ = 0;
            d_dvh_d_v_bxei__ = 1;
            d_dvh_d_v_bici__ = 0;
            d_dvh_d_v_bxbp__ = 0;
        dvh = v_bxei__+dv0;
        if dvh>0
                d_pwq_d_v_biei__ = 0;
                d_pwq_d_v_bxei__ = 0;
                d_pwq_d_v_bici__ = 0;
                d_pwq_d_v_bxbp__ = 0;
            pwq = pow_vapp(1-parm_FC, -1-parm_ME);
                d_qlo_d_v_biei__ = (PEatT*(-((d_pwq_d_v_biei__*(1-parm_FC))*(1-parm_FC))))/(1-parm_ME);
                d_qlo_d_v_bxei__ = (PEatT*(-((d_pwq_d_v_bxei__*(1-parm_FC))*(1-parm_FC))))/(1-parm_ME);
                d_qlo_d_v_bici__ = 0;
                d_qlo_d_v_bxbp__ = 0;
            qlo = (PEatT*(1-(pwq*(1-parm_FC))*(1-parm_FC)))/(1-parm_ME);
                d_qhi_d_v_biei__ = (dvh*((1-parm_FC)+((0.5*parm_ME)*dvh)/PEatT))*d_pwq_d_v_biei__+(dvh*((((0.5*parm_ME)*d_dvh_d_v_biei__)/PEatT))+d_dvh_d_v_biei__*((1-parm_FC)+((0.5*parm_ME)*dvh)/PEatT))*pwq;
                d_qhi_d_v_bxei__ = (dvh*((1-parm_FC)+((0.5*parm_ME)*dvh)/PEatT))*d_pwq_d_v_bxei__+(dvh*((((0.5*parm_ME)*d_dvh_d_v_bxei__)/PEatT))+d_dvh_d_v_bxei__*((1-parm_FC)+((0.5*parm_ME)*dvh)/PEatT))*pwq;
                d_qhi_d_v_bici__ = 0;
                d_qhi_d_v_bxbp__ = 0;
            qhi = (dvh*((1-parm_FC)+((0.5*parm_ME)*dvh)/PEatT))*pwq;
        else
                d_qlo_d_v_biei__ = 0;
                d_qlo_d_v_bxei__ = (PEatT*(-d_pow_vapp_d_arg1__(1-v_bxei__/PEatT, 1-parm_ME)*(-(1/PEatT))))/(1-parm_ME);
                d_qlo_d_v_bici__ = 0;
                d_qlo_d_v_bxbp__ = 0;
            qlo = (PEatT*(1-pow_vapp(1-v_bxei__/PEatT, 1-parm_ME)))/(1-parm_ME);
                d_qhi_d_v_biei__ = 0;
                d_qhi_d_v_bxei__ = 0;
                d_qhi_d_v_bici__ = 0;
                d_qhi_d_v_bxbp__ = 0;
            qhi = 0;
        end
            d_qdbex_d_v_biei__ = d_qlo_d_v_biei__+d_qhi_d_v_biei__;
            d_qdbex_d_v_bxei__ = d_qlo_d_v_bxei__+d_qhi_d_v_bxei__;
        qdbex = qlo+qhi;
    else
        mv0 = sqrt(dv0*dv0+(4*parm_AJE)*parm_AJE);
        vl0 = -0.5*(dv0+mv0);
        q0 = (-PEatT*pow_vapp(1-vl0/PEatT, 1-parm_ME))/(1-parm_ME);
            d_dv_d_v_biei__ = 0;
            d_dv_d_v_bxei__ = 1;
            d_dv_d_v_bici__ = 0;
            d_dv_d_v_bxbp__ = 0;
        dv = v_bxei__+dv0;
            d_mv_d_v_biei__ = (1/(2*sqrt(dv*dv+(4*parm_AJE)*parm_AJE)))*((dv*d_dv_d_v_biei__+d_dv_d_v_biei__*dv));
            d_mv_d_v_bxei__ = (1/(2*sqrt(dv*dv+(4*parm_AJE)*parm_AJE)))*((dv*d_dv_d_v_bxei__+d_dv_d_v_bxei__*dv));
            d_mv_d_v_bici__ = 0;
            d_mv_d_v_bxbp__ = 0;
        mv = sqrt(dv*dv+(4*parm_AJE)*parm_AJE);
            d_vl_d_v_biei__ = (0.5*(d_dv_d_v_biei__-d_mv_d_v_biei__));
            d_vl_d_v_bxei__ = (0.5*(d_dv_d_v_bxei__-d_mv_d_v_bxei__));
            d_vl_d_v_bici__ = 0;
            d_vl_d_v_bxbp__ = 0;
        vl = 0.5*(dv-mv)-dv0;
            d_qlo_d_v_biei__ = (-PEatT*(d_pow_vapp_d_arg1__(1-vl/PEatT, 1-parm_ME)*(-(d_vl_d_v_biei__/PEatT))))/(1-parm_ME);
            d_qlo_d_v_bxei__ = (-PEatT*(d_pow_vapp_d_arg1__(1-vl/PEatT, 1-parm_ME)*(-(d_vl_d_v_bxei__/PEatT))))/(1-parm_ME);
            d_qlo_d_v_bici__ = 0;
            d_qlo_d_v_bxbp__ = 0;
        qlo = (-PEatT*pow_vapp(1-vl/PEatT, 1-parm_ME))/(1-parm_ME);
            d_qdbex_d_v_biei__ = (d_qlo_d_v_biei__+(pow_vapp(1-parm_FC, -parm_ME)*((-d_vl_d_v_biei__))));
            d_qdbex_d_v_bxei__ = (d_qlo_d_v_bxei__+(pow_vapp(1-parm_FC, -parm_ME)*((1-d_vl_d_v_bxei__))));
        qdbex = (qlo+pow_vapp(1-parm_FC, -parm_ME)*((v_bxei__-vl)+vl0))-q0;
    end
    dv0 = -PCatT*parm_FC;
    if parm_AJC<=0
            d_dvh_d_v_biei__ = 0;
            d_dvh_d_v_bxei__ = 0;
            d_dvh_d_v_bici__ = 1;
            d_dvh_d_v_bxbp__ = 0;
        dvh = v_bici__+dv0;
        if dvh>0
                d_pwq_d_v_biei__ = 0;
                d_pwq_d_v_bxei__ = 0;
                d_pwq_d_v_bici__ = 0;
                d_pwq_d_v_bxbp__ = 0;
            pwq = pow_vapp(1-parm_FC, -1-parm_MC);
                d_qlo_d_v_biei__ = (PCatT*(-((d_pwq_d_v_biei__*(1-parm_FC))*(1-parm_FC))))/(1-parm_MC);
                d_qlo_d_v_bxei__ = (PCatT*(-((d_pwq_d_v_bxei__*(1-parm_FC))*(1-parm_FC))))/(1-parm_MC);
                d_qlo_d_v_bici__ = (PCatT*(-((d_pwq_d_v_bici__*(1-parm_FC))*(1-parm_FC))))/(1-parm_MC);
                d_qlo_d_v_bxbp__ = 0;
            qlo = (PCatT*(1-(pwq*(1-parm_FC))*(1-parm_FC)))/(1-parm_MC);
                d_qhi_d_v_biei__ = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*d_pwq_d_v_biei__+(dvh*((((0.5*parm_MC)*d_dvh_d_v_biei__)/PCatT))+d_dvh_d_v_biei__*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
                d_qhi_d_v_bxei__ = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*d_pwq_d_v_bxei__+(dvh*((((0.5*parm_MC)*d_dvh_d_v_bxei__)/PCatT))+d_dvh_d_v_bxei__*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
                d_qhi_d_v_bici__ = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*d_pwq_d_v_bici__+(dvh*((((0.5*parm_MC)*d_dvh_d_v_bici__)/PCatT))+d_dvh_d_v_bici__*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
                d_qhi_d_v_bxbp__ = 0;
            qhi = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
        else
            if parm_VRT>0&&v_bici__<-parm_VRT
                    d_qlo_d_v_biei__ = 0;
                    d_qlo_d_v_bxei__ = 0;
                    d_qlo_d_v_bici__ = (PCatT*(-(pow_vapp(1+parm_VRT/PCatT, 1-parm_MC)*(-(((1-parm_MC)*(1))/(PCatT+parm_VRT))))))/(1-parm_MC);
                    d_qlo_d_v_bxbp__ = 0;
                qlo = (PCatT*(1-pow_vapp(1+parm_VRT/PCatT, 1-parm_MC)*(1-((1-parm_MC)*(v_bici__+parm_VRT))/(PCatT+parm_VRT))))/(1-parm_MC);
            else
                    d_qlo_d_v_biei__ = 0;
                    d_qlo_d_v_bxei__ = 0;
                    d_qlo_d_v_bici__ = (PCatT*(-d_pow_vapp_d_arg1__(1-v_bici__/PCatT, 1-parm_MC)*(-(1/PCatT))))/(1-parm_MC);
                    d_qlo_d_v_bxbp__ = 0;
                qlo = (PCatT*(1-pow_vapp(1-v_bici__/PCatT, 1-parm_MC)))/(1-parm_MC);
            end
                d_qhi_d_v_biei__ = 0;
                d_qhi_d_v_bxei__ = 0;
                d_qhi_d_v_bici__ = 0;
                d_qhi_d_v_bxbp__ = 0;
            qhi = 0;
        end
            d_qdbc_d_v_biei__ = d_qlo_d_v_biei__+d_qhi_d_v_biei__;
            d_qdbc_d_v_bxei__ = d_qlo_d_v_bxei__+d_qhi_d_v_bxei__;
            d_qdbc_d_v_bici__ = d_qlo_d_v_bici__+d_qhi_d_v_bici__;
        qdbc = qlo+qhi;
    else
        if parm_VRT>0&&parm_ART>0
            vn0 = (parm_VRT+dv0)/(parm_VRT-dv0);
            vnl0 = (2*vn0)/(sqrt((vn0-1)*(vn0-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn0+1)*(vn0+1)+(4*parm_ART)*parm_ART));
            vl0 = 0.5*((vnl0*(parm_VRT-dv0)-parm_VRT)-dv0);
            qlo0 = (PCatT*(1-pow_vapp(1-vl0/PCatT, 1-parm_MC)))/(1-parm_MC);
                d_vn_d_v_bici__ = (((2*1)))/(parm_VRT-dv0);
                d_vn_d_v_bxbp__ = 0;
            vn = ((2*v_bici__+parm_VRT)+dv0)/(parm_VRT-dv0);
                d_vnl_d_v_bici__ = (2*d_vn_d_v_bici__)/(sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART))-((2*vn)*((1/(2*sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)))*(((vn-1)*(d_vn_d_v_bici__)+(d_vn_d_v_bici__)*(vn-1)))+(1/(2*sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART)))*(((vn+1)*(d_vn_d_v_bici__)+(d_vn_d_v_bici__)*(vn+1)))))/(sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART))^2;
                d_vnl_d_v_bxbp__ = 0;
            vnl = (2*vn)/(sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART));
                d_vl_d_v_biei__ = 0;
                d_vl_d_v_bxei__ = 0;
                d_vl_d_v_bici__ = 0.5*(((d_vnl_d_v_bici__*(parm_VRT-dv0))));
                d_vl_d_v_bxbp__ = 0;
            vl = 0.5*((vnl*(parm_VRT-dv0)-parm_VRT)-dv0);
                d_qlo_d_v_biei__ = (PCatT*(-d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_biei__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bxei__ = (PCatT*(-d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bxei__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bici__ = (PCatT*(-d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bici__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bxbp__ = 0;
            qlo = (PCatT*(1-pow_vapp(1-vl/PCatT, 1-parm_MC)))/(1-parm_MC);
                d_sel_d_v_bici__ = 0.5*(d_vnl_d_v_bici__);
                d_sel_d_v_bxbp__ = 0;
            sel = 0.5*(vnl+1);
            crt = pow_vapp(1+parm_VRT/PCatT, -parm_MC);
            cmx = pow_vapp(1+dv0/PCatT, -parm_MC);
                d_cl_d_v_bici__ = ((-d_sel_d_v_bici__)*crt)+(d_sel_d_v_bici__*cmx);
                d_cl_d_v_bxbp__ = 0;
            cl = (1-sel)*crt+sel*cmx;
                d_ql_d_v_biei__ = ((-d_vl_d_v_biei__))*cl;
                d_ql_d_v_bxei__ = ((-d_vl_d_v_bxei__))*cl;
                d_ql_d_v_bici__ = ((v_bici__-vl)+vl0)*d_cl_d_v_bici__+((1-d_vl_d_v_bici__))*cl;
                d_ql_d_v_bxbp__ = 0;
            ql = ((v_bici__-vl)+vl0)*cl;
                d_qdbc_d_v_biei__ = (d_ql_d_v_biei__+d_qlo_d_v_biei__);
                d_qdbc_d_v_bxei__ = (d_ql_d_v_bxei__+d_qlo_d_v_bxei__);
                d_qdbc_d_v_bici__ = (d_ql_d_v_bici__+d_qlo_d_v_bici__);
            qdbc = (ql+qlo)-qlo0;
        else
            mv0 = sqrt(dv0*dv0+(4*parm_AJC)*parm_AJC);
            vl0 = -0.5*(dv0+mv0);
            q0 = (-PCatT*pow_vapp(1-vl0/PCatT, 1-parm_MC))/(1-parm_MC);
                d_dv_d_v_biei__ = 0;
                d_dv_d_v_bxei__ = 0;
                d_dv_d_v_bici__ = 1;
                d_dv_d_v_bxbp__ = 0;
            dv = v_bici__+dv0;
                d_mv_d_v_biei__ = (1/(2*sqrt(dv*dv+(4*parm_AJC)*parm_AJC)))*((dv*d_dv_d_v_biei__+d_dv_d_v_biei__*dv));
                d_mv_d_v_bxei__ = (1/(2*sqrt(dv*dv+(4*parm_AJC)*parm_AJC)))*((dv*d_dv_d_v_bxei__+d_dv_d_v_bxei__*dv));
                d_mv_d_v_bici__ = (1/(2*sqrt(dv*dv+(4*parm_AJC)*parm_AJC)))*((dv*d_dv_d_v_bici__+d_dv_d_v_bici__*dv));
                d_mv_d_v_bxbp__ = 0;
            mv = sqrt(dv*dv+(4*parm_AJC)*parm_AJC);
                d_vl_d_v_biei__ = (0.5*(d_dv_d_v_biei__-d_mv_d_v_biei__));
                d_vl_d_v_bxei__ = (0.5*(d_dv_d_v_bxei__-d_mv_d_v_bxei__));
                d_vl_d_v_bici__ = (0.5*(d_dv_d_v_bici__-d_mv_d_v_bici__));
                d_vl_d_v_bxbp__ = 0;
            vl = 0.5*(dv-mv)-dv0;
                d_qlo_d_v_biei__ = (-PCatT*(d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_biei__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bxei__ = (-PCatT*(d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bxei__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bici__ = (-PCatT*(d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bici__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bxbp__ = 0;
            qlo = (-PCatT*pow_vapp(1-vl/PCatT, 1-parm_MC))/(1-parm_MC);
                d_qdbc_d_v_biei__ = (d_qlo_d_v_biei__+(pow_vapp(1-parm_FC, -parm_MC)*((-d_vl_d_v_biei__))));
                d_qdbc_d_v_bxei__ = (d_qlo_d_v_bxei__+(pow_vapp(1-parm_FC, -parm_MC)*((-d_vl_d_v_bxei__))));
                d_qdbc_d_v_bici__ = (d_qlo_d_v_bici__+(pow_vapp(1-parm_FC, -parm_MC)*((1-d_vl_d_v_bici__))));
            qdbc = (qlo+pow_vapp(1-parm_FC, -parm_MC)*((v_bici__-vl)+vl0))-q0;
        end
    end
    dv0 = -PCatT*parm_FC;
    if parm_AJC<=0
            d_dvh_d_v_biei__ = 0;
            d_dvh_d_v_bxei__ = 0;
            d_dvh_d_v_bici__ = 0;
            d_dvh_d_v_bxbp__ = 1;
        dvh = v_bxbp__+dv0;
        if dvh>0
                d_pwq_d_v_biei__ = 0;
                d_pwq_d_v_bxei__ = 0;
                d_pwq_d_v_bici__ = 0;
                d_pwq_d_v_bxbp__ = 0;
            pwq = pow_vapp(1-parm_FC, -1-parm_MC);
                d_qlo_d_v_biei__ = (PCatT*(-((d_pwq_d_v_biei__*(1-parm_FC))*(1-parm_FC))))/(1-parm_MC);
                d_qlo_d_v_bxei__ = (PCatT*(-((d_pwq_d_v_bxei__*(1-parm_FC))*(1-parm_FC))))/(1-parm_MC);
                d_qlo_d_v_bici__ = (PCatT*(-((d_pwq_d_v_bici__*(1-parm_FC))*(1-parm_FC))))/(1-parm_MC);
                d_qlo_d_v_bxbp__ = (PCatT*(-((d_pwq_d_v_bxbp__*(1-parm_FC))*(1-parm_FC))))/(1-parm_MC);
            qlo = (PCatT*(1-(pwq*(1-parm_FC))*(1-parm_FC)))/(1-parm_MC);
                d_qhi_d_v_biei__ = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*d_pwq_d_v_biei__+(dvh*((((0.5*parm_MC)*d_dvh_d_v_biei__)/PCatT))+d_dvh_d_v_biei__*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
                d_qhi_d_v_bxei__ = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*d_pwq_d_v_bxei__+(dvh*((((0.5*parm_MC)*d_dvh_d_v_bxei__)/PCatT))+d_dvh_d_v_bxei__*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
                d_qhi_d_v_bici__ = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*d_pwq_d_v_bici__+(dvh*((((0.5*parm_MC)*d_dvh_d_v_bici__)/PCatT))+d_dvh_d_v_bici__*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
                d_qhi_d_v_bxbp__ = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*d_pwq_d_v_bxbp__+(dvh*((((0.5*parm_MC)*d_dvh_d_v_bxbp__)/PCatT))+d_dvh_d_v_bxbp__*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
            qhi = (dvh*((1-parm_FC)+((0.5*parm_MC)*dvh)/PCatT))*pwq;
        else
            if parm_VRT>0&&v_bxbp__<-parm_VRT
                    d_qlo_d_v_biei__ = 0;
                    d_qlo_d_v_bxei__ = 0;
                    d_qlo_d_v_bici__ = 0;
                    d_qlo_d_v_bxbp__ = (PCatT*(-(pow_vapp(1+parm_VRT/PCatT, 1-parm_MC)*(-(((1-parm_MC)*(1))/(PCatT+parm_VRT))))))/(1-parm_MC);
                qlo = (PCatT*(1-pow_vapp(1+parm_VRT/PCatT, 1-parm_MC)*(1-((1-parm_MC)*(v_bxbp__+parm_VRT))/(PCatT+parm_VRT))))/(1-parm_MC);
            else
                    d_qlo_d_v_biei__ = 0;
                    d_qlo_d_v_bxei__ = 0;
                    d_qlo_d_v_bici__ = 0;
                    d_qlo_d_v_bxbp__ = (PCatT*(-d_pow_vapp_d_arg1__(1-v_bxbp__/PCatT, 1-parm_MC)*(-(1/PCatT))))/(1-parm_MC);
                qlo = (PCatT*(1-pow_vapp(1-v_bxbp__/PCatT, 1-parm_MC)))/(1-parm_MC);
            end
                d_qhi_d_v_biei__ = 0;
                d_qhi_d_v_bxei__ = 0;
                d_qhi_d_v_bici__ = 0;
                d_qhi_d_v_bxbp__ = 0;
            qhi = 0;
        end
            d_qdbep_d_v_biei__ = d_qlo_d_v_biei__+d_qhi_d_v_biei__;
            d_qdbep_d_v_bxei__ = d_qlo_d_v_bxei__+d_qhi_d_v_bxei__;
            d_qdbep_d_v_bici__ = d_qlo_d_v_bici__+d_qhi_d_v_bici__;
            d_qdbep_d_v_bxbp__ = d_qlo_d_v_bxbp__+d_qhi_d_v_bxbp__;
        qdbep = qlo+qhi;
    else
        if parm_VRT>0&&parm_ART>0
            vn0 = (parm_VRT+dv0)/(parm_VRT-dv0);
            vnl0 = (2*vn0)/(sqrt((vn0-1)*(vn0-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn0+1)*(vn0+1)+(4*parm_ART)*parm_ART));
            vl0 = 0.5*((vnl0*(parm_VRT-dv0)-parm_VRT)-dv0);
            qlo0 = (PCatT*(1-pow_vapp(1-vl0/PCatT, 1-parm_MC)))/(1-parm_MC);
                d_vn_d_v_bici__ = 0;
                d_vn_d_v_bxbp__ = (((2*1)))/(parm_VRT-dv0);
            vn = ((2*v_bxbp__+parm_VRT)+dv0)/(parm_VRT-dv0);
                d_vnl_d_v_bici__ = (2*d_vn_d_v_bici__)/(sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART))-((2*vn)*((1/(2*sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)))*(((vn-1)*(d_vn_d_v_bici__)+(d_vn_d_v_bici__)*(vn-1)))+(1/(2*sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART)))*(((vn+1)*(d_vn_d_v_bici__)+(d_vn_d_v_bici__)*(vn+1)))))/(sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART))^2;
                d_vnl_d_v_bxbp__ = (2*d_vn_d_v_bxbp__)/(sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART))-((2*vn)*((1/(2*sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)))*(((vn-1)*(d_vn_d_v_bxbp__)+(d_vn_d_v_bxbp__)*(vn-1)))+(1/(2*sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART)))*(((vn+1)*(d_vn_d_v_bxbp__)+(d_vn_d_v_bxbp__)*(vn+1)))))/(sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART))^2;
            vnl = (2*vn)/(sqrt((vn-1)*(vn-1)+(4*parm_AJC)*parm_AJC)+sqrt((vn+1)*(vn+1)+(4*parm_ART)*parm_ART));
                d_vl_d_v_biei__ = 0;
                d_vl_d_v_bxei__ = 0;
                d_vl_d_v_bici__ = 0.5*(((d_vnl_d_v_bici__*(parm_VRT-dv0))));
                d_vl_d_v_bxbp__ = 0.5*(((d_vnl_d_v_bxbp__*(parm_VRT-dv0))));
            vl = 0.5*((vnl*(parm_VRT-dv0)-parm_VRT)-dv0);
                d_qlo_d_v_biei__ = (PCatT*(-d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_biei__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bxei__ = (PCatT*(-d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bxei__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bici__ = (PCatT*(-d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bici__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bxbp__ = (PCatT*(-d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bxbp__/PCatT))))/(1-parm_MC);
            qlo = (PCatT*(1-pow_vapp(1-vl/PCatT, 1-parm_MC)))/(1-parm_MC);
                d_sel_d_v_bici__ = 0.5*(d_vnl_d_v_bici__);
                d_sel_d_v_bxbp__ = 0.5*(d_vnl_d_v_bxbp__);
            sel = 0.5*(vnl+1);
            crt = pow_vapp(1+parm_VRT/PCatT, -parm_MC);
            cmx = pow_vapp(1+dv0/PCatT, -parm_MC);
                d_cl_d_v_bici__ = ((-d_sel_d_v_bici__)*crt)+(d_sel_d_v_bici__*cmx);
                d_cl_d_v_bxbp__ = ((-d_sel_d_v_bxbp__)*crt)+(d_sel_d_v_bxbp__*cmx);
            cl = (1-sel)*crt+sel*cmx;
                d_ql_d_v_biei__ = ((-d_vl_d_v_biei__))*cl;
                d_ql_d_v_bxei__ = ((-d_vl_d_v_bxei__))*cl;
                d_ql_d_v_bici__ = ((v_bxbp__-vl)+vl0)*d_cl_d_v_bici__+((-d_vl_d_v_bici__))*cl;
                d_ql_d_v_bxbp__ = ((v_bxbp__-vl)+vl0)*d_cl_d_v_bxbp__+((1-d_vl_d_v_bxbp__))*cl;
            ql = ((v_bxbp__-vl)+vl0)*cl;
                d_qdbep_d_v_biei__ = (d_ql_d_v_biei__+d_qlo_d_v_biei__);
                d_qdbep_d_v_bxei__ = (d_ql_d_v_bxei__+d_qlo_d_v_bxei__);
                d_qdbep_d_v_bici__ = (d_ql_d_v_bici__+d_qlo_d_v_bici__);
                d_qdbep_d_v_bxbp__ = (d_ql_d_v_bxbp__+d_qlo_d_v_bxbp__);
            qdbep = (ql+qlo)-qlo0;
        else
            mv0 = sqrt(dv0*dv0+(4*parm_AJC)*parm_AJC);
            vl0 = -0.5*(dv0+mv0);
            q0 = (-PCatT*pow_vapp(1-vl0/PCatT, 1-parm_MC))/(1-parm_MC);
                d_dv_d_v_biei__ = 0;
                d_dv_d_v_bxei__ = 0;
                d_dv_d_v_bici__ = 0;
                d_dv_d_v_bxbp__ = 1;
            dv = v_bxbp__+dv0;
                d_mv_d_v_biei__ = (1/(2*sqrt(dv*dv+(4*parm_AJC)*parm_AJC)))*((dv*d_dv_d_v_biei__+d_dv_d_v_biei__*dv));
                d_mv_d_v_bxei__ = (1/(2*sqrt(dv*dv+(4*parm_AJC)*parm_AJC)))*((dv*d_dv_d_v_bxei__+d_dv_d_v_bxei__*dv));
                d_mv_d_v_bici__ = (1/(2*sqrt(dv*dv+(4*parm_AJC)*parm_AJC)))*((dv*d_dv_d_v_bici__+d_dv_d_v_bici__*dv));
                d_mv_d_v_bxbp__ = (1/(2*sqrt(dv*dv+(4*parm_AJC)*parm_AJC)))*((dv*d_dv_d_v_bxbp__+d_dv_d_v_bxbp__*dv));
            mv = sqrt(dv*dv+(4*parm_AJC)*parm_AJC);
                d_vl_d_v_biei__ = (0.5*(d_dv_d_v_biei__-d_mv_d_v_biei__));
                d_vl_d_v_bxei__ = (0.5*(d_dv_d_v_bxei__-d_mv_d_v_bxei__));
                d_vl_d_v_bici__ = (0.5*(d_dv_d_v_bici__-d_mv_d_v_bici__));
                d_vl_d_v_bxbp__ = (0.5*(d_dv_d_v_bxbp__-d_mv_d_v_bxbp__));
            vl = 0.5*(dv-mv)-dv0;
                d_qlo_d_v_biei__ = (-PCatT*(d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_biei__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bxei__ = (-PCatT*(d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bxei__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bici__ = (-PCatT*(d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bici__/PCatT))))/(1-parm_MC);
                d_qlo_d_v_bxbp__ = (-PCatT*(d_pow_vapp_d_arg1__(1-vl/PCatT, 1-parm_MC)*(-(d_vl_d_v_bxbp__/PCatT))))/(1-parm_MC);
            qlo = (-PCatT*pow_vapp(1-vl/PCatT, 1-parm_MC))/(1-parm_MC);
                d_qdbep_d_v_biei__ = (d_qlo_d_v_biei__+(pow_vapp(1-parm_FC, -parm_MC)*((-d_vl_d_v_biei__))));
                d_qdbep_d_v_bxei__ = (d_qlo_d_v_bxei__+(pow_vapp(1-parm_FC, -parm_MC)*((-d_vl_d_v_bxei__))));
                d_qdbep_d_v_bici__ = (d_qlo_d_v_bici__+(pow_vapp(1-parm_FC, -parm_MC)*((-d_vl_d_v_bici__))));
                d_qdbep_d_v_bxbp__ = (d_qlo_d_v_bxbp__+(pow_vapp(1-parm_FC, -parm_MC)*((1-d_vl_d_v_bxbp__))));
            qdbep = (qlo+pow_vapp(1-parm_FC, -parm_MC)*((v_bxbp__-vl)+vl0))-q0;
        end
    end
        d_argi_d_v_biei__ = 1/(NFatT*Vtv);
        d_argi_d_v_bxei__ = 0;
        d_argi_d_v_bici__ = 0;
        d_argi_d_v_bxbp__ = 0;
    argi = v_biei__/(NFatT*Vtv);
        d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
        d_expi_d_v_bxei__ = 0;
        d_expi_d_v_bici__ = 0;
        d_expi_d_v_bxbp__ = 0;
    expi = limexp_vapp(argi);
        d_Ifi_d_v_biei__ = ISatT*(d_expi_d_v_biei__);
    Ifi = ISatT*(expi-1);
        d_argi_d_v_biei__ = 0;
        d_argi_d_v_bxei__ = 0;
        d_argi_d_v_bici__ = 1/(NRatT*Vtv);
        d_argi_d_v_bxbp__ = 0;
    argi = v_bici__/(NRatT*Vtv);
        d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
        d_expi_d_v_bxei__ = 0;
        d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
        d_expi_d_v_bxbp__ = 0;
    expi = limexp_vapp(argi);
        d_Iri_d_v_biei__ = (ISatT*ISRRatT)*(d_expi_d_v_biei__);
        d_Iri_d_v_bici__ = (ISatT*ISRRatT)*(d_expi_d_v_bici__);
    Iri = (ISatT*ISRRatT)*(expi-1);
        d_q1z_d_v_biei__ = ((d_qdbe_d_v_biei__*IVER))+(d_qdbc_d_v_biei__*IVEF);
        d_q1z_d_v_bxei__ = (d_qdbc_d_v_bxei__*IVEF);
        d_q1z_d_v_bici__ = (d_qdbc_d_v_bici__*IVEF);
    q1z = (1+qdbe*IVER)+qdbc*IVEF;
        d_q1_d_v_biei__ = (0.5*(((1/(2*sqrt((q1z-0.0001)*(q1z-0.0001)+1e-08)))*(((q1z-0.0001)*(d_q1z_d_v_biei__)+(d_q1z_d_v_biei__)*(q1z-0.0001)))+d_q1z_d_v_biei__)));
        d_q1_d_v_bxei__ = (0.5*(((1/(2*sqrt((q1z-0.0001)*(q1z-0.0001)+1e-08)))*(((q1z-0.0001)*(d_q1z_d_v_bxei__)+(d_q1z_d_v_bxei__)*(q1z-0.0001)))+d_q1z_d_v_bxei__)));
        d_q1_d_v_bici__ = (0.5*(((1/(2*sqrt((q1z-0.0001)*(q1z-0.0001)+1e-08)))*(((q1z-0.0001)*(d_q1z_d_v_bici__)+(d_q1z_d_v_bici__)*(q1z-0.0001)))+d_q1z_d_v_bici__)));
    q1 = 0.5*((sqrt((q1z-0.0001)*(q1z-0.0001)+1e-08)+q1z)-0.0001)+0.0001;
        d_q2_d_v_biei__ = (d_Ifi_d_v_biei__*IIKF)+(d_Iri_d_v_biei__*IIKR);
        d_q2_d_v_bici__ = (d_Iri_d_v_bici__*IIKR);
    q2 = Ifi*IIKF+Iri*IIKR;
    if parm_QBM<0.5
            d_qb_d_v_biei__ = 0.5*(d_q1_d_v_biei__+d_pow_vapp_d_arg1__(pow_vapp(q1, 1/parm_NKF)+4*q2, parm_NKF)*(d_pow_vapp_d_arg1__(q1, 1/parm_NKF)*d_q1_d_v_biei__+(4*d_q2_d_v_biei__)));
            d_qb_d_v_bxei__ = 0.5*(d_q1_d_v_bxei__+d_pow_vapp_d_arg1__(pow_vapp(q1, 1/parm_NKF)+4*q2, parm_NKF)*(d_pow_vapp_d_arg1__(q1, 1/parm_NKF)*d_q1_d_v_bxei__));
            d_qb_d_v_bici__ = 0.5*(d_q1_d_v_bici__+d_pow_vapp_d_arg1__(pow_vapp(q1, 1/parm_NKF)+4*q2, parm_NKF)*(d_pow_vapp_d_arg1__(q1, 1/parm_NKF)*d_q1_d_v_bici__+(4*d_q2_d_v_bici__)));
        qb = 0.5*(q1+pow_vapp(pow_vapp(q1, 1/parm_NKF)+4*q2, parm_NKF));
    else
            d_qb_d_v_biei__ = (0.5*q1)*(d_pow_vapp_d_arg1__(1+4*q2, parm_NKF)*((4*d_q2_d_v_biei__)))+(0.5*d_q1_d_v_biei__)*(1+pow_vapp(1+4*q2, parm_NKF));
            d_qb_d_v_bxei__ = (0.5*d_q1_d_v_bxei__)*(1+pow_vapp(1+4*q2, parm_NKF));
            d_qb_d_v_bici__ = (0.5*q1)*(d_pow_vapp_d_arg1__(1+4*q2, parm_NKF)*((4*d_q2_d_v_bici__)))+(0.5*d_q1_d_v_bici__)*(1+pow_vapp(1+4*q2, parm_NKF));
        qb = (0.5*q1)*(1+pow_vapp(1+4*q2, parm_NKF));
    end
        d_Itzr_d_v_biei__ = d_Iri_d_v_biei__/qb-(Iri*d_qb_d_v_biei__)/qb^2;
        d_Itzr_d_v_bxei__ = -(Iri*d_qb_d_v_bxei__)/qb^2;
        d_Itzr_d_v_bici__ = d_Iri_d_v_bici__/qb-(Iri*d_qb_d_v_bici__)/qb^2;
    Itzr = Iri/qb;
        d_Itzf_d_v_biei__ = d_Ifi_d_v_biei__/qb-(Ifi*d_qb_d_v_biei__)/qb^2;
        d_Itzf_d_v_bxei__ = -(Ifi*d_qb_d_v_bxei__)/qb^2;
        d_Itzf_d_v_bici__ = -(Ifi*d_qb_d_v_bici__)/qb^2;
    Itzf = Ifi/qb;
    if parm_ISP>0
            d_argi_d_v_biei__ = 0;
            d_argi_d_v_bxei__ = 0;
            d_argi_d_v_bici__ = 0;
            d_argi_d_v_bxbp__ = 1/(parm_NFP*Vtv);
        argi = v_bxbp__/(parm_NFP*Vtv);
            d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
            d_expi_d_v_bxei__ = 0;
            d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
            d_expi_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxbp__;
        expi = limexp_vapp(argi);
            d_argx_d_v_biei__ = 0;
            d_argx_d_v_bxei__ = 0;
            d_argx_d_v_bici__ = 1/(parm_NFP*Vtv);
            d_argx_d_v_bicx__ = 0;
        argx = v_bici__/(parm_NFP*Vtv);
            d_expx_d_v_biei__ = 0;
            d_expx_d_v_bxei__ = 0;
            d_expx_d_v_bici__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bici__;
            d_expx_d_v_bicx__ = 0;
        expx = limexp_vapp(argx);
            d_Ifp_d_v_biei__ = ISPatT*(((parm_WSP*d_expi_d_v_biei__)+((1-parm_WSP)*d_expx_d_v_biei__)));
            d_Ifp_d_v_bici__ = ISPatT*(((parm_WSP*d_expi_d_v_bici__)+((1-parm_WSP)*d_expx_d_v_bici__)));
            d_Ifp_d_v_bxbp__ = ISPatT*(((parm_WSP*d_expi_d_v_bxbp__)));
        Ifp = ISPatT*((parm_WSP*expi+(1-parm_WSP)*expx)-1);
            d_q2p_d_v_biei__ = d_Ifp_d_v_biei__*IIKP;
            d_q2p_d_v_bici__ = d_Ifp_d_v_bici__*IIKP;
            d_q2p_d_v_bxbp__ = d_Ifp_d_v_bxbp__*IIKP;
        q2p = Ifp*IIKP;
            d_qbp_d_v_biei__ = 0.5*((1/(2*sqrt(1+4*q2p)))*((4*d_q2p_d_v_biei__)));
            d_qbp_d_v_bici__ = 0.5*((1/(2*sqrt(1+4*q2p)))*((4*d_q2p_d_v_bici__)));
            d_qbp_d_v_bxbp__ = 0.5*((1/(2*sqrt(1+4*q2p)))*((4*d_q2p_d_v_bxbp__)));
        qbp = 0.5*(1+sqrt(1+4*q2p));
    else
            d_Ifp_d_v_biei__ = 0;
            d_Ifp_d_v_bici__ = 0;
            d_Ifp_d_v_bxbp__ = 0;
        Ifp = 0;
            d_qbp_d_v_biei__ = 0;
            d_qbp_d_v_bici__ = 0;
            d_qbp_d_v_bxbp__ = 0;
        qbp = 1;
    end
    if parm_WBE==1
            d_argi_d_v_biei__ = 1/(parm_NEI*Vtv);
            d_argi_d_v_bxei__ = 0;
            d_argi_d_v_bici__ = 0;
            d_argi_d_v_bxbp__ = 0;
        argi = v_biei__/(parm_NEI*Vtv);
            d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
            d_expi_d_v_bxei__ = 0;
            d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
            d_expi_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxbp__;
        expi = limexp_vapp(argi);
            d_argn_d_v_biei__ = 1/(parm_NEN*Vtv);
            d_argn_d_v_bxei__ = 0;
            d_argn_d_v_bici__ = 0;
            d_argn_d_v_bxbp__ = 0;
        argn = v_biei__/(parm_NEN*Vtv);
            d_expn_d_v_biei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_biei__;
            d_expn_d_v_bxei__ = 0;
            d_expn_d_v_bici__ = 0;
            d_expn_d_v_bxbp__ = 0;
        expn = limexp_vapp(argn);
        if parm_VBBE>0
                d_argx_d_v_biei__ = (-1)/(NBBEatT*Vtv);
                d_argx_d_v_bxei__ = 0;
                d_argx_d_v_bici__ = 0;
                d_argx_d_v_bicx__ = 0;
            argx = (-VBBEatT-v_biei__)/(NBBEatT*Vtv);
                d_expx_d_v_biei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_biei__;
                d_expx_d_v_bxei__ = 0;
                d_expx_d_v_bici__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bici__;
                d_expx_d_v_bicx__ = 0;
            expx = limexp_vapp(argx);
                d_Ibe_d_v_biei__ = ((IBEIatT*(d_expi_d_v_biei__))+(IBENatT*(d_expn_d_v_biei__)))-(parm_IBBE*(d_expx_d_v_biei__));
                d_Ibe_d_v_bxei__ = 0;
                d_Ibe_d_v_bici__ = ((IBEIatT*(d_expi_d_v_bici__))+(IBENatT*(d_expn_d_v_bici__)))-(parm_IBBE*(d_expx_d_v_bici__));
                d_Ibe_d_v_bxbp__ = ((IBEIatT*(d_expi_d_v_bxbp__))+(IBENatT*(d_expn_d_v_bxbp__)));
            Ibe = (IBEIatT*(expi-1)+IBENatT*(expn-1))-parm_IBBE*(expx-EBBEatT);
        else
                d_Ibe_d_v_biei__ = (IBEIatT*(d_expi_d_v_biei__))+(IBENatT*(d_expn_d_v_biei__));
                d_Ibe_d_v_bxei__ = 0;
                d_Ibe_d_v_bici__ = (IBEIatT*(d_expi_d_v_bici__))+(IBENatT*(d_expn_d_v_bici__));
                d_Ibe_d_v_bxbp__ = (IBEIatT*(d_expi_d_v_bxbp__))+(IBENatT*(d_expn_d_v_bxbp__));
            Ibe = IBEIatT*(expi-1)+IBENatT*(expn-1);
        end
            d_Ibex_d_v_biei__ = 0;
            d_Ibex_d_v_bxei__ = 0;
            d_Ibex_d_v_bici__ = 0;
            d_Ibex_d_v_bxbp__ = 0;
        Ibex = 0;
    else
        if parm_WBE==0
                d_Ibe_d_v_biei__ = 0;
                d_Ibe_d_v_bxei__ = 0;
                d_Ibe_d_v_bici__ = 0;
                d_Ibe_d_v_bxbp__ = 0;
            Ibe = 0;
                d_argi_d_v_biei__ = 0;
                d_argi_d_v_bxei__ = 1/(parm_NEI*Vtv);
                d_argi_d_v_bici__ = 0;
                d_argi_d_v_bxbp__ = 0;
            argi = v_bxei__/(parm_NEI*Vtv);
                d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
                d_expi_d_v_bxei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxei__;
                d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
                d_expi_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxbp__;
            expi = limexp_vapp(argi);
                d_argn_d_v_biei__ = 0;
                d_argn_d_v_bxei__ = 1/(parm_NEN*Vtv);
                d_argn_d_v_bici__ = 0;
                d_argn_d_v_bxbp__ = 0;
            argn = v_bxei__/(parm_NEN*Vtv);
                d_expn_d_v_biei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_biei__;
                d_expn_d_v_bxei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_bxei__;
                d_expn_d_v_bici__ = 0;
                d_expn_d_v_bxbp__ = 0;
            expn = limexp_vapp(argn);
            if parm_VBBE>0
                    d_argx_d_v_biei__ = 0;
                    d_argx_d_v_bxei__ = (-1)/(NBBEatT*Vtv);
                    d_argx_d_v_bici__ = 0;
                    d_argx_d_v_bicx__ = 0;
                argx = (-VBBEatT-v_bxei__)/(NBBEatT*Vtv);
                    d_expx_d_v_biei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_biei__;
                    d_expx_d_v_bxei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bxei__;
                    d_expx_d_v_bici__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bici__;
                    d_expx_d_v_bicx__ = 0;
                expx = limexp_vapp(argx);
                    d_Ibex_d_v_biei__ = ((IBEIatT*(d_expi_d_v_biei__))+(IBENatT*(d_expn_d_v_biei__)))-(parm_IBBE*(d_expx_d_v_biei__));
                    d_Ibex_d_v_bxei__ = ((IBEIatT*(d_expi_d_v_bxei__))+(IBENatT*(d_expn_d_v_bxei__)))-(parm_IBBE*(d_expx_d_v_bxei__));
                    d_Ibex_d_v_bici__ = ((IBEIatT*(d_expi_d_v_bici__))+(IBENatT*(d_expn_d_v_bici__)))-(parm_IBBE*(d_expx_d_v_bici__));
                    d_Ibex_d_v_bxbp__ = ((IBEIatT*(d_expi_d_v_bxbp__))+(IBENatT*(d_expn_d_v_bxbp__)));
                Ibex = (IBEIatT*(expi-1)+IBENatT*(expn-1))-parm_IBBE*(expx-EBBEatT);
            else
                    d_Ibex_d_v_biei__ = (IBEIatT*(d_expi_d_v_biei__))+(IBENatT*(d_expn_d_v_biei__));
                    d_Ibex_d_v_bxei__ = (IBEIatT*(d_expi_d_v_bxei__))+(IBENatT*(d_expn_d_v_bxei__));
                    d_Ibex_d_v_bici__ = (IBEIatT*(d_expi_d_v_bici__))+(IBENatT*(d_expn_d_v_bici__));
                    d_Ibex_d_v_bxbp__ = (IBEIatT*(d_expi_d_v_bxbp__))+(IBENatT*(d_expn_d_v_bxbp__));
                Ibex = IBEIatT*(expi-1)+IBENatT*(expn-1);
            end
        else
                d_argi_d_v_biei__ = 1/(parm_NEI*Vtv);
                d_argi_d_v_bxei__ = 0;
                d_argi_d_v_bici__ = 0;
                d_argi_d_v_bxbp__ = 0;
            argi = v_biei__/(parm_NEI*Vtv);
                d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
                d_expi_d_v_bxei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxei__;
                d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
                d_expi_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxbp__;
            expi = limexp_vapp(argi);
                d_argn_d_v_biei__ = 1/(parm_NEN*Vtv);
                d_argn_d_v_bxei__ = 0;
                d_argn_d_v_bici__ = 0;
                d_argn_d_v_bxbp__ = 0;
            argn = v_biei__/(parm_NEN*Vtv);
                d_expn_d_v_biei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_biei__;
                d_expn_d_v_bxei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_bxei__;
                d_expn_d_v_bici__ = 0;
                d_expn_d_v_bxbp__ = 0;
            expn = limexp_vapp(argn);
            if parm_VBBE>0
                    d_argx_d_v_biei__ = (-1)/(NBBEatT*Vtv);
                    d_argx_d_v_bxei__ = 0;
                    d_argx_d_v_bici__ = 0;
                    d_argx_d_v_bicx__ = 0;
                argx = (-VBBEatT-v_biei__)/(NBBEatT*Vtv);
                    d_expx_d_v_biei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_biei__;
                    d_expx_d_v_bxei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bxei__;
                    d_expx_d_v_bici__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bici__;
                    d_expx_d_v_bicx__ = 0;
                expx = limexp_vapp(argx);
                    d_Ibe_d_v_biei__ = parm_WBE*(((IBEIatT*(d_expi_d_v_biei__))+(IBENatT*(d_expn_d_v_biei__)))-(parm_IBBE*(d_expx_d_v_biei__)));
                    d_Ibe_d_v_bxei__ = parm_WBE*(((IBEIatT*(d_expi_d_v_bxei__))+(IBENatT*(d_expn_d_v_bxei__)))-(parm_IBBE*(d_expx_d_v_bxei__)));
                    d_Ibe_d_v_bici__ = parm_WBE*(((IBEIatT*(d_expi_d_v_bici__))+(IBENatT*(d_expn_d_v_bici__)))-(parm_IBBE*(d_expx_d_v_bici__)));
                    d_Ibe_d_v_bxbp__ = parm_WBE*(((IBEIatT*(d_expi_d_v_bxbp__))+(IBENatT*(d_expn_d_v_bxbp__))));
                Ibe = parm_WBE*((IBEIatT*(expi-1)+IBENatT*(expn-1))-parm_IBBE*(expx-EBBEatT));
            else
                    d_Ibe_d_v_biei__ = parm_WBE*((IBEIatT*(d_expi_d_v_biei__))+(IBENatT*(d_expn_d_v_biei__)));
                    d_Ibe_d_v_bxei__ = parm_WBE*((IBEIatT*(d_expi_d_v_bxei__))+(IBENatT*(d_expn_d_v_bxei__)));
                    d_Ibe_d_v_bici__ = parm_WBE*((IBEIatT*(d_expi_d_v_bici__))+(IBENatT*(d_expn_d_v_bici__)));
                    d_Ibe_d_v_bxbp__ = parm_WBE*((IBEIatT*(d_expi_d_v_bxbp__))+(IBENatT*(d_expn_d_v_bxbp__)));
                Ibe = parm_WBE*(IBEIatT*(expi-1)+IBENatT*(expn-1));
            end
                d_argi_d_v_biei__ = 0;
                d_argi_d_v_bxei__ = 1/(parm_NEI*Vtv);
                d_argi_d_v_bici__ = 0;
                d_argi_d_v_bxbp__ = 0;
            argi = v_bxei__/(parm_NEI*Vtv);
                d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
                d_expi_d_v_bxei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxei__;
                d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
                d_expi_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxbp__;
            expi = limexp_vapp(argi);
                d_argn_d_v_biei__ = 0;
                d_argn_d_v_bxei__ = 1/(parm_NEN*Vtv);
                d_argn_d_v_bici__ = 0;
                d_argn_d_v_bxbp__ = 0;
            argn = v_bxei__/(parm_NEN*Vtv);
                d_expn_d_v_biei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_biei__;
                d_expn_d_v_bxei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_bxei__;
                d_expn_d_v_bici__ = 0;
                d_expn_d_v_bxbp__ = 0;
            expn = limexp_vapp(argn);
            if parm_VBBE>0
                    d_argx_d_v_biei__ = 0;
                    d_argx_d_v_bxei__ = (-1)/(NBBEatT*Vtv);
                    d_argx_d_v_bici__ = 0;
                    d_argx_d_v_bicx__ = 0;
                argx = (-VBBEatT-v_bxei__)/(NBBEatT*Vtv);
                    d_expx_d_v_biei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_biei__;
                    d_expx_d_v_bxei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bxei__;
                    d_expx_d_v_bici__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bici__;
                    d_expx_d_v_bicx__ = 0;
                expx = limexp_vapp(argx);
                    d_Ibex_d_v_biei__ = (1-parm_WBE)*(((IBEIatT*(d_expi_d_v_biei__))+(IBENatT*(d_expn_d_v_biei__)))-(parm_IBBE*(d_expx_d_v_biei__)));
                    d_Ibex_d_v_bxei__ = (1-parm_WBE)*(((IBEIatT*(d_expi_d_v_bxei__))+(IBENatT*(d_expn_d_v_bxei__)))-(parm_IBBE*(d_expx_d_v_bxei__)));
                    d_Ibex_d_v_bici__ = (1-parm_WBE)*(((IBEIatT*(d_expi_d_v_bici__))+(IBENatT*(d_expn_d_v_bici__)))-(parm_IBBE*(d_expx_d_v_bici__)));
                    d_Ibex_d_v_bxbp__ = (1-parm_WBE)*(((IBEIatT*(d_expi_d_v_bxbp__))+(IBENatT*(d_expn_d_v_bxbp__))));
                Ibex = (1-parm_WBE)*((IBEIatT*(expi-1)+IBENatT*(expn-1))-parm_IBBE*(expx-EBBEatT));
            else
                    d_Ibex_d_v_biei__ = (1-parm_WBE)*((IBEIatT*(d_expi_d_v_biei__))+(IBENatT*(d_expn_d_v_biei__)));
                    d_Ibex_d_v_bxei__ = (1-parm_WBE)*((IBEIatT*(d_expi_d_v_bxei__))+(IBENatT*(d_expn_d_v_bxei__)));
                    d_Ibex_d_v_bici__ = (1-parm_WBE)*((IBEIatT*(d_expi_d_v_bici__))+(IBENatT*(d_expn_d_v_bici__)));
                    d_Ibex_d_v_bxbp__ = (1-parm_WBE)*((IBEIatT*(d_expi_d_v_bxbp__))+(IBENatT*(d_expn_d_v_bxbp__)));
                Ibex = (1-parm_WBE)*(IBEIatT*(expi-1)+IBENatT*(expn-1));
            end
        end
    end
        d_argi_d_v_biei__ = 0;
        d_argi_d_v_bxei__ = 0;
        d_argi_d_v_bici__ = 1/(parm_NCI*Vtv);
        d_argi_d_v_bxbp__ = 0;
    argi = v_bici__/(parm_NCI*Vtv);
        d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
        d_expi_d_v_bxei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxei__;
        d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
        d_expi_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxbp__;
    expi = limexp_vapp(argi);
        d_argn_d_v_biei__ = 0;
        d_argn_d_v_bxei__ = 0;
        d_argn_d_v_bici__ = 1/(parm_NCN*Vtv);
        d_argn_d_v_bxbp__ = 0;
    argn = v_bici__/(parm_NCN*Vtv);
        d_expn_d_v_biei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_biei__;
        d_expn_d_v_bxei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_bxei__;
        d_expn_d_v_bici__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_bici__;
        d_expn_d_v_bxbp__ = 0;
    expn = limexp_vapp(argn);
        d_Ibcj_d_v_biei__ = (IBCIatT*(d_expi_d_v_biei__))+(IBCNatT*(d_expn_d_v_biei__));
        d_Ibcj_d_v_bxei__ = (IBCIatT*(d_expi_d_v_bxei__))+(IBCNatT*(d_expn_d_v_bxei__));
        d_Ibcj_d_v_bici__ = (IBCIatT*(d_expi_d_v_bici__))+(IBCNatT*(d_expn_d_v_bici__));
        d_Ibcj_d_v_bxbp__ = (IBCIatT*(d_expi_d_v_bxbp__))+(IBCNatT*(d_expn_d_v_bxbp__));
    Ibcj = IBCIatT*(expi-1)+IBCNatT*(expn-1);
    if parm_IBEIP>0||parm_IBENP>0
            d_argi_d_v_biei__ = 0;
            d_argi_d_v_bxei__ = 0;
            d_argi_d_v_bici__ = 0;
            d_argi_d_v_bxbp__ = 1/(parm_NCI*Vtv);
        argi = v_bxbp__/(parm_NCI*Vtv);
            d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
            d_expi_d_v_bxei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxei__;
            d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
            d_expi_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxbp__;
        expi = limexp_vapp(argi);
            d_argn_d_v_biei__ = 0;
            d_argn_d_v_bxei__ = 0;
            d_argn_d_v_bici__ = 0;
            d_argn_d_v_bxbp__ = 1/(parm_NCN*Vtv);
        argn = v_bxbp__/(parm_NCN*Vtv);
            d_expn_d_v_biei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_biei__;
            d_expn_d_v_bxei__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_bxei__;
            d_expn_d_v_bici__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_bici__;
            d_expn_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argn)*d_argn_d_v_bxbp__;
        expn = limexp_vapp(argn);
            d_Ibep_d_v_biei__ = (IBEIPatT*(d_expi_d_v_biei__))+(IBENPatT*(d_expn_d_v_biei__));
            d_Ibep_d_v_bxei__ = (IBEIPatT*(d_expi_d_v_bxei__))+(IBENPatT*(d_expn_d_v_bxei__));
            d_Ibep_d_v_bici__ = (IBEIPatT*(d_expi_d_v_bici__))+(IBENPatT*(d_expn_d_v_bici__));
            d_Ibep_d_v_bxbp__ = (IBEIPatT*(d_expi_d_v_bxbp__))+(IBENPatT*(d_expn_d_v_bxbp__));
        Ibep = IBEIPatT*(expi-1)+IBENPatT*(expn-1);
    else
            d_Ibep_d_v_biei__ = 0;
            d_Ibep_d_v_bxei__ = 0;
            d_Ibep_d_v_bici__ = 0;
            d_Ibep_d_v_bxbp__ = 0;
        Ibep = 0;
    end
    if parm_AVC1>0
            d_vl_d_v_biei__ = 0;
            d_vl_d_v_bxei__ = 0;
            d_vl_d_v_bici__ = 0.5*((1/(2*sqrt((PCatT-v_bici__)*(PCatT-v_bici__)+0.01)))*(((PCatT-v_bici__)*(-1)+(-1)*(PCatT-v_bici__)))+(-1));
            d_vl_d_v_bxbp__ = 0;
        vl = 0.5*(sqrt((PCatT-v_bici__)*(PCatT-v_bici__)+0.01)+(PCatT-v_bici__));
            d_avalf_d_v_biei__ = (parm_AVC1*vl)*(d_limexp_vapp_d_arg1__(-AVC2atT*pow_vapp(vl, parm_MC-1))*(-AVC2atT*(d_pow_vapp_d_arg1__(vl, parm_MC-1)*d_vl_d_v_biei__)))+(parm_AVC1*d_vl_d_v_biei__)*limexp_vapp(-AVC2atT*pow_vapp(vl, parm_MC-1));
            d_avalf_d_v_bxei__ = (parm_AVC1*vl)*(d_limexp_vapp_d_arg1__(-AVC2atT*pow_vapp(vl, parm_MC-1))*(-AVC2atT*(d_pow_vapp_d_arg1__(vl, parm_MC-1)*d_vl_d_v_bxei__)))+(parm_AVC1*d_vl_d_v_bxei__)*limexp_vapp(-AVC2atT*pow_vapp(vl, parm_MC-1));
            d_avalf_d_v_bici__ = (parm_AVC1*vl)*(d_limexp_vapp_d_arg1__(-AVC2atT*pow_vapp(vl, parm_MC-1))*(-AVC2atT*(d_pow_vapp_d_arg1__(vl, parm_MC-1)*d_vl_d_v_bici__)))+(parm_AVC1*d_vl_d_v_bici__)*limexp_vapp(-AVC2atT*pow_vapp(vl, parm_MC-1));
            d_avalf_d_v_bxbp__ = (parm_AVC1*vl)*(d_limexp_vapp_d_arg1__(-AVC2atT*pow_vapp(vl, parm_MC-1))*(-AVC2atT*(d_pow_vapp_d_arg1__(vl, parm_MC-1)*d_vl_d_v_bxbp__)))+(parm_AVC1*d_vl_d_v_bxbp__)*limexp_vapp(-AVC2atT*pow_vapp(vl, parm_MC-1));
        avalf = (parm_AVC1*vl)*limexp_vapp(-AVC2atT*pow_vapp(vl, parm_MC-1));
            d_Igc_d_v_biei__ = ((Itzf-Itzr)-Ibcj)*d_avalf_d_v_biei__+((d_Itzf_d_v_biei__-d_Itzr_d_v_biei__)-d_Ibcj_d_v_biei__)*avalf;
            d_Igc_d_v_bxei__ = ((Itzf-Itzr)-Ibcj)*d_avalf_d_v_bxei__+((d_Itzf_d_v_bxei__-d_Itzr_d_v_bxei__)-d_Ibcj_d_v_bxei__)*avalf;
            d_Igc_d_v_bici__ = ((Itzf-Itzr)-Ibcj)*d_avalf_d_v_bici__+((d_Itzf_d_v_bici__-d_Itzr_d_v_bici__)-d_Ibcj_d_v_bici__)*avalf;
            d_Igc_d_v_bxbp__ = ((Itzf-Itzr)-Ibcj)*d_avalf_d_v_bxbp__+(-d_Ibcj_d_v_bxbp__)*avalf;
        Igc = ((Itzf-Itzr)-Ibcj)*avalf;
    else
            d_Igc_d_v_biei__ = 0;
            d_Igc_d_v_bxei__ = 0;
            d_Igc_d_v_bici__ = 0;
            d_Igc_d_v_bxbp__ = 0;
        Igc = 0;
    end
        d_Ibc_d_v_biei__ = d_Ibcj_d_v_biei__-d_Igc_d_v_biei__;
        d_Ibc_d_v_bxei__ = d_Ibcj_d_v_bxei__-d_Igc_d_v_bxei__;
        d_Ibc_d_v_bici__ = d_Ibcj_d_v_bici__-d_Igc_d_v_bici__;
        d_Ibc_d_v_bxbp__ = d_Ibcj_d_v_bxbp__-d_Igc_d_v_bxbp__;
    Ibc = Ibcj-Igc;
    if parm_RCX>0
            d_Ircx_d_v_ce__ = d_v_ccx_d_v_ce__/RCXatT;
            d_Ircx_d_v_biei__ = d_v_ccx_d_v_biei__/RCXatT;
            d_Ircx_d_v_bicx__ = d_v_ccx_d_v_bicx__/RCXatT;
            d_Ircx_d_v_eei__ = d_v_ccx_d_v_eei__/RCXatT;
        Ircx = v_ccx__/RCXatT;
    else
            d_Ircx_d_v_ce__ = 0;
            d_Ircx_d_v_biei__ = 0;
            d_Ircx_d_v_bicx__ = 0;
            d_Ircx_d_v_eei__ = 0;
        Ircx = 0;
    end
        d_argi_d_v_biei__ = 0;
        d_argi_d_v_bxei__ = 0;
        d_argi_d_v_bici__ = 1/Vtv;
        d_argi_d_v_bxbp__ = 0;
    argi = v_bici__/Vtv;
        d_expi_d_v_biei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_biei__;
        d_expi_d_v_bxei__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxei__;
        d_expi_d_v_bici__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bici__;
        d_expi_d_v_bxbp__ = d_limexp_vapp_d_arg1__(argi)*d_argi_d_v_bxbp__;
    expi = limexp_vapp(argi);
        d_argx_d_v_biei__ = 0;
        d_argx_d_v_bxei__ = 0;
        d_argx_d_v_bici__ = 0;
        d_argx_d_v_bicx__ = 1/Vtv;
    argx = v_bicx__/Vtv;
        d_expx_d_v_biei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_biei__;
        d_expx_d_v_bxei__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bxei__;
        d_expx_d_v_bici__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bici__;
        d_expx_d_v_bicx__ = d_limexp_vapp_d_arg1__(argx)*d_argx_d_v_bicx__;
    expx = limexp_vapp(argx);
        d_Kbci_d_v_biei__ = (1/(2*sqrt(1+GAMMatT*expi)))*((GAMMatT*d_expi_d_v_biei__));
        d_Kbci_d_v_bxei__ = (1/(2*sqrt(1+GAMMatT*expi)))*((GAMMatT*d_expi_d_v_bxei__));
        d_Kbci_d_v_bici__ = (1/(2*sqrt(1+GAMMatT*expi)))*((GAMMatT*d_expi_d_v_bici__));
        d_Kbci_d_v_bxbp__ = (1/(2*sqrt(1+GAMMatT*expi)))*((GAMMatT*d_expi_d_v_bxbp__));
    Kbci = sqrt(1+GAMMatT*expi);
        d_Kbcx_d_v_biei__ = (1/(2*sqrt(1+GAMMatT*expx)))*((GAMMatT*d_expx_d_v_biei__));
        d_Kbcx_d_v_bxei__ = (1/(2*sqrt(1+GAMMatT*expx)))*((GAMMatT*d_expx_d_v_bxei__));
        d_Kbcx_d_v_bici__ = (1/(2*sqrt(1+GAMMatT*expx)))*((GAMMatT*d_expx_d_v_bici__));
        d_Kbcx_d_v_bicx__ = (1/(2*sqrt(1+GAMMatT*expx)))*((GAMMatT*d_expx_d_v_bicx__));
    Kbcx = sqrt(1+GAMMatT*expx);
    if parm_RCI>0
            d_rKp1_d_v_biei__ = (d_Kbci_d_v_biei__)/(Kbcx+1)-((Kbci+1)*(d_Kbcx_d_v_biei__))/(Kbcx+1)^2;
            d_rKp1_d_v_bxei__ = (d_Kbci_d_v_bxei__)/(Kbcx+1)-((Kbci+1)*(d_Kbcx_d_v_bxei__))/(Kbcx+1)^2;
            d_rKp1_d_v_bici__ = (d_Kbci_d_v_bici__)/(Kbcx+1)-((Kbci+1)*(d_Kbcx_d_v_bici__))/(Kbcx+1)^2;
            d_rKp1_d_v_bicx__ = -((Kbci+1)*(d_Kbcx_d_v_bicx__))/(Kbcx+1)^2;
            d_rKp1_d_v_bxbp__ = (d_Kbci_d_v_bxbp__)/(Kbcx+1);
        rKp1 = (Kbci+1)/(Kbcx+1);
            d_Iohm_d_v_biei__ = ((Vtv*((d_Kbci_d_v_biei__-d_Kbcx_d_v_biei__)-(1/(rKp1*log(10)))*d_rKp1_d_v_biei__)))/RCIatT;
            d_Iohm_d_v_bxei__ = ((Vtv*((d_Kbci_d_v_bxei__-d_Kbcx_d_v_bxei__)-(1/(rKp1*log(10)))*d_rKp1_d_v_bxei__)))/RCIatT;
            d_Iohm_d_v_bici__ = (d_v_cxci_d_v_bici__+(Vtv*((d_Kbci_d_v_bici__-d_Kbcx_d_v_bici__)-(1/(rKp1*log(10)))*d_rKp1_d_v_bici__)))/RCIatT;
            d_Iohm_d_v_bicx__ = (d_v_cxci_d_v_bicx__+(Vtv*((-d_Kbcx_d_v_bicx__)-(1/(rKp1*log(10)))*d_rKp1_d_v_bicx__)))/RCIatT;
            d_Iohm_d_v_bxbp__ = ((Vtv*((d_Kbci_d_v_bxbp__)-(1/(rKp1*log(10)))*d_rKp1_d_v_bxbp__)))/RCIatT;
        Iohm = (v_cxci__+Vtv*((Kbci-Kbcx)-log10(rKp1)))/RCIatT;
            d_derf_d_v_biei__ = ((IVO*RCIatT)*d_Iohm_d_v_biei__)/(1+((0.5*IVO)*IHRCF)*sqrt(v_cxci__*v_cxci__+0.01));
            d_derf_d_v_bxei__ = ((IVO*RCIatT)*d_Iohm_d_v_bxei__)/(1+((0.5*IVO)*IHRCF)*sqrt(v_cxci__*v_cxci__+0.01));
            d_derf_d_v_bici__ = ((IVO*RCIatT)*d_Iohm_d_v_bici__)/(1+((0.5*IVO)*IHRCF)*sqrt(v_cxci__*v_cxci__+0.01))-(((IVO*RCIatT)*Iohm)*((((0.5*IVO)*IHRCF)*((1/(2*sqrt(v_cxci__*v_cxci__+0.01)))*((v_cxci__*d_v_cxci_d_v_bici__+d_v_cxci_d_v_bici__*v_cxci__))))))/(1+((0.5*IVO)*IHRCF)*sqrt(v_cxci__*v_cxci__+0.01))^2;
            d_derf_d_v_bicx__ = ((IVO*RCIatT)*d_Iohm_d_v_bicx__)/(1+((0.5*IVO)*IHRCF)*sqrt(v_cxci__*v_cxci__+0.01))-(((IVO*RCIatT)*Iohm)*((((0.5*IVO)*IHRCF)*((1/(2*sqrt(v_cxci__*v_cxci__+0.01)))*((v_cxci__*d_v_cxci_d_v_bicx__+d_v_cxci_d_v_bicx__*v_cxci__))))))/(1+((0.5*IVO)*IHRCF)*sqrt(v_cxci__*v_cxci__+0.01))^2;
            d_derf_d_v_bxbp__ = ((IVO*RCIatT)*d_Iohm_d_v_bxbp__)/(1+((0.5*IVO)*IHRCF)*sqrt(v_cxci__*v_cxci__+0.01));
        derf = ((IVO*RCIatT)*Iohm)/(1+((0.5*IVO)*IHRCF)*sqrt(v_cxci__*v_cxci__+0.01));
            d_Irci_d_v_biei__ = d_Iohm_d_v_biei__/sqrt(1+derf*derf)-(Iohm*((1/(2*sqrt(1+derf*derf)))*((derf*d_derf_d_v_biei__+d_derf_d_v_biei__*derf))))/sqrt(1+derf*derf)^2;
            d_Irci_d_v_bxei__ = d_Iohm_d_v_bxei__/sqrt(1+derf*derf)-(Iohm*((1/(2*sqrt(1+derf*derf)))*((derf*d_derf_d_v_bxei__+d_derf_d_v_bxei__*derf))))/sqrt(1+derf*derf)^2;
            d_Irci_d_v_bici__ = d_Iohm_d_v_bici__/sqrt(1+derf*derf)-(Iohm*((1/(2*sqrt(1+derf*derf)))*((derf*d_derf_d_v_bici__+d_derf_d_v_bici__*derf))))/sqrt(1+derf*derf)^2;
            d_Irci_d_v_bicx__ = d_Iohm_d_v_bicx__/sqrt(1+derf*derf)-(Iohm*((1/(2*sqrt(1+derf*derf)))*((derf*d_derf_d_v_bicx__+d_derf_d_v_bicx__*derf))))/sqrt(1+derf*derf)^2;
            d_Irci_d_v_bxbp__ = d_Iohm_d_v_bxbp__/sqrt(1+derf*derf)-(Iohm*((1/(2*sqrt(1+derf*derf)))*((derf*d_derf_d_v_bxbp__+d_derf_d_v_bxbp__*derf))))/sqrt(1+derf*derf)^2;
        Irci = Iohm/sqrt(1+derf*derf);
    else
            d_Irci_d_v_biei__ = 0;
            d_Irci_d_v_bxei__ = 0;
            d_Irci_d_v_bici__ = 0;
            d_Irci_d_v_bicx__ = 0;
            d_Irci_d_v_bxbp__ = 0;
        Irci = 0;
    end
    if parm_RBX>0
            d_Irbx_d_v_be__ = d_v_bbx_d_v_be__/RBXatT;
            d_Irbx_d_v_bxei__ = d_v_bbx_d_v_bxei__/RBXatT;
            d_Irbx_d_v_eei__ = d_v_bbx_d_v_eei__/RBXatT;
        Irbx = v_bbx__/RBXatT;
    else
            d_Irbx_d_v_be__ = 0;
            d_Irbx_d_v_bxei__ = 0;
            d_Irbx_d_v_eei__ = 0;
        Irbx = 0;
    end
    if parm_RBI>0
            d_Irbi_d_v_biei__ = (v_bxbi__*d_qb_d_v_biei__+d_v_bxbi_d_v_biei__*qb)/RBIatT;
            d_Irbi_d_v_bxei__ = (v_bxbi__*d_qb_d_v_bxei__+d_v_bxbi_d_v_bxei__*qb)/RBIatT;
            d_Irbi_d_v_bici__ = (v_bxbi__*d_qb_d_v_bici__)/RBIatT;
        Irbi = (v_bxbi__*qb)/RBIatT;
    else
            d_Irbi_d_v_biei__ = 0;
            d_Irbi_d_v_bxei__ = 0;
            d_Irbi_d_v_bici__ = 0;
        Irbi = 0;
    end
    if parm_RE>0
            d_Ire_d_v_eei__ = 1/REatT;
        Ire = v_eei__/REatT;
    else
            d_Ire_d_v_eei__ = 0;
        Ire = 0;
    end
    if parm_RBP>0
            d_Irbp_d_v_biei__ = (v_bpcx__*d_qbp_d_v_biei__+d_v_bpcx_d_v_biei__*qbp)/RBPatT;
            d_Irbp_d_v_bxei__ = (d_v_bpcx_d_v_bxei__*qbp)/RBPatT;
            d_Irbp_d_v_bici__ = (v_bpcx__*d_qbp_d_v_bici__)/RBPatT;
            d_Irbp_d_v_bicx__ = (d_v_bpcx_d_v_bicx__*qbp)/RBPatT;
            d_Irbp_d_v_bxbp__ = (v_bpcx__*d_qbp_d_v_bxbp__+d_v_bpcx_d_v_bxbp__*qbp)/RBPatT;
        Irbp = (v_bpcx__*qbp)/RBPatT;
    else
            d_Irbp_d_v_biei__ = 0;
            d_Irbp_d_v_bxei__ = 0;
            d_Irbp_d_v_bici__ = 0;
            d_Irbp_d_v_bicx__ = 0;
            d_Irbp_d_v_bxbp__ = 0;
        Irbp = 0;
    end
        d_sgIf_d_v_biei__ = qmcol_vapp(Ifi>0, 0, 0);
    sgIf = qmcol_vapp(Ifi>0, 1, 0);
        d_rIf_d_v_biei__ = (Ifi*d_sgIf_d_v_biei__+d_Ifi_d_v_biei__*sgIf)*IITF;
    rIf = (Ifi*sgIf)*IITF;
        d_mIf_d_v_biei__ = d_rIf_d_v_biei__/(rIf+1)-(rIf*(d_rIf_d_v_biei__))/(rIf+1)^2;
    mIf = rIf/(rIf+1);
        d_tff_d_v_biei__ = (parm_TF*(1+parm_QTF*q1))*((((parm_XTF*limexp_vapp((v_bici__*IVTF)/1.44))*(slTF+mIf*mIf))*d_sgIf_d_v_biei__+((parm_XTF*limexp_vapp((v_bici__*IVTF)/1.44))*((mIf*d_mIf_d_v_biei__+d_mIf_d_v_biei__*mIf)))*sgIf))+(parm_TF*((parm_QTF*d_q1_d_v_biei__)))*(1+((parm_XTF*limexp_vapp((v_bici__*IVTF)/1.44))*(slTF+mIf*mIf))*sgIf);
        d_tff_d_v_bxei__ = (parm_TF*((parm_QTF*d_q1_d_v_bxei__)))*(1+((parm_XTF*limexp_vapp((v_bici__*IVTF)/1.44))*(slTF+mIf*mIf))*sgIf);
        d_tff_d_v_bici__ = (parm_TF*(1+parm_QTF*q1))*((((parm_XTF*(d_limexp_vapp_d_arg1__((v_bici__*IVTF)/1.44)*((1*IVTF)/1.44)))*(slTF+mIf*mIf))*sgIf))+(parm_TF*((parm_QTF*d_q1_d_v_bici__)))*(1+((parm_XTF*limexp_vapp((v_bici__*IVTF)/1.44))*(slTF+mIf*mIf))*sgIf);
    tff = (parm_TF*(1+parm_QTF*q1))*(1+((parm_XTF*limexp_vapp((v_bici__*IVTF)/1.44))*(slTF+mIf*mIf))*sgIf);
        d_Qbe_d_v_biei__ = ((CJEatT*d_qdbe_d_v_biei__)*parm_WBE)+((tff*d_Ifi_d_v_biei__+d_tff_d_v_biei__*Ifi)/qb-((tff*Ifi)*d_qb_d_v_biei__)/qb^2);
        d_Qbe_d_v_bxei__ = ((d_tff_d_v_bxei__*Ifi)/qb-((tff*Ifi)*d_qb_d_v_bxei__)/qb^2);
        d_Qbe_d_v_bici__ = ((d_tff_d_v_bici__*Ifi)/qb-((tff*Ifi)*d_qb_d_v_bici__)/qb^2);
    Qbe = (CJEatT*qdbe)*parm_WBE+(tff*Ifi)/qb;
        d_Qbex_d_v_biei__ = (CJEatT*d_qdbex_d_v_biei__)*(1-parm_WBE);
        d_Qbex_d_v_bxei__ = (CJEatT*d_qdbex_d_v_bxei__)*(1-parm_WBE);
    Qbex = (CJEatT*qdbex)*(1-parm_WBE);
        d_Qbc_d_v_biei__ = ((CJCatT*d_qdbc_d_v_biei__)+(parm_TR*d_Iri_d_v_biei__))+(parm_QCO*d_Kbci_d_v_biei__);
        d_Qbc_d_v_bxei__ = ((CJCatT*d_qdbc_d_v_bxei__))+(parm_QCO*d_Kbci_d_v_bxei__);
        d_Qbc_d_v_bici__ = ((CJCatT*d_qdbc_d_v_bici__)+(parm_TR*d_Iri_d_v_bici__))+(parm_QCO*d_Kbci_d_v_bici__);
        d_Qbc_d_v_bxbp__ = (parm_QCO*d_Kbci_d_v_bxbp__);
    Qbc = (CJCatT*qdbc+parm_TR*Iri)+parm_QCO*Kbci;
        d_Qbcx_d_v_biei__ = parm_QCO*d_Kbcx_d_v_biei__;
        d_Qbcx_d_v_bxei__ = parm_QCO*d_Kbcx_d_v_bxei__;
        d_Qbcx_d_v_bici__ = parm_QCO*d_Kbcx_d_v_bici__;
        d_Qbcx_d_v_bicx__ = parm_QCO*d_Kbcx_d_v_bicx__;
    Qbcx = parm_QCO*Kbcx;
        d_Qbep_d_v_biei__ = (CJEPatT*d_qdbep_d_v_biei__)+(parm_TR*d_Ifp_d_v_biei__);
        d_Qbep_d_v_bxei__ = (CJEPatT*d_qdbep_d_v_bxei__);
        d_Qbep_d_v_bici__ = (CJEPatT*d_qdbep_d_v_bici__)+(parm_TR*d_Ifp_d_v_bici__);
        d_Qbep_d_v_bxbp__ = (CJEPatT*d_qdbep_d_v_bxbp__)+(parm_TR*d_Ifp_d_v_bxbp__);
    Qbep = CJEPatT*qdbep+parm_TR*Ifp;
        d_Qbeo_d_v_be__ = 1*parm_CBEO;
    Qbeo = v_be__*parm_CBEO;
        d_Qbco_d_v_ce__ = d_v_bc_d_v_ce__*parm_CBCO;
        d_Qbco_d_v_be__ = d_v_bc_d_v_be__*parm_CBCO;
    Qbco = v_bc__*parm_CBCO;
        d_f_i_biei_d_v_biei__ = d_f_i_biei_d_v_biei__+d_Ibe_d_v_biei__;
        d_f_i_biei_d_v_bxei__ = d_f_i_biei_d_v_bxei__+d_Ibe_d_v_bxei__;
        d_f_i_biei_d_v_bici__ = d_f_i_biei_d_v_bici__+d_Ibe_d_v_bici__;
        d_f_i_biei_d_v_bxbp__ = d_f_i_biei_d_v_bxbp__+d_Ibe_d_v_bxbp__;
    % contribution for i_biei;
    f_i_biei__ = f_i_biei__ + Ibe;
        d_f_i_bxei_d_v_biei__ = d_f_i_bxei_d_v_biei__+d_Ibex_d_v_biei__;
        d_f_i_bxei_d_v_bxei__ = d_f_i_bxei_d_v_bxei__+d_Ibex_d_v_bxei__;
        d_f_i_bxei_d_v_bici__ = d_f_i_bxei_d_v_bici__+d_Ibex_d_v_bici__;
        d_f_i_bxei_d_v_bxbp__ = d_f_i_bxei_d_v_bxbp__+d_Ibex_d_v_bxbp__;
    % contribution for i_bxei;
    f_i_bxei__ = f_i_bxei__ + Ibex;
        d_f_i_ciei_d_v_biei__ = d_f_i_ciei_d_v_biei__+d_Itzf_d_v_biei__;
        d_f_i_ciei_d_v_bxei__ = d_f_i_ciei_d_v_bxei__+d_Itzf_d_v_bxei__;
        d_f_i_ciei_d_v_bici__ = d_f_i_ciei_d_v_bici__+d_Itzf_d_v_bici__;
    % contribution for i_ciei;
    f_i_ciei__ = f_i_ciei__ + Itzf;
        d_f_i_ciei_d_v_biei__ = d_f_i_ciei_d_v_biei__-d_Itzr_d_v_biei__;
        d_f_i_ciei_d_v_bxei__ = d_f_i_ciei_d_v_bxei__-d_Itzr_d_v_bxei__;
        d_f_i_ciei_d_v_bici__ = d_f_i_ciei_d_v_bici__-d_Itzr_d_v_bici__;
    % contribution for i_ciei;
    f_i_ciei__ = f_i_ciei__ - (Itzr);
        d_f_i_bici_d_v_biei__ = d_f_i_bici_d_v_biei__+d_Ibc_d_v_biei__;
        d_f_i_bici_d_v_bxei__ = d_f_i_bici_d_v_bxei__+d_Ibc_d_v_bxei__;
        d_f_i_bici_d_v_bici__ = d_f_i_bici_d_v_bici__+d_Ibc_d_v_bici__;
        d_f_i_bici_d_v_bxbp__ = d_f_i_bici_d_v_bxbp__+d_Ibc_d_v_bxbp__;
    % contribution for i_bici;
    f_i_bici__ = f_i_bici__ + Ibc;
        d_f_i_bxbp_d_v_biei__ = d_f_i_bxbp_d_v_biei__+d_Ibep_d_v_biei__;
        d_f_i_bxbp_d_v_bxei__ = d_f_i_bxbp_d_v_bxei__+d_Ibep_d_v_bxei__;
        d_f_i_bxbp_d_v_bici__ = d_f_i_bxbp_d_v_bici__+d_Ibep_d_v_bici__;
        d_f_i_bxbp_d_v_bxbp__ = d_f_i_bxbp_d_v_bxbp__+d_Ibep_d_v_bxbp__;
    % contribution for i_bxbp;
    f_i_bxbp__ = f_i_bxbp__ + Ibep;
        d_f_i_ccx_d_v_ce__ = d_f_i_ccx_d_v_ce__+d_Ircx_d_v_ce__;
        d_f_i_ccx_d_v_biei__ = d_f_i_ccx_d_v_biei__+d_Ircx_d_v_biei__;
        d_f_i_ccx_d_v_bicx__ = d_f_i_ccx_d_v_bicx__+d_Ircx_d_v_bicx__;
        d_f_i_ccx_d_v_eei__ = d_f_i_ccx_d_v_eei__+d_Ircx_d_v_eei__;
    % contribution for i_ccx;
    f_i_ccx__ = f_i_ccx__ + Ircx;
        d_f_i_cxci_d_v_biei__ = d_f_i_cxci_d_v_biei__+d_Irci_d_v_biei__;
        d_f_i_cxci_d_v_bxei__ = d_f_i_cxci_d_v_bxei__+d_Irci_d_v_bxei__;
        d_f_i_cxci_d_v_bici__ = d_f_i_cxci_d_v_bici__+d_Irci_d_v_bici__;
        d_f_i_cxci_d_v_bicx__ = d_f_i_cxci_d_v_bicx__+d_Irci_d_v_bicx__;
        d_f_i_cxci_d_v_bxbp__ = d_f_i_cxci_d_v_bxbp__+d_Irci_d_v_bxbp__;
    % contribution for i_cxci;
    f_i_cxci__ = f_i_cxci__ + Irci;
        d_f_i_bbx_d_v_be__ = d_f_i_bbx_d_v_be__+d_Irbx_d_v_be__;
        d_f_i_bbx_d_v_bxei__ = d_f_i_bbx_d_v_bxei__+d_Irbx_d_v_bxei__;
        d_f_i_bbx_d_v_eei__ = d_f_i_bbx_d_v_eei__+d_Irbx_d_v_eei__;
    % contribution for i_bbx;
    f_i_bbx__ = f_i_bbx__ + Irbx;
        d_f_i_bxbi_d_v_biei__ = d_f_i_bxbi_d_v_biei__+d_Irbi_d_v_biei__;
        d_f_i_bxbi_d_v_bxei__ = d_f_i_bxbi_d_v_bxei__+d_Irbi_d_v_bxei__;
        d_f_i_bxbi_d_v_bici__ = d_f_i_bxbi_d_v_bici__+d_Irbi_d_v_bici__;
    % contribution for i_bxbi;
    f_i_bxbi__ = f_i_bxbi__ + Irbi;
        d_f_i_eei_d_v_eei__ = d_f_i_eei_d_v_eei__+d_Ire_d_v_eei__;
    % contribution for i_eei;
    f_i_eei__ = f_i_eei__ + Ire;
        d_f_i_bpcx_d_v_biei__ = d_f_i_bpcx_d_v_biei__+d_Irbp_d_v_biei__;
        d_f_i_bpcx_d_v_bxei__ = d_f_i_bpcx_d_v_bxei__+d_Irbp_d_v_bxei__;
        d_f_i_bpcx_d_v_bici__ = d_f_i_bpcx_d_v_bici__+d_Irbp_d_v_bici__;
        d_f_i_bpcx_d_v_bicx__ = d_f_i_bpcx_d_v_bicx__+d_Irbp_d_v_bicx__;
        d_f_i_bpcx_d_v_bxbp__ = d_f_i_bpcx_d_v_bxbp__+d_Irbp_d_v_bxbp__;
    % contribution for i_bpcx;
    f_i_bpcx__ = f_i_bpcx__ + Irbp;
        d_q_i_biei_d_v_biei__ = d_q_i_biei_d_v_biei__+d_Qbe_d_v_biei__;
        d_q_i_biei_d_v_bxei__ = d_q_i_biei_d_v_bxei__+d_Qbe_d_v_bxei__;
        d_q_i_biei_d_v_bici__ = d_q_i_biei_d_v_bici__+d_Qbe_d_v_bici__;
        d_q_i_biei_d_v_bxbp__ = d_q_i_biei_d_v_bxbp__;
    % contribution for i_biei;
    q_i_biei__ = q_i_biei__ + Qbe;
        d_q_i_bxei_d_v_biei__ = d_q_i_bxei_d_v_biei__+d_Qbex_d_v_biei__;
        d_q_i_bxei_d_v_bxei__ = d_q_i_bxei_d_v_bxei__+d_Qbex_d_v_bxei__;
        d_q_i_bxei_d_v_bici__ = d_q_i_bxei_d_v_bici__;
        d_q_i_bxei_d_v_bxbp__ = d_q_i_bxei_d_v_bxbp__;
    % contribution for i_bxei;
    q_i_bxei__ = q_i_bxei__ + Qbex;
        d_q_i_bici_d_v_biei__ = d_q_i_bici_d_v_biei__+d_Qbc_d_v_biei__;
        d_q_i_bici_d_v_bxei__ = d_q_i_bici_d_v_bxei__+d_Qbc_d_v_bxei__;
        d_q_i_bici_d_v_bici__ = d_q_i_bici_d_v_bici__+d_Qbc_d_v_bici__;
        d_q_i_bici_d_v_bxbp__ = d_q_i_bici_d_v_bxbp__+d_Qbc_d_v_bxbp__;
    % contribution for i_bici;
    q_i_bici__ = q_i_bici__ + Qbc;
        d_q_i_bicx_d_v_biei__ = d_q_i_bicx_d_v_biei__+d_Qbcx_d_v_biei__;
        d_q_i_bicx_d_v_bxei__ = d_q_i_bicx_d_v_bxei__+d_Qbcx_d_v_bxei__;
        d_q_i_bicx_d_v_bici__ = d_q_i_bicx_d_v_bici__+d_Qbcx_d_v_bici__;
        d_q_i_bicx_d_v_bicx__ = d_q_i_bicx_d_v_bicx__+d_Qbcx_d_v_bicx__;
    % contribution for i_bicx;
    q_i_bicx__ = q_i_bicx__ + Qbcx;
        d_q_i_bxbp_d_v_biei__ = d_q_i_bxbp_d_v_biei__+d_Qbep_d_v_biei__;
        d_q_i_bxbp_d_v_bxei__ = d_q_i_bxbp_d_v_bxei__+d_Qbep_d_v_bxei__;
        d_q_i_bxbp_d_v_bici__ = d_q_i_bxbp_d_v_bici__+d_Qbep_d_v_bici__;
        d_q_i_bxbp_d_v_bxbp__ = d_q_i_bxbp_d_v_bxbp__+d_Qbep_d_v_bxbp__;
    % contribution for i_bxbp;
    q_i_bxbp__ = q_i_bxbp__ + Qbep;
        d_q_i_be_d_v_be__ = d_q_i_be_d_v_be__+d_Qbeo_d_v_be__;
    % contribution for i_be;
    q_i_be__ = q_i_be__ + Qbeo;
        d_q_i_bc_d_v_ce__ = d_q_i_bc_d_v_ce__+d_Qbco_d_v_ce__;
        d_q_i_bc_d_v_be__ = d_q_i_bc_d_v_be__+d_Qbco_d_v_be__;
    % contribution for i_bc;
    q_i_bc__ = q_i_bc__ + Qbco;
        d_fe_d_X__(1,1) = -d_f_i_bc_d_v_ce__+d_f_i_ccx_d_v_ce__;
        d_qe_d_X__(1,1) = -d_q_i_bc_d_v_ce__+d_q_i_ccx_d_v_ce__;
        d_fe_d_X__(1,2) = -d_f_i_bc_d_v_be__;
        d_qe_d_X__(1,2) = -d_q_i_bc_d_v_be__;
        d_fe_d_Y__(1,1) = d_f_i_ccx_d_v_biei__;
        d_qe_d_Y__(1,1) = d_q_i_ccx_d_v_biei__;
        d_fe_d_Y__(1,4) = d_f_i_ccx_d_v_bicx__;
        d_qe_d_Y__(1,4) = d_q_i_ccx_d_v_bicx__;
        d_fe_d_Y__(1,6) = d_f_i_ccx_d_v_eei__;
        d_qe_d_Y__(1,6) = d_q_i_ccx_d_v_eei__;
    % output for terminalFlow_c (explicit out)
    fe__(1) = -f_i_bc__+f_i_ccx__;
    qe__(1) = -q_i_bc__+q_i_ccx__;
        d_fe_d_X__(2,1) = (d_f_i_bc_d_v_ce__);
        d_qe_d_X__(2,1) = (d_q_i_bc_d_v_ce__);
        d_fe_d_X__(2,2) = (d_f_i_bc_d_v_be__+d_f_i_bbx_d_v_be__)--d_f_i_be_d_v_be__;
        d_qe_d_X__(2,2) = (d_q_i_bc_d_v_be__+d_q_i_bbx_d_v_be__)--d_q_i_be_d_v_be__;
        d_fe_d_Y__(2,2) = (d_f_i_bbx_d_v_bxei__);
        d_qe_d_Y__(2,2) = (d_q_i_bbx_d_v_bxei__);
        d_fe_d_Y__(2,6) = (d_f_i_bbx_d_v_eei__);
        d_qe_d_Y__(2,6) = (d_q_i_bbx_d_v_eei__);
    % output for terminalFlow_b (explicit out)
    fe__(2) = +f_i_bc__+f_i_bbx__ + f_i_be__;
    qe__(2) = +q_i_bc__+q_i_bbx__ + q_i_be__;
        d_fi_d_X__(1,1) = (((d_f_i_ccx_d_v_ce__)));
        d_qi_d_X__(1,1) = (((d_q_i_ccx_d_v_ce__)));
        d_fi_d_Y__(1,1) = (((-d_f_i_ciei_d_v_biei__+d_f_i_ccx_d_v_biei__)+d_f_i_bxbi_d_v_biei__)+d_f_i_bpcx_d_v_biei__)-d_f_i_biei_d_v_biei__;
        d_qi_d_Y__(1,1) = (((-d_q_i_ciei_d_v_biei__+d_q_i_ccx_d_v_biei__)+d_q_i_bxbi_d_v_biei__)+d_q_i_bpcx_d_v_biei__)-d_q_i_biei_d_v_biei__;
        d_fi_d_Y__(1,2) = (((-d_f_i_ciei_d_v_bxei__)+d_f_i_bxbi_d_v_bxei__)+d_f_i_bpcx_d_v_bxei__)-d_f_i_biei_d_v_bxei__;
        d_qi_d_Y__(1,2) = (((-d_q_i_ciei_d_v_bxei__)+d_q_i_bxbi_d_v_bxei__)+d_q_i_bpcx_d_v_bxei__)-d_q_i_biei_d_v_bxei__;
        d_fi_d_Y__(1,3) = (((-d_f_i_ciei_d_v_bici__)+d_f_i_bxbi_d_v_bici__)+d_f_i_bpcx_d_v_bici__)-d_f_i_biei_d_v_bici__;
        d_qi_d_Y__(1,3) = (((-d_q_i_ciei_d_v_bici__)+d_q_i_bxbi_d_v_bici__)+d_q_i_bpcx_d_v_bici__)-d_q_i_biei_d_v_bici__;
        d_fi_d_Y__(1,4) = (((d_f_i_ccx_d_v_bicx__))+d_f_i_bpcx_d_v_bicx__);
        d_qi_d_Y__(1,4) = (((d_q_i_ccx_d_v_bicx__))+d_q_i_bpcx_d_v_bicx__);
        d_fi_d_Y__(1,5) = (d_f_i_bpcx_d_v_bxbp__)-d_f_i_biei_d_v_bxbp__;
        d_qi_d_Y__(1,5) = (d_q_i_bpcx_d_v_bxbp__)-d_q_i_biei_d_v_bxbp__;
        d_fi_d_Y__(1,6) = (((d_f_i_ccx_d_v_eei__)));
        d_qi_d_Y__(1,6) = (((d_q_i_ccx_d_v_eei__)));
    % output for v_biei (internal unknown)
    fi__(1) = -f_i_ciei__+f_i_ccx__+f_i_bxbi__+f_i_bpcx__ - f_i_biei__;
    qi__(1) = -q_i_ciei__+q_i_ccx__+q_i_bxbi__+q_i_bpcx__ - q_i_biei__;
        d_fi_d_X__(2,2) = ((d_f_i_bbx_d_v_be__));
        d_qi_d_X__(2,2) = ((d_q_i_bbx_d_v_be__));
        d_fi_d_Y__(2,1) = ((-d_f_i_bxbi_d_v_biei__)-d_f_i_bpcx_d_v_biei__)-d_f_i_bxei_d_v_biei__;
        d_qi_d_Y__(2,1) = ((-d_q_i_bxbi_d_v_biei__)-d_q_i_bpcx_d_v_biei__)-d_q_i_bxei_d_v_biei__;
        d_fi_d_Y__(2,2) = ((d_f_i_bbx_d_v_bxei__-d_f_i_bxbi_d_v_bxei__)-d_f_i_bpcx_d_v_bxei__)-d_f_i_bxei_d_v_bxei__;
        d_qi_d_Y__(2,2) = ((d_q_i_bbx_d_v_bxei__-d_q_i_bxbi_d_v_bxei__)-d_q_i_bpcx_d_v_bxei__)-d_q_i_bxei_d_v_bxei__;
        d_fi_d_Y__(2,3) = ((-d_f_i_bxbi_d_v_bici__)-d_f_i_bpcx_d_v_bici__)-d_f_i_bxei_d_v_bici__;
        d_qi_d_Y__(2,3) = ((-d_q_i_bxbi_d_v_bici__)-d_q_i_bpcx_d_v_bici__)-d_q_i_bxei_d_v_bici__;
        d_fi_d_Y__(2,4) = (-d_f_i_bpcx_d_v_bicx__);
        d_qi_d_Y__(2,4) = (-d_q_i_bpcx_d_v_bicx__);
        d_fi_d_Y__(2,5) = (-d_f_i_bpcx_d_v_bxbp__)-d_f_i_bxei_d_v_bxbp__;
        d_qi_d_Y__(2,5) = (-d_q_i_bpcx_d_v_bxbp__)-d_q_i_bxei_d_v_bxbp__;
        d_fi_d_Y__(2,6) = ((d_f_i_bbx_d_v_eei__));
        d_qi_d_Y__(2,6) = ((d_q_i_bbx_d_v_eei__));
    % output for v_bxei (internal unknown)
    fi__(2) = +f_i_bbx__-f_i_bxbi__-f_i_bpcx__ - f_i_bxei__;
    qi__(2) = +q_i_bbx__-q_i_bxbi__-q_i_bpcx__ - q_i_bxei__;
        d_fi_d_Y__(3,1) = (d_f_i_ciei_d_v_biei__-d_f_i_cxci_d_v_biei__)-d_f_i_bici_d_v_biei__;
        d_qi_d_Y__(3,1) = (d_q_i_ciei_d_v_biei__-d_q_i_cxci_d_v_biei__)-d_q_i_bici_d_v_biei__;
        d_fi_d_Y__(3,2) = (d_f_i_ciei_d_v_bxei__-d_f_i_cxci_d_v_bxei__)-d_f_i_bici_d_v_bxei__;
        d_qi_d_Y__(3,2) = (d_q_i_ciei_d_v_bxei__-d_q_i_cxci_d_v_bxei__)-d_q_i_bici_d_v_bxei__;
        d_fi_d_Y__(3,3) = (d_f_i_ciei_d_v_bici__-d_f_i_cxci_d_v_bici__)-d_f_i_bici_d_v_bici__;
        d_qi_d_Y__(3,3) = (d_q_i_ciei_d_v_bici__-d_q_i_cxci_d_v_bici__)-d_q_i_bici_d_v_bici__;
        d_fi_d_Y__(3,4) = (-d_f_i_cxci_d_v_bicx__);
        d_qi_d_Y__(3,4) = (-d_q_i_cxci_d_v_bicx__);
        d_fi_d_Y__(3,5) = (-d_f_i_cxci_d_v_bxbp__)-d_f_i_bici_d_v_bxbp__;
        d_qi_d_Y__(3,5) = (-d_q_i_cxci_d_v_bxbp__)-d_q_i_bici_d_v_bxbp__;
    % output for v_bici (internal unknown)
    fi__(3) = +f_i_ciei__-f_i_cxci__ - f_i_bici__;
    qi__(3) = +q_i_ciei__-q_i_cxci__ - q_i_bici__;
        d_fi_d_X__(4,1) = ((-d_f_i_ccx_d_v_ce__));
        d_qi_d_X__(4,1) = ((-d_q_i_ccx_d_v_ce__));
        d_fi_d_Y__(4,1) = ((-d_f_i_ccx_d_v_biei__+d_f_i_cxci_d_v_biei__)-d_f_i_bpcx_d_v_biei__)-d_f_i_bicx_d_v_biei__;
        d_qi_d_Y__(4,1) = ((-d_q_i_ccx_d_v_biei__+d_q_i_cxci_d_v_biei__)-d_q_i_bpcx_d_v_biei__)-d_q_i_bicx_d_v_biei__;
        d_fi_d_Y__(4,2) = ((d_f_i_cxci_d_v_bxei__)-d_f_i_bpcx_d_v_bxei__)-d_f_i_bicx_d_v_bxei__;
        d_qi_d_Y__(4,2) = ((d_q_i_cxci_d_v_bxei__)-d_q_i_bpcx_d_v_bxei__)-d_q_i_bicx_d_v_bxei__;
        d_fi_d_Y__(4,3) = ((d_f_i_cxci_d_v_bici__)-d_f_i_bpcx_d_v_bici__)-d_f_i_bicx_d_v_bici__;
        d_qi_d_Y__(4,3) = ((d_q_i_cxci_d_v_bici__)-d_q_i_bpcx_d_v_bici__)-d_q_i_bicx_d_v_bici__;
        d_fi_d_Y__(4,4) = ((-d_f_i_ccx_d_v_bicx__+d_f_i_cxci_d_v_bicx__)-d_f_i_bpcx_d_v_bicx__)-d_f_i_bicx_d_v_bicx__;
        d_qi_d_Y__(4,4) = ((-d_q_i_ccx_d_v_bicx__+d_q_i_cxci_d_v_bicx__)-d_q_i_bpcx_d_v_bicx__)-d_q_i_bicx_d_v_bicx__;
        d_fi_d_Y__(4,5) = ((d_f_i_cxci_d_v_bxbp__)-d_f_i_bpcx_d_v_bxbp__);
        d_qi_d_Y__(4,5) = ((d_q_i_cxci_d_v_bxbp__)-d_q_i_bpcx_d_v_bxbp__);
        d_fi_d_Y__(4,6) = ((-d_f_i_ccx_d_v_eei__));
        d_qi_d_Y__(4,6) = ((-d_q_i_ccx_d_v_eei__));
    % output for v_bicx (internal unknown)
    fi__(4) = -f_i_ccx__+f_i_cxci__-f_i_bpcx__ - f_i_bicx__;
    qi__(4) = -q_i_ccx__+q_i_cxci__-q_i_bpcx__ - q_i_bicx__;
        d_fi_d_Y__(5,1) = d_f_i_bpcx_d_v_biei__-d_f_i_bxbp_d_v_biei__;
        d_qi_d_Y__(5,1) = d_q_i_bpcx_d_v_biei__-d_q_i_bxbp_d_v_biei__;
        d_fi_d_Y__(5,2) = d_f_i_bpcx_d_v_bxei__-d_f_i_bxbp_d_v_bxei__;
        d_qi_d_Y__(5,2) = d_q_i_bpcx_d_v_bxei__-d_q_i_bxbp_d_v_bxei__;
        d_fi_d_Y__(5,3) = d_f_i_bpcx_d_v_bici__-d_f_i_bxbp_d_v_bici__;
        d_qi_d_Y__(5,3) = d_q_i_bpcx_d_v_bici__-d_q_i_bxbp_d_v_bici__;
        d_fi_d_Y__(5,4) = d_f_i_bpcx_d_v_bicx__;
        d_qi_d_Y__(5,4) = d_q_i_bpcx_d_v_bicx__;
        d_fi_d_Y__(5,5) = d_f_i_bpcx_d_v_bxbp__-d_f_i_bxbp_d_v_bxbp__;
        d_qi_d_Y__(5,5) = d_q_i_bpcx_d_v_bxbp__-d_q_i_bxbp_d_v_bxbp__;
    % output for v_bxbp (internal unknown)
    fi__(5) = +f_i_bpcx__ - f_i_bxbp__;
    qi__(5) = +q_i_bpcx__ - q_i_bxbp__;
        d_fi_d_X__(6,1) = (-d_f_i_ccx_d_v_ce__);
        d_qi_d_X__(6,1) = (-d_q_i_ccx_d_v_ce__);
        d_fi_d_X__(6,2) = (-d_f_i_bbx_d_v_be__);
        d_qi_d_X__(6,2) = (-d_q_i_bbx_d_v_be__);
        d_fi_d_Y__(6,1) = (-d_f_i_ccx_d_v_biei__);
        d_qi_d_Y__(6,1) = (-d_q_i_ccx_d_v_biei__);
        d_fi_d_Y__(6,2) = (-d_f_i_bbx_d_v_bxei__);
        d_qi_d_Y__(6,2) = (-d_q_i_bbx_d_v_bxei__);
        d_fi_d_Y__(6,4) = (-d_f_i_ccx_d_v_bicx__);
        d_qi_d_Y__(6,4) = (-d_q_i_ccx_d_v_bicx__);
        d_fi_d_Y__(6,6) = (-d_f_i_ccx_d_v_eei__-d_f_i_bbx_d_v_eei__)-d_f_i_eei_d_v_eei__;
        d_qi_d_Y__(6,6) = (-d_q_i_ccx_d_v_eei__-d_q_i_bbx_d_v_eei__)-d_q_i_eei_d_v_eei__;
    % output for v_eei (internal unknown)
    fi__(6) = -f_i_ccx__-f_i_bbx__ - f_i_eei__;
    qi__(6) = -q_i_ccx__-q_i_bbx__ - q_i_eei__;
end

function [eonames, iunames, ienames] = get_oui_names__(MOD__)
    eonames = {'ice', 'ibe'};
    iunames = {'v_biei', 'v_bxei', 'v_bici', 'v_bicx', 'v_bxbp', 'v_eei'};
    ienames = {'KCL for i_biei', 'KCL for i_bxei', 'KCL for i_bici', 'KCL for i_bicx', 'KCL for i_bxbp', 'KCL for i_eei'};
end

function [nFeQe, nFiQi, nOtherIo, nIntUnk] = get_nfq__(MOD__)
    nFeQe = 2;
    nFiQi = 6;
    nOtherIo = 2;
    nIntUnk = 6;
end

function iun = get_iu_names__(MOD)
    [~, iun, ~] = get_oui_names__(MOD);
end

function ien = get_ie_names__(MOD)
    [~, ~, ien] = get_oui_names__(MOD);
end


function d_outVal_d_inVal__ = d_limexp_vapp_d_arg1__(inVal)
    d_outVal_d_inVal__ = 0;
    breakPoint = 40;
    maxSlope = exp(40);
    if inVal<=breakPoint
            d_outVal_d_inVal__ = exp(inVal)*1;
        outVal = exp(inVal);
    else
            d_outVal_d_inVal__ = (maxSlope*(1));
        outVal = maxSlope+maxSlope*(inVal-breakPoint);
    end
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

function outVal = limexp_vapp(inVal)
    breakPoint = 40;
    maxSlope = exp(40);
    if inVal<=breakPoint
        outVal = exp(inVal);
    else
        outVal = maxSlope+maxSlope*(inVal-breakPoint);
    end
end

function outVal = pow_vapp(base, exponent)
    outVal = base^exponent;
end
