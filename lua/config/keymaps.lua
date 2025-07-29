local keymap = vim.keymap

-- File tree toggle
keymap.set("n", "<leader>cd", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in visual mode when indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Better paste
keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Clear search highlighting
keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

-- LSP keymaps (will be set in lsp.lua)
keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Multiline comments
keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
keymap.set("v", "<leader>/", function()
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment" })