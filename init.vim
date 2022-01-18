" esc in insert mode
inoremap kj <esc>

" keep all swap files in the same folder
" https://webdevetc.com/blog/should-you-disable-vims-swap-files-swp-being-created
set directory^=$HOME/vimswap//

" use system clipboard
set clipboard+=unnamedplus