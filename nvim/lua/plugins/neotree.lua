return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          always_show = {
            ".circleci",
            "zzz-felipe",
          },
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            --auto close
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
      window = {
        mappings = {
          ["o"] = "open",
          ["l"] = false,
        },
      },
    },
  },
}
