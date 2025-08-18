return {
  {
    "allaman/emoji.nvim",
    dependencies = {
      -- -- util for handling paths
      -- "nvim-lua/plenary.nvim",
      -- -- optional for nvim-cmp integration
      -- "hrsh7th/nvim-cmp",
      -- -- optional for telescope integration
      -- "nvim-telescope/telescope.nvim",
      -- -- optional for fzf-lua integration via vim.ui.select
      "ibhagwan/fzf-lua",
    },
    opts = {
      -- default is false, also needed for blink.cmp integration!
      -- enable_cmp_integration = true,
      -- optional if your plugin installation directory
      -- is not vim.fn.stdpath("data") .. "/lazy/
      -- plugin_path = vim.fn.expand("$HOME/plugins/"),
    },
    config = function(_, opts)
      require("emoji").setup(opts)
      -- optional for telescope integration
      -- local ts = require("telescope").load_extension("emoji")
      -- vim.keymap.set("n", "<leader>se", ts.emoji, { desc = "[S]earch [E]moji" })
    end,
  },
}
