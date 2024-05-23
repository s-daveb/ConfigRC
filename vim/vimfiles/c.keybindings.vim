if !has('nvim')
	nnoremap <leader>gh :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
	nnoremap <leader>kf :LspDocumentFormat<CR>
endif
