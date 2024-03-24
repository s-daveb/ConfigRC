set notitle
set nowrap
set ruler
set number

set copyindent
set preserveindent
set noexpandtab
set softtabstop=0
set shiftwidth=8
set tabstop=8

set foldmethod=marker
set foldmarker=@{,@}

set colorcolumn=80

" function ResCur - Restore cursor position on file load @{
function! ResCur()
		if line("'\"") <= line("$")
				normal! g`"
				return 1
		endif
endfunction

augroup resCur
		autocmd!
		autocmd BufReadPost * call ResCur()
augroup END	" @}
" @{ function SynStack: Syntax Highlighting debugging function
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
map <leader>synstack<CR> :call SynStack()<CR>
" @}

function ColorAdjust() " @{ hard-code some things like background transparency and colorcolums

		if exists('+termguicolors')
				let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
				let &t_8b = "\<ESC>[48;2;%lu;%lu;%lum"
				set termguicolors
		endif

		if !has("gui_running")
				let &t_ZH="\e[3m"
				let &t_ZR="\e[23m"
		endif
"
"		" @{ Makes background transparent
"		" Not needed  with everforest
		hi Normal ctermbg=None guibg=NONE
"		" @}
"		" @{ change how the end of the file is highlighted.
		" Subtly change text width and set a fg color
		hi NonText cterm=bold ctermfg=245 ctermbg=None guibg=NONE
		hi EndOfbuffer cterm=bold ctermfg=245 ctermbg=None guibg=NONE
""		" @}
""		" @{ remove comment highlight and make text gray
		hi clear Comment
		hi clear SpecialComment
"		"hi Comment term=standout ctermfg=247 ctermbg=228 guifg=#939f91
		hi Comment term=bold ctermfg=247 ctermbg=228 gui=italic guifg=#939f91
		hi SpecialComment term=italic ctermfg=247 ctermbg=228 gui=italic guifg=#939f91
"		"@}
"		"@{ More obvious vertical splits
		hi clear VertSplit
		hi VertSplit term=bold cterm=italic ctermfg=247 gui=italic guifg=#939f91
		" @}

		hi ColorColumn term=reverse ctermbg=6 guibg=#41AC83

		hi Folded cterm=italic
		highlight lspInlayHintsType term=bold cterm=italic ctermfg=245 gui=italic guifg=#859289

	highlight link lspInlayHintsParameter lspInlayHintsType

endfunction " @}
function! GuiConfig() " @{ detects GVIM and handles some things differently
		if has('gui_running')
				if has('macunix')
						set guifont=BerkeleyMono-Regular:h14
						set macligatures
				else
						set guifont=Fira\ Code\ 14
				endif
		else " if has('gui_running') == false
				if has("mouse_sgr")
						set ttymouse=sgr
				else
						set ttymouse=xterm2
				endif

				au BufWinEnter :silent set title<CR>
				call ColorAdjust()
		endif
endfunc	" @}


" @{ func SynStack() - Displays the syntax highlighting group under the cursor
function! <SID>SynStack()
		if !exists("*synstack")
				return
		endif
		echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc " @}
nmap <leader>sp :call <SID>SynStack()<CR>


" vim: set ts=2 sts=0 sw=4 noet foldmethod=marker foldmarker=@{,@} :
