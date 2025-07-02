# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a WezTerm terminal emulator configuration written in Lua. The configuration is contained in a single `wezterm.lua` file that defines appearance, behavior, and key bindings for the terminal.

## Architecture

- **Single configuration file**: `wezterm.lua` contains all terminal configuration
- **Modular structure**: Configuration is organized into sections (appearance, key bindings, behavior)
- **Leader key pattern**: Uses tmux-style leader key (Ctrl+s) for window management

## Key Configuration Areas

### Appearance & Behavior
- Color scheme: Catppuccin Macchiato
- Font: JetBrains Mono Regular
- Window opacity and decorations
- Tab bar disabled for minimal UI
- Auto-reload enabled for live configuration updates

### Key Bindings
- **Leader key**: `Ctrl+s` (2 second timeout)
- **Pane splitting**: `|` (horizontal), `-` (vertical) 
- **Pane navigation**: `h/j/k/l` (vim-style)
- **Pane resizing**: Arrow keys with leader
- **Disabled keys**: `Cmd+m` (minimize) is disabled

## Configuration Testing

To test configuration changes:
1. Save `wezterm.lua` 
2. Configuration auto-reloads (no restart needed)
3. Check WezTerm logs if issues occur: `wezterm start --always-new-process`

## Common Issues

- There are duplicate key bindings in the current configuration (lines 28-94 and 95-134) that should be cleaned up
- Leader key timeout typo: `timeout_miliseconds` should be `timeout_milliseconds`