# My Neovim Configuration

A modern, streamlined Neovim 0.12+ configuration focused on development productivity with excellent native LSP support, fuzzy finding, and fluid file management.

## ✨ Features

- **🎨 Beautiful UI**: Cursor Dark with a clean, distraction-free aesthetic and persistent transparency toggle
- **📁 File Management**: Edit your filesystem like a standard Neovim buffer using `oil.nvim`
- **🧠 Smart LSP**: Native Language Server Protocol support with native inlay hints and auto-completion
- **🔍 Fuzzy Finding**: Telescope with FZF integration for blazing fast file navigation
- **🎯 Quick Navigation**: Harpoon for lightning-fast file switching
- **🎭 Syntax Highlighting**: Treesitter for advanced syntax parsing
- **🔧 Code Quality**: Integrated linting and formatting
- **⚡ Performance**: Lazy loading with `lazy.nvim`, taking full advantage of modern Neovim default options without legacy bloat

## 📦 Included Language Servers

- **Lua** (`lua_ls`) - Neovim configuration and Lua development
- **Rust** (`rust_analyzer`) - Full Rust support with Clippy integration
- **Go** (`gopls`) - Complete Go development environment
- **TypeScript/JavaScript** (`ts_ls`) - Modern web development
- **C/C++** (`clangd`) - System programming with advanced features

## 🎛️ Key Bindings

### Leader Key
- **Leader**: `<Space>`
- **Local Leader**: `\`

### File Navigation
| Binding | Action |
|---------|--------|
| `-` | Open parent directory (`oil.nvim`) |
| `<leader>cd` | Open file tree (`oil.nvim`) |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Find buffers (Telescope) |
| `<leader>fr` | Recent files (Telescope) |

### Harpoon (Quick File Switching)
| Binding | Action |
|---------|--------|
| `<leader>a` | Add current file to Harpoon |
| `<Ctrl-e>` | Toggle Harpoon quick menu |
| `<Ctrl-h>` | Jump to Harpoon file 1 |
| `<Ctrl-t>` | Jump to Harpoon file 2 |

### LSP & Code Navigation
| Binding | Action |
|---------|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>e` | Show line diagnostics |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Code Editing
| Binding | Action |
|---------|--------|
| `gcc` (normal) | Toggle comment |
| `gc` (visual) | Toggle block comment |
| `<leader>h` | Clear search highlighting |
| `<leader>ut` | Toggle transparent background |
| `J` (visual) | Move selection down |
| `K` (visual) | Move selection up |
| `p` (visual) | Paste without yanking |

### Window Navigation
| Binding | Action |
|---------|--------|
| `<Ctrl-h>` | Go to left window |
| `<Ctrl-j>` | Go to lower window |
| `<Ctrl-k>` | Go to upper window |
| `<Ctrl-l>` | Go to right window |

### Auto-completion
| Binding | Action |
|---------|--------|
| `<Ctrl-p>` | Previous completion item |
| `<Ctrl-n>` | Next completion item |
| `<Ctrl-y>` | Confirm completion |
| `<Ctrl-Space>` | Trigger completion |

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point and lazy.nvim bootstrap
├── lazy-lock.json             # Plugin version lockfile
└── lua/
    ├── config/
    │   ├── autocmds.lua       # Auto-commands
    │   ├── keymaps.lua        # Key mappings
    │   ├── options.lua        # Vim options and settings
    │   └── transparency.lua   # Persistent transparency state
    └── plugins/
        ├── colorscheme.lua    # Theme configuration (Cursor Dark, Catppuccin)
        ├── completion.lua     # nvim-cmp setup
        ├── oil.lua            # oil.nvim configuration
        ├── fuzzyFinder.lua    # Telescope setup
        ├── harpoon.lua        # Harpoon quick navigation
        ├── linting.lua        # nvim-lint configuration
        ├── lsp.lua           # Language server config with native inlay hints
        └── treesitter.lua     # Syntax highlighting
```

## 🎨 Theme & Appearance

- **Cursor Dark**: Set as the default focused dark theme.
- **Catppuccin Macchiato**: A warm, cozy fallback theme.
- **Persistent Transparency**: Toggle with `<leader>ut`; the state is saved under Neovim's state directory and restored on startup.
- **Cursor**: Block cursor across all modes for consistency.
- **Sign Column**: Always visible for LSP diagnostics without gutter popping.

## 📝 Editor Settings

- **Modern Standards**: Fully updated for Neovim 0.10+ (relying on native `termguicolors`, built-in comments, native inlay hints).
- **Indentation**: 2 spaces (expandtab) by default, standard across web/config editing. 
- **Persistent Undo**: Undo history is gracefully mapped.
- **Incremental Search**: Real-time search highlighting enabled natively.

## 🚀 Getting Started

1. **Prerequisites**: 
   - Neovim 0.12+
   - Git
   - tree-sitter CLI 0.26.1+ (for nvim-treesitter parser installs)
   - A Nerd Font for icons
   - ripgrep (for Telescope live_grep)

2. **Installation**: 
   ```bash
   git clone git@github.com:Aneeshie/nvim.git ~/.config/nvim
   ```

3. **First Launch**: 
   - Open Neovim: `nvim`
   - Lazy.nvim will automatically install all plugins
   - LSP servers will be installed via Mason automatically

## 📊 Plugin Overview

| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **lazy.nvim** | Plugin Manager | Lazy loading, lockfile, fast startup |
| **cursor-dark.nvim** | Color Scheme | Focused dark theme |
| **oil.nvim** | File Explorer | Manage your filesystem like a Neovim buffer |
| **nvim-lspconfig** | LSP Client | Language server integration |
| **mason.nvim** | Server Management | Automatic LSP/Formatter installer |
| **nvim-cmp** | Completion | Smart completion |
| **telescope.nvim**| Fuzzy Finder | File finding and grepping |
| **harpoon** | Quick Navigation | Instant file switching |
| **nvim-treesitter**| Syntax Parser | Advanced parsing and syntax highlighting |
| **conform.nvim** | Formatting | Reliable document formatting |
