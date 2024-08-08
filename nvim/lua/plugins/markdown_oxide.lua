return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "markdown-oxide")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        markdown_oxide = {},
      },
      setup = {
        markdown_oxide = function()
          LazyVim.lsp.on_attach(function(client)
            client.server_capabilities.workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            }
          end, "markdown_oxide")
        end,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, _)
      local cmp = require("cmp")
      cmp.setup.filetype("markdown", {
        sources = {
          {
            name = "nvim_lsp",
            option = {
              markdown_oxide = {
                keyword_pattern = [[\(\k\| \|\/\|#\|\^\)\+]],
              },
            },
          },
        },
      })
    end,
  },
}
