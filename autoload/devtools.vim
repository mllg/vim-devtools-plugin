function! devtools#find_description(path)
    if len(a:path) == 0
        let l:desc = findfile('DESCRIPTION', '.;')
    else
        let l:desc = findfile('DESCRIPTION', expand(a:path[0]) . ';')
    endif
    if l:desc == ''
        call RWarningMsg('DESCRIPTION file not found.')
        return ""
    endif
    let l:path = fnamemodify(l:desc, ':h')
    echo 'Using package DESCRIPTION in "' . l:path . '".'
    return l:path
endfunction

function! devtools#send_line(line)
    call g:SendCmdToR('library(devtools); ' . a:line)
endfunction

function! devtools#install(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        call devtools#send_line('devtools::install("' . l:desc . '")')
    endif
endfunction

function! devtools#load_all(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        call devtools#send_line('devtools::load_all("' . l:desc . '")')
    endif
endfunction

function! devtools#unload(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        call devtools#send_line('devtools::unload("' . l:desc . '")')
    endif
endfunction

function! devtools#build(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        call devtools#send_line('devtools::build("' . l:desc . '")')
    endif
endfunction

function! devtools#check(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        call devtools#send_line('devtools::check("' . l:desc . '")')
    endif
endfunction

function! devtools#document(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        call devtools#send_line('devtools::document("' . l:desc . '")')
    endif
endfunction

function! devtools#clean_dll(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        call devtools#send_line('devtools::clean_dll("' . l:desc . '")')
    endif
endfunction

function! devtools#test(...)
    if a:0 == 2
        let l:filter = a:2
        let l:desc = devtools#find_description([a:1])
    else
        if a:0 == 1
            let l:filter = a:1
        else
            let l:filter = ''
        endif
        let l:desc = devtools#find_description([])
    endif
    let l:filter = substitute(l:filter, '"', '', 'g')
    if (l:desc != '')
        call devtools#send_line('devtools::test("' . l:desc . '", filter="' . l:filter . '")')
    endif
endfunction

function! devtools#make(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        let l:line  = 'devtools::document("' . l:desc . '")'
        let l:line .= '; devtools::install("' . l:desc . '")'
        call devtools#send_line(l:line)
    endif
endfunction

function! devtools#setup_test(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        let l:line  = 'require(testthat); load_all("' . l:desc . '")'
        let l:line .= '; invisible(lapply(list.files(file.path("' . l:desc . '", "tests", "testthat"),'
        let l:line .= ' pattern="^helper", full.names=TRUE), source, chdir=TRUE, verbose=FALSE))'
        call devtools#send_line(l:line)
    endif
endfunction
