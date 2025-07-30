# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Architecture

This is a **modular dotfiles repository** organized by application, using **GNU Stow** for symlink management. Each directory contains configuration for a specific tool with its own CLAUDE.md documentation:

- `.claude/` - Claude Code configuration and integration settings
- `docker/` - Docker container management and development workflows
- `git/` - Git configuration with delta pager, GPG signing, and advanced workflows
- `gpg/` - GPG configuration for commit signing and key management
- `lazygit/` - LazyGit TUI configuration for visual Git operations
- `nodejs/` - Node.js development configuration and version management
- `nvim/` - Neovim IDE configuration with LSP, debugging, and AI assistance
- `ssh/` - SSH configuration for secure remote access and key management
- `terminal/` - Zsh + Oh-My-Zsh + Starship prompt with modern CLI tools
- `tmux/` - Tmux multiplexer configuration for session management
- `wezterm/` - WezTerm terminal emulator configuration

## Quick Start

### Configuration Management

```bash
# Apply all configurations (creates symlinks)
cd ~/dotfiles
./install.sh        # Automated installation script

# Apply individual configurations
stow nvim           # Links ~/.config/nvim
stow terminal       # Links ~/.zshrc and related files
stow git            # Links ~/.gitconfig
stow ssh            # Links ~/.ssh/config

# Remove configuration
stow -D nvim        # Removes symlinks

# Check what would be linked
stow -n nvim        # Dry run
```

### Update and Maintenance

```bash
# Update all configurations and dependencies
./update.sh         # Automated update script

# Manual plugin updates
nvim +Lazy sync +qa # Update Neovim plugins
```

## Development Environment Features

### Language Support

The configuration is optimized for modern development with full LSP support:

- **Go** - gopls, delve debugging, air live reload, comprehensive tooling
- **TypeScript/JavaScript** - ts_ls, Node.js debugging, npm/yarn/pnpm support
- **Rust** - rust-analyzer, codelldb debugging, cargo integration
- **Python** - pyright, debugpy, virtual environment management
- **Lua** - lua_ls for Neovim configuration development
- **JSON/YAML** - Schema validation and formatting

### Development Tools Integration

- **Container Development** - Docker and Docker Compose with cleanup scripts
- **Kubernetes** - kubectl, helm plugins with context switching
- **Cloud Development** - AWS, GCP, Azure CLI tools with lazy loading
- **Database Tools** - Connection management and query tools
- **API Development** - HTTP clients and testing tools

## Core Components

### Terminal Environment (`terminal/`)

- **Shell**: Zsh with Oh-My-Zsh framework and 20+ productivity plugins
- **Prompt**: Starship with Catppuccin Macchiato theme and Git integration
- **Modern CLI**: eza, bat, ripgrep, fd, fzf for enhanced file operations
- **Performance**: Lazy loading for heavy tools (nvm, pyenv, cloud CLIs)

### Code Editor (`nvim/`)

- **Plugin Manager**: Lazy.nvim with auto-installation and lazy loading
- **Language Servers**: Full LSP setup for multiple languages
- **Debugging**: Debug Adapter Protocol (DAP) for step debugging
- **AI Integration**: CodeCompanion for AI-powered development assistance
- **Git Integration**: Gitsigns, LazyGit, and advanced Git workflows

### Version Control (`git/` + `lazygit/`)

- **Advanced Git Config**: Delta pager, LFS support, conventional commits
- **Security**: GPG commit signing with automatic key management
- **Visual Interface**: LazyGit TUI for intuitive Git operations
- **Global Patterns**: Comprehensive gitignore for all platforms and tools

### Security (`gpg/` + `ssh/`)

- **GPG**: Modern cipher preferences, agent configuration, key backup
- **SSH**: Security-hardened config, modern crypto, connection multiplexing
- **Key Management**: Automated generation, backup, and rotation scripts
- **Integration**: Seamless Git commit signing and SSH authentication

### Container Development (`docker/`)

- **Configuration**: Optimized Docker daemon settings and security
- **Templates**: Production-ready compose templates for common stacks
- **Automation**: Cleanup scripts and development workflow helpers
- **Security**: Image scanning, secrets management, network isolation

### Session Management (`tmux/`)

