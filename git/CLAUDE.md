# Git Configuration

This directory contains Git configuration files for advanced repository management, commit signing, and developer workflows.

## Directory Structure

```
git/
├── .gitconfig               # Main Git configuration with aliases and settings
├── .gitconfig.local         # Template for user-specific settings (not tracked)
├── .gitignore_global        # Global gitignore patterns for all repositories
└── README.md                # Setup and configuration guide
```

## Key Files

### `.gitconfig`
- **Purpose**: Advanced Git configuration with productivity enhancements
- **Features**:
  - Delta pager for enhanced diff viewing with syntax highlighting
  - GPG commit signing for security and verification
  - Git LFS (Large File Storage) support for binary files
  - Extensive aliases for common operations
  - Conventional commit message templates
  - Advanced merge and rebase configurations

### `.gitconfig.local` (Template)
- **Purpose**: User-specific settings that shouldn't be shared
- **Contains**: Name, email, GPG signing key, custom aliases
- **Setup**: Copy template and customize with your information
- **Location**: Included by main `.gitconfig` for personalization

### `.gitignore_global`
- **Purpose**: System-wide gitignore patterns for all repositories
- **Coverage**: macOS, Windows, Linux, editors, IDEs, build artifacts
- **Patterns**: 
  - OS-specific files (`.DS_Store`, `Thumbs.db`)
  - Editor files (`.vscode/`, `.idea/`, `*.swp`)
  - Build artifacts (`node_modules/`, `target/`, `dist/`)
  - Security files (`.env`, `*.pem`, `*.key`)

## Configuration Features

### Delta Pager
- **Enhanced diffs**: Syntax highlighting, line numbers, side-by-side view
- **Navigation**: Git-style navigation with search capabilities
- **Themes**: Catppuccin theme integration for consistency
- **Performance**: Fast rendering even for large diffs

### GPG Signing
- **Security**: All commits signed with GPG for verification
- **Integration**: Seamless integration with GitHub verified commits
- **Configuration**: Automatic signing enabled for all commits
- **Key management**: Works with GPG configuration in `../gpg/`

### Git LFS Support
- **Large files**: Efficient handling of binary files and assets
- **Tracking**: Automatic tracking of common binary file types
- **Performance**: Faster clones and reduced repository size
- **Collaboration**: Seamless sharing of large files in teams

### Aliases and Shortcuts
```bash
# Status and inspection
git st          # status
git br          # branch
git co          # checkout
git df          # diff

# Commit operations
git ci          # commit
git ca          # commit --amend
git cm "msg"    # commit -m "msg"

# History and logs
git lg          # log --graph --oneline
git lga         # log --graph --all
git hist        # detailed history with dates

# Stash operations
git sl          # stash list
git ss          # stash save
git sp          # stash pop
```

## Setup and Configuration

### Initial Setup
```bash
# Apply Git configuration
stow git

# Copy and customize local config
cp git/.gitconfig.local ~/.gitconfig.local
# Edit with your name, email, and GPG key
```

### GPG Configuration
```bash
# Generate GPG key (if not exists)
gpg --full-generate-key

# List keys and get key ID
gpg --list-secret-keys --keyid-format LONG

# Configure Git with your key ID
git config --global user.signingkey YOUR_KEY_ID
```

### Verification
```bash
# Test signed commit
git commit --allow-empty -m "Test GPG signing"

# Verify signature
git log --show-signature -1
```

## Development Workflows

### Conventional Commits
- **Format**: `type(scope): description`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
- **Examples**: 
  - `feat(auth): add OAuth2 login support`
  - `fix(ui): resolve button alignment issue`
  - `docs(api): update authentication examples`

### Branch Management
- **Feature branches**: `feature/description` or `feat/short-name`
- **Bug fixes**: `fix/issue-description` or `hotfix/critical-fix`
- **Release branches**: `release/version-number`
- **Maintenance**: `chore/task-description`

### Merge Strategies
- **Feature branches**: Use `git merge --no-ff` for clear history
- **Hotfixes**: Use fast-forward merge when appropriate
- **Release branches**: Use merge commits for tracking
- **Rebase**: Use `git rebase -i` for cleaning up commits

## Security and Best Practices

### Commit Signing
- **Requirement**: All commits must be signed
- **Verification**: Commits show "Verified" badge on GitHub
- **Trust**: Ensures commit authenticity and integrity
- **Compliance**: Meets enterprise security requirements

### Sensitive Data Protection
- **Global gitignore**: Prevents accidental commits of secrets
- **Pre-commit hooks**: Can be added for additional validation
- **Secret scanning**: Compatible with GitHub secret scanning
- **Environment files**: Automatically ignored with patterns

### Repository Hygiene
- **Clean history**: Use interactive rebase for clean commits
- **Meaningful messages**: Follow conventional commit format
- **Small commits**: Atomic changes for easier review
- **Regular cleanup**: Remove merged branches and stale remotes

## Integration with Development Tools

### IDE Integration
- **VS Code**: Git extensions use these configurations
- **IntelliJ**: Recognizes Git configurations and aliases
- **Terminal**: All aliases work in any terminal environment
- **LazyGit**: Uses these configurations for TUI operations

### CI/CD Integration
- **GitHub Actions**: Signed commits work with workflow verification
- **Commit verification**: Required status checks for signed commits
- **Release automation**: Compatible with semantic versioning tools
- **Changelog generation**: Works with conventional commit parsers

## Troubleshooting

### Common Issues
- **GPG signing fails**: Check GPG agent status and key configuration
- **Delta not working**: Ensure delta is installed via Homebrew
- **Large files**: Configure Git LFS for files over 100MB
- **Merge conflicts**: Use configured merge tool for resolution

### Performance
- **Large repositories**: Use partial clones and sparse checkout
- **LFS performance**: Configure LFS cache for faster operations
- **Delta performance**: Adjust delta configuration for large diffs
- **Alias efficiency**: Use short aliases for frequently used commands

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow git

# Remove configuration
stow -D git

# Preview changes
stow -n git
```

The Git configuration integrates with GPG, terminal aliases, and development workflows for a cohesive development environment.