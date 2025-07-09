# Modern CLI Tool Aliases and Enhancements
# This file contains aliases for modern CLI tools that improve the terminal experience

# =============================================================================
# MODERN FILE OPERATIONS
# =============================================================================

# Use eza instead of ls (if available)
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --color=always --group-directories-first"
    alias ll="eza -alF --color=always --group-directories-first"
    alias la="eza -a --color=always --group-directories-first"
    alias l="eza -F --color=always --group-directories-first"
    alias l.="eza -a | grep -E '^\\.'"
    alias lt="eza -aT --color=always --group-directories-first" # tree listing
    alias l1="eza -1 --color=always --group-directories-first" # one column
else
    # Fallback to colorls or regular ls
    if command -v colorls >/dev/null 2>&1; then
        alias ls="colorls"
        alias ll="colorls -la"  # Fixed: removed -F flag
        alias la="colorls -a"
        alias l="colorls"       # Fixed: removed -F flag
        alias lt="colorls --tree" # tree listing for colorls
    else
        alias ll="ls -alF"
        alias la="ls -A"
        alias l="ls -CF"
    fi
fi

# Use bat instead of cat (if available)
if command -v bat >/dev/null 2>&1; then
    alias cat="bat --style=plain --paging=never"
    alias ccat="bat --style=full --paging=never" # colorized cat
    alias less="bat --style=full" # bat as pager
else
    alias ccat="cat"
fi

# Use fd instead of find (if available)
if command -v fd >/dev/null 2>&1; then
    alias find="fd"
fi

# Use ripgrep instead of grep (if available)
if command -v rg >/dev/null 2>&1; then
    alias grep="rg"
fi

# Use duf instead of df (if available)
if command -v duf >/dev/null 2>&1; then
    alias df="duf"
fi

# Use dust instead of du (if available)
if command -v dust >/dev/null 2>&1; then
    alias du="dust"
fi

# Use procs instead of ps (if available)
if command -v procs >/dev/null 2>&1; then
    alias ps="procs"
fi

# Use htop instead of top (if available)
if command -v htop >/dev/null 2>&1; then
    alias top="htop"
fi

# =============================================================================
# GIT ENHANCEMENTS
# =============================================================================

# Git aliases for common operations (comprehensive set)
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gap="git add --patch"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gbD="git branch -D"
alias gc="git commit"
alias gca="git commit -a"
alias gcam="git commit -a -m"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gd="git diff"
alias gds="git diff --staged"
alias gf="git fetch"
alias gl="git log --oneline --graph --decorate --all"
alias gpl="git pull"
alias gp="git push"
alias gpo="git push origin"
alias glog="git log --oneline --decorate --graph"
alias gloga="git log --oneline --decorate --graph --all"
alias gs="git status"
alias gss="git status --short"
alias gst="git stash"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gsts="git stash show --text"
alias gm="git merge"
alias gss="git stash save"
alias gsp="git stash pop"

# Git flow aliases
alias gfl="git flow"
alias gfli="git flow init"
alias gflf="git flow feature"
alias gflfs="git flow feature start"
alias gflff="git flow feature finish"
alias gflr="git flow release"
alias gflrs="git flow release start"
alias gflrf="git flow release finish"

# =============================================================================
# DOCKER ENHANCEMENTS
# =============================================================================

# Docker aliases for efficiency
alias d="docker"
alias dc="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcb="docker compose build"
alias dcl="docker compose logs"
alias dcp="docker compose pull"
alias dcr="docker compose restart"
alias dce="docker compose exec"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dv="docker volume ls"
alias dn="docker network ls"
alias dprune="docker system prune -af"
alias dstop="docker stop \$(docker ps -aq)"
alias drm="docker rm \$(docker ps -aq)"
alias drmi="docker rmi \$(docker images -q)"
alias dlogs="docker logs -f"
alias dexec="docker exec -it"

# Docker functions
docker-ip() {
    docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
}

docker-shell() {
    docker exec -it "$1" /bin/bash
}

# =============================================================================
# KUBERNETES ENHANCEMENTS
# =============================================================================

# Kubernetes aliases
alias k="kubectl"
alias kget="kubectl get"
alias kdesc="kubectl describe"
alias kdel="kubectl delete"
alias kapp="kubectl apply"
alias klog="kubectl logs"
alias kexec="kubectl exec"
alias kpf="kubectl port-forward"
alias kctx="kubectl config current-context"
alias kns="kubectl config set-context --current --namespace"

# Kubernetes functions
ksh() {
    kubectl exec -it "$1" -- /bin/sh
}

kbash() {
    kubectl exec -it "$1" -- /bin/bash
}

# =============================================================================
# DEVELOPMENT SHORTCUTS
# =============================================================================

# Editor aliases
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias code="code ."
alias subl="subl ."

# Language-specific shortcuts
alias py="python3"
alias pip="pip3"

# Package managers
alias pnpm="pnpm"
alias brew="brew"
alias apt="sudo apt"
alias yum="sudo yum"

# =============================================================================
# SYSTEM UTILITIES
# =============================================================================

# System and network utilities
alias ports="lsof -i"
alias listening="lsof -i -P | grep LISTEN"
alias myip="curl -s http://ipinfo.io/ip"
alias localip="ipconfig getifaddr en0"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias ping="ping -c 5"
alias wget="wget -c"
alias curl="curl -L"

# File operations
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias ln="ln -iv"

# Archive operations
alias tar="tar -v"
alias untar="tar -xvf"
alias ungzip="gunzip"
alias unzip="unzip"

# =============================================================================
# PRODUCTIVITY ALIASES
# =============================================================================

# Quick navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# History shortcuts
alias h="history"
alias hg="history | grep"
alias hs="history | grep"

# Process management
alias psg="ps aux | grep"
alias killall="killall"
alias jobs="jobs -l"

# File searching (use modern tools if available)
if ! command -v fd >/dev/null 2>&1; then
    alias ff="find . -type f -name"
    alias fd="find . -type d -name"
fi

# =============================================================================
# SAFETY ALIASES
# =============================================================================

# Safety aliases are already defined in file operations section above

# Safer rm
alias trash="rmtrash" # if available
alias del="rmtrash"   # if available

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

# Extract archives
extract() {
    if [ -f "$1" ]; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Find and kill process by name
killp() {
    ps aux | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill
}

# Quick weather check
weather() {
    curl -s "wttr.in/${1:-}"
}

# Generate random password
randpass() {
    openssl rand -base64 32
}

# URL encode/decode
urlencode() {
    python -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

urldecode() {
    python -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
}