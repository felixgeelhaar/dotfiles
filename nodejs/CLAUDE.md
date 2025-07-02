# Node.js Development Configuration

This directory contains Node.js development configuration files for package management, version control, and development workflows.

## Directory Structure

```
nodejs/
├── .npmrc                   # npm configuration and registry settings
├── .nvmrc                   # Node.js version specification for projects
├── package-scripts/
│   └── base.json           # Reusable npm scripts for common tasks
└── README.md               # Setup and usage documentation
```

## Key Files

### `.npmrc`
- **Purpose**: npm configuration for productivity and security
- **Features**:
  - Performance optimizations for faster installs
  - Security configurations for package verification
  - Registry and authentication settings
  - Cache and logging configurations
  - Private registry support

### `.nvmrc`
- **Purpose**: Node.js version specification for consistent environments
- **Usage**: Automatically detected by nvm for version switching
- **Benefits**: Ensures team uses same Node.js version
- **Integration**: Works with CI/CD and development scripts

### `package-scripts/base.json`
- **Purpose**: Reusable npm scripts for common development tasks
- **Scripts**: Build, test, lint, format, development server
- **Benefits**: Consistent commands across projects
- **Customization**: Base scripts can be extended per project

## Configuration Features

### npm Optimization
- **Fast installs**: Optimized cache and parallel downloads
- **Security**: Package verification and audit configuration
- **Registry management**: Support for multiple registries
- **Workspace support**: Monorepo and workspace configurations

### Version Management
- **Node.js versions**: Automatic version switching with nvm
- **Package compatibility**: Ensures consistent dependency resolution
- **CI/CD integration**: Reproducible builds across environments
- **Team coordination**: Shared version specifications

### Development Scripts
- **Standardized commands**: Common scripts across all projects
- **Build automation**: Webpack, Vite, Rollup configurations
- **Testing**: Jest, Vitest, Playwright script templates
- **Code quality**: ESLint, Prettier, TypeScript configurations

## Setup and Configuration

### Initial Setup
```bash
# Apply Node.js configuration
stow nodejs

# Install/switch to specified Node.js version
nvm use
# or
nvm install
```

### Project Setup
```bash
# Create new project with base scripts
npm init
cp nodejs/package-scripts/base.json package-scripts.json

# Merge base scripts into package.json
npm pkg set scripts="$(cat package-scripts.json)"
```

### Development Environment
```bash
# Install global tools
npm install -g typescript tsx nodemon pnpm yarn

# Verify configuration
npm config list
node --version
npm --version
```

## Development Workflows

### Version Management
```bash
# Switch Node.js versions automatically
cd project-directory
nvm use  # Uses .nvmrc file

# Set project Node.js version
echo "18.17.0" > .nvmrc
nvm use
```

### Package Management
```bash
# Install with optimized settings
npm install

# Use alternative package managers
pnpm install  # Faster, disk-efficient
yarn install  # Alternative with workspaces

# Security audit
npm audit
npm audit fix
```

### Common Development Tasks
```bash
# Start development server
npm run dev

# Build for production
npm run build

# Run tests
npm test
npm run test:watch

# Code quality
npm run lint
npm run format
npm run typecheck
```

## Package Manager Comparison

### npm (Default)
- **Pros**: Standard, universal compatibility, built-in security
- **Cons**: Slower installs, larger node_modules
- **Best for**: Most projects, enterprise environments

### pnpm (Recommended)
- **Pros**: Fast installs, disk efficient, strict dependency resolution
- **Cons**: Some compatibility issues with older tools
- **Best for**: New projects, monorepos, performance-critical builds

### Yarn
- **Pros**: Workspace support, deterministic installs, plugin system
- **Cons**: Additional tool to maintain, different lockfile format
- **Best for**: Large teams, complex monorepos, advanced workflows

## Security and Best Practices

### Package Security
- **Audit regularly**: Use `npm audit` in CI/CD pipelines
- **Pin versions**: Exact versions for production dependencies
- **Verify packages**: Enable package signature verification
- **Private registry**: Use private registries for internal packages

### Dependency Management
- **Keep updated**: Regular dependency updates with testing
- **Minimize dependencies**: Avoid unnecessary packages
- **Review changes**: Check package updates for breaking changes
- **Lock files**: Always commit lock files to repository

### Development Security
- **Environment variables**: Use `.env` files for configuration
- **Secrets management**: Never commit secrets to repositories
- **HTTPS**: Always use HTTPS for registry connections
- **Two-factor auth**: Enable 2FA for npm accounts

## Integration with Development Tools

### IDE Integration
- **VS Code**: Automatic Node.js version detection
- **IntelliJ**: Package.json script running and debugging
- **Vim/Neovim**: LSP integration with Node.js projects
- **Terminal**: Shell integration with nvm and npm

### CI/CD Integration
```yaml
# GitHub Actions example
- uses: actions/setup-node@v3
  with:
    node-version-file: '.nvmrc'
    cache: 'npm'
```

### Docker Integration
```dockerfile
# Use Node.js version from .nvmrc
FROM node:$(cat .nvmrc)-alpine
```

## Performance Optimization

### Build Performance
- **Cache optimization**: Configure npm cache for faster installs
- **Parallel builds**: Use multiple CPU cores for building
- **Tree shaking**: Remove unused code in production builds
- **Code splitting**: Split code for faster loading

### Development Performance
- **Hot reloading**: Fast development server reloads
- **TypeScript**: Incremental compilation for faster builds
- **Module resolution**: Optimize import paths and resolution
- **Memory management**: Monitor and optimize memory usage

## Troubleshooting

### Common Issues
- **Version conflicts**: Use nvm to switch Node.js versions
- **Permission errors**: Configure npm prefix for global installs
- **Cache corruption**: Clear npm cache with `npm cache clean --force`
- **Lock file conflicts**: Delete lock file and reinstall

### Performance Issues
- **Slow installs**: Use pnpm or configure npm cache
- **Large node_modules**: Use .npmignore and cleanup scripts
- **Memory leaks**: Profile applications and fix memory issues
- **Build slowness**: Optimize build configuration and dependencies

### Network Issues
- **Registry timeouts**: Configure timeout and retry settings
- **Proxy configuration**: Set up proxy for corporate networks
- **SSL errors**: Configure SSL settings for registries
- **Offline development**: Use npm cache for offline development

## Advanced Configuration

### Monorepo Support
```json
{
  "workspaces": [
    "packages/*",
    "apps/*"
  ]
}
```

### Custom Registry
```bash
# Configure scoped registry
npm config set @company:registry https://npm.company.com
npm config set //npm.company.com/:_authToken ${TOKEN}
```

### Performance Tuning
```bash
# Optimize for development
npm config set fund false
npm config set audit false
npm config set progress false
```

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow nodejs

# Remove configuration
stow -D nodejs

# Preview changes
stow -n nodejs
```

The Node.js configuration integrates with terminal aliases, development workflows, and the overall development environment setup.