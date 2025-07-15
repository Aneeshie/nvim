-- Init.lua for Neovim with specified requirements

-- Set leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- Block cursor in all modes
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"

-- Install Packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand to reload Neovim and sync plugins when saving init.lua
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]]

-- Use packer to manage plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer manages itself
  
  -- Theme
  use { 'catppuccin/nvim', as = 'catppuccin' }
  
  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'nvimtools/none-ls.nvim' -- Formatters and linters
  use 'MunifTanjim/prettier.nvim' -- Prettier plugin
  
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  
  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'
  
  -- Emmet
  use 'mattn/emmet-vim'
  
  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  
  -- Comments
  use 'preservim/nerdcommenter'
  
  -- File explorer
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  
  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- Harpoon
  use {
    'ThePrimeagen/harpoon',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  
  -- Indent guides
  use 'lukas-reineke/indent-blankline.nvim'
  
  -- Bufferline
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
  
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Setup Catppuccin theme
require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  show_end_of_buffer = false,
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    treesitter = true,
  },
})

vim.cmd.colorscheme "catppuccin"

-- Treesitter setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "python", "cpp", "c", "javascript", "typescript", "go", "html", "css", "json" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
}

-- LSP setup
local lspconfig = require('lspconfig')

-- Completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- LSP attach function
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  
  -- Key mappings
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
end

-- Language servers
local servers = {
  'pyright',
  'ts_ls',
  'gopls',
  'clangd',
  'lua_ls',
  'html',
  'cssls',
  'jsonls'
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Lua LSP specific setup
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Completion setup
local cmp = require'cmp'
local luasnip = require'luasnip'

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
}

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- None-ls setup for formatting and linting
local none_ls_ok, none_ls = pcall(require, 'none-ls')

if none_ls_ok then
  none_ls.setup({
  sources = {
    -- Formatters
    none_ls.builtins.formatting.prettier.with({
      extra_filetypes = { "html", "css", "javascript", "typescript" }
    }),
    none_ls.builtins.formatting.black,
    none_ls.builtins.formatting.gofmt,
    none_ls.builtins.formatting.clang_format,
    none_ls.builtins.formatting.stylua,
    
    -- Linters
    none_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.yaml")
      end,
    }),
    none_ls.builtins.diagnostics.flake8,
    none_ls.builtins.diagnostics.golangci_lint,
    none_ls.builtins.diagnostics.luacheck.with({
      extra_args = { "--globals", "vim" },
    }),
    none_ls.builtins.diagnostics.cpplint,
    none_ls.builtins.diagnostics.jsonlint,
    none_ls.builtins.diagnostics.markdownlint,
    
    -- Code actions
    none_ls.builtins.code_actions.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.json") or utils.root_has_file(".eslintrc.yaml")
      end,
    }),
  },
  })
end

-- Prettier setup
local prettier_ok, prettier = pcall(require, "prettier")

if prettier_ok then
  prettier.setup({
  bin = 'prettier',
  filetypes = {
    "css",
    "html",
    "javascript",
    "json",
    "markdown",
    "typescript",
  },
  })
end

-- Gitsigns setup
require('gitsigns').setup()

-- Lualine setup
require('lualine').setup {
  options = {
    theme = 'catppuccin'
  }
}

-- Bufferline setup
local bufferline_ok, bufferline = pcall(require, "bufferline")
if bufferline_ok then
  bufferline.setup({
    options = {
      mode = "buffers",
      separator_style = "slant",
      always_show_bufferline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
    }
  })
end

-- Indent blankline setup (version 3)
require("ibl").setup {
  indent = { char = "┊" },
  scope = { enabled = false },
}

-- Nvim-tree setup
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Telescope setup
require('telescope').setup{}

-- Harpoon setup (v1 API)
local harpoon_ok, harpoon = pcall(require, "harpoon")
if harpoon_ok then
  harpoon.setup()
end

-- Emmet setup
vim.g.user_emmet_leader_key = '<C-,>'

-- Key mappings
vim.keymap.set('n', '<leader>cd', function()
  vim.cmd('cd ' .. vim.fn.expand('%:p:h'))
  vim.cmd('NvimTreeToggle')
  vim.cmd('pwd')
end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gs', ':Git<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gc', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>/', '<plug>NERDCommenterToggle', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>/', '<plug>NERDCommenterToggle<CR>gv', { noremap = true, silent = true })

-- Harpoon key mappings (v1 API)
if harpoon_ok then
  vim.keymap.set('n', '<leader>ha', function() require('harpoon.mark').add_file() end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>hh', function() require('harpoon.ui').toggle_quick_menu() end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>h1', function() require('harpoon.ui').nav_file(1) end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>h2', function() require('harpoon.ui').nav_file(2) end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>h3', function() require('harpoon.ui').nav_file(3) end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>h4', function() require('harpoon.ui').nav_file(4) end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>hn', function() require('harpoon.ui').nav_next() end, { noremap = true, silent = true })
  vim.keymap.set('n', '<leader>hp', function() require('harpoon.ui').nav_prev() end, { noremap = true, silent = true })
end

-- Auto-format on save
vim.cmd [[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.js,*.ts,*.html,*.css,*.json Prettier
    autocmd BufWritePost *.py lua vim.lsp.buf.format()
    autocmd BufWritePost *.go lua vim.lsp.buf.format()
    autocmd BufWritePost *.c,*.cpp lua vim.lsp.buf.format()
    autocmd BufWritePost *.lua lua vim.lsp.buf.format()
  augroup END
]]
