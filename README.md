# vim-devtools-plugin

Extension for [Vim-R-Plugin](https://github.com/jcfaria/Vim-R-plugin) to support the devtools R package.

## Installation
Use your favourite bundle manager to pull in this script.
Here is a [neobundle](https://github.com/Shougo/neobundle.vim) example using lazy load:
``
NeoBundleLazy 'mllg/vim-devtools-plugin', {'autoload':{'filetypes':['r','rmd']}}
``

## Available commands
* RInstallPackage: Runs "devtools::install"
* RLoadPackage: Runs "devtools::load_all"
* RUnloadPackage: Runs "devtools::unload"
* RBuildPackage: Runs "devtools::build"
* RCheckPackage: Runs "devtools::check"
* RTestPackage: Runs "devtools::test"
* RDocumentPackage: Runs "devtools::document"
* RMakePackage: Runs "devtools::document" and "devtools::install"

The DESCRIPTION file of the package is searched in the current directory and its parents.
You might want to consider setting `autochdir`.
