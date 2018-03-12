" Install basic plugins
call plug#begin('~/.config/nvim/plugged')

  Plug 'rakr/vim-one'
  
  Plug 'bling/vim-airline'
  
  Plug 'plasticboy/vim-markdown', {'for' : 'markdown' }
  Plug 'dpelle/vim-LanguageTool', {'for' : 'markdown' }
  
  Plug 'scrooloose/nerdtree'
  
  Plug 'Shougo/deoplete.nvim'
  Plug 'ervandew/supertab'
  
  Plug 'hashivim/vim-terraform'
  
  Plug 'stephpy/vim-yaml', {'for' : ['yaml', 'yml']}
  
  Plug 'tpope/vim-endwise'
  Plug 'alvan/vim-closetag', { 'for' : ['eelixir', 'html'] }
  
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  
  Plug 'rust-lang/rust.vim', {'for' : 'rust' }
  
  Plug 'elixir-editors/vim-elixir',  { 'for' : ['elixir', 'eelixir'] }
  
  Plug 'Chiel92/vim-autoformat'
  
  Plug 'kana/vim-textobj-user'
  Plug 'andyl/vim-textobj-elixir'
  
  Plug 'pangloss/vim-javascript', { 'for' : 'javascript' }
  Plug 'w0rp/ale'
  
  Plug 'cakebaker/scss-syntax.vim', { 'for' : ['scss', 'css'] }
  
  Plug 'ElmCast/elm-vim',  { 'for' : 'elm' }
  
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
set shortmess+=I
set noswapfile
set noshowcmd                    " Don't show the command as it is being typed in the bottom right
set shell=/usr/local/bin/zsh
set foldmethod=indent            " Fold code based on indentation. Maybe switch to 'syntax'?
set foldlevel=20                 " Don't actually fold when opening a file, file by choice :D
set updatetime=250
set list listchars=tab:»\ ,trail:· " change  the way empty trailing whitespace and tabs look
set grepprg=rg\ --vimgrep        " use ripgrep when grepping in vim

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner       = 0
let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:jsx_ext_required = 0
let g:languagetool_jar = '/usr/local/Cellar/languagetool/4.0/libexec/languagetool-commandline.jar'

set termguicolors
colorscheme one
set background=dark
let g:one_allow_italics=1
let g:airline_theme='one'

call one#highlight('DiffDelete', '', 'ffffff', 'none')
call one#highlight('DiffAdd',    '', 'ffffff', 'none')
call one#highlight('DiffChange', '', 'ffffff', 'none')
call one#highlight('DiffDelete', '', 'ffffff', 'none')
call one#highlight('DiffText',   '', 'ffffff', 'none')
call one#highlight('DiffAdded',  '', 'ffffff', 'none')
call one#highlight('DiffFile',   '', 'ffffff', 'none')
call one#highlight('DiffNewFile','', 'ffffff', 'none')
call one#highlight('DiffLine',   '', 'ffffff', 'none')
call one#highlight('DiffRemoved','', 'ffffff', 'none')

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

"  eliminate white spaace
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>
map <silent> <leader>, :nohl<cr>

" unmap F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>

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

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

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
