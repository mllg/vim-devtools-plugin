function! devtools#SendDevtoolsCmd(cmd, ...)
    let l:path = devtools#FindDescription()
    if l:path == ""
        return
    endif

    let l:line = "require(devtools)"
    if a:cmd == "make"
        let l:line .= "; devtools::document('" . l:path . "', clean=TRUE)"
        let l:line .= "; devtools::install('" . l:path . "')"
    elseif a:cmd == "test" && a:0 > 0
        let l:line .= "; devtools::" . a:cmd . "('" . l:path . "', filter='" . a:1 . "')"
    else
        let l:line .= "; devtools::" . a:cmd . "('" . l:path . "')"
    endif
    call g:SendCmdToR(l:line)
endfunction

function! devtools#SetupTest()
    let l:path = devtools#FindDescription()
    if l:path == ""
        return
    endif
    let l:line = "require(devtools); require(testthat); load_all('" . l:path . "'); "
    let l:line .= "lapply(list.files(file.path('" . l:path . "', 'tests', 'testthat'), pattern='^helper', full.names=TRUE), source, chdir=TRUE, verbose=FALSE)"
    call g:SendCmdToR(l:line)
endfunction

function! devtools#FindDescription()
    let l:desc = findfile("DESCRIPTION", ".;")
    if l:desc == ""
        call RWarningMsg("DESCRIPTION file not found.")
        return ""
    endif
    let l:path = fnamemodify(l:desc, ":h")
    echo "Using package DESCRIPTION in '" . l:path . "'."
    return l:path
endfunction
