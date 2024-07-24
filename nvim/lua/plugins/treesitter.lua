return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_decremental = "<A-j>",
        node_incremental = "<A-k>",
        scope_incremental = "<A-l>",
      },
    },
  },
}
