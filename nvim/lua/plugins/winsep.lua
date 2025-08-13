return {
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    opts = {
      indicator_for_2wins = {
        position = "center",
      },
    },
    event = { "WinLeave" },
  },
}
