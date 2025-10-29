# Terminal Configuration

This directory contains comprehensive terminal configuration including shell setup, prompt theming, and modern CLI tool integration.

## Directory Structure

```
terminal/
├── .config/
│   ├── bat/
│   │   └── config          # Bat pager configuration
│   └── zsh/
│       ├── lazy-loading.zsh    # Performance optimization scripts
│       └── modern-aliases.zsh  # Modern CLI tool aliases
├── .oh-my-zsh/             # Oh My Zsh framework and plugins
├── .ripgreprc              # Ripgrep search configuration
├── .zshrc                  # Main Zsh configuration
└── starship.toml           # Starship prompt configuration
```

## Key Files

### `.zshrc`
- **Purpose**: Main Zsh shell configuration with extensive customization
- **Features**:
  - Oh My Zsh integration with curated plugins
  - Performance optimizations with lazy loading
  - Comprehensive aliases for development workflows
  - Language-specific configurations (Go, Rust, Node.js, Python)
  - Tool integration (Git, Docker, Kubernetes)

### `starship.toml`
- **Purpose**: Modern, fast, and customizable prompt configuration
- **Features**:
  - Catppuccin Macchiato theme for consistency
  - Git status integration with branch and commit info
  - Language version displays (Node.js, Python, Go, Rust)
  - Docker context and Kubernetes cluster information
  - Performance-optimized with minimal latency

### `.config/zsh/lazy-loading.zsh`
- **Purpose**: Performance optimization through lazy loading of heavy tools
- **Features**:
  - NVM lazy loading for faster shell startup
  - Pyenv initialization on demand
  - Cloud CLI tools (AWS, GCP, Azure) lazy loading
  - Performance benchmarking functions

### `.config/zsh/modern-aliases.zsh`
- **Purpose**: Modern CLI tool aliases and enhanced commands
- **Features**:
  - Eza for enhanced file listing
  - Bat for syntax-highlighted file viewing
  - Ripgrep for fast text searching
  - Modern alternatives to traditional Unix tools

## Core Features

### Shell Framework (Oh My Zsh)
- **Plugin ecosystem**: Extensive plugin collection for development tools
- **Theme support**: Customizable themes with Git integration
- **Auto-completion**: Intelligent completion for commands and arguments
- **History management**: Advanced history search and sharing

### Prompt (Starship)
- **Performance**: Written in Rust for minimal startup time
- **Customization**: Highly configurable with modules for different tools
- **Context awareness**: Shows relevant information based on current directory
- **Cross-shell**: Works with Zsh, Bash, Fish, and PowerShell

### Modern CLI Tools Integration
- **File operations**: Enhanced ls (eza), cat (bat), find (fd), grep (ripgrep/rg)
- **JSON/YAML processing**: jq for JSON manipulation, jless for interactive viewing, yq for YAML
- **Developer tools**: tldr (simplified man pages), hyperfine (benchmarking), tokei (code statistics)
- **System monitoring**: bottom/btm (better top), bandwhich (network monitoring), procs (better ps)
- **Git workflows**: Advanced Git aliases, delta diff pager, diffview integration
- **Fuzzy finding**: fzf for files and directories, zoxide for smart directory navigation
- **Development shortcuts**: Language-specific helpers and project detection

## Enabled Oh My Zsh Plugins

### Development Tools
```bash
git              # Git aliases and completion
gh               # GitHub CLI integration
node npm         # Node.js and npm shortcuts
python pip       # Python development tools
golang rust      # Go and Rust language support
```

### DevOps and Infrastructure
```bash
docker           # Docker commands and completion
kubectl helm     # Kubernetes tool integration
terraform        # Terraform workflow shortcuts
ansible          # Ansible playbook tools
```

### System and Productivity
```bash
brew             # Homebrew package manager
tmux             # Terminal multiplexer integration
history          # Enhanced history management
colored-man-pages # Colorized manual pages
```

### Enhanced Features
```bash
zsh-autosuggestions    # Command suggestions based on history
zsh-history-substring-search # History search with highlighting
zsh-syntax-highlighting # Real-time syntax highlighting
```

## Language and Tool Integration

### Go Development
```bash
# Environment setup
export GOPATH=$HOME/Developer/go
export GO111MODULE=on

# Aliases
alias air=$GOPATH/bin/air      # Live reload
alias gotest="go test -v"      # Verbose testing
alias gotidy="go mod tidy"     # Dependency cleanup
```

### Node.js Development
```bash
# Version management with NVM
export NVM_DIR="$HOME/.nvm"

# Auto-use .nvmrc when entering directories
# Aliases for common tasks
alias ni="npm install"
alias nr="npm run"
alias nd="npm run dev"
```

