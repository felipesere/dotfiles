return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          init_options = {
            formatter = "standard",
            linters = { "standard" },
          },
        },
        -- avoid duplicate diagnostics from the standalone rubocop/standardrb LSPs
        -- that LazyVim's ruby extra can also spin up
        rubocop = { enabled = false },
        standardrb = { enabled = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ruby = { "standardrb" },
      },
    },
  },
}
