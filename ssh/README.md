# SSH Configuration

This directory contains SSH configuration files managed by GNU Stow.

## Files

- `.ssh/config` - SSH client configuration with security-hardened defaults
- `generate-key.sh` - Script to generate new SSH keys with proper settings
- `setup-github.sh` - Script to configure SSH for GitHub

## Setup

1. Create the SSH sockets directory:
   ```bash
   mkdir -p ~/.ssh/sockets
   ```

2. Apply with Stow:
   ```bash
   cd ~/dotfiles
   stow ssh
   ```

3. Set proper permissions:
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/config
   chmod 600 ~/.ssh/id_*
   chmod 644 ~/.ssh/id_*.pub
   ```

## Key Generation

Generate a new SSH key:
```bash
./generate-key.sh
```

## Security Notes

- Uses modern cryptographic algorithms
- Enables connection multiplexing for performance
- Configured for security-first approach
- Keys should be protected with strong passphrases

## GitHub Setup

After generating keys, add your public key to GitHub:
1. Copy public key: `cat ~/.ssh/id_ed25519.pub`
2. Go to GitHub → Settings → SSH and GPG keys
3. Add new SSH key and paste the public key

Test connection:
```bash
ssh -T git@github.com
```