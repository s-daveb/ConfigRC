
if !has('nvim')
source ~/.vim/async-lsp/keymap.vim
endif

source ~/.vim/c.keybindings.vim

set foldlevelstart=5
set foldminlines=24    "  Folds must be > this  size to display as closed

if executable('cppman')
	autocmd FileType cpp set keywordprg=cppman
endif
"au BufRead *.cpp,*.h,*.hpp :Vista

" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker=@{,@} :
