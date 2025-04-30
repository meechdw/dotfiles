return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    opts = {
      keymap = { preset = "super-tab" },
      sources = {
        default = { "lsp", "path", "buffer", "avante_commands", "avante_mentions", "avante_files" },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
          },
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,
          },
          avante_files = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 100,
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,
          },
        },
      },
      cmdline = {
        enabled = false,
      },
      signature = { enabled = true },
    },
  },
  {
    "saghen/blink.compat",
    lazy = true,
    config = function()
      require("cmp").ConfirmBehavior = {
        Insert = "insert",
        Replace = "replace",
      }
    end,
  },
}
