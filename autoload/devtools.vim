function! devtools#SendDevtoolsCmd(cmd, ...)
    let l:desc = findfile("DESCRIPTION", ".;")
    if l:desc == ""
        call RWarningMsg("DESCRIPTION file not found.")
        return
    endif
    let l:path = fnamemodify(l:desc, ":h")
    let l:line = "require(devtools)"

    if a:cmd == "make"
        let l:line .= "; devtools::document('" . l:path . "', clean=TRUE)"
        let l:line .= "; devtools::install('" . l:path . "')"
    elseif a:cmd == "test" && a:0 > 0
        let l:line .= "; devtools::" . a:cmd . "('" . l:path . "', filter='" . a:1 . "')"
    else
        let l:line .= "; devtools::" . a:cmd . "('" . l:path . "')"
    endif

    if g:SendCmdToR(l:line)
        echo "Using package DESCRIPTION in '" . l:path . "'."
    endif
endfunction
