
nnoremap <leader>gh :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>

source ~/.vim/vim-asynclsp/keymap.vim

function SetEditorViewOptions()
if (winwidth(0) > 60)	
	TagbarOpen
	"Vexplore
endif
endfunction

autocmd FileType cpp.doxygen call SetEditorViewOptions()
