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
						set guifont=BerkeleyMono-Regular:h15
						set macligatures
				else
						set guifont=Fira\ Code\ 16
				endif
		else " if has('gui_running') == false
				if has("mouse_sgr")
						set ttymouse=sgr
				else
						set ttymouse=xterm2
				end

				au BufWinEnter :silent set title<CR>

				" #region hard-code some things like background transparency and colorcolums

				" #region enable terminal transparency by disabling background colors.
				if exists('+termguicolors')
				"		let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
				"		let &t_8b = "\<ESC>[48;2;%lu;%lu;%lum"
						set termguicolors
				endif
				" Makes background transparent
				hi Normal ctermbg=None guibg=NONE
				" #endregion

				" #region change how the end of the file is highlighted.
				" Subtly change text width and set a fg color
				"hi NonText cterm=bold ctermfg=245 ctermbg=None guibg=NONE
				"hi EndOfbuffer cterm=bold ctermfg=245 ctermbg=None guibg=NONE
				" #endregion

				" #region remove comment highlight and make text grayzozc
				hi clear Comment
				hi Comment term=standout ctermfg=247 ctermbg=228 guifg=#939f91
				" #endregion

				hi ColorColumn term=reverse ctermbg=6 guibg=#41AC83
				" #endregion
		endif
endfunc	" #endregion

call GuiConfig()

" #region func SynStack() - Displays the syntax highlighting group under the cursor
function! <SID>SynStack()
		if !exists("*synstack")
				return
		endif
		echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc " #endregion
nmap <leader>sp :call <SID>SynStack()<CR>

" vim: set ts=2 sts=0 sw=4 noet foldmethod=marker foldmarker=#region,#endregion :
