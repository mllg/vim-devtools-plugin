# vim-devtools-plugin

Extension for [Vim-R-Plugin](https://github.com/jcfaria/Vim-R-plugin) to support the devtools R package.

## Installation
Use your favourite bundle manager to pull in this script.
Here is a [neobundle](https://github.com/Shougo/neobundle.vim) example using lazy load:
``
NeoBundleLazy 'mllg/vim-devtools-plugin', {'autoload':{'filetypes':['r','rmd','rnoweb']}}
``

## Available commands
* `RInstallPackage <dir>`: Runs "devtools::install"
* `RLoadPackage <dir>`: Runs "devtools::load_all"
* `RUnloadPackage <dir>`: Runs "devtools::unload"
* `RBuildPackage <dir>`: Runs "devtools::build"
* `RCheckPackage <dir>`: Runs "devtools::check"
* `RTestPackage <dir> <filter>`: Runs "devtools::test"
* `RDocumentPackage <dir>`: Runs "devtools::document"
* `RMakePackage <dir>`: Runs "devtools::document" and "devtools::install"
* `RSetupTest <dir>`: Loads "testthat" and invisibly sources all files matching pattern `^helper`
  in the test directory.

The DESCRIPTION file is searched in <dir> and all parents.
Default for <dir> is the current working directory.
