return {
  "saghen/blink.cmp",
  opts = {
    sources = {
      min_keyword_length = 3,
      per_filetype = {
        codecompanion = { "codecompanion" },
      },
      providers = {
        codecompanion = {
          name = "CodeCompanion",
          module = "codecompanion.providers.completion.blink",
          enabled = true,
        },
      },
    },
  },
}
