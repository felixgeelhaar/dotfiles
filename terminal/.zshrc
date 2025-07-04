# Path to your oh-my-zsh configuration.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export BAT_THEME="Catppuccin-macchiato"

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
# File and directory operations
# Modern ls aliases are now defined in .config/zsh/modern-aliases.zsh
alias tree="tree -C"
alias mkdir="mkdir -pv"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Smart directory navigation with zoxide (aliases set after zoxide init)

# Git aliases (in addition to gitconfig)
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gm="git merge"
alias gl="git log --oneline --graph --decorate --all"
alias gss="git stash save"
alias gsp="git stash pop"
alias gsl="git stash list"

# Docker aliases
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias drm="docker rm"
alias drmi="docker rmi"
alias dprune="docker system prune -f"
alias dlogs="docker logs -f"
alias dexec="docker exec -it"

# Development aliases
alias v="nvim"
alias vim="nvim"
alias code="code ."
alias py="python3"
alias pip="pip3"

# System aliases
alias reload="source ~/.zshrc"
alias h="history"
alias hg="history | grep"
alias ps="ps aux"
alias df="df -h"
alias du="du -h"
alias free="vm_stat"
alias top="htop"

# Network aliases
alias ping="ping -c 5"
alias wget="wget -c"
alias ports="lsof -i"
alias ip="curl -s http://ipinfo.io/ip"

# Find and search aliases
alias f="fd"
alias find="fd"
alias grep="rg"
alias cat="bat"
alias less="bat"

# Quick edit aliases
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim/init.lua"
alias gitconfig="nvim ~/.gitconfig"

# [FUNCTIONS]
# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

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

# [NVM] - Auto-use .nvmrc when entering directories
export NVM_DIR="$HOME/.nvm"

# Check if we have a working NVM installation
if command -v nvm &> /dev/null; then
  # Auto-use .nvmrc if present when changing directories
  autoload -U add-zsh-hook
  load-nvmrc() {
    if [[ -f .nvmrc && -r .nvmrc ]]; then
      local nvmrc_node_version=$(cat .nvmrc)
      local current_node_version=$(nvm version 2>/dev/null || echo "none")
      
      if [[ "$nvmrc_node_version" != "$current_node_version" ]]; then
        echo "Found .nvmrc with Node.js $nvmrc_node_version"
        if nvm list | grep -q "$nvmrc_node_version"; then
          nvm use "$nvmrc_node_version"
        else
          echo "Node.js $nvmrc_node_version not installed. Run 'nvm install' to install it."
        fi
      fi
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  
  # Run on current directory when shell starts
  load-nvmrc
fi

# GPG configuration
export GPG_TTY=$(tty)
export GNUPGHOME="$HOME/.config/gpg"

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

# Initialize tools
eval "$(starship init zsh)"
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd cd)"
else
    # Fallback cd function if zoxide is not available
    cd() {
        builtin cd "$@"
    }
fi
source <(fzf --zsh)

# zoxide creates cd and cdi functions automatically with --cmd cd flag

# Load performance optimizations and modern aliases
[[ -f "$HOME/.config/zsh/lazy-loading.zsh" ]] && source "$HOME/.config/zsh/lazy-loading.zsh"
[[ -f "$HOME/.config/zsh/modern-aliases.zsh" ]] && source "$HOME/.config/zsh/modern-aliases.zsh"

# Override any conflicting aliases with eza (must be after all other alias definitions)
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --color=always --group-directories-first"
    alias ll="eza -alF --color=always --group-directories-first" 
    alias la="eza -a --color=always --group-directories-first"
    alias l="eza -F --color=always --group-directories-first"
    alias lt="eza -aT --color=always --group-directories-first"
fi

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

export PATH

# Aliases
alias claude="/Users/felixgeelhaar/.claude/local/claude"
