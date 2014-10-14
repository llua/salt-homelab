set background=dark
highlight clear
if exists("syntax on")
	syntax reset
endif
let g:colors_name="vif-lua-og"
hi Normal guifg=#5f8caa guibg=#1c1c1c
hi Comment	guifg=#585858	guibg=NONE	ctermfg=240	ctermbg=NONE
hi Constant	guifg=#7e7999	guibg=NONE	ctermfg=146 	ctermbg=NONE 
hi String	guifg=#ffffff	guibg=NONE	ctermfg=15	ctermbg=NONE
hi htmlTagName	guifg=#f2b8f2	guibg=NONE	ctermfg=219	ctermbg=NONE
hi Identifier	guifg=#7f95c7	guibg=NONE	ctermfg=103	ctermbg=NONE
hi Statement	guifg=#5f8caa	guibg=NONE	ctermfg=67	ctermbg=NONE
hi PreProc	guifg=#0affff	guibg=NONE	ctermfg=159	ctermbg=NONE
hi Type		guifg=#f2b8f2	guibg=NONE	ctermfg=219	ctermbg=NONE
hi Function	guifg=#7a7c95	guibg=NONE	ctermfg=97	ctermbg=NONE
hi Repeat	guifg=#f2b8f2	guibg=NONE	ctermfg=219	ctermbg=NONE
hi Operator	guifg=#858585	guibg=NONE	ctermfg=244	ctermbg=NONE
hi Error	guibg=#ff0000	guifg=#ffffff	ctermfg=15	ctermbg=9
hi TODO		guibg=#0011ff	guifg=#ffffff	ctermfg=15	ctermbg=4
hi LineNr	guifg=#ffffff	guibg=#5f8caa	ctermfg=15	ctermbg=67
hi link character	constant
hi link number	constant
hi link boolean	constant
hi link Float		Number
hi link Conditional	Repeat
hi link Label		Statement
hi link Keyword	Statement
hi link Exception	Statement
hi link Include	PreProc
hi link Define	PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef	Type
hi link htmlTag	Special
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment Special
hi link Debug		Special
