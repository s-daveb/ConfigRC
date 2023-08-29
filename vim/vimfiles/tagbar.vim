" Tagbar Setup

function MobileTagBar()
  if $CELLPHONETELEPHONE != 1
    TagbarToggle
  endif
endfunction


let g:tagbar_width=25
let g:tagbar_expand=2

source ~/.vim/tagbar.keys.vim
