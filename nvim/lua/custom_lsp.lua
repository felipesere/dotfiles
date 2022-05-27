local kind_icons = require("icons")

local opts = {
  noremap = true,
  silent = true,
}
local map = vim.api.nvim_set_keymap

local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
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

local dap, dapui = require("dap"), require("dapui")
dapui.setup({})
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, opts)
vim.keymap.set("n", "<leader>c", dap.continue, opts)
vim.keymap.set("n", "<leader>dso", dap.step_over, opts)
vim.keymap.set("n", "<leader>dsi", dap.step_into, opts)

-- configure the adapter for Rust Debugging
dap.configurations.rust = {
  {
    name = "Launch Debug",
    type = "rt_lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/" .. "")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    initCommand = {},
    runInTerminal = false,
  },
}

local extension_path = vim.env.HOME .. "/bin/extension"
local codelldb_path = extension_path .. "/adapter/codelldb"
local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"
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
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()), -- Hooked up to nvim-cmp
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importGranularity = "module",
        },
        cargo = {
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = false,
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
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  signs = true,
  update_in_insert = false,
})
