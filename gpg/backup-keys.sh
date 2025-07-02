#!/bin/bash
# GPG Key Backup Script
# This script backs up your GPG keys to a secure location

set -euo pipefail

BACKUP_DIR="${HOME}/.gnupg_backup_$(date +%Y%m%d_%H%M%S)"
echo "Creating GPG backup in: $BACKUP_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup public keys
echo "Backing up public keys..."
gpg --armor --export > "$BACKUP_DIR/public_keys.asc"

# Backup private keys (WARNING: This contains sensitive data!)
echo "Backing up private keys..."
gpg --armor --export-secret-keys > "$BACKUP_DIR/private_keys.asc"

# Backup trust database
echo "Backing up trust database..."
gpg --export-ownertrust > "$BACKUP_DIR/ownertrust.txt"

# Backup configuration files
echo "Backing up configuration files..."
cp -r ~/.gnupg/*.conf "$BACKUP_DIR/" 2>/dev/null || true

# Set secure permissions
chmod 700 "$BACKUP_DIR"
chmod 600 "$BACKUP_DIR"/*

echo "GPG backup completed in: $BACKUP_DIR"
echo "WARNING: This backup contains private keys. Store it securely and encrypt if needed!"
echo ""
echo "To restore:"
echo "  gpg --import $BACKUP_DIR/public_keys.asc"
echo "  gpg --import $BACKUP_DIR/private_keys.asc"
echo "  gpg --import-ownertrust $BACKUP_DIR/ownertrust.txt"