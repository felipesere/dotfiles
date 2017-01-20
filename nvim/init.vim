" Install basic plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'chriskempson/base16-vim'
  Plug 'altercation/vim-colors-solarized'

  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'

  Plug 'Shougo/deoplete.nvim'
  Plug 'ervandew/supertab'
  Plug 'sjl/gundo.vim'

  Plug 'tpope/vim-endwise'
  Plug 'albfan/nerdtree-git-plugin'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'kana/vim-textobj-user'

  Plug 'bkad/vim-terraform',      { 'for' :  'terraform' }
  Plug 'elixir-lang/vim-elixir',  { 'for' : ['elixir', 'eelixir'] }
  Plug 'slashmili/alchemist.vim', { 'for' : ['elixir', 'eelixir'] }
  Plug 'cespare/vim-toml', { 'for' : 'toml' }

  Plug 'racer-rust/vim-racer'
  Plug 'rust-lang/rust.vim'

  Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }
  Plug 'Shutnik/jshint2.vim', { 'for' : 'javascript' }
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'sorin-ionescu/vim-htmlvalidator'
  Plug 'alvan/vim-closetag'

  Plug 'ElmCast/elm-vim',  { 'for' : 'elm' }
  Plug 'airblade/vim-gitgutter'
call plug#end()

scriptencoding utf-8
set encoding=utf-8

set hidden  " for rust racer, for now...
set shell=sh                      " avoid major fuck up with fish shell
syntax on                         " show syntax highlighting
filetype plugin indent on
set backspace=indent,eol,start    " respect backspace
set autoindent                    " set auto indent
set ts=2                          " set indent to 2 spaces
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
set mouse=                        " enable mouse support
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set scrolloff=5                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
set shortmess+=I
set noswapfile

set foldmethod=indent " Fold code based on indentation. Maybe switch to 'syntax'?
set foldlevel=20      " Don't actually fold when opening a file, file by choice :D

set updatetime=250

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner       = 0
let g:deoplete#enable_at_startup = 1

let g:SuperTabDefaultCompletionType = "<c-n>"

let g:over_enable_auto_nohlsearch = 1

set background=dark
colorscheme solarized

let g:airline_theme = 'solarized'
let g:rainbow#blacklist = [233, 234]

set pastetoggle=<F2>

noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap H ^
noremap L $

command Q execute "qa!"

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = ''

let g:racer_cmd="/Users/felipe/.cargo/bin/racer"
let $RUST_SRC_PATH="/Users/felipe/.cargo/source/rustc-1.11.0/src"
let $CARGO_HOME="/Users/felipe/.cargo"

let g:RootIgnoreUseHome = 1

let mapleader = "\<Space>"
map <leader>S :so $MYVIMRC <cr>
map <Leader>K :let &background = ( &background == "dark" ? "light" : "dark" )<cr>

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
map <c-p> :execute 'FZF'<CR>

"  eliminate white spaace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>
map <silent> <leader>, :nohl<cr>

" unmap F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

nnoremap <silent> <leader>f :NERDTreeToggle<CR>
nnoremap <silent> <leader>F :NERDTreeFind<CR>

" HTML
au FileType html compiler html
au QuickFixCmdPost make cwindow

" map . in visual mode
vnoremap . :norm.<cr>

nnoremap <silent> <Leader>g :call fzf#run({
      \ 'down': '40%',
      \ 'source': "git grep " . expand("<cword>"),
      \ 'sink': function("Extract_from_grep"),
      \ })<CR>

nnoremap <silent> <Leader>G :call fzf#run({
      \ 'down': '40%',
      \ 'source': "git grep -l " . expand("<cword>"),
      \ 'sink': "e",
      \ })<CR>

function! s:escape(path)
  return substitute(a:path, ' ', '\\ ', 'g')
endfunction

function! Extract_from_grep(line)
  let parts = split(a:line, ':')
  let [fn, lno] = parts[0 : 1]
  execute 'e '. s:escape(fn)
  execute lno
  normal! zz
endfunction

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

nnoremap <silent> <leader>s :Find<cr>
