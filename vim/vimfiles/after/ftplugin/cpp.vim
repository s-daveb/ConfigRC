
if !has('nvim')
source ~/.vim/async-lsp/keymap.vim
endif

source ~/.vim/c.keybindings.vim

set foldlevelstart=5
set foldminlines=24    "  Folds must be > this  size to display as closed

"au BufRead *.cpp,*.h,*.hpp :Vista
