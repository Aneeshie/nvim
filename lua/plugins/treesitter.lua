return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
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
      },
      sync_install = false,
      highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { 
        enable = true,
        -- Disable for problematic languages, let LSP handle it
        disable = {},
      },
      autopairs = { enable = true },
    })
  end,
}