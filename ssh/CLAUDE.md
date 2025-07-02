# SSH Configuration

This directory contains SSH configuration files for secure remote access, key management, and connection optimization.

## Directory Structure

```
ssh/
├── .ssh/
│   └── config              # SSH client configuration
├── generate-key.sh         # SSH key generation script
└── README.md              # Setup and usage documentation
```

## Key Files

### `.ssh/config`
- **Purpose**: SSH client configuration for secure and efficient connections
- **Features**:
  - Security-hardened default settings
  - Modern cryptographic preferences
  - Connection multiplexing for performance
  - Host-specific configurations
  - GitHub integration settings

### `generate-key.sh`
- **Purpose**: Automated SSH key generation with security best practices
- **Features**:
  - Multiple key type support (Ed25519, RSA)
  - Secure key generation parameters
  - Automatic key installation and configuration
  - GitHub integration setup

## Configuration Features

### Security Enhancements
- **Modern algorithms**: ChaCha20-Poly1305, AES-GCM ciphers
- **Strong key exchange**: Curve25519, DH Group 16/18
- **Host key verification**: Ed25519 and RSA certificate support
- **Protocol enforcement**: SSH protocol version 2 only

### Performance Optimization
- **Connection multiplexing**: Reuse connections for faster subsequent connects
- **Compression**: Data compression for slower connections
- **Keep-alive**: Automatic connection maintenance
- **Socket management**: Organized connection socket storage

### Convenience Features
- **Key management**: Automatic key addition to SSH agent
- **Keychain integration**: macOS Keychain integration for convenience
- **Host aliases**: Simplified connection commands
- **Jump server support**: Proxy jump configuration for complex networks

## Setup and Configuration

### Initial Setup
```bash
# Apply SSH configuration
stow ssh

# Create SSH directory and set permissions
mkdir -p ~/.ssh/sockets
chmod 700 ~/.ssh
chmod 600 ~/.ssh/config
```

### Key Generation
```bash
# Generate new SSH key with script
./ssh/generate-key.sh

# Or manually generate Ed25519 key (recommended)
ssh-keygen -t ed25519 -C "your.email@example.com"

# Or RSA key for compatibility
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
```

### GitHub Integration
```bash
# Add public key to GitHub
cat ~/.ssh/id_ed25519.pub | pbcopy
# Paste into GitHub Settings > SSH and GPG keys

# Test GitHub connection
ssh -T git@github.com
```

## Security Best Practices

### Key Management
- **Key types**: Prefer Ed25519, use RSA 4096-bit minimum
- **Passphrases**: Use strong passphrases for private keys
- **Key rotation**: Regular key rotation for long-term security
- **Backup**: Secure backup of private keys

### Access Control
- **Host verification**: Always verify host fingerprints
- **Agent forwarding**: Use cautiously, disable for untrusted hosts
- **Identity files**: Use specific identity files per host
- **Connection limits**: Configure connection timeouts and limits

### Network Security
- **Cipher preferences**: Strong cipher suite configuration
- **MAC algorithms**: Authenticated encryption preferences
- **Key exchange**: Modern key exchange algorithms
- **Host key algorithms**: Prefer Ed25519 host keys

## Connection Management

### Host Configuration Examples
```ssh
# Production server with specific key
Host production
    HostName prod.example.com
    User deploy
    Port 22
    IdentityFile ~/.ssh/id_rsa_production
    IdentitiesOnly yes

# Development server with port forwarding
Host dev
    HostName dev.example.com
    User developer
    Port 2222
    LocalForward 3000 localhost:3000
    RemoteForward 52698 localhost:52698

# Jump server configuration
Host internal
    HostName internal.local
    User admin
    ProxyJump jump-server
    IdentityFile ~/.ssh/id_ed25519
```

### Connection Multiplexing
- **Control master**: Single connection shared among multiple sessions
- **Control path**: Organized socket storage in `~/.ssh/sockets/`
- **Control persist**: Connections persist for improved performance
- **Socket permissions**: Secure socket file permissions

## Development Workflows

### Remote Development
```bash
# Connect with port forwarding for development
ssh -L 3000:localhost:3000 -L 8080:localhost:8080 dev-server

# Copy files securely
scp -r ./project/ dev-server:~/projects/

# Sync directories
rsync -avz --delete ./src/ dev-server:~/app/src/
```

