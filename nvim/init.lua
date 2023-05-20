local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "git@github.com:folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
   -- Install basic plugins
   "folke/tokyonight.nvim",

   -- Both needed for zenbones
   "rktjmp/lush.nvim",
   "mcchrish/zenbones.nvim",

   "hoob3rt/lualine.nvim",
   "alvarosevilla95/luatab.nvim",
   "stevearc/dressing.nvim",
   "j-hui/fidget.nvim",
   "rcarriga/nvim-notify",
   { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x" },
   "MunifTanjim/nui.nvim",

   "christoomey/vim-sort-motion",
   "vim-test/vim-test",

   "stevearc/aerial.nvim",

   "nvim-lua/plenary.nvim",
   "s1n7ax/nvim-window-picker",
   {
       "nvim-telescope/telescope.nvim",
       cmd = "Telescope",
       opts = function()
         return require("custom_telescope")
       end,
       dependencies = {
         "xiyaowong/telescope-emoji.nvim",
       },
       config = function(_, opts)
         local telescope = require "telescope"
         telescope.setup(opts)
   
         -- load extensions
         telescope.load_extension("emoji")
       end,
     },
   { "nvim-treesitter/nvim-treesitter", build = function()
       vim.cmd(":TSUpdate")
     end
   },

   "NoahTheDuke/vim-just",
   "williamboman/mason.nvim",
   "neovim/nvim-lspconfig",
   "williamboman/mason-lspconfig.nvim",
   "simrat39/rust-tools.nvim",
   "Saecki/crates.nvim",
   "SmiteshP/nvim-navic",

   "hrsh7th/nvim-cmp",
   "hrsh7th/cmp-nvim-lsp",
   "hrsh7th/cmp-buffer",
   "hrsh7th/cmp-path",
   "hrsh7th/cmp-vsnip",
   "hrsh7th/vim-vsnip",

   "airblade/vim-gitgutter",
   { "f-person/git-blame.nvim", config = function()
      -- Slightly broken until git-blame actually implement a setup function
      vim.g.gitblame_enable = 0
      vim.g.gitblame_date_format = '%r'
      vim.g.gitblame_message_template = ' <author> - <sha> - <date> - <summary>'
      vim.cmd("GitBlameDisable")
      end
   },
   "rhysd/conflict-marker.vim",
   "lukas-reineke/indent-blankline.nvim",

   "sheerun/vim-polyglot",

   -- Watch a file!
   "rktjmp/fwatch.nvim",

   -- My own
   "felipesere/xit.nvim",
   "felipesere/vim-open-readme",

   -- needs to be last
   "kyazdani42/nvim-web-devicons",
})

vim.opt.autoindent = true -- set auto indent
vim.opt.clipboard = "unnamed" -- use the system clipboard
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.encoding = "utf-8" -- ensures the devicons work
vim.opt.expandtab = true -- use spaces, not tab characters
vim.opt.hidden = true -- for rust racer, for now...
vim.opt.ignorecase = true -- ignore case in search when just typing lowercase
vim.opt.mouse = "a"
vim.opt.swapfile = false -- No need for a swap file
vim.opt.number = true -- show the absolute number as well
vim.opt.scrolloff = 15 -- Keep the cursors
vim.opt.shiftwidth = 2 -- when indenting with `>` use two spaces
vim.opt.shortmess:append("Ic") -- `I` don't give an intro when opening vim. `c` don't give messages about completion (n of k matched) etc
vim.opt.showmatch = true -- highlight matching brackes
vim.opt.signcolumn = "yes:1" -- Git and diagnostics use the sign column
vim.opt.smartcase = true -- pay attention to case when mixing
vim.opt.tabstop = 2 -- set indent to 2 spaces
vim.opt.termguicolors = true
vim.opt.updatetime = 250 -- How long to wait after a write before vim triggers plugins
vim.opt.visualbell = true
vim.opt.wildmode = { "list:longest", "full" } -- how the tab-completion menu behaves: show the list, then the longest match, finally all matches

vim.g.mapleader = " "
vim.g.neo_tree_remove_legacy_commands = 1
vim.g.rustfmt_autosave = 1

vim.o.cmdheight = 0

vim.api.nvim_create_augroup("OnlyOnGit", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group   = "OnlyOnGit",
    pattern = { "gitcommit" },
    command = "exec 'norm gg' | startinsert!",
})

require("color_switcher").setup({
    on_dark = function()
      vim.opt.background = "dark"
      vim.cmd.colorscheme 'tokyonight-storm'
      vim.api.nvim_set_hl(0, "TypeHighlight", { fg = '#8a7751' })
      vim.api.nvim_set_hl(0, "MsgArea", { fg = 'white', bg = '#4E5668' })
    end,
    on_light = function()
      vim.opt.background = "light"
      vim.api.nvim_set_hl(0, "TypeHighlight", { fg = '#819B69' })
      vim.api.nvim_set_hl(0, "IndentBlankLineContextChar", { fg = '#9893a5' })
      vim.api.nvim_set_hl(0, "MsgArea", { fg = 'black', bg = '#E2C592' })
      vim.cmd("colorscheme rosebones")
    end,
})

