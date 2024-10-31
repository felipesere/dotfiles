return {
  {
    "epilande/checkbox-cycle.nvim",
    ft = "markdown",
    opts = {
      states = { "[ ]", "[r]", "[/]", "[x]", "[~]", "[?]" },
    },
    keys = {
      {
        "<CR>",
        "<Cmd>CheckboxCycleNext<CR>",
        desc = "Checkbox Next",
        ft = { "markdown" },
        mode = { "n", "v" },
      },
      {
        "<S-CR>",
        "<Cmd>CheckboxCyclePrev<CR>",
        desc = "Checkbox Previous",
        ft = { "markdown" },
        mode = { "n", "v" },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
    opts = {
      checkbox = {
        custom = {
          ["in-progress"] = { raw = "[/]", rendered = "󰿦", highlight = "RenderMarkdownWarn" },
          urgent = { raw = "[!]", rendered = "󰄱", highlight = "RenderMarkdownError" },
          canceled = { raw = "[~]", rendered = "󰂭", highlight = "RenderMarkdownError" },
          todo = { raw = "[-]", rendered = "", highlight = "Comment" },
          forwarded = { raw = "[>]", rendered = "󰒊", highlight = "RenderMarkdownHint" },
          scheduled = { raw = "[<]", rendered = "󰃰", highlight = "RenderMarkdownHint" },
          info = { raw = "[i]", rendered = "󰋼", highlight = "RenderMarkdownInfo" },
          question = { raw = "[?]", rendered = "", highlight = "RenderMarkdownWarn" },
          idea = { raw = "[I]", rendered = "󰛨", highlight = "RenderMarkdownWarn" },
          pros = { raw = "[p]", rendered = "󰔓", highlight = "RenderMarkdownSuccess" },
          cons = { raw = "[c]", rendered = "󰔑", highlight = "RenderMarkdownError" },
          star = { raw = "[s]", rendered = "󰓎", highlight = "RenderMarkdownWarn" },
          f = { raw = "[f]", rendered = "󰈸", highlight = "RenderMarkdownH2" },
          pull_request_ready = { raw = "[r]", rendered = "", highlight = "RenderMarkdownHint" },
        },
      },
    },
  },
}
