"Features
syntax on           " Syntax Highlighting
set number          " Line Numbers
set tabstop=2       " Tab length (spaces)
set shiftwidth=2    " Forgot tbh
set laststatus=2    " Bottom bar with filename in it
set incsearch       " Incremental Search
set hlsearch        " Highlight strings found in search
set expandtab       " Forgot tbh
filetype indent on  " Indenting

"Color theme
color vif-lua
if &term =~ "xterm"
set t_Co=256
endif
if &term =~ "screen"
set t_Co=256
endif

" Toggle spelling with the F7 key
nn <F7> :setlocal spell! spelllang=en_us<CR>
imap <F7> <C-o>:setlocal spell! spelllang=en_us<CR>

" Spelling
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" where it should get the dictionary files
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
"za - toggles
"zc - closes
"zo - opens
"zR - open all
"zM - close all

nnoremap <silent> <C-l> :nohl<CR><C-l>

" jump to the line you was previously at after opening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif
