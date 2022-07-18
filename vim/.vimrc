scriptencoding utf-8
set encoding=utf-8

"Features
syntax on           " Syntax Highlighting
set confirm         " ask to save when quiting a buffer that wasn't saved
set modeline        " :help modeline
set number          " Line Numbers
set expandtab       " Use the appropriate number of spaces to insert a <Tab>
set smarttab        " <Tab> in front of a line inserts blanks according to sw, ts, and sts used elsewhere
set softtabstop=2   " Number of spaces that a <Tab> counts for
set shiftwidth=2    " Number of spaces to use for each step of (auto)indent
set laststatus=2    " Bottom bar with filename in it
set incsearch       " Incremental Search
set hlsearch        " Highlight strings found in search
set backspace=indent,eol,start
set list            " visually mark tabs, trailing whitespace and nbsp
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
set wildmenu        " show zsh-like menucompletion in ex command mode
set splitright      " Vertical splitting, creates new window on right side
set splitbelow      " Horizontal splitting, creates new window below
set mouse=          " Disable VISUAL selection when using mouse/touchpad
filetype indent on  " Indenting
filetype plugin on
set omnifunc=syntaxcomplete#Complete " <C-x><C-o> for completion

"Color theme
if &term =~ 'xterm\|screen'
color vif-lua
set t_Co=256
endif

" save 'with sudo' by using :w!!
cmap w!! w !sudo tee > /dev/null %

" add command to load python skel
command Skelpy 0r ~/.vim/skel/python.py

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

let g:netrw_liststyle = 3

" where it should get the dictionary files
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/vinfo
set runtimepath^=~/.vim/bundle/vim-misc
set runtimepath^=~/.vim/bundle/vim-notes
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

map Y y$
nnoremap <silent> <C-l> :nohl<CR><C-l>

" disablle auto comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

au BufRead,BufNewFile *.sls setfiletype yaml.jinja
au BufRead,BufNewFile *.yml setfiletype yaml.jinja
au BufRead,BufNewFile *.pp  setfiletype puppet
au BufRead,BufNewFile *.jinja setfiletype jinja
au BufRead,BufNewFile *.j2 setfiletype jinja
" the python community prefers 4 spaces indents or tabs
au FileType python setlocal shiftwidth=4 softtabstop=4
" for https://github.com/vim-python/python-syntax
let g:python_highlight_all = 1

au BufNewFile Gemfile 0r ~/.vim/skel/Gemfile
" jump to the line you was previously at after opening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif
