local opts = {noremap = true, silent = true}
local map = vim.api.nvim_set_keymap

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  INLAY_HINTS = {
  	set = function()
      local lsp_extensions = require('lsp_extensions');
      lsp_extensions.inlay_hints { prefix = '', alinged = true, highlight = "TypeHighlight", enabled = { "TypeHint", "ChainingHint", "ParameterHint"} };
    end;
  }

  local autocmds = {
    highlighting = {
      {"CursorMoved",  "*", "lua INLAY_HINTS.set()" },
      {"InsertLeave",  "*", "lua INLAY_HINTS.set()" },
      {"BufEnter",     "*", "lua INLAY_HINTS.set()" },
      {"BufWinEnter",  "*", "lua INLAY_HINTS.set()" },
      {"TabEnter",     "*", "lua INLAY_HINTS.set()" },
      {"BufWritePost", "*", "lua INLAY_HINTS.set()" },
    },
  }
  require('nvim_utils')
  nvim_create_augroups(autocmds)

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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
  map('n', '<leader>k',   '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  map('n', '<leader>j',   '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
end


-- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#2e3440 ]]
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=#ebcb8b guibg=#2e3440 ]]

local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')
nvim_lsp["rust_analyzer"].setup {
  handlers = handlers,
  capabilities = capabilities, -- Hooked up to nvim-cmp
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
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
nvim_lsp["tsserver"].setup {
  handlers = handlers,
  capabilities = capabilities, -- Hooked up to nvim-cmp
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({

        })
        ts_utils.setup_client(client)

        -- Attach generic macps, then apply ours
        on_attach(client, bufnr)

        map("n", "<leader>O", ":TSLspOrganize<CR>", opts)
        map("n", "<leader>rn", ":TSLspRenameFile<CR>", opts)
        map("n", "<leader>i", ":TSLspImportAll<CR>", opts)
  end,
  flags = {
    debounce_text_changes = 150,
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    update_in_insert = false,
  }
)
