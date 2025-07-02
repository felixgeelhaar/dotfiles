# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Architecture

This is a **modular dotfiles repository** organized by application, using **GNU Stow** for symlink management. Each directory contains configuration for a specific tool:

- `nvim/` - Neovim configuration with Lazy.nvim plugin manager
- `terminal/` - Zsh + Oh-My-Zsh + Starship prompt configuration  
- `wezterm/` - WezTerm terminal emulator configuration
- `tmux/` - Tmux multiplexer configuration
- `git/` - Git configuration with delta pager and signing
- `lazygit/` - LazyGit TUI configuration
- `gpg/` - GPG configuration for commit signing

## Common Commands

### Configuration Management
```bash
# Apply configuration (creates symlinks)
cd ~/dotfiles
stow nvim        # Links ~/.config/nvim
stow terminal    # Links ~/.zshrc and related files
stow wezterm     # Links ~/.config/wezterm
stow git         # Links ~/.gitconfig

# Remove configuration
stow -D nvim     # Removes symlinks

# Check what would be linked
stow -n nvim     # Dry run
```

### Neovim Plugin Management
```bash
# Neovim uses Lazy.nvim - plugins auto-install on startup
nvim             # Plugins install automatically
:Lazy            # Open plugin manager UI
:Lazy sync       # Update all plugins
:Lazy clean      # Remove unused plugins
```

### Development Languages
The configuration is optimized for:
- **Go** - LSP, debugging, live reload with air
- **TypeScript/JavaScript** - Node.js, npm, yarn support
- **Rust** - Rustup integration, LSP
- **Python** - Multiple version management
- **Lua** - Neovim configuration development

## Key Configuration Files

### Terminal Environment
- `terminal/.zshrc` - Main shell configuration with extensive plugin ecosystem
- `terminal/.config/starship.toml` - Prompt configuration with Catppuccin theme
- `terminal/.oh-my-zsh/` - Oh-My-Zsh framework with custom plugins

### Neovim IDE Setup
- `nvim/.config/nvim/init.lua` - Main entry point with Lazy.nvim setup
- `nvim/.config/nvim/lua/plugins/` - Modular plugin configurations
- `nvim/.config/nvim/lazy-lock.json` - Plugin version lockfile (do not edit manually)

### Git Configuration
- `git/.gitconfig` - Advanced Git config with delta, LFS support, and conventional commits
- `git/.gitconfig.local` - Template for user-specific settings (name, email, signing key)

## Theme System

**Unified Catppuccin theming** across all applications:
- Starship prompt: Catppuccin Macchiato
- Neovim: Catppuccin Mocha  
- WezTerm: Catppuccin Macchiato
- Tmux: Catppuccin theme
- LazyGit: Catppuccin colors

## Plugin Management

### Neovim (Lazy.nvim)
- Plugins defined in `nvim/.config/nvim/lua/plugins/*.lua`
- Auto-installs missing plugins on startup
- Lockfile tracks exact versions
- Key plugins: LSP, Treesitter, Telescope, Gitsigns, CodeCompanion AI

### Tmux (TPM)
- Plugin manager: Tmux Plugin Manager
- Plugins defined in `.tmux.conf`
- Install: `<prefix> + I` (Ctrl+s + I)

### Oh-My-Zsh
- Extensive plugin ecosystem enabled in `.zshrc`
- Custom plugins in `terminal/.oh-my-zsh/custom/`
- Key plugins: git, gh, kubectl, docker, terraform, brew

## Development Workflows

### Git Workflow
- Conventional commits supported via LazyGit
- GPG signing configured (requires local setup)
- Delta pager for enhanced diffs
- Global gitignore for common patterns

### Language-Specific Setup
- **Go**: GOPATH configured, air for live reload
- **Node.js**: NVM integration, multiple package managers
- **Docker/K8s**: kubectl, helm, minikube plugins enabled
- **Terraform**: Full Terraform plugin support

## Important Notes

- **No automated installation** - manual stow commands required
- **Local Git config required** - copy `git/.gitconfig.local` and customize
- **Font dependency** - Nerd Font required for proper symbol rendering
- **macOS optimized** - some configs may need adjustment for Linux