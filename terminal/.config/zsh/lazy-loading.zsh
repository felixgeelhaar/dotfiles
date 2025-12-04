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

    # Track if NVM is loaded
    _nvm_loaded=0

    # Lazy load nvm
    nvm() {
        unfunction nvm
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        _nvm_loaded=1
        nvm "$@"
    }

    # Auto-use .nvmrc if available (only triggers if .nvmrc exists)
    autoload -U add-zsh-hook
    load-nvmrc() {
        # Check for .nvmrc BEFORE loading nvm to avoid triggering lazy load in every directory
        local nvmrc_path="$PWD/.nvmrc"
        [[ ! -f "$nvmrc_path" ]] && nvmrc_path="$(command git rev-parse --show-toplevel 2>/dev/null)/.nvmrc"

        if [[ -f "$nvmrc_path" ]]; then
            # Only now load nvm if not already loaded
            if (( _nvm_loaded == 0 )); then
                unfunction nvm 2>/dev/null
                [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
                _nvm_loaded=1
            fi

            local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")" 2>/dev/null)
            local node_version="$(nvm version 2>/dev/null)"

            if [ "$nvmrc_node_version" = "N/A" ]; then
                nvm install
            elif [ "$nvmrc_node_version" != "$node_version" ]; then
                nvm use
            fi
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

# Poetry - no lazy loading needed (modern poetry installs to ~/.local/bin)
# Just ensure PATH includes poetry location
if [[ -d "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# =============================================================================
# CONTAINERIZATION TOOLS
# =============================================================================

# Note: Docker Compose V2 is integrated with `docker compose` (no separate lazy loading needed)
# Standalone docker-compose V1 is deprecated

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