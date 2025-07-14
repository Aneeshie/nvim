#!/bin/bash

echo "Installing linters and formatters for Neovim..."

# JavaScript/TypeScript
echo "Installing JavaScript/TypeScript tools..."
npm install -g eslint_d typescript-language-server typescript prettier

# Python
echo "Installing Python tools..."
pip install flake8 black pyright

# Go
echo "Installing Go tools..."
go install golang.org/x/tools/gopls@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Lua
echo "Installing Lua tools..."
if command -v brew &> /dev/null; then
    brew install luarocks
    luarocks install luacheck
    brew install stylua
elif command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get install luarocks
    luarocks install luacheck
    # For stylua, you might need to install via cargo or download binary
fi

# C/C++
echo "Installing C/C++ tools..."
if command -v brew &> /dev/null; then
    brew install llvm cpplint
elif command -v apt-get &> /dev/null; then
    sudo apt-get install clang-tools cpplint
fi

# HTML/CSS/JSON
echo "Installing web development tools..."
npm install -g vscode-langservers-extracted jsonlint markdownlint-cli

echo "Installation complete!"
echo "Note: Some tools might need to be installed differently based on your system."
echo "Please check the README for manual installation instructions."
