return {
  {
    { "rktjmp/lush.nvim", lazy = false },
  },
  {
    "zenbones-theme/zenbones.nvim",
    lazy = false,
    priority = 1001,
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "rosebones",
      },
    },
  },
  {
    "catppuccin",
    lazy = false,
    priority = 1000,
    optional = false,
  },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
