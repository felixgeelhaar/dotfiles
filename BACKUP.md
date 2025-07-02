# Backup and Restore Guide

This guide covers backing up and restoring your complete development environment configuration.

## Quick Backup Checklist

Before making major changes or setting up a new machine, backup these critical items:

- [ ] GPG keys and trust database
- [ ] SSH keys and known hosts
- [ ] Git configuration and credentials
- [ ] Browser bookmarks and extensions
- [ ] Application-specific data
- [ ] Development projects and databases

## 🔐 Security-Critical Backups

### GPG Keys
```bash
# Backup GPG keys (run from dotfiles directory)
./gpg/backup-keys.sh

# Manual backup
gpg --armor --export > public-keys.asc
gpg --armor --export-secret-keys > private-keys.asc
gpg --export-ownertrust > trust-db.txt
```

### SSH Keys
```bash
# Backup SSH directory
cp -r ~/.ssh ~/backup/ssh-backup-$(date +%Y%m%d)

# List all SSH keys
ls -la ~/.ssh/*.pub

# Backup specific keys
cp ~/.ssh/id_* ~/backup/
```

### Git Credentials
```bash
# Backup git configuration
cp ~/.gitconfig ~/backup/
cp ~/.gitconfig.local ~/backup/

# If using credential helper
git config --list | grep credential
```

## 📁 Application Data Backup

### Development Tools
```bash
# Docker
docker volume ls
docker volume inspect <volume_name>

# Kubernetes contexts
kubectl config view --raw > kubernetes-config-backup.yaml

# VS Code extensions (if using)
code --list-extensions > vscode-extensions.txt

# Homebrew packages
brew list > homebrew-packages.txt
brew list --cask > homebrew-casks.txt
```

### Database Backups
```bash
# PostgreSQL
pg_dumpall > postgres-backup.sql

# MySQL
mysqldump --all-databases > mysql-backup.sql

# MongoDB
mongodump --out mongodb-backup/

# Redis
redis-cli BGSAVE
cp /var/lib/redis/dump.rdb redis-backup.rdb
```

### Browser Data
- **Chrome**: `~/Library/Application Support/Google/Chrome/Default/`
- **Firefox**: `~/Library/Application Support/Firefox/Profiles/`
- **Safari**: Bookmarks can be exported from Safari > File > Export Bookmarks

## 🔄 Complete System Backup Script

Create a comprehensive backup script:

```bash
#!/bin/bash
# Complete development environment backup

BACKUP_DIR="$HOME/dev-backup-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "Creating backup in: $BACKUP_DIR"

# GPG Keys
echo "Backing up GPG keys..."
gpg --armor --export > "$BACKUP_DIR/public-keys.asc"
gpg --armor --export-secret-keys > "$BACKUP_DIR/private-keys.asc"
gpg --export-ownertrust > "$BACKUP_DIR/trust-db.txt"

# SSH Keys
echo "Backing up SSH keys..."
cp -r ~/.ssh "$BACKUP_DIR/ssh"

# Git configuration
echo "Backing up Git configuration..."
cp ~/.gitconfig "$BACKUP_DIR/"
cp ~/.gitconfig.local "$BACKUP_DIR/" 2>/dev/null || true

# Development tools
echo "Backing up development tool configurations..."
brew list > "$BACKUP_DIR/homebrew-packages.txt"
brew list --cask > "$BACKUP_DIR/homebrew-casks.txt"
npm list -g --depth=0 > "$BACKUP_DIR/npm-global-packages.txt" 2>/dev/null || true
code --list-extensions > "$BACKUP_DIR/vscode-extensions.txt" 2>/dev/null || true

# Kubernetes
kubectl config view --raw > "$BACKUP_DIR/kubernetes-config.yaml" 2>/dev/null || true

# Application Support directories
echo "Backing up application data..."
cp -r ~/Library/Application\ Support/Code "$BACKUP_DIR/vscode-data" 2>/dev/null || true

echo "Backup completed: $BACKUP_DIR"
echo "IMPORTANT: Store this backup in a secure, encrypted location!"
```

