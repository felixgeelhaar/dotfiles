# Claude Code Configuration

This directory contains stowable configuration files for Claude Code (claude.ai/code) integration.

## Directory Structure

```
.claude/
├── CLAUDE.md                        # This file - Claude Code configuration documentation
├── .claude/                         # Stowable Claude Code configuration
│   └── agents/                      # Custom agent configurations (STOWABLE)
│       ├── backend-development-specialist.md
│       ├── code-review-quality-assurance-specialist.md
│       ├── devops-infrastructure-specialist.md
│       ├── frontend-ui-ux-development-specialist.md
│       ├── go-backend-specialist.md
│       ├── product-design-strategist.md
│       ├── project-management-specialist.md
│       ├── strategic-product-management-specialist.md
│       └── typescript-javascript-specialist.md
└── .config/claude/                  # Stowable system-wide reference
    └── CLAUDE.md                    # Comprehensive best practices guide (STOWABLE)

# Runtime directories (NOT in dotfiles, live in ~/.claude):
# ~/.claude/local/                   # Local Claude Code installation and dependencies
# ~/.claude/projects/                # Project-specific conversation history
# ~/.claude/shell-snapshots/         # Shell environment snapshots
# ~/.claude/statsig/                 # Usage analytics and feature flags
# ~/.claude/todos/                   # Task management and todo tracking
# ~/.claude/ClAUDE.md                # Legacy Claude configuration file
# ~/.claude/mcp.json                 # MCP (Model Context Protocol) configuration
# ~/.claude/settings.local.json      # Claude Code permissions and settings
```

## Stow Installation

To apply the Claude Code configuration:

```bash
# Apply Claude Code configuration (agents and global CLAUDE.md only)
stow .claude

# This creates:
# ~/.claude/agents/                   # Custom agent configurations
# ~/.config/claude/CLAUDE.md          # System-wide best practices reference
```

**Important:** Runtime files (local/, projects/, shell-snapshots/, statsig/, todos/, mcp.json, settings.local.json) remain in ~/.claude and are NOT managed by stow.

## Configuration Files

### Stowable Configuration Files

#### `~/.config/claude/CLAUDE.md`
Comprehensive system-wide best practices guide covering:
- **Enterprise Architecture**: SOLID principles, DDD, microservices patterns
- **Security Framework**: Input validation, authentication, encryption standards
- **Development Workflow**: TDD, code review, deployment strategies
- **Performance Engineering**: Database optimization, caching, monitoring
- **Technology Guidelines**: Language-specific best practices
- **Agent Utilization**: Specialized agent usage strategies

#### `~/.claude/agents/` (Stowable)
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

### Runtime Configuration Files (Not Stowable)

These files contain user-specific data and runtime state, managed directly in ~/.claude:

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

### Data and History (Runtime Only)

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

## Purpose

The `.claude` directory serves as the centralized location for:

- **Shared Configuration**: Agents and best practices that can be version controlled
- **Runtime Data**: Project history, todos, and user-specific settings that are machine-local
- **Development Assistance**: Context and configurations for Claude-assisted development

## Integration with Dotfiles

This Claude Code configuration is designed to work seamlessly with the modular dotfiles architecture:

- **Stow Compatibility**: Only agents and global CLAUDE.md are managed with GNU Stow
- **Documentation Consistency**: Follows the same documentation patterns as other modules
- **Security Awareness**: Respects the repository's security practices and GPG signing
- **Runtime Separation**: Keeps user data and runtime files separate from version control

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

- **Use Stow for Shared Config**: Apply agent and global CLAUDE.md changes through stow
- **Direct Edit for Runtime**: Modify runtime files directly in ~/.claude
- **Preserve Local Settings**: Respect machine-specific configurations
- **Follow Theme System**: Maintain Catppuccin theming consistency across tools
- **Version Control**: Commit shareable configuration changes with descriptive messages

## Usage Examples

### Common Tasks
```bash
# Apply Claude Code shared configuration (agents + global CLAUDE.md)
stow .claude

# View current agents
ls ~/.claude/agents/

# Edit runtime settings directly
nvim ~/.claude/settings.local.json

# Remove shared configuration
stow -D .claude
```

### Integration Points
- **Installation Scripts**: `install.sh` and `update.sh` integration
- **Tool Configuration**: Individual module CLAUDE.md files
- **Security Operations**: GPG and SSH key management scripts
- **Development Workflows**: Container and editor setup assistance

## Maintenance

### Regular Updates
- Keep Claude Code shared configuration updated with repository changes
- Update documentation when adding new tools or configurations
- Ensure security practices remain current with evolving standards
- Sync agent configurations across development machines

### Quality Assurance
- Verify Claude Code suggestions align with repository patterns
- Test configuration changes before committing
- Maintain consistency with the overall dotfiles architecture
- Review agent configurations for relevance and accuracy

## Future Enhancements

Potential additions to this directory:
- **Custom Prompts**: Specialized prompts for different development tasks (stowable)
- **Workflow Templates**: Common development workflow automations (stowable)
- **Integration Scripts**: Enhanced integration with existing tools (stowable)
- **Context Files**: Additional context for specialized development scenarios (stowable)

This configuration enhances the comprehensive dotfiles setup with intelligent assistance while maintaining the security, modularity, and consistency that defines this repository. The separation between stowable shared configuration and runtime user data ensures both version control benefits and proper data isolation.