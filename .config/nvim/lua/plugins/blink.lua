return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    opts = {
      keymap = { preset = "super-tab" },
      sources = {
        default = { "lsp", "path", "buffer" },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
          },
        },
      },
      cmdline = { enabled = false },
      signature = { enabled = true },
    },
  },
}
