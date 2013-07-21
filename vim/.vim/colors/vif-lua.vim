set background=dark
highlight clear
if exists("syntax on")
	syntax reset
endif
let g:colors_name="vif-lua"
hi Normal	guifg=#5f8caa	guibg=#1c1c1c	ctermfg=67	ctermbg=234
hi Comment	guifg=#585858	guibg=NONE	ctermfg=240	ctermbg=NONE
hi Constant	guifg=#7e7999	guibg=NONE	ctermfg=146	ctermbg=NONE 
hi BConstant	guifg=#7e7999	guibg=NONE	ctermfg=146	ctermbg=NONE	gui=BOLD	cterm=BOLD
hi String	guifg=#ffffff	guibg=NONE	ctermfg=15	ctermbg=NONE
hi String	guifg=#ffffff	guibg=NONE	ctermfg=15	ctermbg=NONE	gui=BOLD	cterm=BOLD
hi htmlTagName	guifg=#f2b8f2	guibg=NONE	ctermfg=219	ctermbg=NONE
hi Identifier	guifg=#7f95c7	guibg=NONE	ctermfg=103	ctermbg=NONE
hi BIdentifier	guifg=#7f95c7	guibg=NONE	ctermfg=103	ctermbg=NONE	gui=BOLD	cterm=BOLD
hi Statement	guifg=#5f8caa	guibg=NONE	ctermfg=67	ctermbg=NONE
hi BStatement	guifg=#5f8caa	guibg=NONE	ctermfg=67	ctermbg=NONE	gui=BOLD	cterm=BOLD
hi PreProc	guifg=#0affff	guibg=NONE	ctermfg=159	ctermbg=NONE
hi BPreProc	guifg=#0affff	guibg=NONE	ctermfg=159	ctermbg=NONE	gui=BOLD	cterm=BOLD
hi Type		guifg=#f2b8f2	guibg=NONE	ctermfg=219	ctermbg=NONE
hi BType	guifg=#f2b8f2	guibg=NONE	ctermfg=219	ctermbg=NONE	gui=BOLD	cterm=BOLD
hi Function	guifg=#7a7c95	guibg=NONE	ctermfg=97	ctermbg=NONE
hi Repeat	guifg=#f2b8f2	guibg=NONE	ctermfg=219	ctermbg=NONE
hi Operator	guifg=#858585	guibg=NONE	ctermfg=244	ctermbg=NONE
hi Question	guifg=#f2b8f2	guibg=NONE	ctermfg=219	ctermbg=NONE
hi Error	guibg=#ff0000	guifg=#ffffff	ctermfg=15	ctermbg=9
hi TODO		guibg=#0011ff	guifg=#ffffff	ctermfg=15	ctermbg=4
hi LineNr	guifg=#ffffff	guibg=#5f8caa	ctermfg=15	ctermbg=67
hi DiffAdd	guifg=#ffffff	guibg=#5f8caa	ctermfg=15	ctermbg=67
hi DiffChange	guifg=#5f8caa	guibg=#0affff	ctermfg=67	ctermbg=159
hi DiffDelete	guifg=#ffffff	guibg=#ff0000	ctermfg=15	ctermbg=9
hi DiffText	guifg=#ffffff	guibg=#f2b8f2	ctermfg=15	ctermbg=219
hi link character	constant
hi link number		constant
hi link boolean		constant
hi link Float		Number
hi link Conditional	Repeat
hi link Label		Statement
hi link Keyword		Statement
hi link Exception	Statement
hi link Include		PreProc
hi link Define		PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef		Type
hi link htmlTag		Special
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment 	Special
hi link Debug		Special
