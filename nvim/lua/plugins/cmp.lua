return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    for _, source in pairs(opts.sources) do
      if source.name == "buffer" then
        -- raise the number of characters that need to have been written
        -- before we start matching on words from the buffer
        source.keyword_length = 3
      end
    end
  end,
}
