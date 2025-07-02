#!/bin/bash

# Dotfiles Update Script
# Updates all tools and dependencies

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

main() {
    log_info "Updating all development tools..."
    
    # Update Homebrew and packages
    if command -v brew &> /dev/null; then
        log_info "Updating Homebrew packages..."
        brew update && brew upgrade && brew cleanup
        log_success "Homebrew packages updated"
    fi
    
    # Update Oh My Zsh
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Updating Oh My Zsh..."
        cd "$HOME/.oh-my-zsh" && git pull
        log_success "Oh My Zsh updated"
    fi
    
    # Update Zsh plugins
    local plugin_dir="$HOME/.oh-my-zsh/custom/plugins"
    for plugin in "$plugin_dir"/*; do
        if [[ -d "$plugin/.git" ]]; then
            log_info "Updating $(basename "$plugin")..."
            cd "$plugin" && git pull
        fi
    done
    
    # Update Tmux plugins
    if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
        log_info "Updating Tmux plugins..."
        "$HOME/.tmux/plugins/tpm/bin/update_plugins" all
        log_success "Tmux plugins updated"
    fi
    
    # Update Neovim plugins
    if command -v nvim &> /dev/null; then
        log_info "Updating Neovim plugins..."
        nvim --headless -c "Lazy! sync" -c "qa"
        log_success "Neovim plugins updated"
    fi
    
    log_success "All updates complete!"
}

main "$@"