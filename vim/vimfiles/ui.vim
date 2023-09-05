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

if has("mouse_sgr")
	set ttymouse=sgr
else
	set ttymouse=xterm2
endif

if has('gui_running') == 0
	au BufWinEnter :silent set title<CR>
endif

" function ResCur - Restore cursor position on file load #region
function! RestoreCursor()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup restoreCursor
	autocmd!
	autocmd BufWinEnter * call RestoreCursor()
augroup END	" #endregion

function! FontConfig() " for gvim
	if has('gui_running')
		if has('macunix')
			set guifont=BerkeleyMono-Regular:h15
			set macligatures
			set lines=48
		else
 	 	 	set guifont=BerkeleyMono Regular\ 14
			set lines=24
		endif
		set columns=83
	endif
endfunc	" #endregion

call FontConfig()

function! TransparentTerminalFix()
	if !has("gui_running")
		hi NonText cterm=bold ctermfg=245 ctermbg=None guibg=NONE
		hi EndOfbuffer cterm=bold ctermfg=245 ctermbg=None guibg=NONE

		" Need these changes to enable terminal transparency in iTerm2 #region
		if exists('+termguicolors')
			let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
			"let &t_8b = "\<ESC>[48;2;%lu;%lu;%lum"
			set termguicolors
		endif

		"hi Normal ctermbg=None guibg=NONE
		"#endregion

		hi clear Comment
		hi Comment term=standout ctermfg=247 ctermbg=228 guifg=#939f91
		"hi Comment term=standout ctermfg=247 ctermbg=228 guifg=#939f91 guibg=#f3efda
		"hi Comment term=bold cterm=italic ctermfg=none gui=italic guifg=#95B6B9
	endif
endfunction

function! ReloadColors()
	if exists("g:loaded_auto_light_dark") && (g:loaded_auto_light_dark == 1)
		call DesiredInterfaceMode()
	else
		if has("gui_running")
			set background=dark
			colo dracula
		else
			set background=dark
  		if ($TMUX != "" )
					let g:everforest_transparent_background=2
					let g:everforest_better_performance = 0
					let g:everforest_background = 'medium'
					let g:everforest_transparent_background=1
					let g:everforest_ui_contrast = 'high'
					colo everforest
			else
				colo dracula
			endif
			call TransparentTerminalFix()
		endif
	endif
endfunction

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
