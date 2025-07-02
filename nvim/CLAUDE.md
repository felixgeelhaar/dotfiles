# Neovim IDE Configuration

This directory contains a comprehensive Neovim configuration optimized for software development with modern plugins and language support.

## Directory Structure

```
nvim/
├── .config/nvim/
│   ├── init.lua                    # Main entry point
│   ├── lazy-lock.json             # Plugin version lockfile
│   └── lua/
│       ├── keymaps.lua            # Custom key mappings
│       └── plugins/
│           ├── ai-assistant.lua    # AI code assistance
│           ├── colorscheme.lua     # Theme configuration
│           ├── debugging.lua       # Debug adapter protocol (DAP)
│           ├── enhancements.lua    # Quality of life improvements
│           ├── git.lua            # Git integration
│           ├── language-servers.lua # LSP configurations
│           ├── lazygit.lua        # LazyGit integration
│           ├── lsp-config.lua     # Language server setup
│           ├── session.lua        # Session management
│           ├── telescope.lua      # Fuzzy finder
│           ├── tmux-navigator.lua # Tmux integration
│           ├── treesitter.lua     # Syntax highlighting
│           ├── trouble.lua        # Diagnostics UI
│           └── which_key.lua      # Key binding help
```

## Core Features

### Plugin Management (Lazy.nvim)
- **Auto-installation**: Plugins install automatically on first startup
- **Lazy loading**: Plugins load only when needed for performance
- **Version locking**: `lazy-lock.json` ensures reproducible setups
- **Update management**: Easy plugin updates with `:Lazy sync`

### Language Support
- **LSP Integration**: Full Language Server Protocol support
- **Supported Languages**: Go, TypeScript/JavaScript, Rust, Python, Lua, JSON, YAML
- **Debugging**: Debug Adapter Protocol (DAP) for multiple languages
- **Syntax Highlighting**: Tree-sitter for accurate syntax highlighting
- **Auto-completion**: Intelligent completion with nvim-cmp

### Development Tools
- **Git Integration**: Gitsigns for inline git information
- **File Explorer**: Neo-tree for project navigation
- **Fuzzy Finding**: Telescope for files, symbols, and text search
- **Terminal**: Integrated terminal with tmux navigation
- **AI Assistant**: CodeCompanion for AI-powered development assistance

## Key Components

### Language Servers
```lua
-- Configured LSP servers:
- gopls (Go)
- ts_ls (TypeScript/JavaScript) 
- rust_analyzer (Rust)
- pyright (Python)
- lua_ls (Lua)
- jsonls (JSON)
- yamlls (YAML)
```

### Debug Adapters
```lua
-- Configured DAP adapters:
- delve (Go debugging)
- node2 (Node.js/TypeScript debugging)
- codelldb (Rust debugging)
- debugpy (Python debugging)
```

### Key Mappings (Leader: Space)

#### File Operations
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Browse buffers
- `<leader>fh` - Help tags

#### Git Operations
- `<leader>gs` - Git status
- `<leader>gc` - Git commits
- `<leader>gb` - Git branches
- `<leader>gd` - Git diff

#### Code Navigation
- `<leader>ca` - Code actions
- `<leader>cf` - Format code
- `<leader>cr` - Rename symbol
- `gd` - Go to definition
- `gr` - Go to references

#### Debugging
- `<F5>` - Start/continue debugging
- `<F10>` - Step over
- `<F11>` - Step into
- `<F12>` - Step out
- `<leader>db` - Toggle breakpoint

## Setup and Configuration

### Installation
```bash
# Apply Neovim configuration
stow nvim

# Start Neovim (plugins auto-install)
nvim

# Update plugins
:Lazy sync
```

### Language Server Setup
```bash
# Install language servers via Mason
:Mason

# Or install manually:
# Go
go install golang.org/x/tools/gopls@latest

# Node.js
npm install -g typescript-language-server

# Rust (via rustup)
rustup component add rust-analyzer

# Python
pip install pyright
```

### Debug Adapter Setup
```bash
# Go debugger
go install github.com/go-delve/delve/cmd/dlv@latest

# Node.js debugger (via Mason)
:Mason
# Search and install: node-debug2-adapter

# Rust debugger
# Install via Mason: codelldb

# Python debugger
pip install debugpy
```

## Development Workflows

### Go Development
- **LSP**: Full Go language support with gopls
- **Debugging**: Delve integration for breakpoint debugging
- **Testing**: Test running and coverage display
- **Formatting**: Automatic gofmt on save
- **Imports**: Auto-import organization

