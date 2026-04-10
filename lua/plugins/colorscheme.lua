return {
  -- Aura theme
  {
    "balion/aura-theme",
    priority = 1000,
    config = function(plugin)
      -- Let the plugin load, then set colorscheme
      vim.opt.termguicolors = true
      -- Aura has variants: aura-dark, aura-dark-soft
      vim.cmd.colorscheme("aura-dark")
    end,
  },
  -- Catppuccin theme (fallback)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 900,
    config = function()
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
