function! devtools#SendDevtoolsCmd(cmd, ...)
    let l:desc = findfile("DESCRIPTION", ".;")
    if l:desc == ""
        call RWarningMsg("DESCRIPTION file not found.")
        return
    endif

    let l:path = fnamemodify(l:desc, ":h")
    let l:line = "require(devtools); "

    if a:0 == 0
        if a:cmd == "make"
            let l:line .= "document('" . l:path . "', clean=TRUE); install('" . l:path . "')"
        else
            let l:line .= a:cmd . "('" . l:path . "')"
        endif
    elseif a:0 == 1
        if a:cmd == "test"
            let l:line .= a:cmd . "('" . l:path . "', filter='" . a:1 . "')"
        else
            call RWarningMsg("Incorrect number of arguments")
            return
        endif
    else
        call RWarningMsg("Incorrect number of arguments")
        return
    endif

    if g:SendCmdToR(l:line)
        echo "Using package DESCRIPTION in '" . l:path . "'."
    endif
endfunction
