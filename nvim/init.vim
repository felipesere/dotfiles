" Install basic plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'chriskempson/base16-vim'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'plasticboy/vim-markdown', {'for' : 'markdown' }
  Plug 'mileszs/ack.vim'

  Plug 'scrooloose/nerdtree'

  Plug 'Shougo/deoplete.nvim'
  Plug 'ervandew/supertab'

  Plug 'tpope/vim-endwise'
  Plug 'alvan/vim-closetag', { 'for' : ['eelixir', 'html'] }

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'elixir-editors/vim-elixir',  { 'for' : ['elixir', 'eelixir'] }
  Plug 'slashmili/alchemist.vim', { 'for' : ['elixir', 'eelixir'] }
  Plug 'cespare/vim-toml', { 'for' : 'toml' }

  Plug 'racer-rust/vim-racer', { 'for' : 'rust' }
  Plug 'rust-lang/rust.vim', { 'for' : 'rust' }

  Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }
  Plug 'w0rp/ale'

  Plug 'cakebaker/scss-syntax.vim', { 'for' : ['scss', 'css'] }

  Plug 'ElmCast/elm-vim',  { 'for' : 'elm' }
call plug#end()

scriptencoding utf-8
set encoding=utf-8

set hidden                        " for rust racer, for now...
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
set noshowcmd                    " Don't show the command as it is being typed in the bottom right
set shell=/usr/local/bin/zsh

set foldmethod=indent " Fold code based on indentation. Maybe switch to 'syntax'?
set foldlevel=20      " Don't actually fold when opening a file, file by choice :D

set updatetime=250
set list listchars=tab:»\ ,trail:·

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner       = 0
let g:deoplete#enable_at_startup = 1
let g:ackprg = 'rg --vimgrep --no-heading -i'
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:jsx_ext_required = 0

"set termguicolors
set background=dark
colorscheme base16-default-dark

let g:airline_theme = 'base16'

set pastetoggle=<F2>

noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap H ^
noremap L $

command! Q execute "qa!"

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)

let g:racer_cmd="/Users/felipe/.cargo/bin/racer"
let $RUST_SRC_PATH="/Users/felipe/.cargo/source/rustc-1.11.0/src"
let $CARGO_HOME="/Users/felipe/.cargo"

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:RootIgnoreUseHome = 1

let mapleader = "\<Space>"
let maplocalleader = ";"
map <leader>S :so $MYVIMRC <cr>
map <leader>K :let &background = ( &background == "dark" ? "light" : "dark" )<cr>
map <F10> :let &background = ( &background == "dark" ? "light" : "dark" )<cr>
map <leader>t :Ack "TODO\|FIXME"<cr>

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
map <c-p> :execute 'FZF'<CR>
map <leader>g :execute 'GFiles?'<CR>


"  eliminate white spaace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>
map <silent> <leader>, :nohl<cr>

" unmap F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

let NERDTreeQuitOnOpen=1
nnoremap <silent> <leader>f :NERDTreeToggle<CR>
nnoremap <silent> <leader>F :NERDTreeFind<CR>

" Only use eslint for linting
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

" map . in visual mode
vnoremap . :norm.<cr>

nnoremap <silent> <Leader>h :call fzf#run({
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

nnoremap <silent> <Leader>c :call fzf#run({
      \ 'down': '40%',
      \ 'source': "git diff --name-only HEAD",
      \ 'sink': "e",
      \ })<CR>

" Ale
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

" Alchemist.VIM has its own shortcut for 'go to definition', remap to gd
autocmd FileType elixir nmap <buffer> gd <c-]>

" Open a potential readme if available

function! Maybe_open_README()
  if bufname('%') != ''
    return
  endif

  let maybe_file = expand(globpath('.', 'README*'))
  if filereadable(maybe_file)
    execute 'edit '. s:escape(maybe_file)
    execute 'set ft=markdown'
  endif
endfunction

autocmd VimEnter * :call Maybe_open_README()

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
