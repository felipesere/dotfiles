return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = { enabled = false }, -- don't show jump labels during / search
        char = { enabled = false }, -- don't hijack f/F/t/T
      },
    },
    keys = {
      -- only bind treesitter selection, nothing else
      {
        "<c-space>",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter({
            actions = {
              ["<c-space>"] = "next",
              ["<bs>"] = "prev",
            },
          })
        end,
        desc = "Treesitter selection",
      },
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "x", "o" }, false },
    },
  },
}
