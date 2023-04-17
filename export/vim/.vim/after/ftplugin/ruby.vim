if executable('solargraph')
  au User lsp_setup call lsp#register_server({
      \ 'name': 'solargraph',
      \ 'cmd': {server_info->['solargraph','stdio']},
      \ 'allowlist': ['ruby'],
      \ })
endif