### Rust Development
```bash
# Cargo shortcuts
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias clippy="cargo clippy"
```

### Python Development
```bash
# Python 3 as default
alias python="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source venv/bin/activate"
```

## Performance Optimization

### Lazy Loading
- **NVM**: Load Node Version Manager only when needed
- **Pyenv**: Initialize Python environment management on demand
- **Cloud CLIs**: Load AWS, GCP, Azure tools when used
- **Heavy plugins**: Defer loading until required

### Shell Startup
- **Minimal .zshrc**: Core configuration loads first
- **Deferred loading**: Non-essential features load after prompt
- **Cache optimization**: Leverage completion and command caches
- **PATH optimization**: Efficient PATH management with deduplication

### Memory Management
- **History optimization**: Efficient history storage and search
- **Completion caching**: Cache expensive completions
- **Plugin management**: Only load necessary plugins
- **Process monitoring**: Tools to monitor shell performance

## Project-Based Auto-Loading

The terminal configuration includes intelligent project detection that automatically loads the appropriate language tools when entering project directories:

### Auto-Detection Features

**Node.js Projects** - Detects `package.json` or `.nvmrc` files:
- Automatically loads NVM if Node.js is not available
- Ensures correct Node.js version for the project
- No manual `nvm use` required

**Python Projects** - Detects `requirements.txt`, `pyproject.toml`, `setup.py`, or `Pipfile`:
- Triggers pyenv lazy loading when needed
- Activates virtual environments automatically
- Ensures proper Python version management

**Go Projects** - Detects `go.mod` or `go.sum`:
- Sets GOPATH environment variable
- Adds Go binaries to PATH
- Ensures Go tooling availability

**Rust Projects** - Detects `Cargo.toml`:
- Sets CARGO_HOME environment variable
- Adds Cargo binaries to PATH
- Ensures Rust toolchain availability

**Kubernetes Projects** - Detects `kubernetes.yaml`, `k8s.yaml`, or `k8s/`, `kubernetes/` directories:
- Loads kubectl if not already available
- Loads helm if not already available
- Triggers lazy loading for Kubernetes tools

**Docker Projects** - Detects `docker-compose.yml`, `docker-compose.yaml`, or `Dockerfile`:
- Marker for future enhancements
- Docker is always available by default

### Usage

The auto-loading function runs automatically:
1. When starting a new shell session
2. When changing directories (`cd` command)
3. Only loads tools that aren't already available
4. Leverages lazy-loading functions for performance

### Benefits

- **Zero configuration**: Works automatically based on project files
- **Performance**: Only loads tools when actually needed
- **Consistency**: Same behavior across all projects
- **Developer experience**: Seamless transition between projects

## Tool Configuration

### Ripgrep (`.ripgreprc`)
```bash
# Performance settings
--max-filesize=10M
--encoding=auto

# Search behavior
--smart-case
--follow
--hidden
--context=2

# Display optimization
--max-columns=150
--max-columns-preview

# Catppuccin-inspired colors
--colors=line:fg:yellow
--colors=path:fg:cyan
--colors=match:fg:red

# Comprehensive exclusions (node_modules, build outputs, caches, locks)
--glob=!.git/*
--glob=!node_modules/*
--glob=!target/*
--glob=!dist/*

# Custom file types (web, config, docs, shell, iac, k8s)
--type-add=web:*.{html,htm,css,scss,sass,less}
--type-add=config:*.{json,yaml,yml,toml,ini,conf,cfg}
```

### Bat Configuration
```bash
# Syntax highlighting and theming
--theme="Catppuccin-macchiato"
--style="numbers,changes,header"
--paging=auto
```

### FZF Integration
```bash
# Fuzzy finder configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
```

### Zoxide Configuration (Smart Directory Navigation)
```bash
# Zoxide environment variables
export _ZO_FZF_OPTS="--height=40% --layout=reverse --border --info=inline"
export _ZO_RESOLVE_SYMLINKS=1
export _ZO_EXCLUDE_DIRS="$HOME/.Trash:$HOME/.npm:$HOME/.cache:*/node_modules:*/.git:*/.svn:*/.hg"

# Available commands:
# cd <query>    - Smart directory jumping based on frequency and recency
# cdi           - Interactive directory selection with FZF
# zi            - Alias for interactive directory selection
```

## Development Workflows

### Smart Directory Navigation with Zoxide
```bash
# Smart directory jumping - learns from your usage patterns
cd ~/projects/myapp          # First visit - traditional navigation
cd myapp                     # Future visits - jump directly with just the name
cd my                        # Partial matching - jumps to most frequent match

# Interactive directory selection with FZF
zi                           # Opens FZF with directory history
cdi                          # Alternative interactive selection

# Common usage patterns:
cd docs                      # Jump to any "docs" directory you've visited
cd ~/work/project1           # Full path first time
cd proj1                     # Short name afterwards
cd test                      # Jump to test directories across projects
```

