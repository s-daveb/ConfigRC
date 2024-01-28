
nnoremap <leader>gh :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>

source ~/.vim/async-lsp/keymap.vim

"autocmd FileType cpp,cpp.doxygen call SetEditorViewOptions()

autocmd BufEnter *.h,*.hpp,*.cpp,*.hpp call SetTagbarWidth()
