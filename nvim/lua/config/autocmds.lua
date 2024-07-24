-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Simple command that runs a script from my dotfiles that toggles the system to Light mode
vim.api.nvim_create_user_command("Light", function()
  os.execute("$HOME/.dotfiles/bin/theme.sh light")
end, { desc = "Change to light mode" })

-- as above, but for dark...
vim.api.nvim_create_user_command("Dark", function()
  os.execute("$HOME/.dotfiles/bin/theme.sh dark")
end, { desc = "Change to Dark mode" })

-- I never rememebr the incantation to format a buffer with jq
vim.api.nvim_create_user_command("JsonFmt", "%!jq '.'", { desc = "Format JSON with jq" })
