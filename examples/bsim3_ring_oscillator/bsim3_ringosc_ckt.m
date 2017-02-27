function DAE = bsim3_ringosc_ckt(uniqIDstr)
    % A three stage ring oscillator with BSIM3 MOSFET
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The Circuit:
    %	a 3 stage ring oscillator made with BSIM3 MOSFETs
    %	using 0.18u parameters, probably from MOSIS
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%
    %see DAEAPIv6_doc.m for a description of the functions here.
    %%%%

    %==============================================================================
    % This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
    % Author: A. Gokcen Mahmutoglu, J. Roychowdhury
    % Last modified: Mon Feb 20, 2017  01:25PM
    %==============================================================================

    % ckt name
    if nargin <1
        cktname = 'BSIM3-ringosc';
    else
        cktname = uniqIDstr;
    end

    % nodes (names)
    nodes = {'VDD', 'inv1', 'inv2', 'inv3'};
    ground = 'gnd';

    % list of elements
    vddM = vsrcModSpec('VDD');
    iInj1M = isrcModSpec('iInj1');
    minv1pM = bsim3('Minv1p');
    minv1nM = bsim3('Minv1n');
    minv2pM = bsim3('Minv2p');
    minv2nM = bsim3('Minv2n');
    minv3pM = bsim3('Minv3p');
    minv3nM = bsim3('Minv3n');

    % element node connectivities
    vddNodes = {'VDD', ground}; % p, n
    iInj1Nodes = {'inv1', ground}; % p, n
    %mp1 inv1 inv3 VDD VDD mypmos
    minv1pNodes = {'inv1', 'inv3', 'VDD', 'VDD'};  % d g s b
    %mn1 inv1 inv3 0 0 mynmos
    minv1nNodes = {'inv1', 'inv3', ground, ground};  % d g s b
    %c1  inv1 0 1e-19

    %mp2 inv2 inv1 VDD VDD mypmos
    minv2pNodes = {'inv2', 'inv1', 'VDD', 'VDD'};  % d g s b
    %mn2 inv2 inv1 0 0 mynmos
    minv2nNodes = {'inv2', 'inv1', ground, ground};  % d g s b

    %mp3 inv3 inv2 VDD VDD mypmos
    minv3pNodes = {'inv3', 'inv2', 'VDD', 'VDD'};  % d g s b
    %mn3 inv3 inv2 0 0 mynmos
    minv3nNodes = {'inv3', 'inv2', ground, ground};  % d g s b

    vddElement.name = 'vdd'; vddElement.model = vddM;
    vddElement.nodes = vddNodes; vddElement.parms = {};

    iInj1Element.name = 'iInj1'; iInj1Element.model = iInj1M;
    iInj1Element.nodes = iInj1Nodes; iInj1Element.parms = {};

    % 0.18u BSIM3 model - probably MOSIS - from old SPP's
    % bsim3ADMS_inv5_osc_subckt.sp
    %
    % .model mynmos bsim3a type=1 W=0.18e-6 L=0.18e-6 Toxm=4.1E-9
    % +TNOM    = 27             TOX     = 4.1E-9
    % +XJ      = 1E-7           NCH     = 2.3549E17      VTH0    = 0.3696986
    % +K1      = 0.6064385      K2      = 1.63871E-3     K3      = 1E-3
    % +K3B     = 2.763267       W0      = 1E-7           NLX     = 1.71872E-7
    % +DVT0W   = 0              DVT1W   = 0              DVT2W   = 0
    % +DVT0    = 1.3330881      DVT1    = 0.3683763      DVT2    = 0.0540199
    % +U0      = 258.9066683    UA      = -1.504141E-9   UB      = 2.428646E-18
    % +UC      = 5.105195E-11   VSAT    = 9.896282E4     A0      = 1.8904342
    % +AGS     = 0.4044483      B0      = -4.706134E-8   B1      = 1.294942E-6
    % +KETA    = -2.730673E-3   A1      = 5.916677E-4    A2      = 0.9069159
    % +RDSW    = 105            PRWG    = 0.5            PRWB    = -0.2
    % +WR      = 1              WINT    = 0              LINT    = 1.69494E-8
    % +DWG     = -3.773529E-9
    % +DWB     = 5.239518E-9    VOFF    = -0.0883818     NFACTOR = 2.1821266
    % +CIT     = 0              CDSC    = 2.4E-4         CDSCD   = 0
    % +CDSCB   = 0              ETA0    = 2.470369E-3    ETAB    = 1.047744E-5
    % +DSUB    = 0.0167866      PCLM    = 0.7326932      PDIBLC1 = 0.1823102
    % +PDIBLC2 = 3.38377E-3     PDIBLCB = -0.1           DROUT   = 0.7469045
    % +PSCBE1  = 8E10           PSCBE2  = 1.254966E-9    PVAG    = 0
    % +DELTA   = 0.01           RSH     = 6.5            MOBMOD  = 1
    % +PRT     = 0              UTE     = -1.5           KT1     = -0.11
    % +KT1L    = 0              KT2     = 0.022          UA1     = 4.31E-9
    % +UB1     = -7.61E-18      UC1     = -5.6E-11       AT      = 3.3E4
    % +WL      = 0              WLN     = 1              WW      = 0
    % +WWN     = 1              WWL     = 0              LL      = 0
    % +LLN     = 1              LW      = 0              LWN     = 1
    % +LWL     = 0              CAPMOD  = 2              XPART   = 0.5
    % +CGDO    = 7.9E-10        CGSO    = 7.9E-10        CGBO    = 1E-12
    % +CJ      = 9.539798E-4    PB      = 0.8            MJ      = 0.380768
    % +CJSW    = 2.53972E-10    PBSW    = 0.8            MJSW    = 0.1061193
    % +CJSWG   = 3.3E-10        PBSWG   = 0.8            MJSWG   = 0.1061193
    % +CF      = 0              PVTH0   = 7.505753E-4    PRDSW   = -2.7650517
    % +PK2     = -4.42044E-4    WKETA   = 3.100384E-3    LKETA   = -0.0104103
    % +PU0     = 10.8203648     PUA     = 2.896652E-11   PUB     = 1.684125E-23
    % +PVSAT   = 1.388017E3     PETA0   = 8.758549E-5    PKETA   = 1.549791E-3

    pnames = { ...
        'parm_Type', ... %	= 1
        'parm_w', ... %	= 0.18e-6
        'parm_l', ... %	= 0.18e-6
        'parm_toxm', ... %	= 4.1e-9
        'parm_tnom', ... %    = 27
        'parm_xj', ... %      = 1e-7
        'parm_k1', ... %      = 0.6064385
        'parm_k3b', ... %     = 2.763267
        'parm_dvt0w', ... %   = 0
        'parm_dvt0', ... %    = 1.3330881
        'parm_u0', ... %      = 258.9066683
        'parm_uc', ... %      = 5.105195e-11
        'parm_ags', ... %     = 0.4044483
        'parm_keta', ... %    = -2.730673e-3
        'parm_rdsw', ... %    = 105
        'parm_wr', ... %      = 1
        'parm_dwg', ... %     = -3.773529e-9
        'parm_dwb', ... %     = 5.239518e-9
        'parm_cit', ... %     = 0
        'parm_cdscb', ... %   = 0
        'parm_dsub', ... %    = 0.0167866
        'parm_pdiblc2', ... % = 3.38377e-3
        'parm_pscbe1', ... %  = 8e10
        'parm_delta', ... %   = 0.01
        'parm_prt', ... %     = 0
        'parm_kt1l', ... %    = 0
        'parm_ub1', ... %     = -7.61e-18
        'parm_wl', ... %      = 0
        'parm_wwn', ... %     = 1
        'parm_lln', ... %     = 1
        'parm_lwl', ... %     = 0
        'parm_cgdo', ... %    = 7.9e-10
        'parm_cj', ... %      = 9.539798e-4
        'parm_cjsw', ... %    = 2.53972e-10
        'parm_cjswg', ... %   = 3.3e-10
        'parm_cf', ... %      = 0
        'parm_pk2', ... %     = -4.42044e-4
        'parm_pu0', ... %     = 10.8203648
        'parm_pvsat', ... %   = 1.388017e3
        'parm_tox', ... %     = 4.1e-9
        'parm_nch', ... %     = 2.3549e17
        'parm_k2', ... %      = 1.63871e-3
        'parm_w0', ... %      = 1e-7
        'parm_dvt1w', ... %   = 0
        'parm_dvt1', ... %    = 0.3683763
        'parm_ua', ... %      = -1.504141e-9
        'parm_vsat', ... %    = 9.896282e4
        'parm_b0', ... %      = -4.706134e-8
        'parm_a1', ... %      = 5.916677e-4
        'parm_prwg', ... %    = 0.5
        'parm_wint', ... %    = 0
        'parm_voff', ... %    = -0.0883818
        'parm_cdsc', ... %    = 2.4e-4
        'parm_eta0', ... %    = 2.470369e-3
        'parm_pclm', ... %    = 0.7326932
        'parm_pdiblcb', ... % = -0.1
        'parm_pscbe2', ... %  = 1.254966e-9
        'parm_rsh', ... %     = 6.5
        'parm_ute', ... %     = -1.5
        'parm_kt2', ... %     = 0.022
        'parm_uc1', ... %     = -5.6e-11
        'parm_wln', ... %     = 1
        'parm_wwl', ... %     = 0
        'parm_lw', ... %      = 0
        'parm_capmod', ... %  = 2
        'parm_cgso', ... %    = 7.9e-10
        'parm_pb', ... %      = 0.8
        'parm_pbsw', ... %    = 0.8
        'parm_pbswg', ... %   = 0.8
        'parm_pvth0', ... %   = 7.505753e-4
        'parm_wketa', ... %   = 3.100384e-3
        'parm_pua', ... %     = 2.896652e-11
        'parm_peta0', ... %   = 8.758549e-5
        'parm_vth0', ... %    = 0.3696986
        'parm_k3', ... %      = 1e-3
        'parm_nlx', ... %     = 1.71872e-7
        'parm_dvt2w', ... %   = 0
        'parm_dvt2', ... %    = 0.0540199
        'parm_ub', ... %      = 2.428646e-18
        'parm_a0', ... %      = 1.8904342
        'parm_b1', ... %      = 1.294942e-6
        'parm_a2', ... %      = 0.9069159
        'parm_prwb', ... %    = -0.2
        'parm_lint', ... %    = 1.69494e-8
        'parm_nfactor', ... % = 2.1821266
        'parm_cdscd', ... %   = 0
        'parm_etab', ... %    = 1.047744e-5
        'parm_pdiblc1', ... % = 0.1823102
        'parm_drout', ... %   = 0.7469045
        'parm_pvag', ... %    = 0
        'parm_mobmod', ... %  = 1
        'parm_kt1', ... %     = -0.11
        'parm_ua1', ... %     = 4.31e-9
        'parm_at', ... %      = 3.3e4
        'parm_ww', ... %      = 0
        'parm_ll', ... %      = 0
        'parm_lwn', ... %     = 1
        'parm_xpart', ... %   = 0.5
        'parm_cgbo', ... %    = 1e-12
        'parm_mj', ... %      = 0.380768
        'parm_mjsw', ... %    = 0.1061193
        'parm_mjswg', ... %   = 0.1061193
        'parm_prdsw', ... %   = -2.7650517
        'parm_lketa', ... %   = -0.0104103
        'parm_pub', ... %     = 1.684125e-23
        'parm_pketa' ... %   = 1.549791e-3
        };
    pvals = { ...
        1 , ... % Type
        0.18e-6 , ... % w
        0.18e-6 , ... % l
        4.1e-9, ... % toxm
        27           , ... % tnom
        1e-7         , ... % xj
        0.6064385    , ... % k1
        2.763267     , ... % k3b
        0            , ... % dvt0w
        1.3330881    , ... % dvt0
        258.9066683  , ... % u0
        5.105195e-11 , ... % uc
        0.4044483    , ... % ags
        -2.730673e-3 , ... % keta
        105          , ... % rdsw
        1            , ... % wr
        -3.773529e-9, ... % dwg
        5.239518e-9  , ... % dwb
        0            , ... % cit
        0            , ... % cdscb
        0.0167866    , ... % dsub
        3.38377e-3   , ... % pdiblc2
        8e10         , ... % pscbe1
        0.01         , ... % delta
        0            , ... % prt
        0            , ... % kt1l
        -7.61e-18    , ... % ub1
        0            , ... % wl
        1            , ... % wwn
        1            , ... % lln
        0            , ... % lwl
        7.9e-10      , ... % cgdo
        9.539798e-4  , ... % cj
        2.53972e-10  , ... % cjsw
        3.3e-10      , ... % cjswg
        0            , ... % cf
        -4.42044e-4  , ... % pk2
        10.8203648   , ... % pu0
        1.388017e3   , ... % pvsat
        4.1e-9, ... % tox
        2.3549e17   , ... % nch
        1.63871e-3  , ... % k2
        1e-7        , ... % w0
        0           , ... % dvt1w
        0.3683763   , ... % dvt1
        -1.504141e-9, ... % ua
        9.896282e4  , ... % vsat
        -4.706134e-8, ... % b0
        5.916677e-4 , ... % a1
        0.5         , ... % prwg
        0           , ... % wint
        -0.0883818  , ... % voff
        2.4e-4      , ... % cdsc
        2.470369e-3 , ... % eta0
        0.7326932   , ... % pclm
        -0.1        , ... % pdiblcb
        1.254966e-9 , ... % pscbe2
        6.5         , ... % rsh
        -1.5        , ... % ute
        0.022       , ... % kt2
        -5.6e-11    , ... % uc1
        1           , ... % wln
        0           , ... % wwl
        0           , ... % lw
        2           , ... % capmod
        7.9e-10     , ... % cgso
        0.8         , ... % pb
        0.8         , ... % pbsw
        0.8         , ... % pbswg
        7.505753e-4 , ... % pvth0
        3.100384e-3 , ... % wketa
        2.896652e-11, ... % pua
        8.758549e-5 , ... % peta0
        0.3696986, ... % vth0
        1e-3, ... % k3
        1.71872e-7, ... % nlx
        0, ... % dvt2w
        0.0540199, ... % dvt2
        2.428646e-18, ... % ub
        1.8904342, ... % a0
        1.294942e-6, ... % b1
        0.9069159, ... % a2
        -0.2, ... % prwb
        1.69494e-8, ... % lint
        2.1821266, ... % nfactor
        0, ... % cdscd
        1.047744e-5, ... % etab
        0.1823102, ... % pdiblc1
        0.7469045, ... % drout
        0, ... % pvag
        1, ... % mobmod
        -0.11, ... % kt1
        4.31e-9, ... % ua1
        3.3e4, ... % at
        0, ... % ww
        0, ... % ll
        1, ... % lwn
        0.5, ... % xpart
        1e-12, ... % cgbo
        0.380768, ... % mj
        0.1061193, ... % mjsw
        0.1061193, ... % mjswg
        -2.7650517, ... % prdsw
        -0.0104103, ... % lketa
        1.684125e-23, ... % pub
        1.549791e-3, ... % pketa
        };

    minv1nM = feval(minv1nM.setparms, pnames, pvals, minv1nM);
    n_parms = feval(minv1nM.getparms, minv1nM);

    minv1nElement.name = 'mn1'; minv1nElement.model = minv1nM;
    minv1nElement.nodes = minv1nNodes;
    minv1nElement.parms = n_parms;

    minv2nElement.name = 'mn2'; minv2nElement.model = minv2nM;
    minv2nElement.nodes = minv2nNodes;
    minv2nElement.parms = n_parms;

    minv3nElement.name = 'mn3'; minv3nElement.model = minv3nM;
    minv3nElement.nodes = minv3nNodes;
    minv3nElement.parms = n_parms;


    % .model mypmos bsim3a type=-1
    % +w=0.54e-6                l=0.18e-6                Toxm=4.1E-9
    % +TNOM=27                  TOX=4.1E-9               XJ=1E-7
    % +NCH=4.1589E17            VTH0=-0.3835898          K1=0.59111
    % +K2=0.0258663             K3=0                     K3B=7.9143108
    % +W0=1E-6                  NLX=1.20187E-7           DVT0W=0
    % +DVT1W=0                  DVT2W=0
    % +DVT0    = 0.6117215      DVT1    = 0.2286816      DVT2    = 0.1
    % +U0      = 106.5280265    UA      = 1.125454E-9    UB      = 1E-21
    % +UC      = -1E-10         VSAT    = 1.593712E5     A0      = 1.6904754
    % +AGS     = 0.3667554      B0      = 5.263128E-7    B1      = 1.496707E-6
    % +KETA    = 0.0237092      A1      = 0.2276342      A2      = 0.6915706
    % +RDSW    = 304.9893888    PRWG    = 0.5            PRWB    = 0.2553725
    % +WR      = 1              WINT    = 0              LINT    = 3.217673E-8
    % +DWG     = -2.44019E-8
    % +DWB     = -9.06003E-10   VOFF    = -0.0878287     NFACTOR = 1.8560303
    % +CIT     = 0              CDSC    = 2.4E-4         CDSCD   = 0
    % +CDSCB   = 0              ETA0    = 0.1672562      ETAB    = -0.1249603
    % +DSUB    = 1.0998181      PCLM    = 2.2249148      PDIBLC1 = 8.275696E-4
    % +PDIBLC2 = 0.0420477      PDIBLCB = -1E-3          DROUT   = 0
    % +PSCBE1  = 1.073111E10    PSCBE2  = 3.099395E-9    PVAG    = 15
    % +DELTA   = 0.01           RSH     = 7.4            MOBMOD  = 1
    % +PRT     = 0              UTE     = -1.5           KT1     = -0.11
    % +KT1L    = 0              KT2     = 0.022          UA1     = 4.31E-9
    % +UB1     = -7.61E-18      UC1     = -5.6E-11       AT      = 3.3E4
    % +WL      = 0              WLN     = 1              WW      = 0
    % +WWN     = 1              WWL     = 0              LL      = 0
    % +LLN     = 1              LW      = 0              LWN     = 1
    % +LWL     = 0              CAPMOD  = 2              XPART   = 0.5
    % +CGDO    = 6.41E-10       CGSO    = 6.41E-10       CGBO    = 1E-12
    % +CJ      = 1.200422E-3    PB      = 0.8478616      MJ      = 0.4105254
    % +CJSW    = 2.001802E-10   PBSW    = 0.8483594      MJSW    = 0.3400571
    % +CJSWG   = 4.22E-10       PBSWG   = 0.8483594      MJSWG   = 0.3400571
    % +CF      = 0              PVTH0   = 2.098588E-3    PRDSW   = 4.4771801
    % +PK2     = 1.799383E-3    WKETA   = 0.0295614      LKETA   = -1.935751E-3
    % +PU0     = -1.3399122     PUA     = -5.27759E-11   PUB     = 1E-21
    % +PVSAT   = -50            PETA0   = 1.003159E-4    PKETA   = -3.434535E-3

    pnames = { ...
        'parm_Type', ... % = -1
        'parm_w', ... %=0.54e-6
        'parm_tnom', ... %=27
        'parm_nch', ... %=4.1589e17
        'parm_k2', ... %=0.0258663
        'parm_w0', ... %=1e-6
        'parm_dvt1w', ... %=0
        'parm_dvt0', ... %    = 0.6117215
        'parm_u0', ... %      = 106.5280265
        'parm_uc', ... %      = -1e-10
        'parm_ags', ... %     = 0.3667554
        'parm_keta', ... %    = 0.0237092
        'parm_rdsw', ... %    = 304.9893888
        'parm_wr', ... %      = 1
        'parm_dwg', ... %     = -2.44019e-8
        'parm_dwb', ... %     = -9.06003e-10
        'parm_cit', ... %     = 0
        'parm_cdscb', ... %   = 0
        'parm_dsub', ... %    = 1.0998181
        'parm_pdiblc2', ... % = 0.0420477
        'parm_pscbe1', ... %  = 1.073111e10
        'parm_delta', ... %   = 0.01
        'parm_prt', ... %     = 0
        'parm_kt1l', ... %    = 0
        'parm_ub1', ... %     = -7.61e-18
        'parm_wl', ... %      = 0
        'parm_wwn', ... %     = 1
        'parm_lln', ... %     = 1
        'parm_lwl', ... %     = 0
        'parm_cgdo', ... %    = 6.41e-10
        'parm_cj', ... %      = 1.200422e-3
        'parm_cjsw', ... %    = 2.001802e-10
        'parm_cjswg', ... %   = 4.22e-10
        'parm_cf', ... %      = 0
        'parm_pk2', ... %     = 1.799383e-3
        'parm_pu0', ... %     = -1.3399122
        'parm_pvsat', ... %   = -50
        'parm_l', ... %=0.18e-6
        'parm_tox', ... %=4.1e-9
        'parm_vth0', ... %=-0.3835898
        'parm_k3', ... %=0
        'parm_nlx', ... %=1.20187e-7
        'parm_dvt2w', ... %=0
        'parm_dvt1', ... %    = 0.2286816
        'parm_ua', ... %      = 1.125454e-9
        'parm_vsat', ... %    = 1.593712e5
        'parm_b0', ... %      = 5.263128e-7
        'parm_a1', ... %      = 0.2276342
        'parm_prwg', ... %    = 0.5
        'parm_wint', ... %    = 0
        'parm_voff', ... %    = -0.0878287
        'parm_cdsc', ... %    = 2.4e-4
        'parm_eta0', ... %    = 0.1672562
        'parm_pclm', ... %    = 2.2249148
        'parm_pdiblcb', ... % = -1e-3
        'parm_pscbe2', ... %  = 3.099395e-9
        'parm_rsh', ... %     = 7.4
        'parm_ute', ... %     = -1.5
        'parm_kt2', ... %     = 0.022
        'parm_uc1', ... %     = -5.6e-11
        'parm_wln', ... %     = 1
        'parm_wwl', ... %     = 0
        'parm_lw', ... %      = 0
        'parm_capmod', ... %  = 2
        'parm_cgso', ... %    = 6.41e-10
        'parm_pb', ... %      = 0.8478616
        'parm_pbsw', ... %    = 0.8483594
        'parm_pbswg', ... %   = 0.8483594
        'parm_pvth0', ... %   = 2.098588e-3
        'parm_wketa', ... %   = 0.0295614
        'parm_pua', ... %     = -5.27759e-11
        'parm_peta0', ... %   = 1.003159e-4
        'parm_toxm', ... %=4.1e-9
        'parm_xj', ... %=1e-7
        'parm_k1', ... %=0.59111
        'parm_k3b', ... %=7.9143108
        'parm_dvt0w', ... %=0
        'parm_dvt2', ... %    = 0.1
        'parm_ub', ... %      = 1e-21
        'parm_a0', ... %      = 1.6904754
        'parm_b1', ... %      = 1.496707e-6
        'parm_a2', ... %      = 0.6915706
        'parm_prwb', ... %    = 0.2553725
        'parm_lint', ... %    = 3.217673e-8
        'parm_nfactor', ... % = 1.8560303
        'parm_cdscd', ... %   = 0
        'parm_etab', ... %    = -0.1249603
        'parm_pdiblc1', ... % = 8.275696e-4
        'parm_drout', ... %   = 0
        'parm_pvag', ... %    = 15
        'parm_mobmod', ... %  = 1
        'parm_kt1', ... %     = -0.11
        'parm_ua1', ... %     = 4.31e-9
        'parm_at', ... %      = 3.3e4
        'parm_ww', ... %      = 0
        'parm_ll', ... %      = 0
        'parm_lwn', ... %     = 1
        'parm_xpart', ... %   = 0.5
        'parm_cgbo', ... %    = 1e-12
        'parm_mj', ... %      = 0.4105254
        'parm_mjsw', ... %    = 0.3400571
        'parm_mjswg', ... %   = 0.3400571
        'parm_prdsw', ... %   = 4.4771801
        'parm_lketa', ... %   = -1.935751e-3
        'parm_pub', ... %     = 1e-21
        'parm_pketa' ... %   = -3.434535e-3
        };


    pvals = { ...
        -1, ... % Type
        0.54e-6             , ... % w
        27               , ... % tnom
        4.1589e17         , ... % nch
        0.0258663          , ... % k2
        1e-6               , ... % w0
        0               , ... % dvt1w
        0.6117215   , ... % dvt0
        106.5280265 , ... % u0
        -1e-10      , ... % uc
        0.3667554   , ... % ags
        0.0237092   , ... % keta
        304.9893888 , ... % rdsw
        1           , ... % wr
        -2.44019e-8, ... % dwg
        -9.06003e-10, ... % dwb
        0           , ... % cit
        0           , ... % cdscb
        1.0998181   , ... % dsub
        0.0420477   , ... % pdiblc2
        1.073111e10 , ... % pscbe1
        0.01        , ... % delta
        0           , ... % prt
        0           , ... % kt1l
        -7.61e-18   , ... % ub1
        0           , ... % wl
        1           , ... % wwn
        1           , ... % lln
        0           , ... % lwl
        6.41e-10    , ... % cgdo
        1.200422e-3 , ... % cj
        2.001802e-10, ... % cjsw
        4.22e-10    , ... % cjswg
        0           , ... % cf
        1.799383e-3 , ... % pk2
        -1.3399122  , ... % pu0
        -50         , ... % pvsat
        0.18e-6             , ... % l
        4.1e-9            , ... % tox
        -0.3835898       , ... % vth0
        0                  , ... % k3
        1.20187e-7        , ... % nlx
        0, ... % dvt2w
        0.2286816   , ... % dvt1
        1.125454e-9 , ... % ua
        1.593712e5  , ... % vsat
        5.263128e-7 , ... % b0
        0.2276342   , ... % a1
        0.5         , ... % prwg
        0           , ... % wint
        -0.0878287  , ... % voff
        2.4e-4      , ... % cdsc
        0.1672562   , ... % eta0
        2.2249148   , ... % pclm
        -1e-3       , ... % pdiblcb
        3.099395e-9 , ... % pscbe2
        7.4         , ... % rsh
        -1.5        , ... % ute
        0.022       , ... % kt2
        -5.6e-11    , ... % uc1
        1           , ... % wln
        0           , ... % wwl
        0           , ... % lw
        2           , ... % capmod
        6.41e-10    , ... % cgso
        0.8478616   , ... % pb
        0.8483594   , ... % pbsw
        0.8483594   , ... % pbswg
        2.098588e-3 , ... % pvth0
        0.0295614   , ... % wketa
        -5.27759e-11, ... % pua
        1.003159e-4 , ... % peta0
        4.1e-9, ... % toxm
        1e-7 , ... % xj
        0.59111 , ... % k1
        7.9143108 , ... % k3b
        0 , ... % dvt0w
        0.1, ... % dvt2
        1e-21, ... % ub
        1.6904754, ... % a0
        1.496707e-6, ... % b1
        0.6915706, ... % a2
        0.2553725, ... % prwb
        3.217673e-8, ... % lint
        1.8560303, ... % nfactor
        0, ... % cdscd
        -0.1249603, ... % etab
        8.275696e-4, ... % pdiblc1
        0, ... % drout
        15, ... % pvag
        1, ... % mobmod
        -0.11, ... % kt1
        4.31e-9, ... % ua1
        3.3e4, ... % at
        0, ... % ww
        0, ... % ll
        1, ... % lwn
        0.5, ... % xpart
        1e-12, ... % cgbo
        0.4105254, ... % mj
        0.3400571, ... % mjsw
        0.3400571, ... % mjswg
        4.4771801, ... % prdsw
        -1.935751e-3, ... % lketa
        1e-21, ... % pub
        -3.434535e-3 ... % pketa
        };

    minv1pM = feval(minv1pM.setparms, pnames, pvals, minv1pM);
    p_parms = feval(minv1pM.getparms, minv1pM);

    minv1pElement.name = 'mp1'; minv1pElement.model = minv1pM;
    minv1pElement.nodes = minv1pNodes;
    minv1pElement.parms = p_parms;

    minv2pElement.name = 'mp2'; minv2pElement.model = minv2pM;
    minv2pElement.nodes = minv2pNodes;
    minv2pElement.parms = p_parms;

    minv3pElement.name = 'mp3'; minv3pElement.model = minv3pM;
    minv3pElement.nodes = minv3pNodes;
    minv3pElement.parms = p_parms;


    % set up circuitdata structure containing all the above
    % contains: nodenames, groundnodename(s), elements
    % each element contains: name, ModSpecModel, nodes, parms
    circuitdata.cktname = cktname;
    circuitdata.nodenames = nodes; % all non-ground nodes
    circuitdata.groundnodename = ground;
    circuitdata.elements = {vddElement, iInj1Element, ...
        minv1nElement, minv1pElement, ...
        minv2nElement, minv2pElement, ...
        minv3nElement, minv3pElement};

    % set up and return a DAE of the MNA equations for the circuit
    DAE = MNA_EqnEngine(cktname, circuitdata);
end
