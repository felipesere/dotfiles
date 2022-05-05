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

  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'nvim-telescope/telescope-dap.nvim'

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

lua << END

vim.opt.autoindent = true             -- set auto indent
vim.opt.clipboard = "unnamed"         -- use the system clipboard
vim.opt.completeopt = { "menu", 'menuone', 'noinsert'}
vim.opt.cursorline = true             -- highlight current line
vim.opt.encoding = "utf-8"            -- ensures the devicons work
vim.opt.expandtab = true              -- use spaces, not tab characters
vim.opt.hidden = true                 -- for rust racer, for now...
vim.opt.ignorecase  = true            -- ignore case in search when just typing lowercase
vim.opt.mouse = "a"
vim.opt.foldenable = false            -- disable code folding
vim.opt.swapfile = false              -- No need for a swap file
vim.opt.number = true                 -- show the absolute number as well
vim.opt.scrolloff = 15                -- Keep the cursors
vim.opt.shiftwidth = 2                -- when indenting with `>` use two spaces
vim.opt.shortmess:append("Ic")        -- `I` don't give an intro when opening vim. `c` don't give messages about completion (n of k matched) etc
vim.opt.showmatch = true              -- highlight matching brackes
vim.opt.signcolumn = "yes:1"          -- Git and diagnostics use the sign column
vim.opt.smartcase = true              -- pay attention to case when mixing
vim.opt.tabstop = 2                   -- set indent to 2 spaces
vim.opt.termguicolors = true
vim.opt.updatetime = 250              -- How long to wait after a write before vim triggers plugins
vim.opt.visualbell = true
vim.opt.wildmode = { "list:longest", "full" } -- how the tab-completion menu behaves: show the list, then the longest match, finally all matches

vim.g.mapleader = ' '

vim.g.nord_contract = true
vim.g.nord_borders = true
vim.cmd('colorscheme nord')

-- Jump into Git Messanger popup when opening
vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_floating_win_opts = { border = "single" }

vim.api.nvim_create_user_command('Q', "qa!", { desc = "Quit all" })

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
vim.keymap.set('n', '<leader>o',          '<cmd>:AerialToggle<cr>')

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
vim.keymap.set('n', '<leader><leader>', '<cmd>:Beacon<cr>')
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

local builtin = require("telescope.builtin")
vim.keymap.set("n", '<C-p>',      function() builtin.find_files() end)
vim.keymap.set("n", '<leader>s',  function() builtin.grep_string()end)
vim.keymap.set("n", '<leader>S',  function() builtin.live_grep() end)

vim.keymap.set('n', '<leader>l',  ":TestLast<cr>")
vim.keymap.set('n', '<leader>n',  ":TestNearest<cr>")
vim.keymap.set('n', '<leader>f',  ":NvimTreeToggle<cr>")
vim.keymap.set('n', '<leader>F',  ":NvimTreeFindFile<cr>")
vim.keymap.set('n', '<leader>r',  ":NvimTreeRefresh<cr>")
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'gk', 'k')
vim.keymap.set('n', 'gt', ':BufferLineCycleNext<cr>')
vim.keymap.set('n', 'gT', ':BufferLineCyclePrev<cr>')

--  eliminate white space
vim.keymap.set('n', '<leader>;', "mz:%s/\\s\\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>")
vim.keymap.set('', '<leader>,', ':nohl<cr>')

END
