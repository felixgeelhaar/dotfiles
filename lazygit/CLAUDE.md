# LazyGit Configuration

This directory contains LazyGit configuration for an enhanced Git terminal user interface with intuitive workflows and visual Git management.

## Directory Structure

```
lazygit/
├── lazygit/
│   └── config.yaml         # LazyGit configuration file
└── README.md               # Setup and usage documentation
```

## Key Files

### `lazygit/config.yaml`
- **Purpose**: LazyGit TUI configuration for Git workflow optimization
- **Features**:
  - Catppuccin theme integration for visual consistency
  - Custom key bindings for efficient Git operations
  - Enhanced diff viewing and commit management
  - Integration with external tools and editors

## Core Features

### Visual Git Interface
- **Tree view**: Intuitive file tree with status indicators
- **Branch visualization**: Clear branch structure and relationships
- **Commit history**: Interactive commit history with detailed information
- **Staging area**: Visual staging and unstaging of changes

### Key Bindings
```bash
# Navigation
j/k             # Move up/down in lists
h/l             # Navigate between panels
tab             # Switch between panels
enter           # Select/view item

# File operations
space           # Stage/unstage files
a               # Stage all files
d               # View diff
e               # Edit file

# Commit operations
c               # Commit staged changes
C               # Commit using conventional commits
A               # Amend last commit
r               # Reword commit message

# Branch operations
n               # Create new branch
b               # Switch branch
m               # Merge branch
r               # Rebase branch
```

### Workflow Integration
- **Conventional commits**: Support for conventional commit format
- **GPG signing**: Automatic commit signing integration
- **External editor**: Seamless integration with Neovim/preferred editor
- **Delta integration**: Enhanced diff viewing with syntax highlighting

## Theme and Appearance

### Catppuccin Integration
- **Color scheme**: Catppuccin theme for consistency with other tools
- **Syntax highlighting**: Enhanced code viewing with proper colors
- **Status indicators**: Clear visual indicators for file and commit status
- **Accessibility**: High contrast and readable color combinations

### Visual Elements
```yaml
# Theme configuration
gui:
  theme:
    lightTheme: false
    activeBorderColor:
      - '#89b4fa'  # Catppuccin blue
    inactiveBorderColor:
      - '#6c7086'  # Catppuccin surface2
    selectedLineBgColor:
      - '#313244'  # Catppuccin surface0
```

## Git Workflow Enhancement

### Staging and Committing
- **Interactive staging**: Visual file staging with space bar
- **Chunk staging**: Stage individual hunks within files
- **Commit templates**: Pre-configured commit message templates
- **Amend support**: Easy commit amendment and rewording

### Branch Management
```bash
# Branch operations
create branch   # n - Create new branch from current
switch branch   # b - Switch to existing branch
merge branch    # m - Merge selected branch
delete branch   # d - Delete branch (with confirmation)
rebase          # r - Interactive or simple rebase
```

### Advanced Git Operations
- **Interactive rebase**: Visual interface for commit reordering and squashing
- **Cherry picking**: Easy cherry-pick operations between branches
- **Stash management**: Create, apply, and manage stashes
- **Submodule support**: Basic submodule operations

## Integration with Development Environment

### Editor Integration
- **Neovim**: Seamless file editing with proper syntax highlighting
- **Diff viewer**: Integration with configured diff tools
- **External tools**: Custom commands for project-specific tools
- **Terminal access**: Quick terminal access for complex operations

### Git Configuration Integration
- **GPG signing**: Uses configured GPG signing settings
- **User configuration**: Respects git user.name and user.email settings
- **Aliases**: Can trigger configured git aliases
- **Hooks**: Integrates with git hooks for validation

### Development Workflow
```bash
# Common workflow
1. Open LazyGit: lg (alias)
2. Review changes: Navigate with j/k
3. Stage files: space on individual files or 'a' for all
4. Commit: c for commit, C for conventional commit
5. Push: P to push to remote
```

## Customization Options

### Key Binding Customization
```yaml
# Custom key bindings
keybinding:
  universal:
    quit: 'q'
    return: '<esc>'
    nextTab: ']'
    prevTab: '['
  files:
    stageAll: 'a'
    commitChanges: 'c'
    amendLastCommit: 'A'
```

