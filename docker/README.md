# Docker Configuration

This directory contains Docker and Docker Compose configuration files.

## Files

- `.docker/config.json` - Docker client configuration
- `compose-templates/` - Common Docker Compose templates
- `dockerfiles/` - Useful Dockerfile examples
- `scripts/` - Docker utility scripts

## Setup

Apply with Stow:
```bash
cd ~/dotfiles
stow docker
```

## Docker Aliases

Add these to your shell configuration for improved Docker workflow:

```bash
# Docker aliases
alias d="docker"
alias dc="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcl="docker compose logs"
alias dcp="docker compose pull"
alias dcr="docker compose restart"
alias dce="docker compose exec"

# Docker management
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dv="docker volume ls"
alias dn="docker network ls"
alias dclean="docker system prune -af"
alias dstop="docker stop \$(docker ps -aq)"
alias drm="docker rm \$(docker ps -aq)"
alias drmi="docker rmi \$(docker images -q)"
```

## Useful Scripts

- `docker-cleanup.sh` - Clean up unused containers, images, and volumes
- `docker-backup.sh` - Backup Docker volumes
- `docker-health-check.sh` - Check Docker system health

## Development Templates

The `compose-templates/` directory contains common setups:
- `web-app/` - NGINX + Node.js + PostgreSQL
- `django/` - Django + PostgreSQL + Redis
- `wordpress/` - WordPress + MySQL
- `monitoring/` - Prometheus + Grafana