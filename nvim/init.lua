-- Install basic plugins
local Plug = vim.fn["plug#"]
vim.call("plug#begin", "~/.config/nvim/plugged")
Plug("shaunsingh/nord.nvim")

Plug("hoob3rt/lualine.nvim")
Plug("alvarosevilla95/luatab.nvim")
Plug("stevearc/dressing.nvim")
Plug("j-hui/fidget.nvim")
Plug("stevearc/aerial.nvim")
Plug("rcarriga/nvim-notify")
Plug("rainbowhxch/beacon.nvim")
Plug("nvim-neo-tree/neo-tree.nvim", { branch = "v2.x" })
Plug("MunifTanjim/nui.nvim")

Plug("christoomey/vim-sort-motion")
Plug("vim-test/vim-test")

Plug("nvim-lua/plenary.nvim")
Plug("s1n7ax/nvim-window-picker")
Plug("nvim-telescope/telescope.nvim")
Plug("xiyaowong/telescope-emoji.nvim")
Plug("nvim-treesitter/nvim-treesitter", {
  ["do"] = ":TSUpdate",
})
Plug("xiyaowong/telescope-emoji.nvim")

Plug("elixir-editors/vim-elixir")

Plug("williamboman/mason.nvim")
Plug("neovim/nvim-lspconfig")
Plug("williamboman/mason-lspconfig.nvim")
Plug("simrat39/rust-tools.nvim")
Plug("SmiteshP/nvim-gps")

Plug("mfussenegger/nvim-dap")
Plug("rcarriga/nvim-dap-ui")
Plug("nvim-telescope/telescope-dap.nvim")

Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")

Plug("airblade/vim-gitgutter")
Plug("rhysd/git-messenger.vim")
Plug("rhysd/conflict-marker.vim")

Plug("sheerun/vim-polyglot")
Plug("RRethy/vim-hexokinase", {
  ["do"] = "make hexokinase",
})
-- My own
Plug("felipesere/vim-open-readme")

-- needs to be last
Plug("kyazdani42/nvim-web-devicons")
vim.call("plug#end")

vim.opt.autoindent = true -- set auto indent
vim.opt.clipboard = "unnamed" -- use the system clipboard
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.encoding = "utf-8" -- ensures the devicons work
vim.opt.expandtab = true -- use spaces, not tab characters
vim.opt.hidden = true -- for rust racer, for now...
vim.opt.ignorecase = true -- ignore case in search when just typing lowercase
vim.opt.mouse = "a"
vim.opt.foldenable = false -- disable code folding
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

vim.g.nord_contrast = true
vim.g.nord_borders = true
require("nord").set()

-- Jump into Git Messanger popup when opening
vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_floating_win_opts = { border = "rounded" }

local nord = require("nord.named_colors")

vim.api.nvim_set_hl(0, "TypeHighlight", { fg = nord.yellow })

vim.api.nvim_set_hl(0, "FloatBorder", { bg = nord.dark_gray, fg = nord.glacier })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = nord.dark_gray })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = nord.dark_gray })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = nord.dark_gray })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = nord.dark_gray, fg = nord.green })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = nord.dark_gray, fg = nord.glacier })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = nord.dark_gray, fg = nord.teal })

vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { fg = nord.yellow })
vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = nord.green })
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = nord.blue })
vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = nord.glacier })

vim.api.nvim_create_user_command("Q", "qa!", { desc = "Quit all" })
vim.notify = require("notify")

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "elixir-ls" }
})

-- Extracted configuration for cmp and lsp intro
-- separate modules as it was getting... hefty
require("custom_cmp_config")
require("custom_lsp")

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local dot = ""
local neotree = require("neo-tree")
neotree.setup({
  close_if_last_window = false,
  enable_modified_markers = false,
  use_popups_for_input = false,
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
    },
  },
})
require("window-picker").setup({
    other_win_hl_color = nord.glacier,
  })

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

require("luatab").setup({
  windowCount = function()
    return ""
  end,
})

require("beacon").setup({})
vim.api.nvim_set_hl(0, "Beacon", {
  bg = nord.yellow,
})

require("nvim-treesitter.configs").setup({
  ignore_install = { "elm" },
  highlight = {
    enable = true,
    disable = { "elm",},
  },
})

require("nvim-web-devicons").setup({
  default = true, -- globally enable default icons (default to false)
})

local gps = require("nvim-gps")
gps.setup()
require("lualine").setup({
  options = {
    theme = "nord",
  },
  sections = {
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      { gps.get_location, cond = gps.is_available },
    },
    lualine_x = { "filetype" },
  },
})

local telescope = require("telescope")
telescope.load_extension("emoji")
local actions = require("telescope.actions")
local telescope = require("telescope")
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
})
telescope.load_extension("emoji")

local opts = function(opts)
  local opts = opts or {}
  local defaults = { noremap = true, silent = true }

  for k, v in pairs(opts) do
    defaults[k] = v
  end
  return defaults
end

vim.keymap.set("n", "<leader>e", ":Telescope emoji<cr>", opts())
vim.keymap.set("n", "<leader>G", ":Telescope git_status<cr>", opts())
vim.keymap.set("n", "<leader>o", ":AerialToggle<cr>", opts())
vim.keymap.set("n", "<leader><leader>", ":Beacon<cr>", opts())
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", function()
  builtin.find_files()
end, opts())
vim.keymap.set("n", "<leader>s", function()
  builtin.grep_string()
end, opts())
vim.keymap.set("n", "<leader>S", function()
  builtin.live_grep()
end, opts())
vim.keymap.set("n", "<leader>e", ":Telescope emoji<cr>", opts())

vim.keymap.set("n", "<leader>l", ":TestLast<cr>", opts({ desc = "Re-run the last test" }))
vim.keymap.set(
  "n",
  "<leader>n",
  ":TestNearest<cr>",
  opts({ desc = "Run the nearest test to the cursor based on context" })
)
vim.keymap.set("n", "<leader>f", ":Neotree focus toggle<cr>", opts({ desc = "Show the current file in the explorer" }))
vim.keymap.set("n", "<leader>F", ":Neotree reveal toggle<cr>", opts({ desc = "Toggle the file explorer" }))

vim.keymap.set("n", "<leader>h", function()
  vim.lsp.buf.hover()
end, opts({ desc = "Show the hover information" }))
vim.keymap.set("n", "j", "gj", opts())
vim.keymap.set("n", "k", "gk", opts())
vim.keymap.set("n", "gj", "j", opts())
vim.keymap.set("n", "gk", "k", opts())

vim.keymap.set("n", "<leader><esc>", function()
  require("notify").dismiss()
end, opts())

--  eliminate white space
vim.keymap.set("n", "<leader>;", "mz:%s/\\s\\+$//<cr>:let @/=''<cr>`z<cr>:w<cr>", opts())
vim.keymap.set("", "<leader>,", ":nohl<cr>", opts())

function reload(package_name)
  require("plenary.reload").reload_module(package_name, true)
end
