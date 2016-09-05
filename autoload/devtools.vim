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
    let l:path = fnamemodify(l:desc, ':p:h')
    echo 'Using package DESCRIPTION in "' . l:path . '".'
    return l:path
endfunction


function! devtools#send_line(line)
    call g:SendCmdToR('requireNamespace("devtools"); ' . a:line)
endfunction


function devtools#simple_cmd(cmd, ...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        call devtools#send_line('devtools::' . a:cmd . '("' . l:desc . '")')
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
        let l:line  = 'library("testthat"); devtools::load_all("' . l:desc . '")'
        let l:line .= '; invisible(lapply(list.files(file.path("' . l:desc . '", "tests", "testthat"),'
        let l:line .= ' pattern="^helper", full.names=TRUE), source, chdir=TRUE, verbose=FALSE))'
        call devtools#send_line(l:line)
    endif
endfunction


function! devtools#build_tags(...)
    let l:rtags = fnamemodify(g:devtools_rtags_dir, ':p')
    if !isdirectory(l:rtags)
        call mkdir(l:rtags)
    endif
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        let l:src = fnamemodify(l:desc . '/R', ':p')
        let l:line  = printf('.etagsfile = tempfile(); utils::rtags(path="%s", ofile= .etagsfile)', l:src)
        let l:line .= printf('; etags2ctags(.etagsfile, file.path("%s", sprintf("%%s.ctags", devtools::as.package("%s")$package)))', l:rtags, l:desc)
        let l:line .= '; rm(list = ".etagsfile")'
        call devtools#send_line(l:line)
        call devtools#use_r_tags()
    endif
endfunction

function! devtools#source_file(...)
    if a:0 == 0
        if exists("s:devtools_master_file")
            let l:file = s:devtools_master_file
        else
            let l:file = expand('%:p')
        endif
    else
        let l:file = a:1
    endif
    call g:SendCmdToR(printf('source("%s")', l:file))
endfunction


function devtools#usage(...)
    let l:desc = devtools#find_description(a:000)
    if (l:desc != '')
        let l:tmp = tempname()
        let l:line  = 'devtools::load_all("' . l:desc . '")'
        let l:line .= '; local({ tmp = capture.output(codetools::checkUsagePackage(devtools::as.package("' . l:desc . '")$package)); writeLines(tmp, "' . l:tmp . '")})'
        call devtools#send_line(l:line)
        setlocal efm+=%m\ (%f:%l%.%#)

        let l:i = 0
        while l:i < 50
            sleep 100m
            if filereadable(l:tmp) == 1
                sleep 50m
                execute ":cfile " . l:tmp
                call delete(l:tmp)
                return
            endif
            let l:i += 1
        endwhile
        echo "Timeout reached."
    endif
endfunction

function! devtools#set_master(...)
    if a:0 == 0
        let s:devtools_master_file = expand('%:p')
    else
        let s:devtools_master_file = a:1
    endif
endfunction

function! devtools#use_r_tags()
    let l:rtags = fnamemodify(g:devtools_rtags_dir, ':p')
    if isdirectory(l:rtags)
        let l:tags = extend(split(&tags, ','), split(glob(l:rtags. '*.ctags'), '\n'))
        let &l:tags = join(filter(l:tags, 'count(l:tags, v:val) == 1'), ',')
    endif
endfunction
