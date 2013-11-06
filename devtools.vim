function! SendDevtoolsCmd(cmd)
    let l:desc = findfile("DESCRIPTION", ".;")
    if l:desc == ""
        call RWarningMsg("DESCRIPTION file not found.")
        return
    endif

    let l:path = fnamemodify(l:desc, ":h")
    let l:line = "require(devtools); "

    if a:cmd == "make"
        let l:line .= "document('" . l:path . "', clean=TRUE); install('" . l:path . "')"
    else
        let l:line .= a:cmd . "('" . l:path . "')"
    endif

    if g:SendCmdToR(l:line)
        echo "Using package DESCRIPTION in '" . l:path . "'."
    endif
endfunction

command! RInstallPackage :call SendDevtoolsCmd("install")
command! RLoadPackage :call SendDevtoolsCmd("load_all")
command! RUnloadPackage :call SendDevtoolsCmd("unload")
command! RBuildPackage :call SendDevtoolsCmd("build")
command! RCheckPackage :call SendDevtoolsCmd("check")
command! RTestPackage :call SendDevtoolsCmd("test")
command! RDocumentPackage :call SendDevtoolsCmd("document")
command! RMake :call SendDevtoolsCmd("make")
command! RSource :call SendCmdToR("source('" . expand('%p') . "')")
