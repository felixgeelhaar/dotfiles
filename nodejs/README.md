# Node.js Configuration

This directory contains Node.js and npm configuration files.

## Files

- `.nvmrc` - Default Node.js version for nvm
- `.npmrc` - NPM configuration with optimized settings
- `package-scripts/` - Common package.json scripts
- `setup-node.sh` - Node.js development environment setup script

## Node Version Managers

This configuration supports multiple Node.js version managers:

### NVM (Node Version Manager)
```bash
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Use version from .nvmrc
nvm use

# Install latest LTS
nvm install --lts
nvm use --lts
```

### Volta (recommended)
```bash
# Install volta
curl https://get.volta.sh | bash

# Install Node.js
volta install node@lts
volta install npm@latest
volta install yarn@latest
```

### FNM (Fast Node Manager)
```bash
# Install fnm
brew install fnm

# Add to shell
fnm env --use-on-cd | source

# Install Node.js
fnm install --lts
fnm use lts-latest
```

## Global Packages

Common global packages to install:
```bash
npm install -g \
  @angular/cli \
  @vue/cli \
  create-react-app \
  create-next-app \
  express-generator \
  gatsby-cli \
  nodemon \
  npm-check-updates \
  prettier \
  eslint \
  typescript \
  ts-node \
  pm2 \
  serve \
  vercel \
  netlify-cli
```

## Package Scripts

Common package.json scripts are available in `package-scripts/`:
- `base.json` - Basic scripts for any Node.js project
- `react.json` - React-specific scripts
- `vue.json` - Vue.js-specific scripts
- `express.json` - Express.js server scripts

## NPM Configuration

The `.npmrc` file includes:
- Performance optimizations
- Security settings
- Development workflow improvements
- Registry configuration
- Workspace support

## Shell Integration

Add to your shell configuration for automatic Node version switching:

### For NVM:
```bash
# Automatically switch Node version when entering directory with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
```

### For FNM:
```bash
eval "$(fnm env --use-on-cd)"
```