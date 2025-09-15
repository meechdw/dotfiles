return {
  {
    "saghen/blink.cmp",
    version = "v0.*",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
      },
      sources = {
        default = { "lsp", "path", "buffer" },
        providers = {
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
          },
        },
      },
      cmdline = { enabled = false },
      signature = { enabled = false },
    },
  },
}
