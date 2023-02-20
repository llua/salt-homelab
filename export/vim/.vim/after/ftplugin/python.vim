" the python community prefers 4 spaces indents or tabs
setlocal shiftwidth=4 softtabstop=4 expandtab
setlocal autoindent smartindent
setlocal wildignore=*/__pycache__/*,*.pyc
setlocal include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>
setlocal includeexpr=PyInclude(v:fname)

function! PyInclude(fname)
  let parts = split(a:fname, ' import ')
  let l = parts[0]
  if len(parts) > 1
    let r = parts[1]
    let joined = join([l, r], '.')
    let fp = substitute(joined, '\.', '/', 'g') . '.py'
    let found = glob(fp, 1)
    if len(found)
      return found
    endif
  endif
  return substitute(l, '\.', '/', 'g') . '.py'
endfunction

if executable('pylsp')
  " pip install python-lsp-server
  au User lsp_setup call lsp#register_server({
      \ 'name': 'pylsp',
      \ 'cmd': {server_info->['pylsp']},
      \ 'allowlist': ['python'],
      \ })
endif
