# Skip execution for non-interactive shells
[[ $- != *i* ]] && return

# Performance profiling (uncomment to profile startup time with: zsh -i -c exit)
# zmodload zsh/zprof

# Docker CLI completions (must be before compinit)
fpath=(/Users/felixgeelhaar/.docker/completions $fpath)

# Performance optimization: Skip security check for faster startup
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
  compinit
else
  compinit -C
fi

# Path to your oh-my-zsh configuration.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export BAT_THEME="gruvbox-dark"
export GNUPGHOME="$HOME/.gnupg"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="false"

# Uncomment this to disable update prompt
DISABLE_UPDATE_PROMPT="false"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="false"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="false"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="false"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="false"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$ZSH/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Removed nvm from plugins for lazy loading
plugins=(gh brew history minikube kubectl helm node npm python pip golang rust docker ansible terraform xcode tmux httpie zsh-history-substring-search zsh-autosuggestions colored-man-pages)

# User configuration

# PATH Configuration - organized by purpose
export PATH="$HOME/bin:/usr/local/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# Enhanced History Configuration
HISTSIZE=50000                   # Number of commands in memory
SAVEHIST=50000                   # Number of commands saved to file
HISTFILE=~/.zsh_history          # History file location

# History behavior options
setopt EXTENDED_HISTORY          # Record timestamp of command
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming
setopt HIST_FIND_NO_DUPS         # Don't display duplicates when searching
setopt HIST_IGNORE_DUPS          # Don't record consecutive duplicates
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space (privacy)
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks from history
setopt HIST_SAVE_NO_DUPS         # Don't save duplicates to history file
setopt HIST_VERIFY               # Show command with history expansion before running
setopt SHARE_HISTORY             # Share history between all sessions
setopt INC_APPEND_HISTORY        # Write to history file immediately, not on shell exit

# Better glob patterns
setopt EXTENDED_GLOB             # Use extended globbing syntax
setopt GLOB_DOTS                 # Include dotfiles in globbing
setopt NO_CASE_GLOB              # Case insensitive globbing

# Improved directory navigation
setopt AUTO_PUSHD                # Push directories onto stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicate directories
setopt PUSHD_MINUS               # Exchange meanings of + and -

# Enhanced Completion Configuration
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Advanced completion settings
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%F{blue}%d%f%b'
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %d%f'
zstyle ':completion:*:corrections' format '%B%F{green}%d (errors: %e)%f%b'

# Enhanced listing with colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Partial word completion
zstyle ':completion:*' matcher-list '' \
    'm:{a-z\-}={A-Z\_}' \
    'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
    'r:|?=** m:{a-z\-}={A-Z\_}'

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias vim=nvim


# Key bindings for zsh-history-substring-search (plugin handles sourcing)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Syntax highlighting loaded via Homebrew installation
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# [ALIASES]
# Basic navigation - keep only essential ones here
alias tree="tree -C"
alias reload="source ~/.zshrc"

# Quick edit aliases
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim/init.lua"
alias gitconfig="nvim ~/.gitconfig"

# [FUNCTIONS]
# Functions specific to .zshrc - others moved to modern-aliases.zsh

# Find process by name
psgrep() {
    ps aux | head -1
    ps aux | grep -v grep | grep "$@" -i --color=auto
}


# Git commit with ticket number from branch
gcticket() {
    local branch_name=$(git branch --show-current)
    local ticket=$(echo $branch_name | grep -o -E '[A-Z]+-[0-9]+')
    if [ -n "$ticket" ]; then
        git commit -m "$ticket: $1"
    else
        git commit -m "$1"
    fi
}

# Quick project navigation
proj() {
    local project_dir="$HOME/projects"
    if [ -z "$1" ]; then
        ls -la "$project_dir"
    else
        cd "$project_dir/$1"
    fi
}

# Weather function
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

### [LANGUAGES]
# [GOLANG]
export GOPATH=$HOME/Developer/go
export GO111MODULE=on
alias air=$GOPATH/bin/air
alias gofmt="gofmt -l -w"
alias gotest="go test -v"
alias gobuild="go build -v"
alias gorun="go run"
alias gomod="go mod"
alias gotidy="go mod tidy"

# Go development helpers
gocover() {
    go test -coverprofile=coverage.out && go tool cover -html=coverage.out -o coverage.html
}

# [RUST]
export CARGO_HOME="$HOME/.cargo"
alias cb="cargo build"
alias cr="cargo run"
alias ct="cargo test"
alias cc="cargo check"
alias cw="cargo watch -x run"
alias clippy="cargo clippy"
alias rustfmt="cargo fmt"

# [NODE.JS/TYPESCRIPT]
alias ni="npm install"
alias nr="npm run"
alias ns="npm start"
alias nt="npm test"
alias nb="npm run build"
alias nd="npm run dev"
alias nrd="npm run dev"
alias nrb="npm run build"
alias nrt="npm run test"
alias yb="yarn build"
alias ys="yarn start"
alias yt="yarn test"
alias yd="yarn dev"

# Quick TypeScript execution
alias tsx="npx tsx"
alias ts-node="npx ts-node"

# [PYTHON]
alias python="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source venv/bin/activate"
alias req="pip freeze > requirements.txt"
alias install-req="pip install -r requirements.txt"

