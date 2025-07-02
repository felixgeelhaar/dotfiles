#!/bin/bash

# Dotfiles Installation Script
# Automated setup for macOS development environment

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        log_error "This script is designed for macOS only"
        exit 1
    fi
}

# Install Xcode Command Line Tools
install_xcode_tools() {
    if ! xcode-select -p &> /dev/null; then
        log_info "Installing Xcode Command Line Tools..."
        xcode-select --install
        log_warning "Please complete the Xcode Command Line Tools installation and re-run this script"
        exit 1
    else
        log_success "Xcode Command Line Tools already installed"
    fi
}

# Install Homebrew
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        log_success "Homebrew installed"
    else
        log_success "Homebrew already installed"
    fi
}

# Install essential tools via Homebrew
install_essential_tools() {
    log_info "Installing essential tools..."
    
    local tools=(
        "stow"           # Dotfiles management
        "git"            # Version control
        "git-delta"      # Better git diffs
        "zsh"            # Shell
        "starship"       # Prompt
        "fzf"            # Fuzzy finder
        "ripgrep"        # Fast grep
        "fd"             # Fast find
        "bat"            # Better cat
        "tree"           # Directory tree
        "htop"           # Process monitor
        "wget"           # File downloader
        "zoxide"         # Smart cd
        "eza"            # Modern ls replacement
        "neovim"         # Text editor
        "tmux"           # Terminal multiplexer
        "gpg"            # GPG for commit signing
        "pinentry-mac"   # GPG passphrase entry
        "gh"             # GitHub CLI
        "docker"         # Containerization
        "kubectl"        # Kubernetes CLI
        "terraform"      # Infrastructure as code
        "jq"             # JSON processor
        "yq"             # YAML processor
    )
    
    for tool in "${tools[@]}"; do
        if brew list "$tool" &> /dev/null; then
            log_success "$tool already installed"
        else
            log_info "Installing $tool..."
            brew install "$tool"
        fi
    done
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh installed"
    else
        log_success "Oh My Zsh already installed"
    fi
}

# Install Zsh plugins
install_zsh_plugins() {
    local plugin_dir="$HOME/.oh-my-zsh/custom/plugins"
    
    # zsh-autosuggestions
    if [[ ! -d "$plugin_dir/zsh-autosuggestions" ]]; then
        log_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
    fi
    
    # zsh-syntax-highlighting (via Homebrew, so just check)
    if brew list zsh-syntax-highlighting &> /dev/null; then
        log_success "zsh-syntax-highlighting already installed"
    else
        log_info "Installing zsh-syntax-highlighting..."
        brew install zsh-syntax-highlighting
    fi
    
    # zsh-history-substring-search
    if [[ ! -d "$plugin_dir/zsh-history-substring-search" ]]; then
        log_info "Installing zsh-history-substring-search..."
        git clone https://github.com/zsh-users/zsh-history-substring-search "$plugin_dir/zsh-history-substring-search"
    fi
}

# Apply dotfiles with GNU Stow
apply_dotfiles() {
    local dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    log_info "Applying dotfiles from $dotfiles_dir..."
    
    cd "$dotfiles_dir"
    
    local configs=("git" "gpg" "nvim" "terminal" "tmux" "wezterm" "lazygit" "ssh" "docker" "nodejs")
    
    for config in "${configs[@]}"; do
        if [[ -d "$config" ]]; then
            log_info "Applying $config configuration..."
            stow "$config"
            log_success "$config configuration applied"
        else
            log_warning "$config directory not found, skipping"
        fi
    done
}

# Setup Git configuration
setup_git() {
    log_info "Setting up Git configuration..."
    
    # Check if local git config exists
    if [[ ! -f "$HOME/.gitconfig.local" ]]; then
        log_warning "Creating ~/.gitconfig.local template"
        cat > "$HOME/.gitconfig.local" << EOF
[user]
    name = Your Name
    email = your.email@example.com
    signingkey = YOUR_GPG_KEY_ID

[github]
    user = yourusername
EOF
        log_warning "Please edit ~/.gitconfig.local with your information"
    fi
}

# Setup GPG
setup_gpg() {
    log_info "Setting up GPG..."
    
    # Create GPG directory if it doesn't exist
    mkdir -p "$HOME/.config/gpg"
    chmod 700 "$HOME/.config/gpg"
    
    # Ensure GPG agent is running
    if ! pgrep -x "gpg-agent" > /dev/null; then
        gpg-connect-agent --quiet /bye >/dev/null 2>&1
    fi
    
    log_success "GPG setup complete"
}

# Setup SSH
setup_ssh() {
    log_info "Setting up SSH..."
    
    # Create SSH directories
    mkdir -p "$HOME/.ssh/sockets"
    chmod 700 "$HOME/.ssh"
    
    # Set proper permissions if config exists
    if [[ -f "$HOME/.ssh/config" ]]; then
        chmod 600 "$HOME/.ssh/config"
    fi
    
    log_success "SSH setup complete"
    log_info "Run './ssh/generate-key.sh' to create SSH keys"
}

# Change default shell to Zsh
change_shell() {
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        log_info "Changing default shell to Zsh..."
        chsh -s "$(which zsh)"
        log_success "Default shell changed to Zsh"
        log_warning "Please restart your terminal"
    else
        log_success "Zsh is already the default shell"
    fi
}

# Final setup steps
final_setup() {
    log_info "Running final setup steps..."
    
    # Install TPM for tmux if tmux config exists
    if [[ -f "$HOME/.tmux.conf" && ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        log_info "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        log_success "TPM installed. Run 'Prefix + I' in tmux to install plugins"
    fi
    
    # Source zshrc if it exists
    if [[ -f "$HOME/.zshrc" ]]; then
        log_info "Sourcing new zsh configuration..."
        zsh -c "source ~/.zshrc" 2>/dev/null || log_warning "Could not source .zshrc (this is normal)"
    fi
}

# Main installation function
main() {
    log_info "Starting dotfiles installation..."
    
    check_macos
    install_xcode_tools
    install_homebrew
    install_essential_tools
    install_oh_my_zsh
    install_zsh_plugins
    apply_dotfiles
    setup_git
    setup_gpg
    setup_ssh
    change_shell
    final_setup
    
    log_success "Dotfiles installation complete!"
    log_info "Please restart your terminal and complete the following:"
    log_info "1. Edit ~/.gitconfig.local with your information"
    log_info "2. Generate or import your GPG key"
    log_info "3. In tmux, press Prefix + I to install plugins"
    log_info "4. Open Neovim to let plugins install automatically"
}

# Run main function
main "$@"