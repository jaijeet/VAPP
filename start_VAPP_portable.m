% START_VAPP setup VAPP paths
%
% Call start_VAPP from the top-level directory where the VAPP files are located
% in order to setup paths to all the source files.
%
% See also VA2MODSPEC

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.
% Author: A. Gokcen Mahmutoglu
% Last modified: Fri Feb 24, 2017  06:14PM
%==============================================================================

VAPPTOP=pwd;
addpath(VAPPTOP);
addpath(sprintf('%s/frontend',                           VAPPTOP));
addpath(sprintf('%s/backend',                            VAPPTOP));
addpath(sprintf('%s/backend/IrVisitor',                  VAPPTOP));
addpath(sprintf('%s/backend/Ms',                         VAPPTOP));
addpath(sprintf('%s/backend/AstVisitor',                 VAPPTOP));
addpath(sprintf('%s/backend/IrNode',                     VAPPTOP));
addpath(sprintf('%s/backend/utils',                      VAPPTOP));
addpath(sprintf('%s/backend/print_templates',            VAPPTOP));
addpath(sprintf('%s/include',                            VAPPTOP));
addpath(sprintf('%s/doc',                                VAPPTOP));
addpath(sprintf('%s/examples/bsim3_ring_oscillator',     VAPPTOP));
addpath(sprintf('%s/examples/bsim4_iv_curves',           VAPPTOP));
addpath(sprintf('%s/examples/bsim6_iv_curves',           VAPPTOP));
addpath(sprintf('%s/examples/mvs1_inverter_transient',   VAPPTOP));
addpath(sprintf('%s/examples/psp_csamp_transient',       VAPPTOP));
addpath(sprintf('%s/examples/purdue_ncfet_homotopy',     VAPPTOP));
addpath(sprintf('%s/examples/r3_self-heating_transient', VAPPTOP));
addpath(sprintf('%s/examples/vbic_diffpair_ac',          VAPPTOP));
fprintf('VAPP paths have been set up.\n\n');
