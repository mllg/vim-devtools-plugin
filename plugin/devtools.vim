if exists("g:loaded_vim_devtools_plugin") || &cpo
    finish
endif

let g:loaded_vim_devtools_plugin=1
let s:keepcpo=&cpo
set cpo&vim

if !exists('g:devtools_commands') || g:devtools_commands
    command! -complete=dir -nargs=? RInstallPackage :call devtools#simple_cmd('install', <f-args>)
    command! -complete=dir -nargs=? RLoadPackage :call devtools#simple_cmd('load_all', <f-args>)
    command! -complete=dir -nargs=? RUnloadPackage :call devtools#simple_cmd('unload', <f-args>)
    command! -complete=dir -nargs=? RBuildPackage :call devtools#simple_cmd('build', <f-args>)
    command! -complete=dir -nargs=? RCheckPackage :call devtools#simple_cmd('check', <f-args>)
    command! -complete=dir -nargs=? RDocumentPackage :call devtools#simple_cmd('document', <f-args>)
    command! -complete=dir -nargs=? RClean :call devtools#simple_cmd('clean_dll', <f-args>)
    command! -complete=dir -nargs=* RTestPackage :call devtools#test(<f-args>)
    command! -complete=dir -nargs=? RMake :call devtools#make(<f-args>)
    command! -complete=dir -nargs=? RSetupTest :call devtools#setup_test(<f-args>)
    command! -complete=dir -nargs=? RBuildPackageTags :call devtools#build_tags(<f-args>)
    command! -complete=file -nargs=? RSourceFile :call devtools#source_file(<f-args>)
    command! -complete=file -nargs=? RSetMaster :call devtools#set_master(<f-args>)
    command! -complete=file -nargs=? RUsage :call devtools#usage(<f-args>)
endif

let g:devtools_rtags_dir = get(g:, 'devtools_rtags_dir', expand('~/.rtags'))

let &cpo=s:keepcpo
unlet s:keepcpo
