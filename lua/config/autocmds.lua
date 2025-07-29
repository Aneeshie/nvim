-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e",
})

-- Auto format on save for supported languages (excluding JS/TS which are handled by conform.nvim)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rs", "*.go", "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
