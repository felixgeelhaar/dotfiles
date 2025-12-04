# Skip execution for non-interactive shells
[[ $- != *i* ]] && return

# Performance profiling (uncomment to profile startup time with: zsh -i -c exit)
# zmodload zsh/zprof

# =============================================================================
# COMPLETION SETUP (must be early)
# =============================================================================

# Docker CLI completions (must be before compinit)
[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)

# Custom completions
[[ -d "$HOME/.config/zsh/completions" ]] && fpath=("$HOME/.config/zsh/completions" $fpath)

# Ensure cache directory exists
[[ -d ~/.zsh/cache ]] || mkdir -p ~/.zsh/cache

# Performance optimization: Skip security check for faster startup
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
    compinit
else
    compinit -C
fi

# =============================================================================
# ENVIRONMENT VARIABLES
# =============================================================================

# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"

# Editor configuration
export EDITOR="nvim"
export VISUAL="nvim"

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Tool configurations
export BAT_THEME="gruvbox-dark"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export GNUPGHOME="$HOME/.gnupg"

# =============================================================================
# OH-MY-ZSH CONFIGURATION
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM=$ZSH/custom

# OMZ Settings
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="false"
DISABLE_UPDATE_PROMPT="false"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=13
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
DISABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="false"

# Plugins - kept minimal for performance
# Core: gh, brew, history, tmux
# Containers: docker, kubectl, helm, minikube
# IaC: terraform, ansible
# Productivity: zsh-history-substring-search, zsh-autosuggestions
plugins=(
    gh
    brew
    history
    tmux
    docker
    kubectl
    helm
    minikube
    terraform
    ansible
    zsh-history-substring-search
    zsh-autosuggestions
)

# Autosuggestions performance tuning
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *|ls *|ll *|exit|clear|history"

# WezTerm-compatible colored man pages
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

# Load Oh-My-Zsh
source "$ZSH/oh-my-zsh.sh"

# =============================================================================
# SHELL OPTIONS
# =============================================================================

# History
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

setopt EXTENDED_HISTORY          # Record timestamp of command
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming
setopt HIST_FIND_NO_DUPS         # Don't display duplicates when searching
setopt HIST_IGNORE_DUPS          # Don't record consecutive duplicates
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space (privacy)
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks from history
setopt HIST_SAVE_NO_DUPS         # Don't save duplicates to history file
setopt HIST_VERIFY               # Show command with history expansion before running
setopt SHARE_HISTORY             # Share history between all sessions
setopt INC_APPEND_HISTORY        # Write to history file immediately

# Globbing
setopt EXTENDED_GLOB             # Use extended globbing syntax
setopt GLOB_DOTS                 # Include dotfiles in globbing
setopt NO_CASE_GLOB              # Case insensitive globbing

# Directory navigation
setopt AUTO_PUSHD                # Push directories onto stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicate directories
setopt PUSHD_MINUS               # Exchange meanings of + and -

# Misc
setopt CORRECT                   # Spell correction for commands
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shell
setopt NO_BEEP                   # Disable beep on error
setopt PROMPT_SUBST              # Enable prompt substitution

# =============================================================================
# COMPLETION CONFIGURATION
# =============================================================================

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''

# Case-insensitive and partial matching
zstyle ':completion:*' matcher-list '' \
    'm:{a-z\-}={A-Z\_}' \
    'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
    'r:|?=** m:{a-z\-}={A-Z\_}'

# Completion display formatting
zstyle ':completion:*:descriptions' format '%B%F{blue}%d%f%b'
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %d%f'
zstyle ':completion:*:corrections' format '%B%F{green}%d (errors: %e)%f%b'

# Approximate matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Colors in completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# =============================================================================
# KEY BINDINGS
# =============================================================================

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# =============================================================================
# SYNTAX HIGHLIGHTING (loaded via Homebrew)
# =============================================================================

# Performance settings (must be before sourcing)
ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # Disable expensive highlighting patterns
    typeset -gA ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[path]='none'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
fi

# =============================================================================
# ALIASES
# =============================================================================

# Navigation & basics
alias tree="tree -C"
alias reload="source ~/.zshrc"

# Quick edit
alias zshrc="$EDITOR ~/.zshrc"
alias vimrc="$EDITOR ~/.config/nvim/init.lua"
alias gitconfig="$EDITOR ~/.gitconfig"