### TypeScript/JavaScript Development
- **LSP**: TypeScript language server with full IntelliSense
- **Debugging**: Node.js debugging with breakpoints
- **Linting**: ESLint integration
- **Formatting**: Prettier integration
- **React/Vue**: JSX/TSX support with proper highlighting

### Rust Development
- **LSP**: rust-analyzer with cargo integration
- **Debugging**: LLDB-based debugging
- **Formatting**: rustfmt on save
- **Cargo**: Integrated cargo commands
- **Clippy**: Lint suggestions and fixes

### Python Development
- **LSP**: Pyright for type checking and completion
- **Debugging**: debugpy for Python debugging
- **Formatting**: Black and isort integration
- **Virtual environments**: Automatic venv detection
- **Jupyter**: Basic notebook support

## AI-Powered Development

### CodeCompanion Integration
- **Chat interface**: AI-powered coding assistance
- **Code generation**: Generate code from natural language
- **Code explanation**: Understand complex code sections
- **Refactoring**: AI-suggested improvements
- **Documentation**: Auto-generate documentation

### Usage
```vim
# Open AI chat
:CodeCompanionChat

# Explain selected code
:CodeCompanionExplain

# Generate code
:CodeCompanionGenerate
```

## Theme and Appearance

### Catppuccin Theme
- **Variant**: Mocha (dark theme)
- **Integration**: Consistent with terminal and other tools
- **Customization**: Optimized for code readability
- **Syntax highlighting**: Enhanced with Tree-sitter

### UI Enhancements
- **Statusline**: Informative status with git info
- **Tabline**: Buffer management
- **File explorer**: Neo-tree with git integration
- **Which-key**: Visual key binding help

## Performance Optimization

### Lazy Loading
- **Plugin loading**: Plugins load only when needed
- **Language servers**: Start only for relevant file types
- **Large files**: Optimized handling of large files
- **Startup time**: Fast startup with deferred loading

### Memory Management
- **Buffer management**: Automatic cleanup of unused buffers
- **LSP optimization**: Memory-efficient language server usage
- **Tree-sitter**: Incremental parsing for performance
- **Cache management**: Efficient plugin and data caching

## Integration with Development Environment

### Terminal Integration
- **Tmux navigation**: Seamless pane switching
- **Terminal emulator**: Built-in terminal with shell integration
- **External tools**: Integration with system tools and commands

### Git Workflow
- **LazyGit**: Full-featured Git TUI integration
- **Gitsigns**: Inline git blame and diff information
- **Conflict resolution**: Merge conflict handling
- **Commit signing**: GPG signing integration

### Project Management
- **Session management**: Automatic session restoration
- **Project-specific configuration**: Per-project settings
- **Workspace support**: Multi-root workspace handling
- **File watching**: Automatic reload on external changes

## Troubleshooting

### Common Issues
- **LSP not starting**: Check language server installation
- **Slow startup**: Review plugin loading and disable unused plugins
- **Key conflicts**: Check key mapping conflicts with `:map`
- **Theme issues**: Ensure terminal supports true color

### Performance Issues
- **Large files**: Disable syntax highlighting for files > 1MB
- **Memory usage**: Monitor with `:checkhealth`
- **Plugin conflicts**: Disable plugins systematically to identify issues
- **Tree-sitter**: Update parsers with `:TSUpdate`

### Debugging Configuration Issues
- **Health check**: `:checkhealth` for system diagnostics
- **Plugin status**: `:Lazy` for plugin management
- **LSP status**: `:LspInfo` for language server information
- **Mason status**: `:Mason` for tool installation status

## Customization

### Adding New Languages
1. Add LSP configuration in `language-servers.lua`
2. Configure Tree-sitter parser in `treesitter.lua` 
3. Add debug adapter in `debugging.lua` if needed
4. Update key mappings in `keymaps.lua`

### Plugin Management
```lua
-- Add new plugin in appropriate file
return {
  'author/plugin-name',
  config = function()
    -- Plugin configuration
  end,
  dependencies = { 'dependency1', 'dependency2' },
  lazy = true, -- Enable lazy loading
}
```

### Key Mapping Customization
```lua
-- Add custom mappings in keymaps.lua
vim.keymap.set('n', '<leader>custom', function()
  -- Custom function
end, { desc = 'Custom function' })
```

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow nvim

# Remove configuration  
stow -D nvim

# Preview changes
stow -n nvim
```

The Neovim configuration integrates with terminal, git, tmux, and the overall development environment for a cohesive coding experience.