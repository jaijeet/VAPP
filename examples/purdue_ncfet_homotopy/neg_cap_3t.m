function MOD = neg_cap_3t(uniqID)

%===============================================================================
% This file was created using VAPP, the Berkeley Verilog-A Parser and Processor.   
% Last modified: 23-Feb-2017 13:34:15
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

    MOD.model_name = 'neg_cap_3t';
    MOD.NIL.node_names = {'ncp', 'qg_as_v', 'ncn'};
    MOD.NIL.refnode_name = 'ncn';

    parmNameDefValArr = {'parm_alpha', -180000000000,...
                         'parm_beta', 5.8e+22,...
                         'parm_gamma', 0,...
                         'parm_rho', 9,...
                         'parm_tFE', 1e-06};

    nParm = 5;
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
    parm_alpha = MOD__.parm_vals{1};
    parm_beta = MOD__.parm_vals{2};
    parm_gamma = MOD__.parm_vals{3};
    parm_rho = MOD__.parm_vals{4};
    parm_tFE = MOD__.parm_vals{5};

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
    d_f_v_ncpncn_d_v_qg_as_vncn__ = 0;
    d_q_v_ncpncn_d_v_qg_as_vncn__ = 0;
    % Initializing inputs
    v_qg_as_vncn__ = vecX__(1);
    terminalFlow_ncp__ = vecX__(2);
    % Initializing remaining IOs and auxiliary IOs
    f_v_ncpncn__ = 0;
    q_v_ncpncn__ = 0;
    % module body
        d_f_v_ncpncn_d_v_qg_as_vncn__ = d_f_v_ncpncn_d_v_qg_as_vncn__+(((((2*parm_alpha)*parm_tFE)*(1*1e-06))+(((4*parm_beta)*parm_tFE)*(d_pow_vapp_d_arg1__(v_qg_as_vncn__*1e-06, 3)*(1*1e-06))))+(((6*parm_gamma)*parm_tFE)*(d_pow_vapp_d_arg1__(v_qg_as_vncn__*1e-06, 5)*(1*1e-06))));
    % contribution for v_ncpncn;
    f_v_ncpncn__ = f_v_ncpncn__ + (((2*parm_alpha)*parm_tFE)*(v_qg_as_vncn__*1e-06)+((4*parm_beta)*parm_tFE)*pow_vapp(v_qg_as_vncn__*1e-06, 3))+((6*parm_gamma)*parm_tFE)*pow_vapp(v_qg_as_vncn__*1e-06, 5);
        d_q_v_ncpncn_d_v_qg_as_vncn__ = d_q_v_ncpncn_d_v_qg_as_vncn__+((parm_rho*parm_tFE)*(1*1e-06));
    % contribution for v_ncpncn;
    q_v_ncpncn__ = q_v_ncpncn__ + (parm_rho*parm_tFE)*v_qg_as_vncn__*1e-06;
        d_fe_d_X__(1,1) = d_f_v_ncpncn_d_v_qg_as_vncn__;
        d_qe_d_X__(1,1) = d_q_v_ncpncn_d_v_qg_as_vncn__;
    % output for v_ncpncn (explicit out)
    fe__(1) = +f_v_ncpncn__;
    qe__(1) = +q_v_ncpncn__;
    % output for terminalFlow_qg_as_v (explicit out)
    fe__(2) = 0;
    qe__(2) = 0;
end

function [eonames, iunames, ienames] = get_oui_names__(MOD__)
    eonames = {'vncpncn', 'iqg_as_vncn'};
    iunames = {};
    ienames = {};
end

function [nFeQe, nFiQi, nOtherIo, nIntUnk] = get_nfq__(MOD__)
    nFeQe = 2;
    nFiQi = 0;
    nOtherIo = 2;
    nIntUnk = 0;
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
