setlocal listchars=nbsp:¬,tab:\ \ ,extends:»,precedes:«,trail:•
setlocal noexpandtab
setlocal shiftwidth=2 softtabstop=2 tabstop=2
hi! link goMethodCall goFunction
hi! link goFunctionCall goFunction
autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'go-lang',
    \ 'cmd': {server_info->['gopls']},
    \ 'whitelist': ['go'],
    \ })
