" Install basic plugins
call plug#begin('~/.config/nvim/plugged')
  " Plug 'shaunsingh/nord.nvim'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'stevearc/dressing.nvim'
  Plug 'j-hui/fidget.nvim'
  Plug 'stevearc/aerial.nvim'
  Plug 'rcarriga/nvim-notify'
  Plug 'rainbowhxch/beacon.nvim'

  Plug 'christoomey/vim-sort-motion'
  Plug 'vim-test/vim-test'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'kyazdani42/nvim-tree.lua'

  Plug 'neovim/nvim-lspconfig'
  Plug 'simrat39/rust-tools.nvim'

  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  Plug 'airblade/vim-gitgutter'
  Plug 'rhysd/git-messenger.vim'

  Plug 'sheerun/vim-polyglot'
  Plug 'towolf/vim-helm'
  Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }

  " My own
  Plug 'felipesere/nord.nvim'
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

let mapleader = "\<Space>"

" Jump into Git Messanger popup when opening
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_floating_win_opts = { 'border': 'single' }

let g:nord_contrast = v:true
let g:nord_borders = v:true

colorscheme nord

command! Q execute "qa!"

" LSP configuration
lua << END
local opts = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap


vim.notify = require("notify")

-- Extracted configuration for cmp and lsp intro
-- separate modules as it was getting... hefty
require("custom_cmp_config")
require("custom_lsp")

require("fidget").setup()

require("aerial").setup({
 backends = { "treesitter" },
 default_direction = "prefer_right",
})
map('n', '<leader>o',          '<cmd>:AerialToggle<cr>', opts)


require('dressing').setup({
  input = {
    insert_only = true,
    max_width = { 150, 0.9 },
    min_width = { 100, 0.2 },
  },
})

require("bufferline").setup({
  options = {
    mode = "tabs",
    numbers = "ordinal",
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
        text = "Directory:",
        highlight = "Directory",
        text_align = "left"
      }
    },
    separator_style = "slant"
  }
})

require('beacon').setup({})
map('n', '<leader><leader>', '<cmd>:Beacon<cr>', opts)
vim.api.nvim_set_hl(0, "Beacon", {bg="#EBCB8B"})

require('nvim-treesitter.configs').setup {
   ignore_install = {
     "elm"
   },
   highlight = {
    enable = true,
    disable = {
      "elm"
    },
   },
}

require('nvim-tree').setup {
  disable_netrw = true,
  open_on_setup = false,
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  filters = {
    custom = { '.git', 'node_modules', '.cache' }
  },
  renderer = {
    indent_markers = {
      enable = true,
    }
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
map('v',  '<leader>s',  "zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>", opts)

map('n',  '<leader>l',  ":TestLast<cr>", opts)
map('n',  '<leader>n',  ":TestNearest<cr>", opts)

map('n', '<leader>f',  ':NvimTreeToggle<cr>', opts)
map('n', '<leader>F',  ':NvimTreeFindFile<cr>', opts)
map('n', '<leader>r',  ':NvimTreeRefresh<cr>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n', 'gj', 'j', opts)
map('n', 'gk', 'k', opts)
map('n', 'gt', ':BufferLineCycleNext<cr>', opts)
map('n', 'gT', ':BufferLineCyclePrev<cr>', opts)

--  eliminate white space
map('n', '<leader>;', "mz:%s/\\s\\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>", opts)

map('', '<leader>,', ':nohl<cr>', opts)

END
