# WezTerm Terminal Emulator Configuration

This directory contains WezTerm terminal emulator configuration optimized for development workflows with modern features and seamless integration.

## Directory Structure

```
wezterm/
├── .config/wezterm/
│   ├── wezterm.lua         # Main WezTerm configuration
│   └── CLAUDE.md           # Configuration documentation
└── README.md               # Setup and usage documentation
```

## Key Files

### `.config/wezterm/wezterm.lua`
- **Purpose**: Comprehensive WezTerm configuration for modern terminal experience
- **Features**:
  - GPU-accelerated rendering for smooth performance
  - Catppuccin Macchiato theme for visual consistency
  - Tmux-style leader key bindings for window/pane management
  - **Contextual window titles** with project type, git branch, and process indicators
  - **Neovim-optimized** with true color, large scrollback, and cursor shape support
  - **Developer shortcuts** for search, font adjustment, and scrollback management
  - Integrated clipboard and file operations
  - Development-optimized font and display settings

## Core Features

### Performance
- **GPU acceleration**: Hardware-accelerated rendering for smooth scrolling
- **Fast startup**: Optimized configuration for quick terminal startup
- **Memory efficiency**: Intelligent buffer management for large outputs
- **Responsive UI**: Low-latency input handling and display updates

### Visual Design
- **Theme**: Catppuccin Macchiato for consistency with other tools
- **Font**: JetBrains Mono Nerd Font with full icon support
- **Transparency**: Configurable window opacity for desktop integration
- **Minimal UI**: Clean interface without unnecessary chrome (tabs disabled by default)

### Contextual Window Titles
The window title provides rich context about your current development environment:

**Project Information:**
- **Folder name**: Current directory/project name
- **Project type detection**: Automatically identifies Node.js, Python, Go, Rust, Ruby, PHP, Java, Kotlin projects
- **Git branch**: Shows current git branch in parentheses (if in a git repository)

**Process Indicators** (with emojis):
- `✎ nvim` - Neovim editor active
- `⬢ node` - Node.js runtime
- `🐍 python` - Python interpreter
- `🦀 rust` - Rust toolchain (cargo/rustc)
- `🐹 go` - Go compiler/tools
- `🐳 docker` - Docker commands
- `☸ k8s` - Kubernetes tools (kubectl/k9s)
- `▶ [process]` - Other active processes

**Example Titles:**
```
dotfiles [Node.js] (main) ✎ nvim
my-api [Go] (feature/auth) 🐹 go
frontend [Node.js] (develop) ⬢ node
scripts [Python] 🐍 python
```

### Key Binding System
```bash
# Leader key: Ctrl+s (2 second timeout)
<leader> |          # Split pane horizontally
<leader> -          # Split pane vertically
<leader> h/j/k/l    # Navigate panes (vim-style)
<leader> arrow      # Resize panes
<leader> x          # Close current pane
<leader> z          # Toggle pane zoom
<leader> r          # Reload configuration
<leader> [          # Enter copy mode

# Developer shortcuts (CMD key on macOS)
CMD+k               # Clear scrollback
CMD+f               # Search in scrollback
CMD++               # Increase font size
CMD+-               # Decrease font size
CMD+0               # Reset font size
CMD+c               # Copy to clipboard
CMD+v               # Paste from clipboard
CMD+n               # New window
```

### Neovim Integration
WezTerm is optimized for Neovim with the following features:

**Visual Features:**
- **True color support**: 24-bit color for accurate theme rendering
- **Cursor shape changes**: Supports Neovim's cursor shape changes (block, bar, underline) for different modes
- **Non-blinking cursor**: Steady cursor for better focus during coding
- **60 FPS rendering**: Smooth cursor movements and animations

**Performance Features:**
- **Large scrollback**: 10,000 lines for debugging and log review
- **Kitty graphics protocol**: Image rendering support for plugins
- **Fast rendering**: GPU-accelerated text display
- **Proper TERM value**: Set to `wezterm` for optimal feature detection

**Workflow Benefits:**
- Window title shows when Neovim is active (`✎ nvim`)
- Clean UI without tabs (consistent with single-window workflow preference)
- Vim-style pane navigation matching Neovim keybindings
- Copy-paste integration with system clipboard

## Development Integration

### Tmux Compatibility
- **Seamless navigation**: Works perfectly with tmux multiplexer
- **Shared keybindings**: Compatible key bindings with tmux configuration
- **Copy-paste**: Unified clipboard operations across terminal and tmux
- **Session management**: Supports tmux session restoration

### Shell Integration
- **Zsh compatibility**: Full support for zsh with Oh-My-Zsh
- **Starship prompt**: Optimized rendering for Starship prompt
- **Modern CLI tools**: Excellent support for eza, bat, ripgrep, etc.
- **Color support**: Full 24-bit color support for enhanced visuals

### Development Workflow
- **Multi-pane layouts**: Efficient development workspace organization
- **File operations**: Drag-and-drop file support with path insertion
- **Quick terminal**: Fast terminal spawning for development tasks
- **Search integration**: Built-in search with regex support

## Configuration Features

### Appearance Customization
```lua
-- Theme configuration
color_scheme = "Catppuccin Macchiato"
font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
font_size = 14.0

-- Window appearance
window_background_opacity = 0.95
hide_tab_bar_if_only_one_tab = true
use_fancy_tab_bar = false
```

