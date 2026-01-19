return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- dont show the winbar for some filetypes
      opts.options.disabled_filetypes.winbar = { "dashboard", "lazy", "alpha" }
      -- remove navic from the statusline
      -- local navic = table.remove(opts.sections.lualine_c)
      -- add it to the winbar instead
      -- opts.sections = { lualine_b = { navic } }
    end,
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
}
