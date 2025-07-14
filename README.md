# Neovim Configuration



## Features

- **Catppuccin Theme**: Beautiful mocha flavor theme
- **Block Cursor**: Block cursor in all modes
- **LSP Support**: Language Server Protocol for multiple languages
- **Language Support**: Lua, Python, C++, C, JavaScript, TypeScript, Go, HTML, CSS, JSON
- **Prettier Integration**: Auto-formatting on save
- **Emmet**: HTML/CSS expansion support
- **No Auto-complete Braces**: Disabled automatic bracket completion
- **TreeSitter**: Syntax highlighting and code parsing
- **Git Integration**: Git status and diff viewing
- **Multi-line Comments**: Easy commenting/uncommenting
- **VSCode-like Autocomplete**: Intelligent code completion
- **Harpoon**: Quick file navigation and bookmarking
- **Comprehensive Linting**: ESLint, Flake8, Golangci-lint, Luacheck, and more
- **Real-time Diagnostics**: Instant error and warning detection

## Key Mappings

### Leader Key
- Leader key is set to `<Space>`

### LSP Mappings
- `gd` - Go to definition
- `gD` - Go to declaration
- `K` - Show hover information
- `gi` - Go to implementation
- `gr` - Show references
- `<Space>rn` - Rename symbol
- `<Space>ca` - Code actions
- `<Space>f` - Format code
- `<C-k>` - Signature help

### General Mappings
- `<Space>cd` - Change directory to current file's directory
- `<Space>e` - Toggle file explorer (NvimTree)
- `<Space>ff` - Find files (Telescope)
- `<Space>fg` - Live grep (Telescope)
- `<Space>fb` - Browse buffers (Telescope)
- `<Space>fh` - Help tags (Telescope)
- `<Space>gs` - Git status (Fugitive)
- `<Space>gc` - Git preview hunk (Gitsigns)
- `<Space>/` - Toggle comment (normal mode)
- `<Space>/` - Toggle comment (visual mode)

### Completion Mappings
- `<C-Space>` - Trigger completion
- `<Tab>` - Next completion item / expand snippet
- `<S-Tab>` - Previous completion item / jump back in snippet
- `<C-e>` - Abort completion
- `<Enter>` - Confirm completion
- `<C-b>` - Scroll docs up
- `<C-f>` - Scroll docs down

### Emmet
- `<C-,>` - Emmet leader key (e.g., `<C-,>,` to expand)

### Harpoon Mappings
- `<Space>ha` - Add current file to Harpoon
- `<Space>hh` - Toggle Harpoon quick menu
- `<Space>h1` - Navigate to Harpoon file 1
- `<Space>h2` - Navigate to Harpoon file 2
- `<Space>h3` - Navigate to Harpoon file 3
- `<Space>h4` - Navigate to Harpoon file 4
- `<Space>hn` - Navigate to next Harpoon file
- `<Space>hp` - Navigate to previous Harpoon file

## Installation

1. Make sure you have Neovim 0.8+ installed
2. The configuration will automatically install Packer plugin manager
3. Open Neovim and run `:PackerSync` to install all plugins
4. Restart Neovim

## Language Servers

You'll need to install the following language servers:

### Python
```bash
pip install pyright
```

### JavaScript/TypeScript
```bash
npm install -g typescript-language-server typescript
```

### Go
```bash
go install golang.org/x/tools/gopls@latest
```

### C/C++
```bash
# On macOS with Homebrew
brew install llvm

# On Ubuntu/Debian
sudo apt install clang-tools
```

### HTML/CSS
```bash
npm install -g vscode-langservers-extracted
```

### JSON
```bash
npm install -g vscode-langservers-extracted
```

### Lua
```bash
# The lua-language-server will be installed automatically
```

## Formatters

### Prettier
```bash
npm install -g prettier
```

### Black (Python)
```bash
pip install black
```

### Go fmt
```bash
# Included with Go installation
```

### Clang Format
```bash
# Usually included with clang installation
```

## Linters

The configuration includes comprehensive linting support. You can install all linters at once:

```bash
# Run the installation script
./install_linters.sh
```

### Manual Installation

#### JavaScript/TypeScript
```bash
npm install -g eslint_d
```

#### Python
```bash
pip install flake8
```

#### Go
```bash
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

#### Lua
```bash
# On macOS with Homebrew
brew install luarocks
luarocks install luacheck
brew install stylua

# On Ubuntu/Debian
sudo apt-get install luarocks
luarocks install luacheck
```

#### C/C++
```bash
# On macOS with Homebrew
brew install cpplint

# On Ubuntu/Debian
sudo apt-get install cpplint
```

#### JSON/Markdown
```bash
npm install -g jsonlint markdownlint-cli
```

## File Structure

```
~/.config/nvim/
├── init.lua          # Main configuration file
└── README.md         # This file
```

## Theme

The configuration uses Catppuccin Mocha theme, which provides:
- Beautiful color scheme
- Consistent theming across all plugins
- Dark background with vibrant colors
- Italic comments and conditionals

## Plugins Included

- **packer.nvim** - Plugin manager
- **catppuccin** - Color scheme
- **nvim-lspconfig** - LSP configuration
- **nvim-treesitter** - Syntax highlighting
- **nvim-cmp** - Autocompletion
- **LuaSnip** - Snippet engine
- **null-ls.nvim** - Formatters and linters
- **prettier.nvim** - Prettier integration
- **emmet-vim** - Emmet support
- **vim-fugitive** - Git integration
- **gitsigns.nvim** - Git signs in gutter
- **nerdcommenter** - Commenting
- **nvim-tree.lua** - File explorer
- **telescope.nvim** - Fuzzy finder
- **harpoon** - Quick file navigation and bookmarking
- **lualine.nvim** - Status line
- **bufferline.nvim** - Buffer tabs
- **indent-blankline.nvim** - Indent guides

## Customization

You can customize the configuration by editing `~/.config/nvim/init.lua`. The configuration is well-commented and organized into sections for easy modification.