- **Leader Key**: Ctrl+s for consistent tmux operations
- **Theme**: Catppuccin integration matching other tools
- **Productivity**: Session restoration, copy-paste integration
- **Development**: Multi-pane layouts for development workflows

### Terminal Emulator (`wezterm/`)

- **Performance**: GPU-accelerated terminal with fast rendering
- **Theme**: Catppuccin Macchiato with consistent color scheme
- **Integration**: Tmux-aware navigation and clipboard integration
- **Fonts**: JetBrains Mono Nerd Font with full icon support

### Package Management (`nodejs/`)

- **Version Management**: nvm integration with automatic version switching
- **Registry Configuration**: npm optimization and security settings
- **Script Templates**: Reusable package.json scripts for common tasks
- **Package Manager Support**: npm, yarn, pnpm with optimized configurations

## Theme System

**Unified Catppuccin theming** across all applications for visual consistency:

- **Terminal**: Catppuccin Macchiato in WezTerm and terminal colors
- **Shell**: Starship prompt with Catppuccin Macchiato theme
- **Editor**: Neovim with Catppuccin Mocha for optimal code readability
- **Multiplexer**: Tmux with Catppuccin theme matching terminal
- **Git TUI**: LazyGit with Catppuccin colors for consistent interface

## Security and Best Practices

### Cryptographic Standards

- **GPG**: RSA 4096-bit or Ed25519 keys with modern cipher preferences
- **SSH**: ChaCha20-Poly1305, AES-GCM ciphers with Curve25519 key exchange
- **Git**: Mandatory commit signing with GPG verification
- **Backup**: Encrypted key backups with automated rotation

### Development Security

- **Secrets Management**: Global gitignore patterns for common secret files
- **Environment Isolation**: Container-based development workflows
- **Access Control**: SSH key-based authentication with proper permissions
- **Audit Trail**: Comprehensive logging and monitoring configurations

## Documentation Structure

Each directory contains its own `CLAUDE.md` file with detailed configuration information:

- **`.claude/CLAUDE.md`** - Claude Code configuration and integration documentation
- **`docker/CLAUDE.md`** - Container management, templates, and security
- **`git/CLAUDE.md`** - Repository configuration, workflows, and signing
- **`gpg/CLAUDE.md`** - Key management, security setup, and backup procedures
- **`lazygit/CLAUDE.md`** - Visual Git interface and workflow optimization
- **`nodejs/CLAUDE.md`** - Node.js development and package management
- **`nvim/CLAUDE.md`** - IDE configuration, LSP setup, and debugging
- **`ssh/CLAUDE.md`** - Secure access configuration and key management
- **`terminal/CLAUDE.md`** - Shell configuration and modern CLI tools
- **`tmux/CLAUDE.md`** - Session management and productivity workflows
- **`wezterm/CLAUDE.md`** - Terminal emulator configuration and features

## Installation and Setup

### Prerequisites

- **macOS**: Optimized for macOS but adaptable to Linux
- **Homebrew**: Package manager for tool installation
- **Nerd Font**: Required for proper icon rendering (JetBrains Mono recommended)
- **Git**: Version control system with user configuration

### Installation Process

1. **Clone repository**: `git clone https://github.com/username/dotfiles.git ~/dotfiles`
2. **Run installer**: `cd ~/dotfiles && ./install.sh`
3. **Configure Git**: Copy and customize `git/.gitconfig.local`
4. **Generate keys**: Run GPG and SSH key generation scripts
5. **Verify setup**: Test configurations and integrations

### Customization

- **Local overrides**: Use `.local` files for machine-specific settings
- **Environment variables**: Configure via shell environment
- **Plugin management**: Add/remove plugins via configuration files
- **Theme variants**: Switch between Catppuccin flavors as needed

## Maintenance and Updates

### Regular Maintenance

```bash
# Update all tools and configurations
./update.sh

# Clean up unused resources
docker system prune -af
npm cache clean --force
brew cleanup
```

### Backup Procedures

```bash
# Backup GPG and SSH keys
./gpg/backup-keys.sh
tar -czf ssh-backup.tar.gz ~/.ssh/

# Backup configurations
git add . && git commit -m "backup: save current configurations"
```

## Troubleshooting

For detailed troubleshooting information, consult the individual `CLAUDE.md` files in each directory. Common issues and solutions are documented for each tool and configuration.
