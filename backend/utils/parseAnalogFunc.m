function aFuncAst = parseAnalogFunc(fileName)
    funcPath = mfilename('fullpath');
    fileDir = fileparts(funcPath);
    filePath = fullfile(fileDir, '/', fileName);

    ppArgs.combine_lines_allow_whitespace = true;
    ppArgs.include_dirs = {};
    strUtils = VAPP_str_utils();
    toks = VAPP_pre_process(filePath, {}, ppArgs, strUtils);
    aFuncRoot = VAPP_parse(toks, strUtils);
    aFuncAst = aFuncRoot.get_child(1);
end
