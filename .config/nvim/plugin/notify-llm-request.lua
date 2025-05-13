local handle = nil

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestStarted",
  callback = function()
    if vim.bo.filetype == "codecompanion" then
      return
    end

    local fidget = require("fidget")
    handle = fidget.progress.handle.create({
      title = "LLM Request",
      message = "Thinking...",
      lsp_client = { name = "CodeCompanion" },
    })
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionRequestFinished",
  callback = function()
    if handle then
      handle:finish({ message = "Complete" })
      handle = nil
    end
  end,
})
