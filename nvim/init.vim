" some of the plugins need python which gets confused in virtualenv
let g:python3_host_prog='/usr/local/bin/python3'

 "Install basic plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'chriskempson/base16-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'preservim/nerdtree'
  Plug 'ervandew/supertab'
  Plug 'airblade/vim-gitgutter'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'w0rp/ale'
  Plug 'sbdchd/neoformat'

  Plug 'hashivim/vim-terraform', {'for' : 'terraform' }
  Plug 'plasticboy/vim-markdown', {'for' : 'markdown' }
  Plug 'stephpy/vim-yaml', {'for' : ['yaml', 'yml']}
  Plug 'rust-lang/rust.vim', {'for' : 'rust' }
  Plug 'elixir-editors/vim-elixir',  {'for' : ['elixir', 'eelixir'] }

  Plug 'pangloss/vim-javascript', {'for' : 'javascript' }
  Plug 'mxw/vim-jsx', { 'for' : 'javascript' }
  Plug 'elzr/vim-json', { 'for' : 'json' }

  Plug 'evanleck/vim-svelte', { 'for' : 'svelte' }
  Plug 'jparise/vim-graphql', { 'for': 'graphql' }

  Plug 'junegunn/goyo.vim'
  Plug 'tpope/vim-fugitive'

  " My own
  Plug 'felipesere/vim-open-readme'
  Plug 'felipesere/search'

  " needs to be last
  Plug 'ryanoasis/vim-devicons'
call plug#end()

scriptencoding utf-8
set encoding=utf-8                " ensures the devicons work
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
set termguicolors

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner       = 0
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:jsx_ext_required = 0
let g:vim_json_syntax_conceal = 0
let g:goyo_width = 160

let g:airline#extensions#branch#enabled = 0

noremap j gj
noremap k gk
noremap gj j
noremap gk k

command! Q execute "qa!"

let NERDTreeMinimalUI  = 1
let NERDTreeDirArrows  = 1
let NERDTreeQuitOnOpen = 1

let NERDTreeMapOpenInTab='<c-t>'

let mapleader = "\<Space>"
let maplocalleader = ";"

map <c-p> :execute 'FZF'<CR>
nmap <silent> <Leader>s :execute 'FindUnderCursor'<CR>
vmap <silent> <Leader>s :call FindText()<CR>

"  eliminate white space
nnoremap <leader>; mz:%s/\s\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>
map <silent> <leader>, :nohl<cr>

nnoremap <silent> <leader>f :NERDTreeToggle<CR>
nnoremap <silent> <leader>F :NERDTreeFind<CR>

" Only use eslint for linting
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'ruby': ['standardrb'],
      \   'elixir': ['credo'],
      \}

" map . in visual mode
vnoremap . :norm.<cr>

" Ale
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)
