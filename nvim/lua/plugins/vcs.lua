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
  {
    "rafikdraoui/jj-diffconflicts",
  },
  {
    "0xKitsune/pr.nvim",
    -- or use a local path:
    -- dir = "~/path/to/pr.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("pr").setup()
    end,
  },
}
