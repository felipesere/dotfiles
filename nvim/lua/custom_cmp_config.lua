local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
  },
  view = {
    docs = {
      auto_open = false
    }
  },
  window = {
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ['<C-g>'] = function()
        if cmp.visible_docs() then
          cmp.close_docs()
        else
          cmp.open_docs()
        end
      end
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp", },
    { name = "luasnip" }, -- For luasnip users.
    { name = "path" },
    { name = "buffer" },
  }),
})
