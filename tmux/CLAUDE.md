# Tmux Configuration

This directory contains tmux (Terminal Multiplexer) configuration for enhanced terminal session management, productivity workflows, and development environment integration.

## Directory Structure

```
tmux/
├── .tmux.conf              # Main tmux configuration
└── README.md               # Setup and usage documentation
```

## Key Files

### `.tmux.conf`
- **Purpose**: Comprehensive tmux configuration optimized for development workflows
- **Features**:
  - Modern key bindings with leader key approach
  - Catppuccin theme integration for visual consistency
  - Enhanced pane and window management
  - Status bar with useful development information
  - Plugin integration with Tmux Plugin Manager (TPM)

## Core Features

### Leader Key Configuration
- **Leader key**: `Ctrl+s` (customizable, vim/screen style alternative)
- **Philosophy**: Consistent leader-based approach for all tmux operations
- **Muscle memory**: Designed to complement vim and other modal tools
- **Accessibility**: Ergonomic key combinations for frequent operations

### Window and Pane Management
```bash
# Window operations (leader = Ctrl+s)
<leader> c          # Create new window
<leader> &          # Kill current window
<leader> ,          # Rename window
<leader> n/p        # Next/previous window
<leader> 1-9        # Switch to window by number

# Pane operations
<leader> |          # Split pane horizontally (custom)
<leader> -          # Split pane vertically (custom)
<leader> x          # Kill current pane
<leader> o          # Switch to next pane
<leader> arrow      # Navigate panes with arrow keys
```

### Session Management
```bash
# Session operations
<leader> s          # List and switch sessions
<leader> d          # Detach from session
<leader> $          # Rename current session

# External session management
tmux new -s name    # Create named session
tmux attach -t name # Attach to session
tmux list-sessions  # List all sessions
```

## Theme and Appearance

### Catppuccin Integration
- **Theme**: Catppuccin color scheme for consistency with other tools
- **Variants**: Supports multiple Catppuccin flavors (Mocha, Macchiato, Frappe, Latte)
- **Customization**: Configurable colors and status bar elements
- **Visual harmony**: Consistent with Neovim, terminal, and other tool themes

### Status Bar
```bash
# Left status: Session and window info
[session-name] window-index:window-name

# Right status: System information
CPU: 15% | RAM: 8.2G | 15:42 | 2024-07-02
```

### Visual Enhancements
- **Pane borders**: Visible borders with activity indicators
- **Window status**: Active/inactive window highlighting
- **Activity monitoring**: Visual indicators for pane activity
- **Clock and date**: Integrated time display

## Plugin Management

### Tmux Plugin Manager (TPM)
```bash
# Plugin installation
<leader> I          # Install plugins

# Plugin updates
<leader> U          # Update plugins

# Plugin removal
<leader> alt+u      # Remove/uninstall plugins
```

### Installed Plugins
```bash
# Core plugins
tmux-sensible       # Sensible default settings
tmux-resurrect      # Session restoration
tmux-continuum      # Automatic session saving

# Theme and appearance
catppuccin/tmux     # Catppuccin theme

# Navigation and productivity
tmux-pain-control   # Improved pane management
tmux-copycat        # Enhanced search and copy
```

## Development Workflow Integration

### Vim/Neovim Integration
```bash
# Seamless navigation between tmux panes and vim splits
<C-h> <C-j> <C-k> <C-l>  # Navigate panes/splits uniformly

# Copy mode with vim bindings
<leader> [          # Enter copy mode
v                   # Begin selection (vim-style)
y                   # Copy selection
<leader> ]          # Paste
```

### Terminal Integration
- **Shell integration**: Works seamlessly with zsh configuration
- **Environment preservation**: Maintains environment variables across sessions
- **Directory awareness**: New panes open in current directory
- **Command history**: Shared history across panes in same session

### Git Workflow
```bash
# Common development layout
<leader> |          # Split for git status/log
<leader> -          # Split for tests/build output
<leader> c          # New window for different project/task
```

## Advanced Features

### Session Restoration
- **tmux-resurrect**: Manual session save/restore
- **tmux-continuum**: Automatic session saving every 15 minutes
- **Restoration scope**: Windows, panes, and working directories
- **Process restoration**: Optional restoration of running processes

### Copy and Paste
```bash
# Copy mode navigation (vim-style)
<leader> [          # Enter copy mode
h j k l             # Navigate with vim keys
v                   # Start visual selection
y                   # Copy to tmux buffer
<leader> ]          # Paste from tmux buffer

# System clipboard integration
<leader> y          # Copy to system clipboard
<leader> p          # Paste from system clipboard
```

