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
function! GuiConfig() " #region detects GVIM and handles some things differently
	if has('gui_running')
		if has('macunix')
			set guifont=Iosevka-Fixed:h16
			set macligatures
			set lines=48
		else
			set guifont=Fira\ Code\ 16
			set lines=24
		endif
		set columns=83

	else
		if has("mouse_sgr")
			set ttymouse=sgr
		else
			set ttymouse=xterm2
		end

		au BufWinEnter :silent set ti
		"hi NonText cterm=bold ctermfg=245 ctermbg=None guibg=NONE
		hi EndOfbuffer cterm=bold ctermfg=245 ctermbg=None guibg=NONE
	"
		" Need these changes to enable terminal transparency in iTerm2 #region
		if exists('+termguicolors')
			let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
			let &t_8b = "\<ESC>[48;2;%lu;%lu;%lum"
			set termguicolors
		endif

		hi Normal ctermbg=None guibg=NONE
		"#endregion

		hi clear Comment

	endif

	set background=light
	colo everforest

endfunc	" #endregion

call GuiConfig()


" Displays the syntax highlighting group under the cursor
function! <SID>SynStack()  " #region
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc " #endregion
nmap <leader>sp :call <SID>SynStack()<CR>

" vim: set ts=2 sts=0 sw=4 noet foldmethod=marker foldmarker=#region,#endregion :
