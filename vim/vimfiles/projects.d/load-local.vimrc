
let projroot = getcwd()

" Function to load a vimrc file if it exists
"   credit goes to:
"   https://web.archive.org/web/20210418074034/https://devel.tech/snippets/n/vIIMz8vZ/load-vim-source-files-only-if-they-exist
function! SourceIfExists(file) "{
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }
"

call SourceIfExists(projroot . "/.vim/local.vimrc")
call SourceIfExists(projroot . "/editorconfig/local.vimrc")


" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker={,} :
