return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_x = { "filetype" },
      },
    },
  },
  {
    "felipesere/darkmode.nvim",
    dependencies = {
      "rktjmp/fwatch.nvim",
    },
    opts = {
      on_dark = function()
        vim.opt.background = "dark"
        vim.cmd.colorscheme("catppuccin-frappe")
      end,
      on_light = function()
        vim.opt.background = "light"
        vim.cmd.colorscheme("rosebones")
      end,
    },
  },
  -- {
  --   "folke/edgy.nvim",
  --   opts = function(_, opts)
  --     table.insert(opts.animate, { enabled = false })
  --   end,
  -- },
}
