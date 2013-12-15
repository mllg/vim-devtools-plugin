# vim-devtools-plugin

Extension for [Vim-R-Plugin](https://github.com/jcfaria/Vim-R-plugin) to support the devtools R package.

## Installation
Use your favourite bundle manager to pull in this script.
Here is a [neobundle](https://github.com/Shougo/neobundle.vim) example:
``
NeoBundle 'mllg/vim-devtools-plugin'
``

## Available commands
* RInstallPackage: Issues "devtools::install"
* RLoadPackage: Issues "devtools::load_all"
* RUnloadPackage: Issues "devtools::unload"
* RBuildPackage: Issues "devtools::build"
* RCheckPackage: Issues "devtools::check"
* RTestPackage: Issues "devtools::test"
* RDocumentPackage: Issues "devtools::document"
* RMakePackage: Issues "devtools::document" and "devtools::install"
* RSource: Sources the current file with R's `source` command

The DESCRITION file of the package is searched in the directory and its parents of the current buffer.
