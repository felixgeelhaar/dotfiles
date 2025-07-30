# Claude Code Configuration

This directory contains configuration files and resources for Claude Code (claude.ai/code) integration with the dotfiles repository.

## Directory Structure

```
.claude/
├── CLAUDE.md                        # This file - Claude Code configuration documentation
├── .claude/                         # Stowable Claude Code configuration
│   ├── agents/                      # Custom agent configurations
│   │   ├── backend-development-specialist.md
│   │   ├── code-review-quality-assurance-specialist.md
│   │   ├── devops-infrastructure-specialist.md
│   │   ├── frontend-ui-ux-development-specialist.md
│   │   ├── go-backend-specialist.md
│   │   ├── product-design-strategist.md
│   │   ├── project-management-specialist.md
│   │   ├── strategic-product-management-specialist.md
│   │   └── typescript-javascript-specialist.md
│   ├── local/                       # Local Claude Code installation and dependencies
│   ├── projects/                    # Project-specific conversation history
│   ├── shell-snapshots/             # Shell environment snapshots
│   ├── statsig/                     # Usage analytics and feature flags
│   ├── todos/                       # Task management and todo tracking
│   ├── ClAUDE.md                    # Legacy Claude configuration file
│   ├── mcp.json                     # MCP (Model Context Protocol) configuration
│   └── settings.local.json          # Claude Code permissions and settings
└── .config/claude/                  # Stowable system-wide reference
    └── CLAUDE.md                     # Comprehensive best practices guide
```

## Stow Installation

To apply the Claude Code configuration system-wide:

```bash
# Apply Claude Code configuration
stow .claude

# This creates:
# ~/.claude/agents/                   # Custom agent configurations
# ~/.claude/local/                    # Local Claude Code installation  
# ~/.claude/projects/                 # Project conversation history
# ~/.claude/shell-snapshots/          # Shell environment snapshots
# ~/.claude/statsig/                  # Usage analytics and feature flags
# ~/.claude/todos/                    # Task management and todo tracking
# ~/.claude/ClAUDE.md                 # Legacy Claude configuration
# ~/.claude/mcp.json                  # MCP configuration
# ~/.claude/settings.local.json       # Claude Code permissions and settings
# ~/.config/claude/CLAUDE.md          # System-wide best practices reference
```

## Configuration Files

### Core Configuration Files

#### `~/.claude/settings.local.json`
Claude Code permissions and tool access configuration:
- **Bash permissions**: Specific command access patterns
- **Tool integrations**: Git, GPG, Homebrew, development tools
- **Security controls**: Allow/deny patterns for command execution

#### `~/.claude/mcp.json`
Model Context Protocol configuration:
- **MCP server connections**: GitHub, Playwright, Ref documentation access
- **Resource access**: Repository management, browser automation, documentation search
- **Integration settings**: Tool-specific configurations and permissions

#### `~/.claude/ClAUDE.md`
Legacy Claude configuration file (migrated from existing setup):
- **Historical configurations**: Previous Claude setup instructions
- **Migration reference**: Documentation of configuration evolution

### Agent Configurations (`~/.claude/agents/`)

Custom agent definitions for specialized development tasks:
- **backend-development-specialist.md**: Server-side architecture and database design
- **code-review-quality-assurance-specialist.md**: Code quality and security reviews  
- **devops-infrastructure-specialist.md**: Deployment and infrastructure management
- **frontend-ui-ux-development-specialist.md**: UI/UX development and design systems
- **go-backend-specialist.md**: Go-specific backend development patterns
- **product-design-strategist.md**: Product design and user experience strategy
- **project-management-specialist.md**: Project planning and delivery management
- **strategic-product-management-specialist.md**: Product strategy and roadmap planning
- **typescript-javascript-specialist.md**: TypeScript/JavaScript development expertise

### Data and History

#### `~/.claude/projects/`
Project-specific conversation history and context:
- **Conversation logs**: Per-project interaction history with Claude
- **Context preservation**: Maintains project-specific knowledge between sessions
- **Development continuity**: Enables Claude to understand ongoing project work

#### `~/.claude/todos/`
Task management and todo tracking:
- **Session todos**: Task lists from Claude Code sessions
- **Progress tracking**: Completion status and task history
- **Archive**: Historical task data for reference

#### `~/.claude/shell-snapshots/`
Shell environment snapshots for context:
- **Environment capture**: Shell state and variable snapshots
- **Context restoration**: Ability to understand shell session context
- **Debugging assistance**: Historical shell state for troubleshooting

#### `~/.claude/statsig/`
Usage analytics and feature flags:
- **Usage metrics**: Claude Code usage patterns and statistics
- **Feature flags**: Beta feature enablement and configuration
- **Performance data**: Session performance and optimization metrics

#### `~/.claude/local/`
Local Claude Code installation and dependencies:
- **Binary files**: Claude Code executable and runtime dependencies
- **Node modules**: Required JavaScript packages and libraries
- **Installation assets**: Supporting files for Claude Code operation

### System-Wide Reference

