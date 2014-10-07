if exists("g:loaded_vim_devtools_plugin") || &cpo
    finish
endif

let g:loaded_vim_devtools_plugin=1
let s:keepcpo= &cpo
set cpo&vim

command! -complete=dir -nargs=? RInstallPackage :call devtools#install(<f-args>)
command! -complete=dir -nargs=? RLoadPackage :call devtools#load_all(<f-args>)
command! -complete=dir -nargs=? RUnloadPackage :call devtools#unload(<f-args>)
command! -complete=dir -nargs=? RBuildPackage :call devtools#build(<f-args>)
command! -complete=dir -nargs=? RCheckPackage :call devtools#check(<f-args>)
command! -complete=dir -nargs=* RTestPackage :call devtools#test(<f-args>)
command! -complete=dir -nargs=? RDocumentPackage :call devtools#document(<f-args>)
command! -complete=dir -nargs=? RClean :call devtools#clean_dll(<f-args>)
command! -complete=dir -nargs=? RMake :call devtools#make(<f-args>)
command! -complete=dir -nargs=? RSetupTest :call devtools#setup_test(<f-args>)

let &cpo=s:keepcpo
unlet s:keepcpo
