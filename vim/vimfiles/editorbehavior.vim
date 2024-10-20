" for sh shell
let g:is_posix=1

set undofile

if has('nvim')
	set directory=$HOME/.cache/nvim/swap/
	set viewdir=$HOME/.cache/nvim/view
	set undodir=$HOME/.cache/nvim/undo/
else
	set directory=$HOME/.cache/vim/swap/
	set viewdir=$HOME/.cache/vim/view
	set undodir=$HOME/.cache/vim/undo/
endif

set undolevels=1000
set undoreload=10000

set modeline

set tagrelative
set tags=./build/tags,./tags;

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %	:  saves and restores the buffer list
"  n... :  where to save the viminfo files
if !has('nvim')
	set viminfo='10,\"100,:20,n~/.viminfo
endif

function! FileOffset()
	echo line2byte(line('.')) + col('.') - 1
endfunction

function! SetFileTitle()
	let &titlestring = expand("%:t")

	if &term =~ "screen"
  		set t_ts=^[k
  		set t_fs=^[\
	endif
	if &term =~ "screen" || &term =~ "xterm"
  		set title
	endif
endfunction
autocmd BufEnter * call SetFileTitle()

set viewoptions-=options
"set splitbelow

syntax on

function! RepeatChar(char, count)
return repeat(a:char, a:count)
endfunction


nnoremap s :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>

function! WriteRandomNum()
 r! dd if=/dev/urandom count=4 bs=1 2> /dev/null | od -D | awk '{ print $2 }'
endfunction

command WriteRandom call WriteRandomNum()
nnoremap <leader>rand :WriteRandom<CR>

" # Function to permanently delete views created by
function! MyDeleteView()
  let path = fnamemodify(bufname('%'),':p')
  " vim's odd =~ escaping for /
  let path = substitute(path, '=', '==', 'g')
  if empty($HOME)
  else
	  let path = substitute(path, '^'.$HOME, '\~', '')
  endif
  let path = substitute(path, '/', '=+', 'g') . '='
  " view directory
  let path = &viewdir.'/'.path
  call delete(path)
  echo "Deleted: ".path
endfunction

" # Command Delview (and it's abbreviation 'delview')
command Delview call MyDeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <CR>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>

com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap <leader>x :FormatXML<CR>

set clipboard=unnamed

set errorbells

map q] :cn<CR>
map q[ :cp<CR>
map q{ :copen<CR>
map q} :cclose<CR>

map l] :ln<CR>
map l[ :lp<CR>
map l{ :lopen<CR>
map l} :lclose<CR>

map <leader>l :redraw!<CR>

"map <ScrollWheelUp> <C-u>
"map <ScrollWheelDown> <C-d>


function! CloseAll()
    " Close all buffers
    exe "%bd"
    lcd $HOME/Developer/
    enew
    exe ":Welcome"
endfunction

command! CloseAll call CloseAll()
command CloseOthers %bd|e#
" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker=@{,@} :
