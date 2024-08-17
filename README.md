# DOTFILE Configuration

Welcome everyone! This is my personal dotfile repository.
Usually I use these days `wezterm + starship` and mostly work on

- golang
- nodejs, javascript, typescript, bun
- rust
- python
- lua.

## How To

I use the dotfiles in combination with `stow`.
This enables to manage the dotfiles in a repo and enable these configurations via symlinks.

Navigate to your dotfiles directory and run:

```bash
    cd ~/dotfiles
    # stow <config directory>
    # for neovim config it looks like
    stow nvim
```

This essentially creates a symlink in your HOME directory to `.config/nvim`.

## Inspirations & Credits

The following amazing people inspired my configs and earn credit! Thank you!

- Dotfiles configuration of [carmen-gh](https://github.com/carmen-gh/.dotfiles "dotfiles of carmen-gh")
- Dotfiles configuration of [typecraft](https://github.com/typecraft-dev/dotfiles "dotfiles of typecraft")
