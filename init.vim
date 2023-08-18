" Vim settings
set nocompatible

" Use vim-plug for bundle management https://github.com/junegunn/vim-plug

" Automatically install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has('nvim')
  let g:python_host_prog  = '/usr/local/bin/python2'
  let g:python3_host_prog  = '/usr/local/bin/python3'
endif

call plug#begin('~/.vim/bundle')

" Support
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'mtth/scratch.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/matchit.zip'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'docunext/closetag.vim'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-abolish'
"Plug 'ludovicchabant/vim-gutentags'
" TODO: Try to make this work sometime. I got stuck getting relative imports to
" work because vim's working directory != the current file's directory.
"Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

" Display
"Plug 'altercation/vim-colors-solarized'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Ruby
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-scripts/ruby-matchit', { 'for': 'ruby' }

" Javascript
Plug 'flowtype/vim-flow', { 'for': 'javascript' }

" TypeScript
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }

" Python
Plug 'plytophogy/vim-virtualenv', { 'for': 'python' }

" Elm
Plug 'elmcast/elm-vim'

" Reason
Plug 'reasonml-editor/vim-reason-plus'

" Templating, markdown, etc.
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" All of your Plugins must be added before the following line
call plug#end()

let mapleader = ";" " Leader
" Repeat character search forward (we lose repeating the search backward, but
" it's worth it to keep ; as the leader key)
nnoremap , ;

set backspace=2   " Make backspace behave like in other programs
set colorcolumn=80 " Show column at 80
set diffopt+=vertical " Always use vertical diffs
set laststatus=2
set list listchars=tab:»·,trail:·,nbsp:· " Trailing whitespace
set nobackup
set noswapfile
set nowritebackup
set number
set relativenumber
set ruler
set shortmess=atI
set showcmd
set splitbelow
set splitright

" Tab settings
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Persistent undo
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

" Search settings
set incsearch
set hlsearch
set ignorecase
set infercase
set smartcase

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR>

" Move around tabs with Ctrl and g and t
map <C-g> :tabprevious<CR>
map <C-t> :tabnext<CR>
map <leader>x :tabclose<CR>
map <leader>i :tabnew<CR>

" Move around windows with Ctrl and movement keys
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Speedier viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

nmap <leader>hs :let @/=""<CR>
map <leader>n :NERDTreeToggle<CR> " leader-n for NERDTree
nnoremap <leader><leader> <c-^> " Switch between the last two files

" EasyAlign settings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Solarized color scheme
"syntax enable
"set background=dark
"if $SSH_CONNECTION
"  let g:solarized_termcolors=256
"  let g:solarized_termtrans=1
"endif
"colorscheme solarized

" Gruvbox color scheme
set background=dark
colorscheme gruvbox

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor " Use Ag over Grep
  let g:ackprg = 'ag --vimgrep'
endif

" FZF stuff
nnoremap <C-p> :FZF<CR>
nnoremap <C-s> :Ag<CR>
" Disallow Ag from searching for filenames (only file contents)
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
" Tell fzf to ignore things in .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ALE
nnoremap <leader>f :ALEFix<CR>

" Quick write and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

"let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:ale_linters = {
\ 'javascript': ['eslint', 'flow'],
\ 'ruby': ['rubocop', 'reek'],
\ 'python': ['flake8', 'pylint', 'mypy'],
\}
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\ 'typescript': ['prettier'],
\ 'typescriptreact': ['prettier'],
\ 'python': ['black'],
\ 'ruby': ['rubocop'],
\ 'json': ['prettier'],
\ 'css': ['prettier'],
\}
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
let g:ale_lint_delay = 1500

" Airline settings
set guifont=Meslo\ LG\ M\ for\ Powerline
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#enabled = 1     " Show buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Only show buffer file names
let g:airline_section_b = ''
let g:airline_section_y = ''
let g:airline_section_z = ''

" Buffergator settings
let g:buffergator_viewport_split_policy = 'R'

" Gitgutter settings
let g:gitgutter_max_signs = 10000

" ctags
set tags=./tags,tags;$HOME
set wildignore+=*node_modules/**

" Tagbar
nmap <F8> :TagbarToggle<CR>
" make it work with typescript
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:class',
    \ 'n:namespace',
    \ 'f:function',
    \ 'G:generator',
    \ 'v:variable',
    \ 'm:method',
    \ 'p:property',
    \ 'i:interface',
    \ 'g:enum',
    \ 't:type',
    \ 'a:alias',
  \ ],
  \'sro': '.',
    \ 'kind2scope' : {
    \ 'c' : 'class',
    \ 'n' : 'namespace',
    \ 'i' : 'interface',
    \ 'f' : 'function',
    \ 'G' : 'generator',
    \ 'm' : 'method',
    \ 'p' : 'property',
    \},
\ }

" TMP TODO: Remove this if I don't remember what it is
"inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    "\ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    "\ fzf#wrap({'dir': expand('%:p:h')}))
"imap <C-x><C-f> <Plug>RelativelyCompleteFile
"let g:js_file_import_from_root = 0
"autocmd BufEnter * silent! lcd %:p:h
"set autochdir
"set tagrelative
"noremap <expr> <CR> pumvisible() ? '<C-X><C-F>':'<CR>'
"map <CR> <C-X><C-F>
"inoremap <expr> <cr> pumvisible()  ? complete_info()["selected"] != "-1"    ? "<c-y>" : "<c-e><cr>"  : "<cr>"

" Enable mouse interaction for all modes
set mouse=a

" Turn on spell checking for certain files
autocmd Bufread,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell

" Javascript settings
autocmd BufRead,BufNewFile *.es6 setfiletype javascript
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0 " JSX in js files
let g:vim_json_syntax_conceal = 0 " Disable hiding quotes for json
let g:flow#enable = 0 " Disable flow type checking on save
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php, *.jsx"
autocmd FileType javascript map <silent> <leader><space> :FlowType<CR>
autocmd FileType javascript map <silent> gd :FlowJumpToDef<CR>
"autocmd FileType javascript set formatprg=prettier\ --stdin\ --parser\ flow\ --single-quote\ --trailing-comma\ es5

" Elixir settings
autocmd FileType elixir map <silent> <leader><space> :TestFile<CR>

" Python settings
au FileType python setl sw=4 sts=4 et
" NOTE(gnewman): Temporarily disable this until I can figure out how to make
" the VirtualEnvActivate command available in vim.
"autocmd FileType python :VirtualEnvActivate ~/.virtualenvs/djangodev

" Ruby settings
autocmd FileType ruby nmap <leader>h :%s/:\([^=,'"]*\) =>/\1:/gc<CR>

" Markdown settings
let g:vim_markdown_folding_disabled = 1

" --- MAPPED MACROS ---
" You can record a macro and then print it with Ctrl-R Ctrl-R <reg>

" Search highlighted text
vnoremap <leader>s y/"
vnoremap <leader>S y:Ag "
nnoremap <leader>v oconsole.log(<esc>a);<esc>hi

lua require('config/treesitter')
