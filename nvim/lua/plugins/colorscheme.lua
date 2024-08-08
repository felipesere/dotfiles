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
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
