return {
  "saghen/blink.cmp",
  version = "v0.*",
  opts = {
    keymap = { preset = "super-tab" },
    sources = {
      default = { "lsp", "path", "buffer" },
      providers = {
        markdown = {
          name = "RenderMarkdown",
          module = "render-markdown.integ.blink",
        },
      },
    },
    cmdline = {
      enabled = false,
    },
    signature = { enabled = true },
  },
}
