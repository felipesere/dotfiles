local kind_icons = require("icons");

local opts = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap

local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  tele = require('telescope.builtin')

  -- Only hook these mappings up when there is a LSP client attached
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', 'gd',          '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  map('n', 'gi',          '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  map('n', '?',           '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  map('n', '<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  map('n', '<leader>a',   "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  map('n', '<leader>r',   "<cmd>lua tele.lsp_references()<cr>", opts)
  map('n', '<leader>d',   "<cmd>lua tele.lsp_document_symbols()<cr>", opts)
  map('n', '<leader>q',   "<cmd>lua tele.lsp_workspace_symbols()<cr>", opts)
  map('n', '<leader>Q',   "<cmd>lua tele.lsp_dynamic_workspace_symbols()<cr>", opts)
  map('n', '<leader>k',   '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  map('n', '<leader>j',   '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
end

vim.api.nvim_set_hl(0, "TypeHighlight", {fg="#B48EAD"})

require('rust-tools').setup({
  tools = {
    inlay_hints = {
      other_hints_prefix = "➤ ",
      show_parameter_hints = false,
      highlight = "TypeHighlight",
    }
  },
  server = {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()), -- Hooked up to nvim-cmp
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
        },
        cargo = {
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = false
        },
        checkOnSave = {
          extraArgs = {
            "--target-dir", "/tmp/rust-analyzer-check"
          }
        },
        diagnostics = {
          enable = true,
          disabled = {"unresolved-proc-macro"},
        }
      }
    }
  }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    update_in_insert = false,
  }
)
