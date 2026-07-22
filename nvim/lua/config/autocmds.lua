-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- I never rememebr the incantation to format a buffer with jq
vim.api.nvim_create_user_command("JsonFmt", "%!jq '.'", { desc = "Format JSON with jq" })

-- Remove all trailing whitespace by pressing F5
vim.api.nvim_create_user_command("Trim", [[%s/\s\+$//e]], { desc = "Trim trailing whitespace" })

-- Disable spell-check in
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "txt" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

local function apply_theme()
  if vim.o.background == "light" then
    require("zenbones")
    vim.cmd.colorscheme("rosebones")
  else
    require("catppuccin")
    vim.cmd.colorscheme("catppuccin-frappe")
  end
end

-- run every time the appreach changes
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = apply_theme,
})

-- run once at startup, since OptionSet won't fire for the initial/unchanged value
vim.api.nvim_create_autocmd("VimEnter", {
  callback = apply_theme,
})
