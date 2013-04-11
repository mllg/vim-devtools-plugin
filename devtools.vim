function! s:SendDevtoolsCmd(cmd)
    let l:desc = findfile("DESCRIPTION", ".;")
    let l:path = fnamemodify(l:desc, ":h")

    if l:desc == ""
        echo "DESCRIPTION file not found"
        return
    endif

    if SendCmdToR("require('devtools'); " . a:cmd . "('" . l:path . "')")
        echo "Found package DESCRIPTION in '" . l:path . "'"
    endif
endfunction

function! RInstallPackage()
    call s:SendDevtoolsCmd("install")
endfunction

function! RLoadPackage()
    call s:SendDevtoolsCmd("load_all")
endfunction

function! RUnloadPackage()
    call s:SendDevtoolsCmd("unload")
endfunction

function! RBuildPackage()
    call s:SendDevtoolsCmd("build")
endfunction

function! RCheckPackage()
    call s:SendDevtoolsCmd("check")
endfunction

function! RTestPackage()
    call s:SendDevtoolsCmd("test")
endfunction
