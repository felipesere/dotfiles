return {
  {
    { "rktjmp/lush.nvim", lazy = false },
  },
  {
    "zenbones-theme/zenbones.nvim",
    lazy = false,
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "rosebones",
      },
    },
  },
  {
    "catppuccin",
    priority = 1000,
    optional = true,
    opts = function()
      local bufferline = require("catppuccin.groups.integrations.bufferline")
      bufferline.get = bufferline.get or bufferline.get_theme
    end,
  },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