vim.notify = require("notify")

require('crates').setup()
require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "yamlls", "marksman" }
})

-- Extracted configuration for cmp and lsp intro
-- separate modules as it was getting... hefty
require("custom_cmp_config")
require("custom_lsp")


local dot = ""
local neotree = require("neo-tree")
neotree.setup({
  use_popups_for_input = false,
  filesystem = {
    filtered_items = {
      always_show = {
        ".circleci",
        "zzz-felipe",
      }
    }
  },
  default_component_configs = {
    git_status = {
      symbols = {
        added = "",
        deleted = dot,
        modified = dot,
        renamed = "",
        untracked = dot,
        ignored = dot,
        unstaged = "",
        staged = dot,
        conflict = dot,
      },
      align = "right",
    },
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        --auto close
        neotree.close_all()
      end,
    },
  },
  window = {
    mappings = {
      ["o"] = "open",
      ["l"] = false,
    },
  },
})
require("window-picker").setup()
require("fidget").setup()

require("aerial").setup({
  backends = { "treesitter" },
  default_direction = "prefer_right",
})

require("dressing").setup({
  input = {
    insert_only = true,
    max_width = { 150, 0.9 },
    min_width = { 100, 0.2 },
  },
})

require("indent_blankline").setup({
   char = "⁞",
  show_current_context = true,
})

require("luatab").setup({
  windowCount = function()
    return ""
  end,
})

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true
  },
  incremental_selection = {
     enable = true,
     keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_decremental = "<A-j>",
        node_incremental = "<A-k>",
        scope_incremental = "<A-l>",
     },
  },
})

-- requires treesittter, so needs to come after?
require("xit").setup({
      keymaps = {
         ['<C-t>'] = "toggle_checkbox",
         ['<C-S-t>'] = "toggle_checkbox_reverse",
      }
   })

require("nvim-web-devicons").setup({
  default = true, -- globally enable default icons (default to false)
})

local navic = require("nvim-navic")
require("lualine").setup({
  sections = {
    lualine_b = { "branch", "diff", "filename", "diagnostics" },
    lualine_c = {
      {
         function()
            return navic.get_location()
         end,
         cond = function()
            return navic.is_available()
         end
      },
    },
    lualine_x = { "filetype" },
  },
})


local changed_on_branch = function()
    local previewers = require('telescope.previewers')
    local pickers = require('telescope.pickers')
    local sorters = require('telescope.sorters')
    local finders = require('telescope.finders')
    local home = os.getenv( "HOME" )

    local git_branch_modified = home .. '/bin/git-branch-modified.sh'

    pickers.new {
        results_title = 'Modified on current branch',
        finder = finders.new_oneshot_job({ git_branch_modified, 'list'}),
        sorter = sorters.get_fuzzy_file(),
        previewer = previewers.new_termopen_previewer {
            get_command = function(entry)
                return { git_branch_modified, 'diff', entry.value}
            end
        },
    }:find()
end

local opts = function(opts)
  local opts = opts or {}
  local defaults = { noremap = true, silent = true }

  for k, v in pairs(opts) do
    defaults[k] = v
  end
  return defaults
end

vim.api.nvim_create_user_command("Q", "qa!", { desc = "Quit all" })
vim.api.nvim_create_user_command("Light", function() os.execute('$HOME/.dotfiles/bin/theme.sh light') end, { desc = "Change to light mode" })
vim.api.nvim_create_user_command("Dark", function() os.execute('$HOME/.dotfiles/bin/theme.sh dark') end, { desc = "Change to Dark mode" })
vim.keymap.set("n", "<leader>e", ":Telescope emoji<cr>", opts())
vim.keymap.set("n", "<leader>g", ":Telescope git_status<cr>", opts())
vim.keymap.set("n", "<leader>G", changed_on_branch, opts())
vim.keymap.set("n", "<leader>o", ":AerialToggle<cr>", opts())

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, opts())
vim.keymap.set("n", "<leader>s", builtin.grep_string, opts())
vim.keymap.set("n", "<leader>S", builtin.live_grep,  opts())
vim.keymap.set("n", "<leader>e", ":Telescope emoji<cr>", opts())

vim.keymap.set("n", "<leader>f", ":Neotree focus toggle<cr>", opts({ desc = "Show the current file in the explorer" }))
vim.keymap.set("n", "<leader>F", ":Neotree reveal toggle<cr>", opts({ desc = "Toggle the file explorer" }))
vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts({ desc = "Show the hover information" }))

vim.keymap.set("n", "j", "gj", opts())
vim.keymap.set("n", "k", "gk", opts())
vim.keymap.set("n", "gj", "j", opts())
vim.keymap.set("n", "gk", "k", opts())

local notify = require("notify")
vim.keymap.set("n", "<leader><esc>", notify.dismiss, opts())

--  eliminate white space
vim.keymap.set("n", "<leader>;", "mz:%s/\\s\\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>", opts())
vim.keymap.set("", "<leader>,", ":nohl<cr>", opts())
