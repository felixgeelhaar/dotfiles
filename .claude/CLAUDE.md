# Claude Code Configuration

This directory contains stowable configuration files for Claude Code (claude.ai/code) integration.

## Directory Structure

```
.claude/
├── CLAUDE.md                        # This file - Claude Code configuration documentation
├── .claude/                         # Stowable Claude Code configuration
│   └── agents/                      # Custom agent configurations (STOWABLE)
│       ├── code-review-specialist.md
│       ├── database-architecture-specialist.md
│       ├── devops-infrastructure-specialist.md
│       ├── frontend-ui-ux-specialist.md
│       ├── go-backend-expert.md
│       ├── governance-standards-enforcer.md
│       ├── performance-engineering-specialist.md
│       ├── playwright-qa-specialist.md
│       ├── product-strategy-manager.md
│       ├── python-backend-specialist.md
│       ├── security-compliance-specialist.md
│       ├── tdd-testing-specialist.md
│       ├── technical-architect.md
│       └── typescript-node-specialist.md
└── .config/claude/                  # Stowable system-wide reference
    └── CLAUDE.md                    # Comprehensive best practices guide (STOWABLE)

# NOTE: settings.json is NOT managed by dotfiles
# Claude Code dynamically writes to ~/.claude/settings.json
# Managing it via stow causes conflicts during Claude updates

# Runtime directories (NOT in dotfiles, live in ~/.claude):
# ~/.claude/skills/                  # Personal skills (global, available across all projects)
# │   ├── tdd-workflow/              # Test-Driven Development workflow
# │   ├── git-workflow-commit-standards/ # Git workflow and commit standards
# │   ├── code-review-checklist/     # Code review checklist
# │   ├── refactoring-patterns/      # Refactoring techniques and patterns
# │   ├── enterprise-architecture-review/ # Architecture review skill
# │   ├── api-design-documentation/  # API design and documentation
# │   ├── database-design-migration/ # Database design and migrations
# │   ├── security-audit/            # Security auditing skill
# │   ├── performance-optimization-profiling/ # Performance optimization
# │   ├── production-readiness/      # Production readiness checklist
# │   ├── observability-logging-setup/ # Logging and observability
# │   ├── docker-demo-environment/   # Docker demo environment setup
# │   └── dependency-management-security/ # Dependency management and security
# ~/.claude/local/                   # Local Claude Code installation and dependencies
# ~/.claude/projects/                # Project-specific conversation history
# ~/.claude/shell-snapshots/         # Shell environment snapshots
# ~/.claude/statsig/                 # Usage analytics and feature flags
# ~/.claude/todos/                   # Task management and todo tracking
# ~/.claude/ClAUDE.md                # Legacy Claude configuration file
# ~/.claude/mcp.json                 # MCP (Model Context Protocol) configuration
# ~/.claude/settings.local.json      # Local overrides for settings (if needed)
```

## Stow Installation

To apply the Claude Code configuration:

```bash
# Apply Claude Code configuration (agents and global CLAUDE.md)
stow .claude

# This creates:
# ~/.claude/agents/                   # Custom agent configurations
# ~/.config/claude/CLAUDE.md          # System-wide best practices reference
```

**Important:**
- `settings.json` is NOT managed by stow - Claude Code dynamically manages this file
- Runtime files (local/, projects/, shell-snapshots/, statsig/, todos/, mcp.json, settings.local.json) remain in ~/.claude and are NOT managed by stow
- If you need to share base settings, use `settings.local.json` for local overrides

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
- **code-review-specialist.md**: Code quality and security reviews
- **database-architecture-specialist.md**: Database design and optimization
- **devops-infrastructure-specialist.md**: Deployment and infrastructure management
- **frontend-ui-ux-specialist.md**: UI/UX development and design systems
- **go-backend-expert.md**: Go-specific backend development patterns
- **governance-standards-enforcer.md**: Standards compliance and governance
- **performance-engineering-specialist.md**: Performance optimization
- **playwright-qa-specialist.md**: End-to-end testing with Playwright
- **product-strategy-manager.md**: Product strategy and roadmap planning
- **python-backend-specialist.md**: Python backend development
- **security-compliance-specialist.md**: Security auditing and compliance
- **tdd-testing-specialist.md**: Test-driven development
- **technical-architect.md**: System architecture and design
- **typescript-node-specialist.md**: TypeScript/JavaScript development expertise

#### `~/.claude/settings.json` (NOT Stowable - Runtime Managed)
Claude Code dynamically manages `settings.json` - do NOT include it in dotfiles:
- Claude writes to this file during normal operation
- Symlinks get overwritten, causing conflicts
- Use `settings.local.json` for machine-specific overrides instead

#### `~/.claude/skills/` (Personal Skills)
Global skills that extend Claude's capabilities across all projects:

**Development Workflow:**
- **tdd-workflow**: Test-Driven Development workflow with Red-Green-Refactor cycle, atomic commits, and Vitest/Playwright integration
- **git-workflow-commit-standards**: Git workflow, conventional commits, atomic commits, branch strategies, and interactive rebase

