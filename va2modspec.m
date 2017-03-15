function va2modspec(inFileName, varargin)
% VA2MODSPEC translates a Verilog-A model into ModSpec format.
%
% va2modspec is the main user interface for VAPP. It translates a Verilog-A
% model into ModSpec format and prints the result into an output file. The name
% of the output file will be the module name with an ".m" extension. Note that
% the module name in the Verilog-A file can be different from the name of the
% file itself. 
%
% Caution: If the output file already exists, VAPP will overwrite it.
% 
% VAPP will require an 'include' directory where the files inserted into the
% model with the `include directives (such as `include "disciplines.vams") in
% the Verilog-A file are located. By default this directory is assumed to be in
% the same directory as the Verilog-A input file.
%       
% Usage:
%       va2modspec(path_to_input_file)
%           will take the path_to_input_file as the Verilog-A source, generate
%           the ModSpec model and write the output file to the current
%           directory. 
%
%       va2modspec(path_to_input_file, 'outputDir', path_to_output_directory)
%           will write the translated ModSpec file to path_to_output_directory 
%
%       va2modspec(path_to_input_file, 'include', path_to_include_directory)
%           will search for files in the path_to_include_directory that are
%           inserted into the mail Verilog-A file with `include statements.
%       
% Example:
% 
%   Given a Verilog-A file with the name 'example.va' and the module name
%   'example':
%
%       va2modspec('example.va');
%
%   will translate it into Modspec and write the output file to 'example.m'.
%   If there are any `include statements in example.va, VAPP will look for an
%   include directory (with the actual name 'include') in the same path as the
%   file.
%
%       va2modspec('example.va', 'outputDir', '~/modspec_models');
%
%   will translate 'example.va' and write the output to the '~/modspec_models'
%   directory. This directory has to exist prior to calling va2modspec.
%
%       va2modspec('example.va', 'outputDir', '~/modspec_models', ...
%                  'include', '~/va_models/include');
%
%   will look for an include directory at the location '~/va_models/inlcude'.
%
%   va2modspec can be called with only one of the options and the order of the
%   options can be arbitrary. I.e.,
%
%       va2modspec('example.va', 'include', '~/va_models/include');
%
%       va2modspec('example.va', 'include', '~/va_models/include', ...
%                  'outputDir', '~/modspec_models');
%
%See also
%--------
%VAPPquickstart, VAPPexamples, aboutVAPP
%

%==============================================================================
% This file is part of VAPP, the Berkeley Verilog-A Parser and Processor.   
% Author: A. Gokcen Mahmutoglu                                
% Last modified: Thu Aug 25, 2016  10:49AM
%==============================================================================

    inPar = inputParser;
    inPar.addRequired('inFileName', @isstr);
    inPar.addParamValue('outFileName', '', @ischar);
    inPar.addParamValue('outputDir', '', @ischar);
    inPar.addParamValue('includeDir', '', @ischar);
    inPar.parse(inFileName, varargin{:});
    outFileName = inPar.Results.outFileName;
    outputDir = inPar.Results.outputDir;
    includeDir = inPar.Results.includeDir;

    str_utils = VAPP_str_utils();

    % pre-process
    macro_definitions = {};
    working_dir = fileparts(inFileName);

    pre_process_parms.combine_lines_allow_whitespace = true;

    if isempty(includeDir)
        includeDir = fullfile(working_dir, 'include');
    end
    pre_process_parms.include_dirs = {includeDir};


    fprintf('Pre-processing and tokenizing...\n');
    tic;
    if exist(inFileName, 'file') == 2 % 2 excludes directories
        toks  = VAPP_pre_process(inFileName, macro_definitions, ...
                                                 pre_process_parms, str_utils);
        if isempty(toks)
            error(['Error while tokenizing the file. Please make sure that',...
                   ' the input file is syntactically correct.']);
        end
    else
        error('The file "%s" could not be found!' , inFileName);
    end

    processingTime = toc;
    fprintf('%.2f seconds\n', processingTime);

    % parse
    fprintf('Parsing...\n');
    tic;
    Ast = VAPP_parse(toks, str_utils);

    % if error parsing
    if isempty(Ast)
        fprintf(2, 'Error while parsing the input file. Could not create AST.\n');
        return;
    end

    processingTime = toc;
    fprintf('%.2f seconds\n', processingTime);

    % translate
    fprintf('Translating...\n');
    tic;

    % create intermediate representation (IR) tree
    ig = AstVisitorIrGenerator(Ast);

    module = ig.getModule;

    % go over the IR tree in several passes and perform various operations on
    % its nodes.

    fprintf('Marking access functions...\n');
    IrVisitorMark001(module);
    fprintf('Handling node collapse...\n');
    IrVisitorNodeCollapse(module);
    fprintf('Generating IO definitions and model equations...\n');
    module.seal();
    fprintf('Generating IO/variable dependencies...\n');
    IrVisitorGenerateDependency(module);
    IrVisitorMark003(module);
    processingTime = toc;
    fprintf('%.2f seconds\n', processingTime);
    % NOTE: the backend supports differentiation with respect to IOs *and*
    % variables. Because the differentiation operation with respect to
    % variables is more fragile (think if-else conditions), for now, we don't
    % offer an interface for it.
    fprintf('Generating Derivatives...\n');
    tic
    derVarVec = []; % could be: derVarVec = module.getVar('BSIM3tox');
    % get all the input IOs in the module. Do the differentiation with respect
    % to them.
    derPfVec = module.getInputPfVec();
    IrVisitorGenerateDerivative(derPfVec, derVarVec, module);
    IrVisitorMarkDerivative(1, module);
    % NOTE: this procedure can be repeated to get higher order derivatives.
    % Again, no interface is offered for it but we would first start with
    % marking the derivatives with something like:
    %IrVisitorMarkDerivative(1, module);
    %IrVisitorMark3(module);

    if isempty(outFileName)
        outFileBase = ig.getModule.getName();
        outFileName = [outFileBase, '.m'];
    end

    if isempty(outputDir) == false
        outFileName = [outputDir, '/', outFileName];
    end
    outFileId = fopen(outFileName, 'w+');
    if outFileId == -1
        error(['Could not open the output file for writing. Please make',...
               ' sure the output directory exists.']);
    end
    ig.printModSpec(outFileId);
    fclose(outFileId);
    processingTime = toc;
    fprintf('%.2f seconds\n', processingTime);

    fprintf('Done: Output printed to ''%s''\n', outFileName);
end
