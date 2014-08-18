if exists("g:loaded_vim_devtools_plugin") || &cpo
    finish
endif

let g:loaded_vim_devtools_plugin=1
let s:keepcpo= &cpo
set cpo&vim

command! -nargs=0 RInstallPackage :call devtools#SendDevtoolsCmd("install")
command! -nargs=0 RLoadPackage :call devtools#SendDevtoolsCmd("load_all")
command! -nargs=0 RUnloadPackage :call devtools#SendDevtoolsCmd("unload")
command! -nargs=0 RBuildPackage :call devtools#SendDevtoolsCmd("build")
command! -nargs=0 RCheckPackage :call devtools#SendDevtoolsCmd("check")
command! -nargs=? RTestPackage :call devtools#SendDevtoolsCmd("test", <f-args>)
command! -nargs=0 RDocumentPackage :call devtools#SendDevtoolsCmd("document")
command! -nargs=0 RClean :call devtools#SendDevtoolsCmd("clean_dll")
command! -nargs=0 RMake :call devtools#SendDevtoolsCmd("make")

let &cpo=s:keepcpo
unlet s:keepcpo
