# ZSH Performance Optimizations with Lazy Loading
# This file contains lazy loading functions for heavy tools to improve shell startup time

# =============================================================================
# LAZY LOADING UTILITIES
# =============================================================================

# Generic lazy loading function
lazy_load() {
    local cmd="$1"
    local load_cmd="$2"
    
    eval "
    $cmd() {
        unfunction $cmd
        $load_cmd
        $cmd \"\$@\"
    }
    "
}

# =============================================================================
# NODE.JS VERSION MANAGERS
# =============================================================================

# NVM Lazy Loading
if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
    export NVM_DIR="$HOME/.nvm"
    
    # Lazy load nvm
    nvm() {
        unfunction nvm
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        nvm "$@"
    }
    
    # Auto-use .nvmrc if available
    autoload -U add-zsh-hook
    load-nvmrc() {
        local node_version="$(nvm version 2>/dev/null)"
        local nvmrc_path="$(nvm_find_nvmrc 2>/dev/null)"
        
        if [ -n "$nvmrc_path" ]; then
            local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")" 2>/dev/null)
            
            if [ "$nvmrc_node_version" = "N/A" ]; then
                nvm install
            elif [ "$nvmrc_node_version" != "$node_version" ]; then
                nvm use
            fi
        elif [ "$node_version" != "$(nvm version default 2>/dev/null)" ]; then
            echo "Reverting to nvm default version"
            nvm use default
        fi
    }
    add-zsh-hook chpwd load-nvmrc
fi

# Volta integration (if available)
if command -v volta >/dev/null 2>&1; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
fi

# FNM integration (if available)
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi

# =============================================================================
# PYTHON VERSION MANAGERS
# =============================================================================

# Pyenv lazy loading
if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    
    pyenv() {
        unfunction pyenv
        eval "$(command pyenv init -)"
        eval "$(command pyenv virtualenv-init -)"
        pyenv "$@"
    }
fi

# Poetry lazy loading
if command -v poetry >/dev/null 2>&1; then
    poetry() {
        unfunction poetry
        export PATH="$HOME/.local/bin:$PATH"
        source "$HOME/.poetry/env" 2>/dev/null || true
        poetry "$@"
    }
fi

# =============================================================================
# CONTAINERIZATION TOOLS
# =============================================================================

# Docker Compose lazy loading (if using standalone)
if command -v docker-compose >/dev/null 2>&1; then
    docker-compose() {
        unfunction docker-compose
        # Load any docker-compose specific configurations
        docker-compose "$@"
    }
fi

# =============================================================================
# CLOUD TOOLS
# =============================================================================

# AWS CLI lazy loading
if command -v aws >/dev/null 2>&1; then
    aws() {
        unfunction aws
        # Load AWS completion if available
        if [[ -f /usr/local/bin/aws_zsh_completer.sh ]]; then
            source /usr/local/bin/aws_zsh_completer.sh
        fi
        aws "$@"
    }
fi

# Google Cloud SDK lazy loading
if [[ -d "$HOME/google-cloud-sdk" ]]; then
    gcloud() {
        unfunction gcloud
        unfunction gsutil
        unfunction bq
        
        # Load Google Cloud SDK
        source "$HOME/google-cloud-sdk/path.zsh.inc"
        source "$HOME/google-cloud-sdk/completion.zsh.inc"
        
        gcloud "$@"
    }
    
    gsutil() {
        gcloud # This will load the SDK
        gsutil "$@"
    }
    
    bq() {
        gcloud # This will load the SDK
        bq "$@"
    }
fi

# Azure CLI lazy loading
if command -v az >/dev/null 2>&1; then
    az() {
        unfunction az
        # Load Azure CLI completion if available
        if [[ -f /usr/local/etc/bash_completion.d/az ]]; then
            autoload -U +X bashcompinit && bashcompinit
            source /usr/local/etc/bash_completion.d/az
        fi
        az "$@"
    }
fi

# =============================================================================
# KUBERNETES TOOLS
# =============================================================================

# Kubectl with faster completion
if command -v kubectl >/dev/null 2>&1; then
    kubectl() {
        unfunction kubectl
        source <(command kubectl completion zsh)
        kubectl "$@"
    }
fi

# Helm lazy loading
if command -v helm >/dev/null 2>&1; then
    helm() {
        unfunction helm
        source <(command helm completion zsh)
        helm "$@"
    }
fi

# =============================================================================
# DEVELOPMENT TOOLS
# =============================================================================

# Ruby/RVM lazy loading
if [[ -d "$HOME/.rvm" ]]; then
    rvm() {
        unfunction rvm
        source "$HOME/.rvm/scripts/rvm"
        rvm "$@"
    }
fi

# Java/SDKMAN lazy loading
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    sdk() {
        unfunction sdk
        export SDKMAN_DIR="$HOME/.sdkman"
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        sdk "$@"
    }
fi

# =============================================================================
# PERFORMANCE MONITORING
# =============================================================================

# Function to measure shell startup time
zsh_bench() {
    local i
    for i in $(seq 1 10); do
        time zsh -i -c exit
    done
}

# Function to profile zsh startup
zsh_profile() {
    PS4=$'%D{%M%S%.} %N:%i> '
    exec 3>&2 2>"/tmp/zsh-startup-$$.log"
    setopt xtrace prompt_subst
    # Your zshrc content here
    unsetopt xtrace
    exec 2>&3 3>&-
    echo "Profiling data written to /tmp/zsh-startup-$$.log"
}