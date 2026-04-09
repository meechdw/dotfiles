vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
  "https://github.com/coder/claudecode.nvim",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/folke/flash.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/echasnovski/mini.icons",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/stevearc/oil.nvim",
})

local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local plugin_files = vim.fn.readdir(plugins_dir)

for _, file in ipairs(plugin_files) do
  if file:match("%.lua$") then
    local module = file:gsub("%.lua$", "")
    require("plugins." .. module)
  end
end
