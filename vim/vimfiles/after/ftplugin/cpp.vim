
nnoremap <leader>gh :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>

"source ~/.vim/vim-asynclsp/keymap.vim

"autocmd FileType cpp,cpp.doxygen call SetEditorViewOptions()

autocmd FileType c,cpp,cpp.doxygen,c.doxygen TagbarOpen