### Project Navigation
```bash
# Quick project switching
proj() {
    local project_dir="$HOME/projects"
    if [ -z "$1" ]; then
        ls -la "$project_dir"
    else
        cd "$project_dir/$1"
    fi
}

# Enhanced with zoxide integration
# After using proj a few times, you can use:
# cd projname instead of proj projname
```

### Git Workflows
```bash
# Enhanced Git aliases
alias gs="git status"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate --all"
alias gcticket="git commit with automatic ticket extraction"
```

### File Operations
```bash
# Modern file listing with eza
alias ls="eza --color=always --group-directories-first"
alias ll="eza -alF --color=always --group-directories-first"
alias lt="eza -aT --color=always --group-directories-first"

# Enhanced file viewing
alias cat="bat --style=plain --paging=never"
alias less="bat --style=full"
```

## Customization and Extension

### Adding New Aliases
```bash
# Add to .zshrc or create in .config/zsh/custom-aliases.zsh
alias myalias="command with options"

# For project-specific aliases
if [[ -f ./.zshrc.local ]]; then
    source ./.zshrc.local
fi
```

### Plugin Management
```bash
# Add plugins to .zshrc plugins array
plugins=(
    existing-plugins
    new-plugin
)

# Custom plugins in ~/.oh-my-zsh/custom/plugins/
```

### Theme Customization
```bash
# Starship theme modifications in starship.toml
[git_status]
modified = "📝"
staged = "✅"
deleted = "🗑"
```

## Integration with Development Environment

### Tmux Integration
- **Seamless navigation**: Tmux-aware command execution
- **Session management**: Integration with tmux session handling
- **Status integration**: Terminal status in tmux status bar
- **Copy mode**: Enhanced copy-paste between tmux and terminal

### Editor Integration
- **Neovim**: Terminal integration with proper colors and features
- **Git operations**: Enhanced Git workflows from terminal
- **File navigation**: Quick file opening with fuzzy finding
- **Command execution**: Run development commands from editor

### Docker and Kubernetes
```bash
# Docker aliases
alias d="docker"
alias dc="docker compose"
alias dps="docker ps"
alias dprune="docker system prune -f"

# Kubernetes shortcuts
alias k="kubectl"
alias kget="kubectl get"
alias kdesc="kubectl describe"
```

## Troubleshooting

### Performance Issues
- **Slow startup**: Use `zprof` to profile startup time
- **Plugin conflicts**: Disable plugins systematically to identify issues
- **Completion slowness**: Clear completion cache with `rm ~/.zcompdump*`
- **Memory usage**: Monitor with `ps` and optimize heavy plugins

### Common Issues
- **Alias conflicts**: Check alias definitions with `alias | grep command`
- **Path issues**: Verify PATH with `echo $PATH` and path_prepend function
- **Plugin errors**: Check plugin loading in `.zshrc`
- **Color issues**: Verify terminal true color support

### Compatibility
- **Terminal emulators**: Test with different terminals for compatibility
- **Operating systems**: Adjust configuration for Linux/macOS differences
- **Remote sessions**: Ensure SSH compatibility with agent forwarding
- **Older systems**: Fallback configurations for older tools

## Security Considerations

### Environment Variables
- **Sensitive data**: Never store secrets in shell configuration
- **API keys**: Use secure credential management
- **Path safety**: Verify PATH doesn't include current directory
- **History**: Configure history to exclude sensitive commands

### Network Operations
- **Proxy settings**: Configure HTTP/HTTPS proxy when needed
- **SSL verification**: Ensure proper SSL certificate verification
- **Secure protocols**: Prefer HTTPS and SSH over insecure alternatives
- **Authentication**: Use secure authentication methods

## Backup and Sync

### Configuration Backup
```bash
# Backup shell configuration
tar -czf shell-config-backup.tar.gz ~/.zshrc ~/.config/zsh/ ~/.oh-my-zsh/custom/
```

### Cross-machine Sync
- **Dotfiles repository**: Version-controlled configuration sync
- **Stow management**: Consistent deployment across machines
- **Machine-specific**: Local overrides for machine differences
- **Cloud sync**: Optional cloud storage for additional backup

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow terminal

# Remove configuration
stow -D terminal

# Preview changes
stow -n terminal
```

The terminal configuration serves as the foundation for the development environment, integrating with all other tools and configurations in the dotfiles ecosystem.