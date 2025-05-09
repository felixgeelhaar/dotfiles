# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME=""

export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$HOME/.oh-my-zsh"
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
plugins=(gh brew history minikube kubectl helm node npm nvm python pip golang rust docker ansible terraform xcode tmux httpie zsh-history-substring-search zsh-autosuggestions colored-man-pages)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

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


# oh-my-zsh plugin configuration
source ${ZSH_CUSTOM}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

source ${ZSH_CUSTOM}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# [ALIAS]
alias ls=colorls

### [LANGUAGES]
# [GOLANG]
export GOPATH=$HOME/Developer/go
alias air=$GOPATH/bin/air

export PATH="$(go env GOPATH)/bin:$PATH"

# [NVM]
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Enable GPG Signing
export GPG_TTY=$(tty)

eval "$(starship init zsh)"
source <(fzf --zsh)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