# Python development helpers
pytest() {
    python3 -m pytest "$@"
}

pyserve() {
    python3 -m http.server "${1:-8000}"
}

# [DOCKER DEVELOPMENT]
alias ddev="docker-compose -f docker-compose.dev.yml"
alias dprod="docker-compose -f docker-compose.prod.yml"
alias dtest="docker-compose -f docker-compose.test.yml"

# Docker cleanup
dclean() {
    docker system prune -a --volumes
}

# [PROJECT HELPERS]
# Quick project setup
mkproject() {
    mkdir -p "$1" && cd "$1" && git init
}

# Find and kill process on port
killport() {
    if [ -z "$1" ]; then
        echo "Usage: killport <port>"
        return 1
    fi
    lsof -ti:"$1" | xargs kill -9
}

# Quick server start based on project type
serve() {
    if [ -f "package.json" ]; then
        if jq -e '.scripts.dev' package.json >/dev/null; then
            npm run dev
        elif jq -e '.scripts.start' package.json >/dev/null; then
            npm start
        else
            echo "No dev or start script found in package.json"
        fi
    elif [ -f "Cargo.toml" ]; then
        cargo run
    elif [ -f "go.mod" ]; then
        go run .
    elif [ -f "requirements.txt" ]; then
        python3 -m http.server 8000
    else
        python3 -m http.server 8000
    fi
}

# [NVM] - Lazy loaded via lazy-loading.zsh for better performance
# NVM will be loaded on first use of node/npm/nvm commands
# Project-based auto-loading handled by auto_load_project_tools function below

# =============================================================================
# PROJECT-BASED TOOL AUTO-LOADING
# =============================================================================
# Automatically load language tools when entering project directories

auto_load_project_tools() {
  # Node.js projects - load NVM if package.json exists
  if [[ -f package.json || -f .nvmrc ]] && ! command -v node >/dev/null 2>&1; then
    # Trigger lazy loading if nvm function exists
    if typeset -f load_nvm >/dev/null 2>&1; then
      load_nvm
    fi
  fi

  # Python projects - load pyenv if Python project files exist
  if [[ -f requirements.txt || -f pyproject.toml || -f setup.py || -f Pipfile ]]; then
    # Trigger lazy loading if pyenv function exists
    if typeset -f load_pyenv >/dev/null 2>&1 && ! command -v pyenv >/dev/null 2>&1; then
      load_pyenv
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
    # Trigger lazy loading if kubectl function exists
    if typeset -f load_kubectl >/dev/null 2>&1 && ! command -v kubectl >/dev/null 2>&1; then
      load_kubectl
    fi
    if typeset -f load_helm >/dev/null 2>&1 && ! command -v helm >/dev/null 2>&1; then
      load_helm
    fi
  fi

  # Docker projects - helpful to have docker compose available
  if [[ -f docker-compose.yml || -f docker-compose.yaml || -f Dockerfile ]]; then
    # Docker should already be available, just a marker for future enhancements
    :
  fi
}

# Hook auto-loading into directory changes
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_load_project_tools

# Run on current directory when shell starts
auto_load_project_tools

# GPG configuration
export GPG_TTY=$(tty)

# Refresh GPG agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

# Start gpg-agent if not running
if ! pgrep -x "gpg-agent" > /dev/null; then
    gpg-connect-agent --quiet /bye >/dev/null 2>&1
fi

# Tool configurations
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Zoxide configuration
export _ZO_FZF_OPTS="--height=40% --layout=reverse --border --info=inline"
export _ZO_RESOLVE_SYMLINKS=1
export _ZO_EXCLUDE_DIRS="$HOME/.Trash:$HOME/.npm:$HOME/.cache:*/node_modules:*/.git:*/.svn:*/.hg"

# Initialize tools with error handling
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
else
    echo "Warning: starship not found, using default prompt"
fi

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
else
    echo "Warning: fzf not found, fuzzy finding disabled"
fi


# Load performance optimizations and modern aliases
[[ -f "$HOME/.config/zsh/lazy-loading.zsh" ]] && source "$HOME/.config/zsh/lazy-loading.zsh"
[[ -f "$HOME/.config/zsh/modern-aliases.zsh" ]] && source "$HOME/.config/zsh/modern-aliases.zsh"

# Load custom completions
fpath=(~/.config/zsh/completions $fpath)

# PATH consolidation and deduplication
path_prepend() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
  esac
}

# Add language-specific paths
path_prepend "$(go env GOPATH)/bin"
path_prepend "/opt/homebrew/opt/ruby/bin"
path_prepend "/opt/homebrew/opt/rustup/bin"

# PATH Sanitization - remove duplicates and non-existent directories
typeset -U path                  # Remove duplicate entries from path array
path=($^path(N-/))               # Keep only existing directories

export PATH

# Initialize zoxide - MUST be at the end of the file
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
else
    echo "Warning: zoxide not found, smart directory navigation disabled"
fi

# Local machine-specific configuration override
# Create ~/.zshrc.local for machine-specific customizations
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Performance profiling output (uncomment the zmodload at top to enable)
# zprof

# Claude CLI - local symlink points to global installation
# ~/.claude/local/claude -> ~/.nvm/versions/node/v22.17.0/bin/claude
