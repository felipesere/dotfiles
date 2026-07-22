-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local function get_macos_appearance()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  vim.notify(result)
  if result:match("Dark") then
    require("catppuccin")
    vim.cmd.colorscheme("catppuccin-frappe")
  else
    require("zenbones")
    vim.cmd.colorscheme("rosebones")
  end
end

get_macos_appearance()
