" some of the plugins need python which gets confused in virtualenv
let g:python3_host_prog='/usr/local/bin/python3'

 "Install basic plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'vim-airline/vim-airline'

  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-tree.lua' " replace nerdtree

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
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'pangloss/vim-javascript', {'for' : 'javascript' }
  Plug 'mxw/vim-jsx', { 'for' : 'javascript' }
  Plug 'elzr/vim-json', { 'for' : 'json' }

  Plug 'https://gitlab.com/gi1242/vim-emoji-ab'

  " My own
  Plug 'felipesere/vim-open-readme'

  " needs to be last
  Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

scriptencoding utf-8
set encoding=utf-8                " ensures the devicons work
set hidden                        " for rust racer, for now...
set shell=sh                      " avoid major fuck up with fish shell
syntax on                         " show syntax highlighting
filetype plugin indent on         "
set backspace=indent,eol,start    " respect backspace
set autoindent                    " set auto indent
set tabstop=2                     " set indent to 2 spaces
set shiftwidth=2                  " when indenting with `>` use two spaces
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
set wildmode=list:longest,full    " how the tab-completion menu behaves: show the list, then the longest match, finally all matches
set shortmess+=Ic                 " `I` don't give an intro when opening vim. `c` don't give messages about completion (n of k matched) etc
set noswapfile                    " No need for a swap file
set noshowcmd                     " Don't show the command as it is being typed in the bottom right
set shell=/usr/local/bin/zsh
set foldmethod=indent             " Fold code based on indentation. Maybe switch to 'syntax'?
set foldlevel=20                  " Don't actually fold when opening a file, file by choice :D
set updatetime=250                " How long to wait after a write before vim triggers plugins
set list listchars=tab:»\ ,trail:· " change the way empty trailing whitespace and tabs look
set grepprg=rg\ --vimgrep         " use ripgrep when grepping in vim
set secure                        " Prevent :autocmd, shell and write commands from being run inside project-specific .vimrc files unless they’re owned by you.
set termguicolors

colorscheme nord

let mapleader = "\<Space>"
let maplocalleader = ";"

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner       = 0
let g:SuperTabDefaultCompletionType = "<c-n>"

let g:jsx_ext_required = 0
let g:vim_json_syntax_conceal = 0
let g:neoformat_only_msg_on_error = 1

let g:airline#extensions#branch#enabled = 0

let g:terraform_fmt_on_save=1
let g:terraform_align=1

let g:vim_markdown_conceal_code_blocks = 0

lua << EOF
require('nvim-web-devicons').setup {
 default = true; -- globally enable default icons (default to false)
}

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
     mappings = {
      i = {
        -- I'm just sooo used to using j/k to navigate up and down
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      }
    }
  }
}

vim.api.nvim_command("highlight! link TelescopeSelection Type")
vim.api.nvim_command("highlight! link TelescopeMatching Statement")
EOF

nmap <c-p> :execute 'Telescope find_files'<CR>
nmap <silent> <Leader>s :execute 'Telescope grep_string'<CR>
nmap <silent> <Leader>S :execute 'Telescope live_grep'<CR>

noremap j gj
noremap k gk
noremap gj j
noremap gk k

command! Q execute "qa!"

let g:lua_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:lua_tree_quit_on_open = 1
let g:lua_tree_indent_markers = 1

nnoremap <silent> <leader>f :LuaTreeToggle<CR>
nnoremap <silent> <leader>F :LuaTreeFind<CR>
nnoremap <silent> <leader>r :LuaTreeRefresh<CR>

"  eliminate white space
nnoremap <leader>; mz:%s/\s\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>
map <silent> <leader>, :nohl<cr>

" Ale
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

" map . in visual mode
vnoremap . :norm.<cr>

" Not sure why I need to use guifg. I'd also much rather just do this for Markdown
hi Bold gui=bold guifg=#EBCB8B
hi Comment gui=bold guifg=#bca26f

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> <leader>h call CocAction('doHover')<CR>