### Git Integration
```bash
# Clone over SSH
git clone git@github.com:username/repository.git

# Set up SSH-based remotes
git remote add origin git@github.com:username/repository.git
```

### Key Agent Management
```bash
# Add key to agent
ssh-add ~/.ssh/id_ed25519

# List loaded keys
ssh-add -l

# Remove all keys
ssh-add -D
```

## Integration with Development Tools

### Git and Version Control
- **Repository access**: SSH-based Git operations
- **Key authentication**: Seamless GitHub/GitLab integration
- **Commit signing**: Integration with GPG commit signing
- **Multiple accounts**: Support for multiple Git accounts

### IDE and Editor Integration
- **VS Code**: Remote development over SSH
- **IntelliJ**: Remote development and deployment
- **Vim/Neovim**: Remote editing with proper terminal support
- **File synchronization**: Real-time file sync for development

### CI/CD Integration
- **Deploy keys**: Repository-specific deployment keys
- **Automation**: SSH keys for automated deployments
- **Secrets management**: Secure key storage in CI/CD systems
- **Multi-environment**: Different keys for different environments

## Advanced Configuration

### Jump Server Setup
```ssh
# Multi-hop connection through jump server
Host jump
    HostName jump.example.com
    User jumpuser
    IdentityFile ~/.ssh/id_rsa_jump

Host target
    HostName target.internal
    User targetuser
    ProxyJump jump
    IdentityFile ~/.ssh/id_ed25519
```

### Port Forwarding
```ssh
# Local port forwarding (access remote service locally)
Host webapp
    HostName web.example.com
    LocalForward 8080 localhost:80

# Remote port forwarding (expose local service remotely)
Host devserver
    HostName dev.example.com
    RemoteForward 3000 localhost:3000

# Dynamic port forwarding (SOCKS proxy)
Host proxy
    HostName proxy.example.com
    DynamicForward 1080
```

### Certificate Authentication
```ssh
# Use SSH certificates instead of keys
Host certified
    HostName secure.example.com
    CertificateFile ~/.ssh/id_ed25519-cert.pub
    IdentityFile ~/.ssh/id_ed25519
```

## Troubleshooting

### Connection Issues
- **Permission denied**: Check key permissions and SSH agent
- **Host key verification**: Update known_hosts file
- **Connection timeout**: Check network and firewall settings
- **Agent issues**: Restart SSH agent or add keys manually

### Performance Issues
- **Slow connections**: Enable compression or check network
- **Multiple prompts**: Configure proper key authentication
- **Connection drops**: Adjust keep-alive settings
- **DNS resolution**: Use IP addresses or check DNS configuration

### Security Concerns
- **Key compromise**: Revoke and replace compromised keys
- **Unauthorized access**: Monitor SSH logs and access patterns
- **Man-in-the-middle**: Verify host key fingerprints
- **Agent forwarding**: Disable on untrusted hosts

## Key Generation Script Usage

### Basic Usage
```bash
# Interactive key generation
./ssh/generate-key.sh

# Generate Ed25519 key with specific comment
./ssh/generate-key.sh -t ed25519 -c "work@company.com"

# Generate RSA key for compatibility
./ssh/generate-key.sh -t rsa -b 4096
```

### Script Features
- **Key type selection**: Ed25519 (default) or RSA
- **Custom comments**: Email or description for key identification
- **Automatic setup**: Key addition to agent and GitHub configuration
- **Permission setting**: Correct file permissions automatically applied

## Backup and Recovery

### Key Backup
```bash
# Backup private keys securely
tar -czf ssh-keys-backup.tar.gz ~/.ssh/id_*
gpg --cipher-algo AES256 --compress-algo 1 --s2k-cipher-algo AES256 \
    --s2k-digest-algo SHA512 --s2k-mode 3 --s2k-count 65536 \
    --symmetric ssh-keys-backup.tar.gz
```

### Key Recovery
```bash
# Restore from backup
gpg --decrypt ssh-keys-backup.tar.gz.gpg | tar -xz -C ~/
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/id_*.pub
```

### Configuration Backup
```bash
# Backup SSH configuration
cp ~/.ssh/config ~/.ssh/config.backup

# Version control SSH config (without private keys)
git add ssh/.ssh/config
```

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow ssh

# Remove configuration
stow -D ssh

# Preview changes
stow -n ssh
```

The SSH configuration integrates with Git, development workflows, and the overall security infrastructure of the dotfiles ecosystem.