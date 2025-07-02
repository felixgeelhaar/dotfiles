#!/bin/bash
# SSH Key Generation Script
# Generates secure SSH keys with proper settings

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
KEY_TYPE="ed25519"
KEY_SIZE=""
KEY_NAME=""
EMAIL=""

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Generate SSH keys with secure defaults"
    echo ""
    echo "Options:"
    echo "  -t TYPE    Key type (ed25519, rsa, ecdsa) [default: ed25519]"
    echo "  -s SIZE    Key size (for RSA: 2048, 3072, 4096) [default: 4096 for RSA]"
    echo "  -n NAME    Key name [default: id_TYPE]"
    echo "  -e EMAIL   Email address for key comment"
    echo "  -h         Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 -e user@example.com"
    echo "  $0 -t rsa -s 4096 -n github -e user@example.com"
}

while getopts "t:s:n:e:h" opt; do
    case $opt in
        t) KEY_TYPE="$OPTARG" ;;
        s) KEY_SIZE="$OPTARG" ;;
        n) KEY_NAME="$OPTARG" ;;
        e) EMAIL="$OPTARG" ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
    esac
done

# Validate key type
case $KEY_TYPE in
    ed25519|rsa|ecdsa) ;;
    *) echo -e "${RED}Error: Invalid key type. Use ed25519, rsa, or ecdsa${NC}"; exit 1 ;;
esac

# Set defaults based on key type
if [[ -z "$KEY_NAME" ]]; then
    KEY_NAME="id_${KEY_TYPE}"
fi

if [[ -z "$EMAIL" ]]; then
    echo -e "${YELLOW}Warning: No email provided. Using hostname as comment.${NC}"
    EMAIL="$(whoami)@$(hostname)"
fi

# Set key size for RSA if not specified
if [[ "$KEY_TYPE" == "rsa" && -z "$KEY_SIZE" ]]; then
    KEY_SIZE="4096"
fi

# Construct key path
KEY_PATH="$HOME/.ssh/$KEY_NAME"

# Check if key already exists
if [[ -f "$KEY_PATH" ]]; then
    echo -e "${RED}Error: Key already exists at $KEY_PATH${NC}"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
fi

# Generate the key
echo -e "${GREEN}Generating $KEY_TYPE SSH key...${NC}"

case $KEY_TYPE in
    ed25519)
        ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH"
        ;;
    rsa)
        ssh-keygen -t rsa -b "$KEY_SIZE" -C "$EMAIL" -f "$KEY_PATH"
        ;;
    ecdsa)
        ssh-keygen -t ecdsa -b 521 -C "$EMAIL" -f "$KEY_PATH"
        ;;
esac

# Set proper permissions
chmod 600 "$KEY_PATH"
chmod 644 "${KEY_PATH}.pub"

echo -e "${GREEN}SSH key generated successfully!${NC}"
echo ""
echo "Private key: $KEY_PATH"
echo "Public key:  ${KEY_PATH}.pub"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Add the key to SSH agent: ssh-add $KEY_PATH"
echo "2. Copy public key: cat ${KEY_PATH}.pub"
echo "3. Add public key to your services (GitHub, servers, etc.)"
echo ""
echo -e "${GREEN}Public key content:${NC}"
cat "${KEY_PATH}.pub"