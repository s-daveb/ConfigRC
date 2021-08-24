
let projroot = getcwd()

function! Test()
	save
	cd debug
	make qw-test -j 2 | !./qw-test
	cd ..
endfunction

command! Test :call Test()

"augroup UnitTesting
"	au!
"	autocmd BufWritePost *.cpp,*.hpp Test
"augroup END


function! BuildDebug()
	cd ./debug
	make -j 2 all check
	cd ..
	copen
endfunction

nnoremap <leader>bd :call BuildDebug()<CR>