# Go
alias gofmt="gofmt -l -w"
alias gotest="go test -v"
alias gobuild="go build -v"
alias gorun="go run"
alias gomod="go mod"
alias gotidy="go mod tidy"

# Rust
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias cc="cargo check"
alias cw="cargo watch -x run"
alias clippy="cargo clippy"
alias rustfmt="cargo fmt"

# Node.js/TypeScript
alias ni="npm install"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"
alias nd="npm run dev"
alias yb="yarn build"
alias ys="yarn start"
alias yt="yarn test"
alias yd="yarn dev"
alias tsx="npx tsx"
alias ts-node="npx ts-node"

# Python
alias python="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source venv/bin/activate"
alias req="pip freeze > requirements.txt"
alias install-req="pip install -r requirements.txt"
alias pytest="python3 -m pytest"

# Docker (using Compose V2)
alias ddev="docker compose -f docker-compose.dev.yml"
alias dprod="docker compose -f docker-compose.prod.yml"
alias dtest="docker compose -f docker-compose.test.yml"

# =============================================================================
# FUNCTIONS
# =============================================================================

# Find process by name
psgrep() {
    ps aux | head -1
    ps aux | grep -v grep | grep "$@" -i --color=auto
}

# Git commit with ticket number from branch
gcticket() {
    local branch_name=$(git branch --show-current)
    local ticket=$(echo "$branch_name" | grep -o -E '[A-Z]+-[0-9]+')
    if [[ -n "$ticket" ]]; then
        git commit -m "$ticket: $1"
    else
        git commit -m "$1"
    fi
}

# Quick project navigation
proj() {
    local project_dir="$HOME/projects"
    if [[ -z "$1" ]]; then
        ls -la "$project_dir"
    else
        cd "$project_dir/$1" || return 1
    fi
}

# Weather
weather() {
    curl -s "wttr.in/${1:-}"
}

# System info
sysinfo() {
    echo "System Information:"
    echo "==================="
    echo "OS: $(uname -s) $(uname -r)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime)"
    echo "Memory: $(vm_stat | head -4)"
    echo "Disk Usage:"
    df -h
}

# Go coverage report
gocover() {
    go test -coverprofile=coverage.out && go tool cover -html=coverage.out -o coverage.html
}

# Python HTTP server
pyserve() {
    python3 -m http.server "${1:-8000}"
}

# Docker cleanup (with confirmation)
dclean() {
    echo "This will remove all unused containers, networks, images, and volumes."
    read -q "REPLY?Are you sure? (y/n) "
    echo
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        docker system prune -a --volumes
    fi
}

# Quick project setup
mkproject() {
    if [[ -z "$1" ]]; then
        echo "Usage: mkproject <name>"
        return 1
    fi
    mkdir -p "$1" && cd "$1" && git init
}

# Find and kill process on port (safe version)
killport() {
    if [[ -z "$1" ]]; then
        echo "Usage: killport <port>"
        return 1
    fi
    local pids=$(lsof -ti:"$1" 2>/dev/null)
    if [[ -z "$pids" ]]; then
        echo "No process found on port $1"
        return 1
    fi
    echo "Found processes on port $1: $pids"
    read -q "REPLY?Kill these processes? (y/n) "
    echo
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "$pids" | xargs kill -15
        echo "Sent SIGTERM to processes"
    fi
}

# Quick server start based on project type
serve() {
    if [[ -f "package.json" ]]; then
        if jq -e '.scripts.dev' package.json >/dev/null 2>&1; then
            npm run dev
        elif jq -e '.scripts.start' package.json >/dev/null 2>&1; then
            npm start
        else
            echo "No dev or start script found in package.json"
        fi
    elif [[ -f "Cargo.toml" ]]; then
        cargo run
    elif [[ -f "go.mod" ]]; then
        go run .
    elif [[ -f "requirements.txt" || -f "pyproject.toml" ]]; then
        python3 -m http.server 8000
    else
        python3 -m http.server 8000
    fi
}

# =============================================================================
# LANGUAGE ENVIRONMENTS
# =============================================================================

# Go
export GOPATH="$HOME/Developer/go"
export GO111MODULE=on
[[ -d "$GOPATH/bin" ]] && alias air="$GOPATH/bin/air"

# Rust
export CARGO_HOME="$HOME/.cargo"

# =============================================================================
# PATH MANAGEMENT
# =============================================================================

path_prepend() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

