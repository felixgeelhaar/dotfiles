# GPG Configuration

This directory contains GPG (GNU Privacy Guard) configuration templates for commit signing, key management, and cryptographic operations.

**⚠️ SECURITY NOTICE**: This GPG configuration should NOT be stowed due to security concerns. Private keys must remain local and never be version controlled.

## Directory Structure

```
gpg/
├── .config/gpg/
│   ├── gpg.conf             # GPG daemon configuration
│   └── gpg-agent.conf       # GPG agent settings
├── backup-keys.sh           # Key backup automation script
└── README.md                # Setup and usage documentation
```

## Key Files

### `.config/gpg/gpg.conf`
- **Purpose**: GPG daemon configuration for enhanced security
- **Features**:
  - Modern cipher preferences (AES256, SHA256)
  - Strong key algorithms and hash functions
  - Security-hardened default settings
  - Keyserver configuration for key distribution
  - Trust model and verification settings

### `.config/gpg/gpg-agent.conf`
- **Purpose**: GPG agent configuration for key management
- **Features**:
  - Configurable cache timeouts for security/convenience balance
  - Pinentry program selection for password prompts
  - TTY and display settings for terminal/GUI compatibility
  - SSH agent emulation for SSH key management

### `backup-keys.sh`
- **Purpose**: Automated backup script for GPG keys
- **Functions**:
  - Export public and private keys securely
  - Create encrypted backups with timestamps
  - Verify backup integrity
  - Support for multiple backup destinations

## Configuration Features

### Security Enhancements
- **Strong algorithms**: AES256, SHA256, RSA 4096-bit minimum
- **Key preferences**: Prioritizes strongest available ciphers
- **Verification**: Strict signature verification settings
- **Cache management**: Configurable timeout for security/usability

### Agent Configuration
- **Cache timeouts**: 
  - Default: 1 hour for regular operations
  - Maximum: 8 hours for extended work sessions
  - SSH: 2 hours for SSH key operations
- **Pinentry**: Configured for both terminal and GUI environments
- **SSH support**: GPG agent can replace SSH agent

### Integration Features
- **Git signing**: Seamless integration with Git commit signing
- **SSH authentication**: GPG keys can be used for SSH
- **Terminal compatibility**: Works in tmux, screen, and SSH sessions
- **Keychain support**: macOS Keychain integration for convenience

## Setup and Configuration

### Initial Setup
```bash
# Apply GPG configuration
stow gpg

# Generate new GPG key (if needed)
gpg --full-generate-key
# Choose: RSA, 4096 bits, no expiration (or 2-5 years)
```

### Key Management
```bash
# List existing keys
gpg --list-secret-keys --keyid-format LONG

# Export public key for GitHub/GitLab
gpg --armor --export YOUR_KEY_ID

# Export for backup
./gpg/backup-keys.sh
```

### Git Integration
```bash
# Configure Git to use GPG key
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true

# Test signing
git commit --allow-empty -m "Test GPG signing"
git log --show-signature -1
```

## Security Best Practices

### Key Generation
- **Algorithm**: Use RSA 4096-bit or Ed25519 keys
- **Expiration**: Set 2-5 year expiration for security
- **Passphrase**: Use strong, unique passphrase
- **Subkeys**: Generate separate subkeys for signing/encryption

### Key Management
- **Backup**: Regular encrypted backups to secure locations
- **Revocation**: Generate and store revocation certificates
- **Distribution**: Publish public keys to keyservers
- **Rotation**: Regular key rotation for long-term security

### Operational Security
- **Cache timeouts**: Balance security and convenience
- **Agent isolation**: Separate agents for different security contexts
- **Network isolation**: Use keyservers over secure connections
- **Verification**: Always verify signatures and key fingerprints

## Development Workflow

### Commit Signing
- **Automatic**: All commits signed automatically with Git integration
- **Verification**: Commits show "Verified" badge on GitHub/GitLab
- **Trust**: Establishes authenticity and non-repudiation
- **Compliance**: Meets enterprise security requirements

### SSH Authentication
```bash
# Enable SSH support in GPG agent
echo "enable-ssh-support" >> ~/.gnupg/gpg-agent.conf

# Add SSH key to GPG
ssh-add ~/.ssh/id_rsa

# Use GPG keys for SSH
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
```

### Team Collaboration
- **Key sharing**: Share public keys via keyservers or secure channels
- **Signature verification**: Verify team member signatures
- **Trust network**: Build web of trust for team security
- **Backup coordination**: Coordinate backup procedures

## Integration with Development Tools

### Git and Version Control
- **Commit signing**: Automatic signing for all repositories
- **Tag signing**: Sign release tags for verification
- **Integration**: Works with LazyGit, GitHub CLI, and other tools
- **Verification**: Signature verification in git log and web interfaces

### SSH and Remote Access
- **SSH keys**: Use GPG keys for SSH authentication
- **Agent forwarding**: Secure agent forwarding for remote development
- **Smart card support**: Hardware security key integration
- **Yubikey**: Compatible with Yubikey and similar devices

### macOS Integration
- **Keychain**: Integration with macOS Keychain for convenience
- **Pinentry**: Native macOS password prompts
- **Notification**: System notifications for GPG operations
- **Touch ID**: Potential Touch ID integration via Pinentry

## Troubleshooting

### Common Issues
- **Agent not running**: `gpg-connect-agent reloadagent /bye`
- **Cache timeout**: Adjust timeout settings in `gpg-agent.conf`
- **Pinentry issues**: Configure appropriate pinentry program
- **SSH conflicts**: Ensure GPG agent SSH support is properly configured

### Performance and Reliability
- **Key lookup**: Configure reliable keyservers
- **Network issues**: Handle offline scenarios gracefully
- **Cache performance**: Optimize cache settings for workflow
- **Resource usage**: Monitor GPG agent resource consumption

### Security Concerns
- **Compromised keys**: Procedures for key revocation and replacement
- **Agent security**: Secure agent socket permissions
- **Memory protection**: Enable memory protection features
- **Audit trail**: Logging and monitoring GPG operations

## Backup and Recovery

### Automated Backup
```bash
# Run backup script
./gpg/backup-keys.sh

# Verify backup
gpg --dry-run --import backup/gpg-backup-YYYYMMDD.asc
```

### Manual Backup
```bash
# Export all keys
gpg --export-secret-keys --armor > private-keys.asc
gpg --export --armor > public-keys.asc

# Export specific key
gpg --export-secret-keys --armor KEY_ID > specific-key.asc
```

### Recovery Procedures
```bash
# Import from backup
gpg --import private-keys.asc
gpg --import public-keys.asc

# Restore trust
gpg --edit-key KEY_ID trust quit

# Update agent
gpg-connect-agent reloadagent /bye
```

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow gpg

# Remove configuration
stow -D gpg

# Preview changes
stow -n gpg
```

The GPG configuration integrates with Git, SSH, and the overall security infrastructure of the dotfiles ecosystem.