### Mouse Support
- **Mouse mode**: Optional mouse support for pane/window operations
- **Scroll support**: Mouse wheel scrolling in panes
- **Resize support**: Mouse-based pane resizing
- **Selection**: Mouse-based text selection and copying

## Performance Optimization

### Resource Management
- **Memory efficiency**: Optimized for long-running sessions
- **CPU usage**: Minimal impact on system performance
- **Status updates**: Configurable refresh rates
- **History limits**: Balanced history size for performance

### Network Sessions
- **SSH compatibility**: Works seamlessly over SSH connections
- **Latency optimization**: Reduced key repeat delays for remote sessions
- **Connection resilience**: Maintains sessions through network interruptions
- **Agent forwarding**: Compatible with SSH agent forwarding

## Customization Options

### Key Binding Customization
```bash
# Custom leader key (alternative to Ctrl+s)
set -g prefix C-a    # Use Ctrl+a instead
unbind C-b          # Remove default prefix

# Custom split bindings
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
```

### Theme Customization
```bash
# Catppuccin theme options
set -g @catppuccin_flavour 'mocha'    # mocha, macchiato, frappe, latte
set -g @catppuccin_window_tabs_enabled on
set -g @catppuccin_date_time "%H:%M"
```

### Status Bar Customization
```bash
# Custom status elements
set -g status-left "#[fg=blue,bold]#S #[default]"
set -g status-right "#[fg=yellow]%Y-%m-%d %H:%M#[default]"
set -g status-interval 1    # Update every second
```

## Integration with Development Environment

### Docker Integration
```bash
# Container development workflow
<leader> c          # New window for docker commands
<leader> |          # Split for logs/monitoring
docker exec -it container_name /bin/bash
```

### Kubernetes Integration
```bash
# K8s development workflow
<leader> c          # New window for kubectl commands
<leader> |          # Split for pod logs
kubectl logs -f pod-name
```

### Database Management
```bash
# Database session management
<leader> c          # New window for database client
<leader> |          # Split for query results/logs
mysql -u user -p database
```

## Troubleshooting

### Common Issues
- **Key binding conflicts**: Check for conflicts with terminal/shell key bindings
- **Plugin issues**: Verify TPM installation and plugin loading
- **Theme problems**: Ensure terminal supports true color
- **Copy/paste**: Configure system clipboard integration properly

### Performance Issues
- **Slow startup**: Review plugin loading and configuration complexity
- **Memory usage**: Monitor with `tmux info` and adjust history limits
- **Network latency**: Optimize settings for remote sessions
- **Status bar**: Reduce update frequency for resource-intensive status elements

### Session Management Issues
- **Lost sessions**: Check tmux server status and session persistence
- **Restoration fails**: Verify tmux-resurrect and tmux-continuum configuration
- **Environment issues**: Check environment variable preservation settings
- **Working directory**: Ensure proper directory handling in new panes

## Best Practices

### Session Organization
- **Project-based sessions**: One session per major project
- **Descriptive names**: Use clear session and window names
- **Consistent layout**: Develop standard window/pane layouts
- **Regular cleanup**: Remove unused sessions periodically

### Workflow Efficiency
- **Muscle memory**: Practice key bindings for common operations
- **Layout templates**: Create and save common window layouts
- **Command aliases**: Use shell aliases for complex tmux commands
- **Integration**: Leverage integration with other development tools

### Maintenance
- **Regular updates**: Keep tmux and plugins updated
- **Configuration backup**: Version control tmux configuration
- **Performance monitoring**: Regularly check resource usage
- **Feature adoption**: Stay current with new tmux features

## Advanced Workflows

### Development Project Setup
```bash
# Automated project session setup
tmux new-session -d -s project-name
tmux split-window -h -t project-name
tmux split-window -v -t project-name:0.1
tmux send-keys -t project-name:0.0 'nvim .' Enter
tmux send-keys -t project-name:0.1 'npm run dev' Enter
tmux send-keys -t project-name:0.2 'git status' Enter
tmux attach -t project-name
```

### Multi-Environment Management
```bash
# Production monitoring session
tmux new-session -d -s prod-monitor
tmux split-window -h
tmux split-window -v
tmux send-keys -t prod-monitor:0.0 'ssh prod-server' Enter
tmux send-keys -t prod-monitor:0.1 'kubectl logs -f deployment/app' Enter
tmux send-keys -t prod-monitor:0.2 'htop' Enter
```

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow tmux

# Remove configuration
stow -D tmux

# Preview changes
stow -n tmux
```

The tmux configuration integrates seamlessly with the terminal, Neovim, and other tools to provide a cohesive development environment with powerful session management capabilities.