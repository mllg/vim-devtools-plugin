if exists("g:loaded_VimDevtools") || &cpo
    finish
endif
let g:loaded_VimDevtools=1
let s:keepcpo= &cpo
set cpo&vim

command! RInstallPackage :call devtools#SendDevtoolsCmd("install")
command! RLoadPackage :call devtools#SendDevtoolsCmd("load_all")
command! RUnloadPackage :call devtools#SendDevtoolsCmd("unload")
command! RBuildPackage :call devtools#SendDevtoolsCmd("build")
command! RCheckPackage :call devtools#SendDevtoolsCmd("check")
command! RTestPackage :call devtools#SendDevtoolsCmd("test")
command! RDocumentPackage :call devtools#SendDevtoolsCmd("document")
command! RMake :call devtools#SendDevtoolsCmd("make")
command! RSource :call devtools#SendCmdToR("source('" . expand('%p') . "')")

let &cpo=s:keepcpo
unlet s:keepcpo
