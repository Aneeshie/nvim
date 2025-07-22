# My Neovim Configuration

A modern, feature-rich Neovim configuration focused on development productivity with excellent LSP support, fuzzy finding, and intuitive keybindings.

## ✨ Features

- **🎨 Beautiful UI**: Gruvbox colorscheme with hard contrast
- **🔍 Fuzzy Finding**: Telescope with FZF integration for blazing fast file navigation
- **🧠 Smart LSP**: Full Language Server Protocol support with auto-completion
- **📁 File Management**: NvimTree for intuitive file exploration
- **🎯 Quick Navigation**: Harpoon for lightning-fast file switching
- **🎭 Syntax Highlighting**: Treesitter for advanced syntax highlighting
- **🔧 Code Quality**: Integrated linting and formatting
- **⚡ Performance**: Lazy loading with lazy.nvim for fast startup times

## 📦 Included Language Servers

- **Lua** (`lua_ls`) - Neovim configuration and Lua development
- **Rust** (`rust_analyzer`) - Full Rust support with Clippy integration
- **Go** (`gopls`) - Complete Go development environment with inlay hints
- **TypeScript/JavaScript** (`ts_ls`) - Modern web development
- **C/C++** (`clangd`) - System programming with advanced features

## 🎛️ Key Bindings

### Leader Key
- **Leader**: `<Space>`
- **Local Leader**: `\`

### File Navigation
| Binding | Action |
|---------|--------|
| `<leader>cd` | Toggle file tree (NvimTree) |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Find buffers (Telescope) |
| `<leader>fr` | Recent files (Telescope) |
| `<leader>fh` | Help tags (Telescope) |
| `<leader>fs` | Grep string under cursor (Telescope) |

### Harpoon (Quick File Switching)
| Binding | Action |
|---------|--------|
| `<leader>a` | Add current file to Harpoon |
| `<Ctrl-e>` | Toggle Harpoon quick menu |
| `<Ctrl-h>` | Jump to Harpoon file 1 |
| `<Ctrl-t>` | Jump to Harpoon file 2 |
| `<Ctrl-n>` | Jump to Harpoon file 3 |
| `<Ctrl-s>` | Jump to Harpoon file 4 |

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
| `<leader>/` | Toggle comment (line/visual) |
| `<leader>h` | Clear search highlighting |
| `J` (visual) | Move selection down |
| `K` (visual) | Move selection up |
| `<` (visual) | Indent left (stay in visual) |
| `>` (visual) | Indent right (stay in visual) |
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
| `<Ctrl-k>` | Show signature help |

## 🔧 Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point and lazy.nvim bootstrap
├── lazy-lock.json             # Plugin version lockfile
└── lua/
    ├── config/
    │   ├── autocmds.lua       # Auto-commands
    │   ├── keymaps.lua        # Key mappings
    │   └── options.lua        # Vim options and settings
    └── plugins/
        ├── colorscheme.lua    # Gruvbox theme configuration
        ├── completion.lua     # nvim-cmp setup
        ├── fileTree.lua       # NvimTree configuration
        ├── fuzzyFinder.lua    # Telescope setup
        ├── harpoon.lua        # Harpoon quick navigation
        ├── linting.lua        # nvim-lint configuration
        ├── lsp.lua           # Language server configuration
        └── treesitter.lua     # Syntax highlighting
```

## 🎨 Theme & Appearance

- **Colorscheme**: Gruvbox (hard contrast) with custom italics
- **Cursor**: Block cursor in all modes
- **Line Numbers**: Relative line numbers enabled
- **Color Column**: Set at 120 characters
- **Scroll Offset**: 8 lines of context
- **Sign Column**: Always visible for LSP diagnostics

## 📝 Editor Settings

- **Indentation**: 4 spaces (expandtab)
- **Smart Indent**: Enabled for automatic indentation
- **No Wrap**: Long lines don't wrap
- **No Swap Files**: Disabled for cleaner workspace
- **Persistent Undo**: Undo history saved to `~/.vim/undodir`
- **Incremental Search**: Real-time search highlighting
- **System Clipboard**: Integrated with `unnamedplus`

## 🚀 Getting Started

1. **Prerequisites**: 
   - Neovim 0.8+ 
   - Git
   - A Nerd Font for icons
   - ripgrep (for Telescope live_grep)
   - Node.js (for some LSP servers)

2. **Installation**: 
   ```bash
   # If using with dotfiles (as configured)
   git clone git@github.com:Aneeshie/nvim.git ~/.dotfiles
   ln -sf ~/.dotfiles/nvim/.config/nvim ~/.config/nvim
   
   # Or directly
   git clone git@github.com:Aneeshie/nvim.git ~/.config/nvim
   ```

3. **First Launch**: 
   - Open Neovim: `nvim`
   - Lazy.nvim will automatically install all plugins
   - LSP servers will be installed via Mason on first use
   - Restart Neovim after initial setup

## 🛠️ Customization

### Adding New LSP Servers
Edit `lua/plugins/lsp.lua` and add your desired language server to the `ensure_installed` table in the Mason setup.

### Changing Theme
Modify `lua/plugins/colorscheme.lua` to use a different colorscheme or adjust Gruvbox settings.

### Custom Keybindings
Add your custom keymaps to `lua/config/keymaps.lua` following the existing patterns.

## 🎯 LSP Features

### Signature Help
- **Visual Indicator**: 🐼 emoji for parameters
- **Floating Windows**: Rounded borders for clean appearance
- **Auto-trigger**: Intelligent signature help in insert mode

### Diagnostics
- **Custom Icons**: Beautiful diagnostic symbols
- **Floating Details**: Detailed error information on hover
- **Severity Sorting**: Errors prioritized over warnings

### Language-Specific Features

#### Rust
- Clippy integration for enhanced linting
- All Cargo features enabled
- Advanced error checking

#### Go  
- gofumpt formatting
- Comprehensive code lenses
- Type hints and analysis
- Static checking with various analyzers

#### TypeScript/JavaScript
- Inlay hints for parameters and types
- Advanced type information
- Modern JS/TS support

#### C/C++
- Clang-tidy integration
- IWYU header insertion
- Detailed completion
- LLVM fallback style

## 📊 Plugin Overview

| Plugin | Purpose | Key Features |
|--------|---------|--------------|
| **lazy.nvim** | Plugin Manager | Lazy loading, lockfile, auto-updates |
| **gruvbox.nvim** | Color Scheme | Hard contrast, italic support |
| **nvim-lspconfig** | LSP Client | Language server integration |
| **mason.nvim** | LSP Installer | Automatic server management |
| **nvim-cmp** | Completion | Smart auto-completion |
| **telescope.nvim** | Fuzzy Finder | File/text search with preview |
| **nvim-tree.lua** | File Explorer | Sidebar file management |
| **harpoon** | Quick Navigation | Bookmark and switch files |
| **nvim-treesitter** | Syntax Highlighting | Advanced parsing |
| **nvim-lint** | Linting | Code quality checking |