### Performance Optimization
```lua
-- Performance settings
scrollback_lines = 10000
enable_scroll_bar = false
animation_fps = 60
max_fps = 60

-- GPU acceleration
front_end = "WebGpu"
webgpu_power_preference = "HighPerformance"
```

### Key Binding Configuration
```lua
-- Leader key setup
leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 2000 }

-- Pane management
{ key = '|', mods = 'LEADER', action = act.SplitHorizontal }
{ key = '-', mods = 'LEADER', action = act.SplitVertical }
{ key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') }
```

## Integration with Development Environment

### Code Editor Integration
- **Neovim**: Terminal integration with proper color support
- **VS Code**: Compatible with integrated terminal features
- **Color schemes**: Consistent theming with editor configurations
- **Font rendering**: Optimized for code readability

### Version Control Integration
- **Git operations**: Excellent support for git diff and log viewing
- **LazyGit**: Perfect integration with LazyGit TUI
- **Delta pager**: Enhanced diff viewing with syntax highlighting
- **Terminal Git**: Full-featured Git operations in terminal

### Container Development
- **Docker**: Seamless Docker command execution and log viewing
- **Kubernetes**: kubectl command execution with proper formatting
- **SSH sessions**: Excellent support for remote development
- **Port forwarding**: Easy access to development servers

## Advanced Features

### Clipboard Integration
```bash
# Copy to system clipboard
Ctrl+Shift+C        # Copy selection

# Paste from system clipboard
Ctrl+Shift+V        # Paste

# Quick paste from clipboard ring
<leader> p          # Paste from clipboard history
```

### Search and Navigation
```bash
# Search functionality
Ctrl+Shift+F        # Open search
Ctrl+Shift+H        # Search backward
Ctrl+Shift+G        # Search forward

# Quick navigation
Page Up/Down        # Scroll by page
Ctrl+Home/End       # Jump to buffer start/end
```

### Window Management
```bash
# Tab operations
<leader> c          # Create new tab
<leader> x          # Close current tab
<leader> n          # Next tab
<leader> p          # Previous tab

# Window operations
F11                 # Toggle fullscreen
Ctrl+Shift+N        # New window
```

## Customization Options

### Theme Variants
```lua
-- Alternative Catppuccin flavors
color_scheme = "Catppuccin Mocha"     -- Dark variant
color_scheme = "Catppuccin Macchiato" -- Default
color_scheme = "Catppuccin Frappe"    -- Medium contrast
color_scheme = "Catppuccin Latte"     -- Light variant
```

### Font Configuration
```lua
-- Font customization
font = wezterm.font_with_fallback({
  'JetBrains Mono',
  'Fira Code',
  'Menlo',
  'Monaco',
})

-- Font sizing
font_size = 14.0              -- Default size
cell_width = 1.0              -- Character width
line_height = 1.0             # Line spacing
```

### Window Behavior
```lua
-- Window settings
initial_cols = 120            -- Default width
initial_rows = 30             -- Default height
window_background_opacity = 0.95  -- Transparency
macos_window_background_blur = 20 -- macOS blur effect
```

## Performance Tuning

### Resource Optimization
- **Memory management**: Efficient scrollback buffer handling
- **CPU usage**: Optimized rendering for smooth performance
- **GPU utilization**: Proper GPU acceleration configuration
- **Battery life**: Power-efficient settings for laptop use

### Network Performance
- **SSH optimization**: Low-latency remote terminal sessions
- **Bandwidth efficiency**: Optimized for slow network connections
- **Compression**: Built-in compression for remote sessions
- **Connection resilience**: Robust handling of network interruptions

## Troubleshooting

### Common Issues
- **Font rendering**: Ensure Nerd Font is properly installed
- **Color issues**: Verify terminal supports true color
- **Key binding conflicts**: Check for conflicts with system shortcuts
- **Performance**: Adjust GPU settings if experiencing issues

### Configuration Debugging
```bash
# Test configuration
wezterm start --always-new-process

# Check configuration
wezterm ls-fonts --list-system

# Debug performance
wezterm imgcat performance.png
```

### System Integration
- **macOS**: Configure proper permissions for full functionality
- **Linux**: Ensure wayland/X11 compatibility
- **SSH**: Verify terminal type propagation
- **Tmux**: Check terminfo compatibility

## Security Considerations

### Terminal Security
- **Input sanitization**: Proper handling of untrusted input
- **Clipboard security**: Secure clipboard operations
- **URL handling**: Safe URL opening with confirmation
- **File operations**: Secure file drag-and-drop handling

### Remote Sessions
- **SSH security**: Secure remote terminal sessions
- **Agent forwarding**: Proper SSH agent integration
- **Key management**: Secure handling of SSH keys
- **Network security**: Encrypted communication protocols

## Configuration Testing

### Live Configuration Updates
1. **Edit configuration**: Modify `wezterm.lua`
2. **Auto-reload**: Configuration reloads automatically
3. **Test changes**: Verify functionality immediately
4. **Debug issues**: Check WezTerm logs if problems occur

### Validation Process
```bash
# Validate configuration syntax
wezterm --config-file wezterm.lua start --always-new-process

# Test specific features
wezterm start --always-new-process -- zsh -c "echo 'Test successful'"
```

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow wezterm

# Remove configuration
stow -D wezterm

# Preview changes
stow -n wezterm
```

WezTerm serves as the foundation terminal emulator for the entire development environment, providing high performance, excellent integration, and a beautiful, consistent interface that works seamlessly with all other dotfiles configurations.