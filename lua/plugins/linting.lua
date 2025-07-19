return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    -- Function to check if a linter is available
    local function linter_exists(name)
      return vim.fn.executable(name) == 1
    end

    -- Only add linters that are actually installed
    local linters_by_ft = {}
    
    if linter_exists("eslint_d") then
      linters_by_ft.javascript = { "eslint_d" }
      linters_by_ft.typescript = { "eslint_d" }
      linters_by_ft.javascriptreact = { "eslint_d" }
      linters_by_ft.typescriptreact = { "eslint_d" }
    end
    
    if linter_exists("pylint") then
      linters_by_ft.python = { "pylint" }
    end
    
    if linter_exists("golangci-lint") then
      linters_by_ft.go = { "golangcilint" }
    end
    
    -- Rust uses built-in cargo check via LSP, so we don't need external linter
    -- C/C++ linting is handled by clangd LSP
    
    lint.linters_by_ft = linters_by_ft

    -- Only create autocmds if we have linters configured
    if next(linters_by_ft) ~= nil then
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          -- Only lint if there are linters for this filetype
          local ft = vim.bo.filetype
          if linters_by_ft[ft] then
            lint.try_lint()
          end
        end,
      })

      vim.keymap.set("n", "<leader>l", function()
        local ft = vim.bo.filetype
        if linters_by_ft[ft] then
          lint.try_lint()
        else
          vim.notify("No linters configured for filetype: " .. ft, vim.log.levels.INFO)
        end
      end, { desc = "Trigger linting for current file" })
    else
      -- If no linters are available, just create a dummy keymap
      vim.keymap.set("n", "<leader>l", function()
        vim.notify("No external linters installed. Using LSP diagnostics only.", vim.log.levels.INFO)
      end, { desc = "Trigger linting for current file" })
    end
  end,
}