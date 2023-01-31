
" Common config
set nowrap
set ruler
set nu
set colorcolumn=80

set notitle

set noexpandtab
set copyindent
set preserveindent
set softtabstop=0
set shiftwidth=4
set tabstop=4

" Restore cursor position if possible
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END

function! SetColors()
  if has('gui_running')
    if has('mac')
      set guifont=Iosevka-Slaggathor:h14
      set macligatures
      set lines=48
      set columns=83
    else
      set guifont=IosevkaTerm\ Nerd\ Font\ 12

  	  set lines=24
  	  set columns=83
    endif

    "set background=dark
    "let g:everforest_background = 'hard'
    colo brogrammer

  else
    if has("mouse_sgr")
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    end

  "  colo monokai
    set background=light
    let g:everforest_background = 'hard'
    colo everforest

    if exists('+termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<ESC>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif

    hi Normal ctermbg=None guibg=NONE
    "hi NonText cterm=bold ctermfg=245 ctermbg=None guibg=NONE
    hi EndOfbuffer cterm=bold ctermfg=245 ctermbg=None guibg=NONE

  " hi clear Comment
  " hi Comment term=standout ctermfg=Grey ctermbg=236 guifg=#859289 guibg=#323c41
    hi ColorColumn guibg=#4C5558 term=standout
    au BufWinEnter :silent set title<CR>
  endif
endfunc


call SetColors()

"hi Fold ctermbg=DarkGrey ctermfg=White guifg=white guibg=Grey
"hi ColorColumn ctermbg=DarkBlue
"hi lspReference ctermfg=DarkGrey ctermbg=none cterm=underline gui=underline  guifg=Grey
"hi Pmenu guifg=white guibg=#34363A ctermbg=none ctermfg=245 cterm=bold
"hi PmenuSel cterm=bold gui=bold

nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


" vim: set ts=2 sts=2 et sw=2 :
