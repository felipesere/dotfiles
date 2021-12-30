" some of the plugins need python which gets confused in virtualenv
let g:python3_host_prog='/usr/local/bin/python3'

" Install basic plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'hoob3rt/lualine.nvim'
  Plug 'stevearc/dressing.nvim'

  Plug 'shaunsingh/nord.nvim'

  Plug 'christoomey/vim-sort-motion'
  Plug 'vim-test/vim-test'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'kyazdani42/nvim-tree.lua'

  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/vim-vsnip'

  Plug 'airblade/vim-gitgutter'
  Plug 'rhysd/git-messenger.vim'

  Plug 'sbdchd/neoformat'

  Plug 'sheerun/vim-polyglot'

  " My own
  Plug 'felipesere/vim-open-readme'

  " needs to be last
  Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

set autoindent                    " set auto indent
set clipboard=unnamed             " use the system clipboard
set completeopt=menu,menuone,noinsert
set cursorline                    " highlight current line
set encoding=utf-8                " ensures the devicons work
set expandtab                     " use spaces, not tab characters
set hidden                        " for rust racer, for now...
set ignorecase                    " ignore case in search when just typing lowercase
set mouse=a
set nofoldenable                  " disable code folding
set noswapfile                    " No need for a swap file
set number                        " show the absolute number as well
set scrolloff=15                   " Keep the cursors
set shiftwidth=2                  " when indenting with `>` use two spaces
set shortmess+=Ic                 " `I` don't give an intro when opening vim. `c` don't give messages about completion (n of k matched) etc
set showmatch                     " highlight matching brackes
set signcolumn=yes:1              " Git and diagnostics use the sign column
set smartcase                     " pay attention to case when mixing
set tabstop=2                     " set indent to 2 spaces
set termguicolors
set updatetime=250                " How long to wait after a write before vim triggers plugins
set visualbell
set wildmode=list:longest,full    " how the tab-completion menu behaves: show the list, then the longest match, finally all matches

colorscheme nord

let mapleader = "\<Space>"

" Jump into Git Messanger popup when opening
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_floating_win_opts = { 'border': 'single' }

let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_indent_markers = 1
let g:nord_contrast = v:true

command! Q execute "qa!"

" Not sure why I need to use guifg. I'd also much rather just do this for Markdown
hi Comment gui=bold guifg=#bca26f

hi TypeHighlight gui=bold guifg=#6F89BC
" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require('lsp_extensions').inlay_hints{ prefix = '', alinged = true, highlight = "TypeHighlight", enabled = { "TypeHint", "ChainingHint", "ParameterHint"} }

" LSP configuration
lua << END
require('dressing').setup()

require('nvim-treesitter.configs').setup {
   highlight = {
    enable = true,
   },
}

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
    theme = "nord",
  },
  sections = {
    lualine_b = { 'branch', 'diff', 'diagnostics'},
    lualine_x = { 'filetype' },
  },
  extensions = {
    'nvim-tree',
  }
})



local cmp = require('cmp')
local nvim_lsp = require('lspconfig')

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine. Remove it when possible
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
      ['<CR>'] = cmp.mapping.confirm({ select = true })
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'path' },
    }, {
      { name = 'buffer' },
    }),

    experimental = {
      ghost_text = true,
    },
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local opts = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap


local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Only hook these mappings up when there is a LSP client attached
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  map('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  map('n', '<leader>a', "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  map('n', '<leader>d', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
  map('n', '<leader>q', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", opts)
  map('n', '<leader>k', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
  map('n', '<leader>j', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
end

nvim_lsp["rust_analyzer"].setup {
  capabilities = capabilities, -- Hooked up to nvim-cmp
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
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
      },
      diagnostics = {
        enable = true,
        disabled = {"unresolved-proc-macro"},
      }
    }
  }
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    update_in_insert = false,
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

map('n',  '<C-p>',      "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map('n',  '<leader>s',  "<cmd>lua require('telescope.builtin').grep_string()<cr>", opts)
map('n',  '<leader>S',  "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)

map('n', '<leader>f',  ':NvimTreeToggle<cr>', opts)
map('n', '<leader>F',  ':NvimTreeFindFile<cr>', opts)
map('n', '<leader>r',  ':NvimTreeRefresh<cr>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', 'gj', 'j', opts)
map('n', 'gk', 'k', opts)

--  eliminate white space
map('n', '<leader>;', "mz:%s/\\s\\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>", opts)

map('', '<leader>,', ':nohl<cr>', opts)

END

