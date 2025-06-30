return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fj",
        function()
          require("plugins.extensions.jj-picker").status()
        end,
        mode = { "n" },
        desc = "snacks: jj status",
      },
    },
  },
}
