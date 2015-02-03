"Features
syntax on           " Syntax Highlighting
set modeline        " :help modeline
set number          " Line Numbers
set tabstop=2       " Tab length (spaces)
set shiftwidth=2    " Forgot tbh
set laststatus=2    " Bottom bar with filename in it
set incsearch       " Incremental Search
set hlsearch        " Highlight strings found in search
set expandtab       " Forgot tbh
set backspace=indent,eol,start
filetype indent on  " Indenting
filetype plugin on
set omnifunc=syntaxcomplete#Complete " <C-x><C-o> for completion

"Color theme
if &term =~ 'xterm\|screen'
color vif-lua
set t_Co=256
endif

" Toggle spelling with the F7 key
nn <F7> :setlocal spell! spelllang=en_us<CR>
imap <F7> <C-o>:setlocal spell! spelllang=en_us<CR>

" c-<arrow> for tmux
map <ESC>[D <C-Left>
map <ESC>[C <C-Right>
map! <ESC>[D <C-Left>
map! <ESC>[C <C-Right>

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

"let g:lua_complete_omni = 1
"let g:lua_define_completefunc = 1

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
