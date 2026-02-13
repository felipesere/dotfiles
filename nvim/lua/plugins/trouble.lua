return {
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR<CR>",
        desc = "Compile errors",
      },
      { "<leader>xX", "<cmd>Trouble diagnostics<CR>", desc = "All diagnostics" },
    },
  },
}
