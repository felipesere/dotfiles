return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = false,
  },
  {
    "algmyr/vcsigns.nvim",
    dependencies = {
      "algmyr/vclib.nvim",
    },
    config = function()
      require("vcsigns").setup({
        target_commit = 0, -- Nice default for jj with new+squash flow.
      })
    end,
  },
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    config = function()
      require("hunk").setup({})
    end,
  },
}