### Display Customization
```yaml
# Display options
gui:
  showFileTree: true
  showRandomTip: false
  showBranchCommitHash: true
  showBottomLine: false
  sidePanelWidth: 0.3333
```

### External Tool Integration
```yaml
# External commands
os:
  editPreset: 'nvim'
  openDirInEditor: 'nvim {{dir}}'
  openFileInEditor: 'nvim {{filename}}'
```

## Performance and Efficiency

### Large Repository Handling
- **Efficient loading**: Optimized for large repositories
- **Lazy loading**: Content loads as needed
- **Memory management**: Efficient memory usage for long sessions
- **Index optimization**: Fast git index operations

### Keyboard-Driven Workflow
- **No mouse required**: Fully keyboard-navigable interface
- **Muscle memory**: Consistent key bindings across all views
- **Quick actions**: Single-key operations for common tasks
- **Context-aware**: Keys behave differently based on current context

## Advanced Features

### Merge Conflict Resolution
```bash
# Conflict resolution workflow
1. Navigate to conflicted file
2. Press 'e' to edit in external editor
3. Resolve conflicts in Neovim
4. Stage resolved file with space
5. Commit resolution with 'c'
```

### Interactive Rebase
```bash
# Rebase operations
r               # Start interactive rebase
s               # Squash commit
e               # Edit commit
d               # Drop commit
p               # Pick commit (default)
```

### Stash Management
```bash
# Stash operations
s               # Create new stash
space           # Apply stash
d               # Drop stash
enter           # View stash contents
```

## Integration with Other Tools

### Terminal Integration
- **Shell aliases**: Quick access via terminal aliases
- **Tmux integration**: Works seamlessly in tmux sessions
- **SSH support**: Full functionality over SSH connections
- **Screen support**: Compatible with screen multiplexer

### CI/CD Integration
- **Commit validation**: Pre-commit hook integration
- **Branch policies**: Respects branch protection rules
- **Conventional commits**: Supports commit message standards
- **Release workflows**: Integration with release automation

## Troubleshooting

### Common Issues
- **Terminal colors**: Ensure terminal supports true color
- **Key conflicts**: Check for key binding conflicts with terminal
- **Git configuration**: Verify git is properly configured
- **Performance**: Check git repository health and optimize if needed

### Configuration Issues
- **Config location**: Verify config file is in correct location
- **YAML syntax**: Check for YAML formatting errors
- **Theme loading**: Ensure theme files are accessible
- **External tools**: Verify external tool paths are correct

### Git Integration Issues
- **Authentication**: Check SSH keys and credentials
- **Remote access**: Verify network connectivity to git remotes
- **Permissions**: Check file system permissions
- **Large files**: Handle Git LFS files appropriately

## Best Practices

### Workflow Efficiency
- **Learn key bindings**: Invest time in memorizing common key combinations
- **Use conventions**: Adopt conventional commit message format
- **Regular commits**: Make small, frequent commits with clear messages
- **Branch strategy**: Use consistent branch naming and workflow

### Repository Management
- **Clean history**: Use interactive rebase to clean commit history
- **Meaningful commits**: Write clear, descriptive commit messages
- **Regular maintenance**: Periodically clean up merged branches
- **Backup important work**: Push work regularly to remote repositories

### Team Collaboration
- **Consistent workflow**: Establish team conventions for LazyGit usage
- **Code review**: Use LazyGit for efficient code review preparation
- **Conflict resolution**: Develop skills in merge conflict resolution
- **Documentation**: Document team-specific LazyGit configurations

## Advanced Workflows

### Feature Development
```bash
# Feature branch workflow
1. Create feature branch: n -> type branch name
2. Make changes and commits throughout development
3. Interactive rebase to clean history: r
4. Merge or create pull request: m or external tools
```

### Release Management
```bash
# Release preparation
1. Review all changes since last release
2. Clean up commit history with interactive rebase
3. Tag release: t -> create annotated tag
4. Push tags: P with tags option
```

### Hotfix Workflow
```bash
# Emergency fixes
1. Create hotfix branch from main/master
2. Make minimal necessary changes
3. Test and commit with clear message
4. Merge back to main and develop branches
```

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow lazygit

# Remove configuration
stow -D lazygit

# Preview changes
stow -n lazygit
```

LazyGit serves as a powerful visual interface for Git operations, integrating seamlessly with the terminal, Neovim, and overall development workflow to provide an efficient and intuitive Git experience.