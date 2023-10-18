
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" @{ - Allow both UltiSnips and LSP to use <tab>. Credit to  Natwar Singh:
" https://github.com/ycm-core/YouCompleteMe/issues/420#issuecomment-28773618
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
"@}

let g:snips_author="Saul D. Beniquez"

" vim: set ts=4 sts=4 noet sw=4 foldmethod=marker foldmarker=@{,@} ::
