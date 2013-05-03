function! SendDevtoolsCmd(cmd)
    let l:desc = findfile("DESCRIPTION", ".;")
    if l:desc == ""
        call RWarningMsg("DESCRIPTION file not found.")
        return
    endif

    let l:path = fnamemodify(l:desc, ":h")
    if SendCmdToR("require('devtools'); " . a:cmd . "('" . l:path . "')")
        echo "Found package DESCRIPTION in '" . l:path . "'."
    endif
endfunction

command! RInstallPackage :call SendDevtoolsCmd("install")
command! RLoadPackage :call SendDevtoolsCmd("load_all")
command! RUnloadPackage :call SendDevtoolsCmd("unload")
command! RBuildPackage :call SendDevtoolsCmd("build")
command! RCheckPackage :call SendDevtoolsCmd("check")
command! RTestPackage :call SendDevtoolsCmd("test")
