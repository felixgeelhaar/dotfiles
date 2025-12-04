# Skip non-interactive shells
[[ $- != *i* ]] && return

# Profiling (uncomment to debug: zsh -i -c exit)
# zmodload zsh/zprof

# --- Completion Setup (must be early) ---

[[ -d "$HOME/.docker/completions" ]] && fpath=("$HOME/.docker/completions" $fpath)
[[ -d "$HOME/.config/zsh/completions" ]] && fpath=("$HOME/.config/zsh/completions" $fpath)
[[ -d ~/.zsh/cache ]] || mkdir -p ~/.zsh/cache

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
    compinit
else
    compinit -C  # Skip security check for faster startup
fi

# --- Environment Variables ---

export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
export VISUAL="nvim"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BAT_THEME="gruvbox-dark"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export GNUPGHOME="$HOME/.gnupg"

# --- Oh-My-Zsh ---

export ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM=$ZSH/custom

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

plugins=(
    gh brew history tmux
    docker kubectl helm minikube
    terraform ansible
    zsh-history-substring-search zsh-autosuggestions
)

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *|ls *|ll *|exit|clear|history"

export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

source "$ZSH/oh-my-zsh.sh"

# --- Shell Options ---

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE         # Commands starting with space are private
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

setopt EXTENDED_GLOB
setopt GLOB_DOTS
setopt NO_CASE_GLOB

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt PROMPT_SUBST

# --- Completion Styles ---

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''

zstyle ':completion:*' matcher-list '' \
    'm:{a-z\-}={A-Z\_}' \
    'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
    'r:|?=** m:{a-z\-}={A-Z\_}'

zstyle ':completion:*:descriptions' format '%B%F{blue}%d%f%b'
zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for: %d%f'
zstyle ':completion:*:corrections' format '%B%F{green}%d (errors: %e)%f%b'

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# --- Key Bindings ---

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# --- Syntax Highlighting ---

ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

