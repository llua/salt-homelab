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
set laststatus=2    " show statusline
set ruler           " show line & column number in statusline
set incsearch       " Incremental Search
set hlsearch        " Highlight strings found in search
set backspace=indent,eol,start
set list            " visually mark tabs, trailing whitespace and nbsp
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
set wildmenu        " show zsh-like menucompletion in ex command mode
set splitright      " Vertical splitting, creates new window on right side
set splitbelow      " Horizontal splitting, creates new window below
set mouse=          " Disable VISUAL selection when using mouse/touchpad
set path=.,**       " path used by find command to search for files
filetype indent on  " Indenting
filetype plugin on
set omnifunc=syntaxcomplete#Complete " <C-x><C-o> for completion

"Color theme
if &term =~ 'xterm\|screen'
color vif-crepusculo
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

" for https://github.com/vim-python/python-syntax
let g:python_highlight_all = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:ruby_operators = 1
let g:ruby_pseudo_operators = 1
let g:crystal_operators = 1
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

au BufNewFile Gemfile 0r ~/.vim/skel/Gemfile
" jump to the line you was previously at after opening a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
                         \ exe "normal g'\"" | endif

let g:lsp_diagnostics_enabled=0
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
