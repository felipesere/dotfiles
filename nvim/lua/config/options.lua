-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- TODO:giganting workaround for an issue running `:Inspect`
vim.hl = vim.highlight

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
vim.opt.splitright = true -- when opening vertical splits, open them to the _right_ of the current bufffer
vim.opt.wrap = true -- soft-wrapping because I hate scrolling to the right

-- Switching off some of LazyVims defaults
vim.opt.relativenumber = false

-- Until I have my color switcher working!
-- vim.opt.background = "light"
