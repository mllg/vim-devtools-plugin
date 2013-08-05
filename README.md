# vim-devtools-plugin

Extension for [Vim-R-Plugin](https://github.com/jcfaria/Vim-R-plugin) to support the devtools R package.

## Installation
Vim-R-Plugin has the ability to include plugins, but you need to adde these to your .vimrc as described in section 6.27 of the vim-r-plugin docs:

``
 let g:vimrplugin_source = "~/path/to/MyScript.vim,/path/to/AnotherScript.vim"
``

So for example, if you have installed vim-r-plugin with vundle, the line would look like:

``
  let g:vimrplugin_source = "~/.vim/bundle/vim-devtools-plugin/devtools.vim"
``

## Available commands
* RInstallPackage - sends DevtoolsCmd "install"
* RLoadPackage - sends DevtoolsCmd "load_all"
* RUnloadPackage -  sends DevtoolsCmd "unload"
* RBuildPackage - sends DevtoolsCmd "build"
* RCheckPackage - sends DevtoolsCmd "check"
* RTestPackage - sends DevtoolsCmd "test"
* RDocumentPackage - sends DevtoolsCmd "document"