#### `~/.config/claude/CLAUDE.md`
Comprehensive system-wide best practices guide covering:
- **Enterprise Architecture**: SOLID principles, DDD, microservices patterns
- **Security Framework**: Input validation, authentication, encryption standards
- **Development Workflow**: TDD, code review, deployment strategies
- **Performance Engineering**: Database optimization, caching, monitoring
- **Technology Guidelines**: Language-specific best practices
- **Agent Utilization**: Specialized agent usage strategies

## Purpose

The `.claude` directory serves as the centralized location for:

- **Claude Code Settings**: Configuration files for Claude Code behavior
- **Project Context**: Additional context files for better code understanding
- **Custom Instructions**: Specific instructions for Claude Code operations
- **Workflow Automation**: Scripts and configurations for Claude-assisted development

## Integration with Dotfiles

This Claude Code configuration is designed to work seamlessly with the modular dotfiles architecture:

- **Stow Compatibility**: Managed with GNU Stow like other configurations
- **Documentation Consistency**: Follows the same documentation patterns as other modules
- **Security Awareness**: Respects the repository's security practices and GPG signing
- **Development Workflow**: Enhances the existing development environment setup

## Features

### Context Awareness
Claude Code is configured to understand:
- The modular architecture of this dotfiles repository
- Each tool's specific configuration patterns
- Security requirements for GPG and SSH key management
- Stow-based symlink management system

### Tool Integration
Works with all configured tools:
- **Terminal Environment**: Zsh, Oh-My-Zsh, Starship configurations
- **Code Editor**: Neovim with LSP and debugging setup
- **Version Control**: Git with GPG signing and LazyGit interface
- **Container Development**: Docker configurations and templates
- **Session Management**: Tmux multiplexer setup
- **Security Tools**: GPG and SSH key management

### Development Assistance
- **Configuration Management**: Help with stow operations and symlink management
- **Security Guidance**: Assist with GPG key generation and SSH configuration
- **Tool Setup**: Guide through complex tool installations and configurations
- **Troubleshooting**: Debug configuration issues across all modules

## Best Practices

### When Working with Claude Code

1. **Respect Existing Patterns**: Follow the established configuration patterns in each module
2. **Security First**: Never compromise GPG or SSH key security when making changes
3. **Test Changes**: Always test configuration changes in a safe environment
4. **Document Updates**: Update relevant CLAUDE.md files when making significant changes
5. **Backup Important Data**: Ensure GPG and SSH keys are backed up before major changes

### Configuration Changes

- **Use Stow**: Apply configuration changes through the stow system
- **Preserve Local Settings**: Respect `.local` files and environment-specific configurations
- **Follow Theme System**: Maintain Catppuccin theming consistency across tools
- **Version Control**: Commit configuration changes with descriptive messages

## Usage Examples

### Common Tasks
```bash
# Apply Claude Code configuration
stow .claude

# Update all configurations with Claude assistance
./update.sh

# Remove Claude Code configuration
stow -D .claude
```

### Integration Points
- **Installation Scripts**: `install.sh` and `update.sh` integration
- **Tool Configuration**: Individual module CLAUDE.md files
- **Security Operations**: GPG and SSH key management scripts
- **Development Workflows**: Container and editor setup assistance

## Backup and Recovery

### Backup Location
Complete backup of existing ~/.claude configuration is stored at:
`/Users/felixgeelhaar/dotfiles/.claude-backup-20250730_125458/`

This backup includes:
- **agents/**: All 9 specialized agent configuration files
- **todos/**: Complete todo history with archive
- **local/**: Full Claude Code installation
- **projects/**: Project conversation history
- **shell-snapshots/**: Shell environment snapshots
- **statsig/**: Usage analytics and feature flags
- **mcp.json**: MCP server configurations (puppeteer, filesystem, sequential-thinking, memory)
- **ClAUDE.md**: Legacy configuration file (empty)
- **settings.local.json**: Missing from original location

### Recovery Procedure
If the stow migration causes issues, restore from backup:
```bash
# Remove stowed configuration
stow -D .claude

# Restore from backup
cp -r /Users/felixgeelhaar/dotfiles/.claude-backup-20250730_125458/* ~/.claude/

# Verify restoration
ls -la ~/.claude/
cat ~/.claude/mcp.json
```

## Maintenance

### Regular Updates
- Keep Claude Code context files updated with repository changes
- Update documentation when adding new tools or configurations
- Ensure security practices remain current with evolving standards

### Quality Assurance
- Verify Claude Code suggestions align with repository patterns
- Test configuration changes before committing
- Maintain consistency with the overall dotfiles architecture

## Future Enhancements

Potential additions to this directory:
- **Custom Prompts**: Specialized prompts for different development tasks
- **Workflow Templates**: Common development workflow automations
- **Integration Scripts**: Enhanced integration with existing tools
- **Context Files**: Additional context for specialized development scenarios

This configuration enhances the already comprehensive dotfiles setup with intelligent assistance while maintaining the security, modularity, and consistency that defines this repository.