# Add paths (only if they exist)
[[ -d "$HOME/bin" ]] && path_prepend "$HOME/bin"
[[ -d "/usr/local/bin" ]] && path_prepend "/usr/local/bin"
[[ -d "$GOPATH/bin" ]] && path_prepend "$GOPATH/bin"
[[ -d "$CARGO_HOME/bin" ]] && path_prepend "$CARGO_HOME/bin"
[[ -d "/opt/homebrew/opt/ruby/bin" ]] && path_prepend "/opt/homebrew/opt/ruby/bin"
[[ -d "/opt/homebrew/opt/rustup/bin" ]] && path_prepend "/opt/homebrew/opt/rustup/bin"

# PATH Sanitization - remove duplicates and non-existent directories
typeset -U path
path=($^path(N-/))
export PATH

# =============================================================================
# PROJECT-BASED TOOL AUTO-LOADING
# =============================================================================

auto_load_project_tools() {
    # Node.js projects - load NVM if package.json exists
    if [[ -f package.json || -f .nvmrc ]] && ! command -v node >/dev/null 2>&1; then
        if typeset -f load_nvm >/dev/null 2>&1; then
            load_nvm
        fi
    fi

    # Python projects - load pyenv and auto-activate venv
    if [[ -f requirements.txt || -f pyproject.toml || -f setup.py || -f Pipfile ]]; then
        if typeset -f load_pyenv >/dev/null 2>&1 && ! command -v pyenv >/dev/null 2>&1; then
            load_pyenv
        fi
        # Auto-activate venv if present and not already activated
        if [[ -d "venv" ]] && [[ -z "$VIRTUAL_ENV" ]]; then
            source venv/bin/activate
        elif [[ -d ".venv" ]] && [[ -z "$VIRTUAL_ENV" ]]; then
            source .venv/bin/activate
        fi
    fi

    # Go projects - ensure GOPATH is set
    if [[ -f go.mod || -f go.sum ]]; then
        export GOPATH="${GOPATH:-$HOME/Developer/go}"
        path_prepend "$GOPATH/bin"
    fi

    # Rust projects - ensure cargo is in PATH
    if [[ -f Cargo.toml ]]; then
        export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
        path_prepend "$CARGO_HOME/bin"
    fi

    # Kubernetes projects - load kubectl/helm if k8s files exist
    if [[ -f kubernetes.yaml || -f k8s.yaml || -d k8s/ || -d kubernetes/ ]]; then
        if typeset -f load_kubectl >/dev/null 2>&1 && ! command -v kubectl >/dev/null 2>&1; then
            load_kubectl
        fi
        if typeset -f load_helm >/dev/null 2>&1 && ! command -v helm >/dev/null 2>&1; then
            load_helm
        fi
    fi
}

# Hook auto-loading into directory changes
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_load_project_tools

# Run on current directory when shell starts
auto_load_project_tools

# =============================================================================
# GPG CONFIGURATION
# =============================================================================

export GPG_TTY=$(tty)

# Refresh GPG agent tty
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

# Start gpg-agent if not running
if ! pgrep -x "gpg-agent" >/dev/null; then
    gpg-connect-agent --quiet /bye >/dev/null 2>&1
fi

# TTY signal configuration
stty intr ^C 2>/dev/null || true

# =============================================================================
# FZF CONFIGURATION
# =============================================================================

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Preview options for better UX
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {} 2>/dev/null || cat {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --level=2 {} 2>/dev/null || ls -la {}'"

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# =============================================================================
# ZOXIDE CONFIGURATION
# =============================================================================

export _ZO_FZF_OPTS="--height=40% --layout=reverse --border --info=inline"
export _ZO_RESOLVE_SYMLINKS=1
export _ZO_EXCLUDE_DIRS="$HOME/.Trash:$HOME/.npm:$HOME/.cache:*/node_modules:*/.git:*/.svn:*/.hg"

# =============================================================================
# TOOL INITIALIZATION
# =============================================================================

# Starship prompt
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# Load lazy loading and modern aliases
[[ -f "$HOME/.config/zsh/lazy-loading.zsh" ]] && source "$HOME/.config/zsh/lazy-loading.zsh"
[[ -f "$HOME/.config/zsh/modern-aliases.zsh" ]] && source "$HOME/.config/zsh/modern-aliases.zsh"

# Zoxide - MUST be at the end (after cd aliases are set up)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# =============================================================================
# LOCAL OVERRIDES (machine-specific)
# =============================================================================

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Performance profiling output (uncomment zmodload at top to enable)
# zprof
