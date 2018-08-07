" some of the plugins need python which gets confused in virtualenv
let g:python3_host_prog='/usr/local/bin/python3'

 "Install basic plugins
call plug#begin('~/.config/nvim/plugged')

  Plug 'rakr/vim-one'
  Plug 'chriskempson/base16-vim'
  Plug 'mhartington/oceanic-next'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'plasticboy/vim-markdown', {'for' : 'markdown' }

  Plug 'scrooloose/nerdtree'

  Plug 'ervandew/supertab'

  Plug 'hashivim/vim-terraform'
  Plug 'stephpy/vim-yaml', {'for' : ['yaml', 'yml']}

  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'

  Plug 'alvan/vim-closetag', { 'for' : ['eelixir', 'html'] }

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'rust-lang/rust.vim', {'for' : 'rust' }
  Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
  Plug 'elixir-editors/vim-elixir',  { 'for' : ['elixir', 'eelixir'] }

  Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }
  Plug 'mxw/vim-jsx'
  Plug 'elzr/vim-json'

  Plug 'ElmCast/elm-vim'

  Plug 'w0rp/ale'

  Plug 'sbdchd/neoformat'

  " My own
  Plug 'felipesere/vim-open-readme'
call plug#end()

scriptencoding utf-8
set encoding=utf-8

set hidden                        " for rust racer, for now...
set shell=sh                      " avoid major fuck up with fish shell
syntax on                         " show syntax highlighting
filetype plugin indent on
set backspace=indent,eol,start    " respect backspace
set autoindent                    " set auto indent
set tabstop=2                     " set indent to 2 spaces
set shiftwidth=2
set expandtab                     " use spaces, not tab characters
set number                        " show the absolute number as well
set showmatch                     " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set nofoldenable                  " disable code folding
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set inccommand=nosplit            " don't open a split when search/replace
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set visualbell                    " enable visual bell (disable audio bell)
set scrolloff=5                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
set shortmess+=Ic
set noswapfile
set noshowcmd                    " Don't show the command as it is being typed in the bottom right
set shell=/usr/local/bin/zsh
set foldmethod=indent            " Fold code based on indentation. Maybe switch to 'syntax'?
set foldlevel=20                 " Don't actually fold when opening a file, file by choice :D
set updatetime=250
set list listchars=tab:»\ ,trail:· " change  the way empty trailing whitespace and tabs look
set grepprg=rg\ --vimgrep        " use ripgrep when grepping in vim
set exrc                         " Allow project specif vim configs
set secure                       " Prevent :autocmd, shell and write commands from being run inside project-specific .vimrc files unless they’re owned by you.


"autocmd BufWritePre *.js Neoformat
autocmd BufWritePre *.py Neoformat

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner       = 0
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:jsx_ext_required = 0
let g:vim_json_syntax_conceal = 0

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Maps K to hover, gd to goto definition, F2 to rename
nnoremap <silent> K :call LanguageClient_textDocument_hover()<cr>
autocmd FileType javascript,jsx,rust nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <F6> :call LanguageClient_textDocument_rename()<cr>

set termguicolors
colorscheme one
set background=dark
let g:one_allow_italics=1

let g:airline_theme='one'

call one#highlight('DiffDelete', '', 16, 'none')
call one#highlight('DiffAdd',    '', 16, 'none')
call one#highlight('DiffChange', '', 16, 'none')
call one#highlight('DiffDelete', '', 16, 'none')
call one#highlight('DiffText',   '', 16, 'none')
call one#highlight('DiffAdded',  '', 16, 'none')
call one#highlight('DiffFile',   '', 16, 'none')
call one#highlight('DiffNewFile','', 16, 'none')
call one#highlight('DiffLine',   '', 16, 'none')
call one#highlight('DiffRemoved','', 16, 'none')

set pastetoggle=<F2>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

command! Q execute "qa!"

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen=1

let mapleader = "\<Space>"
let maplocalleader = ";"

map <leader>D :let &background = ( &background == "dark" ? "light" : "dark" )<cr>

map <c-p> :execute 'FZF'<CR>
map <leader>g :execute 'GFiles?'<CR>
map :W :w
map <leader>w :execute 'Windows'<CR>

"  eliminate white spaace
nnoremap <leader>; mz:%s/\s\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>
map <silent> <leader>, :nohl<cr>

nnoremap <silent> <leader>f :NERDTreeToggle<CR>
nnoremap <silent> <leader>F :NERDTreeFind<CR>

" Only use eslint for linting
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \}

" map . in visual mode
vnoremap . :norm.<cr>

" Ale
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

command! -bang -nargs=1 Search
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --fixed-strings '. shellescape(expand('<args>')), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nmap <silent> <Leader>s :execute 'Find'<CR>
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --fixed-strings '. shellescape(expand('<cword>')), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
