return {
  -- Cursor Dark Theme
  {
    "ydkulks/cursor-dark.nvim",
    priority = 1000,
    config = function()
      local transparency = require("config.transparency")

      transparency.setup_autocmd()

      require("cursor-dark").setup({
        style = "dark-midnight", -- Options: "dark", "dark-midnight"
        transparent = false,
      })

      vim.cmd.colorscheme("cursor-dark")
      transparency.load()
      transparency.apply()
    end,
  },
  -- Catppuccin theme (fallback)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 900,
    config = function()
      local transparency = require("config.transparency")

      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          cmp = true,
          gitsigns = true,
          telescope = true,
          which_key = true,
        },
      })
    end,
  },
}