## 🔧 Restore Procedures

### New Machine Setup
1. **Clone dotfiles repository**
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Run installation script**
   ```bash
   ./install.sh
   ```

3. **Restore GPG keys**
   ```bash
   gpg --import public-keys.asc
   gpg --import private-keys.asc
   gpg --import-ownertrust trust-db.txt
   ```

4. **Restore SSH keys**
   ```bash
   cp backup/ssh/* ~/.ssh/
   chmod 600 ~/.ssh/id_*
   chmod 644 ~/.ssh/id_*.pub
   chmod 600 ~/.ssh/config
   ```

5. **Configure Git**
   ```bash
   # Edit ~/.gitconfig.local with your information
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   git config --global user.signingkey YOUR_GPG_KEY_ID
   ```

### Selective Restore

#### Restore Homebrew packages
```bash
# Install packages from backup
xargs brew install < homebrew-packages.txt
xargs brew install --cask < homebrew-casks.txt
```

#### Restore NPM packages
```bash
# Extract and install global packages
npm install -g $(cat npm-global-packages.txt | grep -E '^├──|^└──' | awk '{print $2}' | sed 's/@.*//')
```

#### Restore VS Code extensions
```bash
cat vscode-extensions.txt | xargs -n 1 code --install-extension
```

#### Restore Kubernetes contexts
```bash
# Backup current config
cp ~/.kube/config ~/.kube/config.backup

# Restore from backup
cp kubernetes-config.yaml ~/.kube/config
```

## 🔄 Regular Maintenance

### Automated Backup Schedule
Set up a cron job for regular backups:

```bash
# Edit crontab
crontab -e

# Add weekly backup (every Sunday at 2 AM)
0 2 * * 0 /path/to/backup-script.sh
```

### Version Control for Dotfiles
```bash
# Regular commits of dotfile changes
cd ~/dotfiles
git add .
git commit -m "Update configurations - $(date +%Y-%m-%d)"
git push origin main
```

### Cleanup Old Backups
```bash
# Remove backups older than 30 days
find ~/backups -name "dev-backup-*" -mtime +30 -exec rm -rf {} \;
```

## 🚨 Emergency Recovery

### Lost Git History
```bash
# If you lose local git history
git clone --mirror https://github.com/yourusername/dotfiles.git
cd dotfiles.git
git config --bool core.bare false
git checkout main
```

### Corrupted Shell Configuration
```bash
# Reset to default shell
chsh -s /bin/bash

# Restore from dotfiles
cd ~/dotfiles
stow terminal --restow
```

### GPG Key Recovery
If you lose access to GPG keys:
1. Use your backup private key
2. Import the key: `gpg --import private-keys.asc`
3. Set trust level: `gpg --edit-key YOUR_KEY_ID` then `trust` then `5` (ultimate)

## 📝 Documentation

Keep documentation of:
- Custom configurations and their purposes
- Installed software and versions
- Important file locations
- Recovery procedures specific to your setup
- Contact information for services requiring re-authentication

## 🔒 Security Notes

- **Encrypt sensitive backups** using tools like `gpg` or disk encryption
- **Store backups in multiple locations** (local + cloud + physical)
- **Test restore procedures regularly** to ensure they work
- **Never store passwords in plain text** - use password managers
- **Regularly rotate SSH keys and GPG keys**

## ☁️ Cloud Backup Options

### Encrypted Cloud Storage
```bash
# Using rclone with encryption
rclone copy ~/backups remote:encrypted-backups

# Using tar with GPG encryption
tar czf - ~/backups | gpg --cipher-algo AES256 --compress-algo 1 --symmetric --output backup.tar.gz.gpg
```

### Git-based Backup
```bash
# Create private repository for sensitive configs
git init ~/private-dotfiles
cd ~/private-dotfiles
git remote add origin https://github.com/yourusername/private-dotfiles.git

# Add encrypted files
gpg --cipher-algo AES256 --compress-algo 1 --symmetric --output ssh-keys.gpg ~/.ssh
git add ssh-keys.gpg
git commit -m "Backup SSH keys"
git push origin main
```