" Mappings to run current line or selection as ex command
" Selection only works within a line at the moment (as might be expected)
nnoremap <buffer> <LocalLeader>e yyq:p<CR>
vnoremap <buffer> <LocalLeader>e  yq:p<CR>
