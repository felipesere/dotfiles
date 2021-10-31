" some of the plugins need python which gets confused in virtualenv
let g:python3_host_prog='/usr/local/bin/python3'

 "Install basic plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'arcticicestudio/nord-vim'
  Plug 'hoob3rt/lualine.nvim'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'kyazdani42/nvim-tree.lua'

  Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --all' }
  Plug 'junegunn/fzf.vim'

  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'nvim-lua/completion-nvim'

  Plug 'ervandew/supertab'
  Plug 'airblade/vim-gitgutter'
  Plug 'rhysd/git-messenger.vim'

  Plug 'sbdchd/neoformat'

  Plug 'hashivim/vim-terraform', {'for' : 'terraform' }

  Plug 'plasticboy/vim-markdown', {'for' : 'markdown' }
  Plug 'stephpy/vim-yaml', {'for' : ['yaml', 'yml']}

  Plug 'rust-lang/rust.vim', {'for' : 'rust' }
  Plug 'cespare/vim-toml', { 'branch': 'main' }

  Plug 'pangloss/vim-javascript', {'for' : 'javascript' }
  Plug 'mxw/vim-jsx', { 'for' : 'javascript' }
  Plug 'elzr/vim-json', { 'for' : 'json' }

  " My own
  Plug 'felipesere/vim-open-readme'
  " Plug 'felipesere/search'

  " needs to be last
  Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

scriptencoding utf-8
set encoding=utf-8                " ensures the devicons work
set hidden                        " for rust racer, for now...
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
set foldmethod=indent             " Fold code based on indentation. Maybe switch to 'syntax'?
set foldlevel=20                  " Don't actually fold when opening a file, file by choice :D
set updatetime=250                " How long to wait after a write before vim triggers plugins
set list listchars=tab:»\ ,trail:· " change the way empty trailing whitespace and tabs look
set grepprg=rg\ --vimgrep         " use ripgrep when grepping in vim
set secure                        " Prevent :autocmd, shell and write commands from being run inside project-specific .vimrc files unless they’re owned by you.
set termguicolors
set completeopt=menuone,noinsert,noselect
syntax on                         " show syntax highlighting
filetype plugin indent on         "

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

" Jump into Git Messanger popup when opening
let g:git_messenger_always_into_popup = v:true

" LSP configuration
lua << END
require('nvim-tree').setup {
  disable_netrw = true,
  open_on_setup = false,
  filters = {
    custom = { '.git', 'node_modules', '.cache' }
  }
}

require('nvim-web-devicons').setup {
 default = true; -- globally enable default icons (default to false)
}

require('lualine').setup({
  options = {
    theme = "oceanicnext",
  },
  sections = {
    lualine_x = { 'filetype' },
  }
})

local opts = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Only hook these mappings up when there is a LSP client attached
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map('n', '<leader>q', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", opts)

  -- Forward to other plugins
  require'completion'.on_attach(client)
end

local servers = { "rust_analyzer", "yamlls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
      },
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = false
        },
        checkOnSave = {
          extraArgs = {
            "--target-dir", "/tmp/rust-analyzer-check"
            }
        }
      }
    }
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

local actions = require "telescope.actions"
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  }
}

map('n',  '<C-p>', "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map('n',  '<leader>s', "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts)
map('n',  '<leader>S', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)

map('n', '<leader>f',  ':NvimTreeToggle<cr>', opts)
map('n', '<leader>F',  ':NvimTreeFind<cr>', opts)
map('n', '<leader>r',  ':NvimTreeRefresh<cr>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', 'gj', 'j', opts)
map('n', 'gk', 'k', opts)

--  eliminate white space
map('n', '<leader>;', "mz:%s/\\s\\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>", opts)


-- for tab completion
map('i', '<C-Space>', '<C-x><C-o>', opts)
map('i', '<C-@>', '<C-x><C-o>', opts)


map('', '<leader>,', ':nohl<cr>', opts)
END

hi TypeHighlight gui=bold guifg=#6F89BC
" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', alinged = true, highlight = "TypeHighlight", enabled = { "TypeHint", "ChainingHint", "ParameterHint"} }

command! Q execute "qa!"

let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_indent_markers = 1

" Not sure why I need to use guifg. I'd also much rather just do this for Markdown
hi Bold gui=bold guifg=#EBCB8B
hi Comment gui=bold guifg=#bca26f
