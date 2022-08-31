local kind_icons = require("icons")

local lspkind_comparator = function(conf)
  local lsp_types = require("cmp.types").lsp
  return function(entry1, entry2)
    if entry1.source.name ~= "nvim_lsp" then
      if entry2.source.name == "nvim_lsp" then
        return false
      else
        return nil
      end
    end
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end

local cmp = require("cmp")
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine. Remove it when possible
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.confirm({
      select = true,
    }),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
    }),
  }),

  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
      keyword_length = 3,
    },
    {
      name = "path",
    },
    {
      name = "buffer",
      keyword_length = 5,
    },
  }),

  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      local icon = kind_icons[vim_item.kind] or " "
      vim_item.kind = string.format("%s %s", icon, vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        path = "[Path]",
        nvim_lsp = "[LSP]",
      })[entry.source.name]
      return vim_item
    end,
  },

  sorting = {
    comparators = {
      lspkind_comparator({
        kind_priority = {
          Field = 11,
          Property = 11,
          Constant = 10,
          Enum = 10,
          EnumMember = 10,
          Function = 10,
          Method = 10,
          Struct = 10,
          Variable = 9,
          File = 8,
          Folder = 8,
          Class = 5,
          Module = 5,
          Keyword = 2,
          Interface = 1,
          Value = 1,
        },
      }),
      label_comparator,
    },
  },

  experimental = {
    ghost_text = true,
  },
})
