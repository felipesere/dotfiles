-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  opts = function(_, opts)
    -- LazyVim binds class motions to [c/]c/[C/]C as *buffer-local* keymaps,
    -- which shadow the global hunk motions from vcsigns (see vcs.lua).
    -- Move the class motions to [k/]k and leave [c/]c for hunks.
    opts.move = opts.move or {}
    opts.move.keys = {
      goto_next_start = { ["]f"] = "@function.outer", ["]k"] = "@class.outer", ["]a"] = "@parameter.inner" },
      goto_next_end = { ["]F"] = "@function.outer", ["]K"] = "@class.outer", ["]A"] = "@parameter.inner" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[k"] = "@class.outer", ["[a"] = "@parameter.inner" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[K"] = "@class.outer", ["[A"] = "@parameter.inner" },
    }
  end,
}