if [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    typeset -gA ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[path]='none'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='none'
fi

# --- Aliases ---

alias tree="tree -C"
alias reload="source ~/.zshrc"
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

# Node.js
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

# Docker
alias ddev="docker compose -f docker-compose.dev.yml"
alias dprod="docker compose -f docker-compose.prod.yml"
alias dtest="docker compose -f docker-compose.test.yml"

# --- Functions ---

psgrep() {
    ps aux | head -1
    ps aux | grep -v grep | grep "$@" -i --color=auto
}

gcticket() {
    local branch_name=$(git branch --show-current)
    local ticket=$(echo "$branch_name" | grep -o -E '[A-Z]+-[0-9]+')
    if [[ -n "$ticket" ]]; then
        git commit -m "$ticket: $1"
    else
        git commit -m "$1"
    fi
}

proj() {
    local project_dir="$HOME/projects"
    if [[ -z "$1" ]]; then
        ls -la "$project_dir"
    else
        cd "$project_dir/$1" || return 1
    fi
}

weather() { curl -s "wttr.in/${1:-}"; }

sysinfo() {
    echo "OS: $(uname -s) $(uname -r)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime)"
    df -h
}

gocover() {
    go test -coverprofile=coverage.out && go tool cover -html=coverage.out -o coverage.html
}

pyserve() { python3 -m http.server "${1:-8000}"; }

dclean() {
    echo "This will remove all unused containers, networks, images, and volumes."
    read -q "REPLY?Are you sure? (y/n) "
    echo
    [[ "$REPLY" =~ ^[Yy]$ ]] && docker system prune -a --volumes
}

mkproject() {
    [[ -z "$1" ]] && { echo "Usage: mkproject <name>"; return 1; }
    mkdir -p "$1" && cd "$1" && git init
}

killport() {
    [[ -z "$1" ]] && { echo "Usage: killport <port>"; return 1; }
    local pids=$(lsof -ti:"$1" 2>/dev/null)
    [[ -z "$pids" ]] && { echo "No process on port $1"; return 1; }
    echo "Found on port $1: $pids"
    read -q "REPLY?Kill? (y/n) "
    echo
    [[ "$REPLY" =~ ^[Yy]$ ]] && echo "$pids" | xargs kill -15
}

serve() {
    if [[ -f "package.json" ]]; then
        if jq -e '.scripts.dev' package.json >/dev/null 2>&1; then
            npm run dev
        elif jq -e '.scripts.start' package.json >/dev/null 2>&1; then
            npm start
        else
            echo "No dev or start script found"
        fi
    elif [[ -f "Cargo.toml" ]]; then
        cargo run
    elif [[ -f "go.mod" ]]; then
        go run .
    else
        python3 -m http.server 8000
    fi
}

# --- Language Environments ---

export GOPATH="$HOME/Developer/go"
export GO111MODULE=on
[[ -d "$GOPATH/bin" ]] && alias air="$GOPATH/bin/air"

export CARGO_HOME="$HOME/.cargo"

# --- PATH ---

path_prepend() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

[[ -d "$HOME/bin" ]] && path_prepend "$HOME/bin"
[[ -d "/usr/local/bin" ]] && path_prepend "/usr/local/bin"
[[ -d "$GOPATH/bin" ]] && path_prepend "$GOPATH/bin"
[[ -d "$CARGO_HOME/bin" ]] && path_prepend "$CARGO_HOME/bin"
[[ -d "/opt/homebrew/opt/ruby/bin" ]] && path_prepend "/opt/homebrew/opt/ruby/bin"
[[ -d "/opt/homebrew/opt/rustup/bin" ]] && path_prepend "/opt/homebrew/opt/rustup/bin"

typeset -U path
path=($^path(N-/))
export PATH

# --- Project Auto-Loading ---

auto_load_project_tools() {
    # Node.js
    if [[ -f package.json || -f .nvmrc ]] && ! command -v node >/dev/null 2>&1; then
        typeset -f load_nvm >/dev/null 2>&1 && load_nvm
    fi

    # Python
    if [[ -f requirements.txt || -f pyproject.toml || -f setup.py || -f Pipfile ]]; then
        typeset -f load_pyenv >/dev/null 2>&1 && ! command -v pyenv >/dev/null 2>&1 && load_pyenv
        [[ -d "venv" && -z "$VIRTUAL_ENV" ]] && source venv/bin/activate
        [[ -d ".venv" && -z "$VIRTUAL_ENV" ]] && source .venv/bin/activate
    fi

    # Go
    if [[ -f go.mod || -f go.sum ]]; then
        export GOPATH="${GOPATH:-$HOME/Developer/go}"
        path_prepend "$GOPATH/bin"
    fi

    # Rust
    if [[ -f Cargo.toml ]]; then
        export CARGO_HOME="${CARGO_HOME:-$HOME/.cargo}"
        path_prepend "$CARGO_HOME/bin"
    fi

    # Kubernetes
    if [[ -f kubernetes.yaml || -f k8s.yaml || -d k8s/ || -d kubernetes/ ]]; then
        typeset -f load_kubectl >/dev/null 2>&1 && ! command -v kubectl >/dev/null 2>&1 && load_kubectl
        typeset -f load_helm >/dev/null 2>&1 && ! command -v helm >/dev/null 2>&1 && load_helm
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd auto_load_project_tools
auto_load_project_tools

# --- GPG ---

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
pgrep -x "gpg-agent" >/dev/null || gpg-connect-agent --quiet /bye >/dev/null 2>&1
stty intr ^C 2>/dev/null || true

# --- FZF ---

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {} 2>/dev/null || cat {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --level=2 {} 2>/dev/null || ls -la {}'"

command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)

# --- Zoxide ---

export _ZO_FZF_OPTS="--height=40% --layout=reverse --border --info=inline"
export _ZO_RESOLVE_SYMLINKS=1
export _ZO_EXCLUDE_DIRS="$HOME/.Trash:$HOME/.npm:$HOME/.cache:*/node_modules:*/.git:*/.svn:*/.hg"

# --- Tool Init ---

command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

[[ -f "$HOME/.config/zsh/lazy-loading.zsh" ]] && source "$HOME/.config/zsh/lazy-loading.zsh"
[[ -f "$HOME/.config/zsh/modern-aliases.zsh" ]] && source "$HOME/.config/zsh/modern-aliases.zsh"

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# --- Local Overrides ---

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# zprof
