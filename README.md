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
* `RDocumentPackage <dir>`: Runs `devtools::document`
* `RMakePackage <dir>`: Runs `devtools::document`, then `devtools::install`.
* `RSetupTest <dir>`: Loads "testthat" and invisibly sources all files matching pattern `^helper` in the test directory.
* `RSourceFile <file>`: Sources the given file. If argument <file> is omitted, either the master file (if set, see below) or the current buffer gets sourced.
* `RBuildPackgeTags <dir>`: Builds a tag file for the package and stores it in `g:devtools_rtags_dir` (default is "~/.rtags"). All tag files in this directory will automatically added to &tags for file types `r`, `rnoweb` and `rmd`.
* `RUsage <dir>`: Loads the package and calls `codetools::checkUsagePackage()`. Reported problems are send to the quickfix window.
* `RSetMaster <file>`: Declare <file> as the master file. Used in `:RSourceFile`. If <file> is omitted, the current buffer is declared as master.
  Note that this choice is not persistent between vim sessions.

The DESCRIPTION file is searched in `<dir>` and all its parents.
Default for `<dir>` is the directory of the current buffer.

The command `RTestFile` has been removed to simplify command completion with the much more frequently used `RTestFile`.
If you liked it, you can restore it by defining the command in your `.vimrc`:
```vim
command! -nargs=0 RTestFile :call devtools#test_file()
```

If you do not want any of these commands to be defined, set the option `devtools_commands`:
```vim
let g:devtools_commands = 0
```


## Support for FZF

If you are a user of [FZF](https://github.com/junegunn/fzf.vim), you can grep your R history file with the following setup:

### Make R history persistent across sessions

Put the following code in your `.Rprofile`, preferably inside the `.First` function:

```r
if (interactive()) {
    history_file = normalizePath("~/.Rhistory", mustWork = FALSE)
    ok = try(utils::loadhistory(history_file))
    if (inherits(ok, "try-error")) {
        message("History could not be loaded: ", history_file)
    } else {
        message("Loaded history: ", history_file)
        .Last <<- function() try(utils::savehistory(history_file))
    }
}
```

### Create new command
```vim
function! s:fzf_r_history()
    let l:history_file = expand('~/.Rhistory')
    call g:devtools#send_cmd('utils::savehistory("' . l:history_file . '")')
    call fzf#run({
                \ 'source': 'cat ' . l:history_file . ' | grep -v "# \\[history skip\\]$" | uniq',
                \ 'sink' :  g:SendCmdToR,
                \ 'options': '--no-sort --tac',
                \ 'down' : '40%' })
endfunction

command! RHistory call s:fzf_r_history()
```
Map to a key as you find appropiate.
