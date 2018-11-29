# vim-devtools-plugin

Extension for the vim plugins [Vim-R-Plugin](https://github.com/jcfaria/Vim-R-plugin) and [Nvim-r](https://github.com/jalvesaq/Nvim-R) to support the [devtools R package](https://github.com/hadley/devtools).

## Installation
Use your favourite bundle manager to install this script, e.g.:
```vim
" Vundle
Plugin 'mllg/vim-devtools-plugin'

" Neobundle with lazy load
NeoBundleLazy 'mllg/vim-devtools-plugin',
    \ {'autoload' : {'filetypes' : ['r','rmd','rnoweb']}}

" dein with lazy load
call dein#add('mllg/vim-devtools-plugin', {'on_ft' : ['r', 'rmd', 'rdoc', 'rnoweb']})

" Vim-Plug with lazy load
Plug 'mllg/vim-devtools-plugin', { 'for': ['r', 'rmd', 'rnoweb']}
```

## Available commands

* `RLoadPackage <dir>`: Runs `devtools::load_all`.
* `RUnloadPackage <dir>`: Runs `devtools::unload`.
* `RBuildPackage <dir>`: Runs `devtools::build`.
* `RCheckPackage <dir>`: Runs `devtools::check`.
* `RTestPackage <dir> <filter>`: Runs `devtools::test` using specified filter (default `''`).
* `RTestFile`: Runs `devtools::test` setting a filter to test the current file.
* `RDocumentPackage <dir>`: Runs `devtools::document`
* `RMakePackage <dir>`: Runs `devtools::document`, then `devtools::install`.
* `RSetupTest <dir>`: Loads "testthat" and invisibly sources all files matching pattern `^helper` in the test directory.
* `RSourceFile <file>`: Sources the given file. If argument <file> is omitted, either the master file (if set, see below) or the current buffer gets sourced.
* `RBuildPackgeTags <dir>`: Builds a tag file for the package and stores it in `g:devtools_rtags_dir` (default is "~/.rtags"). All tag files in this directory will automatically added to &tags for file types `r`, `rnoweb` and `rmd`.
* `RUsage <dir>`: Loads the package and calls `codetools::checkUsagePackage()`. Reported problems are send to the quickfix window.
* `RSetMaster <file>`: Declare <file> the master file. Used in `:RSourceFile`. If <file> is omitted, the current buffer is declared as master. Note that this choice is not persistent between vim sessions.

The DESCRIPTION file is searched in `<dir>` and all its parents.
Default for `<dir>` is the directory of the current buffer.

If you do not want all these commands to be defined, set the option `devtools_commands`:
```vim
let g:devtools_commands = 0
```
