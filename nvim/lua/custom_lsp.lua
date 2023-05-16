local lspconfig = require("lspconfig")
local navic = require("nvim-navic")

local opts = {
  noremap = true,
  silent = true,
}
local on_attach = function(client, bufnr)

  --  Shwo navication
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  tele = require("telescope.builtin")

  -- Only hook these mappings up when there is a LSP client attached
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "?", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>r", tele.lsp_references, opts)
  vim.keymap.set("n", "<leader>d", tele.lsp_document_symbols, opts)
  vim.keymap.set("n", "<leader>q", tele.lsp_workspace_symbols, opts)
  vim.keymap.set("n", "<leader>Q", tele.lsp_dynamic_workspace_symbols, opts)
  vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>j", vim.diagnostic.goto_next, opts)
end

require("rust-tools").setup({
  tools = {
    inlay_hints = {
      other_hints_prefix = "➤ ",
      show_parameter_hints = false,
      highlight = "TypeHighlight",
    },
    hover_actions = {
      auto_focus = true,
    },
  },
  server = {
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
        },
        cargo = {
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
        checkOnSave = {
          extraArgs = {
            "--target-dir",
            "/tmp/rust-analyzer-check",
          },
        },
        diagnostics = {
          enable = true,
          disabled = {
            "unresolved-proc-macro",
          },
        },
      },
    },
  },
})

local lspconfig = require("lspconfig")

lspconfig.marksman.setup({
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

lspconfig.yamlls.setup({
  cmd = { "yaml-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  settings = {
    yaml = {
      keyOrdering = false,
    }
  },
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  signs = true,
  update_in_insert = false,
})
