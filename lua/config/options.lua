-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Block cursor in all modes
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:block,r-cr-o:block"

-- General options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 250  -- Increased from 50 to reduce lag
vim.opt.colorcolumn = "120"
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10
vim.opt.lazyredraw = false  -- Faster macro execution
vim.opt.ttyfast = true  -- Faster terminal connection

-- Error handling
vim.opt.errorbells = false
vim.opt.visualbell = false

