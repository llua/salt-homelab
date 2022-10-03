setlocal listchars=nbsp:¬,tab:\ \ ,extends:»,precedes:«,trail:•
setlocal noexpandtab
setlocal shiftwidth=0 softtabstop=0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
hi! link goMethodCall goFunction
hi! link goFunctionCall goFunction
