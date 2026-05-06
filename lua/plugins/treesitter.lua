local parsers = {
  "c",
  "cpp",
  "lua",
  "vim",
  "vimdoc",
  "query",
  "javascript",
  "typescript",
  "tsx",
  "html",
  "css",
  "json",
  "yaml",
  "toml",
  "rust",
  "go",
  "python",
  "bash",
  "markdown",
  "markdown_inline",
}

local filetypes = {
  "c",
  "cpp",
  "lua",
  "vim",
  "help",
  "vimdoc",
  "query",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "html",
  "css",
  "json",
  "jsonc",
  "yaml",
  "toml",
  "rust",
  "go",
  "python",
  "sh",
  "bash",
  "markdown",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    treesitter.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)

        if ok then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
