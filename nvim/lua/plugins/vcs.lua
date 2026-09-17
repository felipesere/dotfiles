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
      local function map(mode, lhs, rhs, desc, opts)
        local options = { noremap = true, silent = true, desc = desc }
        if opts then
          options = vim.tbl_extend("force", options, opts)
        end
        vim.keymap.set(mode, lhs, rhs, options)
      end

      map("n", "[c", function()
        require("vcsigns.actions").hunk_prev(0, vim.v.count1)
      end, "Go to previous hunk")
      map("n", "]c", function()
        require("vcsigns.actions").hunk_next(0, vim.v.count1)
      end, "Go to next hunk")
      map("n", "[C", function()
        require("vcsigns.actions").hunk_prev(0, 9999)
      end, "Go to first hunk")
      map("n", "]C", function()
        require("vcsigns.actions").hunk_next(0, 9999)
      end, "Go to last hunk")
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
