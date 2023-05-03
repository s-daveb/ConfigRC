set notitle
set nowrap
set ruler
set number

set copyindent
set preserveindent
set noexpandtab
set softtabstop=0
set shiftwidth=4
set tabstop=4

set foldmethod=marker
set foldmarker=#region,#endregion

set colorcolumn=80

" function ResCur - Restore cursor position on file load #region
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END	" #endregion
function! ViewConfig() " #region detects GVIM and handles some things differently
	if has('gui_running')
		if has('macunix')
			set guifont=Iosevka-Fixed:h16
			set macligatures
			set lines=48
		else
 	 	 	set guifont=IosevkaTerm\ Nerd\ Font\ 12
			set lines=24
		endif
		set columns=83
	else " if has('gui_running') == false
		if has("mouse_sgr")
			set ttymouse=sgr
		else
			set ttymouse=xterm2
		end

		au BufWinEnter :silent set title<CR>
	endif
endfunc	" #endregion

function! TransparentTerminalFix()
	hi NonText cterm=bold ctermfg=245 ctermbg=None guibg=NONE
	hi EndOfbuffer cterm=bold ctermfg=245 ctermbg=None guibg=NONE

	" Need these changes to enable terminal transparency in iTerm2 #region
	if exists('+termguicolors')
		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
		let &t_8b = "\<ESC>[48;2;%lu;%lu;%lum"
		set termguicolors
	endif

	hi Normal ctermbg=None guibg=NONE
	"#endregion

	hi clear Comment
	hi Comment term=standout ctermfg=247 ctermbg=228 guifg=#939f91
	"hi Comment term=standout ctermfg=247 ctermbg=228 guifg=#939f91 guibg=#f3efda
	"hi Comment term=bold cterm=italic ctermfg=none gui=italic guifg=#95B6B9
endfunction

function Everforest_config()
	let g:everforest_better_performance = 0
	let g:everforest_background = 'medium'
	let g:everforest_ui_contrast = 'high'
	let g:airline_theme='everforest'

	if !has("gui_running")
		let g:everforest_transparent_background=2
	endif
endfunction

function! ReloadColors()
	call ViewConfig()

	if has("gui_running")
		set background=dark
		colo dracula
	else
		set background=dark
  	if ($TMUX != "" )
			call Everforest_config()
			colo everforest
		else
			colo dracula
			let g:airline_theme='dracula'
		endif
		call TransparentTerminalFix()
	endif
endfunction

call ReloadColors()

nmap <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
nmap <leader>rc :call ReloadColors()<CR>

" #region  SynStack() - Displays the syntax highlighting group under the cursor
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc " #endregion
nmap <leader>sp :call <SID>SynStack()<CR>

" vim: set ts=2 sts=0 sw=2 noet foldmethod=marker foldmarker=#region,#endregion :