**Code Quality:**
- **code-review-checklist**: Comprehensive code review covering functionality, quality, testing, security, performance, and documentation
- **refactoring-patterns**: Code smell detection, refactoring techniques, Boy Scout Rule, and technical debt management

**Architecture & Design:**
- **enterprise-architecture-review**: SOLID principles, DDD, Clean Architecture, microservices patterns, and architecture decision records
- **api-design-documentation**: RESTful and GraphQL API design, OpenAPI/Swagger documentation, versioning, and best practices
- **database-design-migration**: Schema design, normalization, indexing, migrations, query optimization, and data modeling

**Security & Performance:**
- **security-audit**: OWASP Top 10, input validation, authentication, authorization, encryption, and security headers
- **performance-optimization-profiling**: Profiling, memory leak detection, bundle optimization, query optimization, and load testing

**Operations:**
- **production-readiness**: 12-Factor App, health checks, graceful shutdown, resilience patterns, and monitoring
- **observability-logging-setup**: Structured logging, correlation IDs, metrics, distributed tracing, and alerting
- **docker-demo-environment**: Production-grade Docker demo environments with database seeding and data separation
- **dependency-management-security**: Vulnerability scanning, automated updates, breaking change detection, and supply chain security

Skills are model-invoked (Claude decides when to use them based on context) and package expertise into discoverable capabilities.

### Understanding Skills vs Agents

**Agents** are specialized AI personas invoked explicitly by the user or Claude Code for complex multi-step tasks:
- User or system explicitly launches agents with the Task tool
- Examples: `devops-infrastructure-specialist`, `frontend-ui-ux-specialist`
- Long-running autonomous operations
- Can use all available tools

**Skills** are model-invoked capabilities that Claude automatically uses when relevant:
- Claude autonomously decides to use skills based on the task context
- Examples: TDD workflow triggers when writing tests, security audit triggers when reviewing security
- Focused on specific workflows or checklists
- Can restrict tool usage with `allowed-tools` field
- Lighter-weight than agents, perfect for patterns and workflows

**When to Use Each:**
- Use **agents** for complex, multi-step projects requiring planning and execution (e.g., "design and implement a microservices architecture")
- Use **skills** for recurring workflows, checklists, and best practices (e.g., TDD cycle, security audits, production readiness checks)

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

# View installed skills
ls ~/.claude/skills/

# Edit a skill
nvim ~/.claude/skills/tdd-workflow/SKILL.md

# Create a new skill
mkdir -p ~/.claude/skills/my-new-skill
nvim ~/.claude/skills/my-new-skill/SKILL.md

# Edit runtime settings directly
nvim ~/.claude/settings.local.json

# Remove shared configuration
stow -D .claude
```

### Using Skills

Skills activate automatically when Claude detects relevant context:

```bash
# Development Workflow Skills activate when you:
# - Ask to write tests, mention TDD → TDD Workflow skill
# - Write commit messages, create branches → Git Workflow skill

# Code Quality Skills activate when you:
# - Request code review, PR review → Code Review Checklist skill
# - Refactor code, mention code smells → Refactoring Patterns skill

# Architecture Skills activate when you:
# - Design systems, review architecture → Enterprise Architecture Review skill
# - Design APIs, create endpoints → API Design & Documentation skill
# - Design database schema, create migrations → Database Design & Migration skill

# Security & Performance Skills activate when you:
# - Security review, mention OWASP → Security Audit skill
# - Optimize performance, profile code → Performance Optimization skill

# Operations Skills activate when you:
# - Prepare for production deployment → Production Readiness skill
# - Set up logging, implement monitoring → Observability & Logging skill
# - Create demo environments → Docker Demo Environment skill
# - Update dependencies, fix vulnerabilities → Dependency Management skill

# Check which skills are available
# Just ask Claude: "What skills are available?"
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
- **Additional Skills**: More specialized skills for specific frameworks and workflows
  - Accessibility (a11y) audit skill
  - CI/CD pipeline configuration skill (GitHub Actions, GitLab CI, Jenkins)
  - Container orchestration skill (Kubernetes, Docker Swarm)
  - Incident response and postmortem skill
  - API integration testing skill
  - Mobile-first responsive design skill
  - Internationalization (i18n) and localization skill
  - Data privacy and GDPR compliance skill
- **Project-Specific Skills**: Skills in `.claude/skills/` within projects for team-shared workflows
- **Custom Prompts**: Specialized prompts for different development tasks (stowable)
- **Workflow Templates**: Common development workflow automations (stowable)
- **Integration Scripts**: Enhanced integration with existing tools (stowable)
- **Context Files**: Additional context for specialized development scenarios (stowable)

This configuration enhances the comprehensive dotfiles setup with intelligent assistance while maintaining the security, modularity, and consistency that defines this repository. The separation between stowable shared configuration and runtime user data ensures both version control benefits and proper data isolation.