" Tagbar Setup

function MobileTagBar()
  if $CELLPHONETELEPHONE != 1
    TagbarToggle
  endif
endfunction


"au BufWinEnter *.c,*.cpp,*.h,*.hpp, TagbarOpen
"au BufWinEnter * if &previewwindow | resize 5

let g:tagbar_width=15
let g:tagbar_expand=1

source ~/.vim/tagbar.keys.vim
