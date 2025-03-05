local hostname = vim.fn.hostname()

local is_personal_laptop = hostname == "Felipes-MacBook-Pro.local"

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          show_defaults = false,
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:op item get qchhxk7vdhyczgss2dx7vqhthm --reveal --fields label=credential"
                  or "ANTHROPIC_API_KEY",
              },
            })
          end,
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "claude-3.7-sonnet",
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = is_personal_laptop and "anthropic" or "copilot",
            slash_commands = {
              ["file"] = {
                opts = {
                  provider = "telescop",
                },
              },
            },
          },
          agent = {
            adapter = is_personal_laptop and "anthropic" or "copilot",
          },
          inline = {
            adapter = is_personal_laptop and "anthropic" or "copilot",
          },
        },
      })
    end,
  },
}
