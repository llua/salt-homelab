if executable('puppet-languageserver') || isdirectory(expand('~/puppet-editor-services'))
  au User lsp_setup call lsp#register_server({
    \ 'name': 'puppet-languageserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'cd ~/puppet-editor-services && bundle exec ./puppet-languageserver --stdio']},
    \ 'allowlist': ['puppet'],
    \ })
endif
