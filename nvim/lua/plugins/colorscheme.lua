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
  },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
