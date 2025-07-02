# Docker Configuration

This directory contains Docker configuration files and management tools for containerized development workflows.

## Directory Structure

```
docker/
├── .docker/
│   └── config.json          # Docker daemon configuration
├── compose-templates/
│   └── web-app/
│       └── docker-compose.yml  # Web application template
├── scripts/
│   └── docker-cleanup.sh    # Container cleanup automation
└── README.md                # Setup and usage documentation
```

## Key Files

### `.docker/config.json`
- **Purpose**: Docker daemon configuration with security enhancements
- **Features**: 
  - BuildKit enabled for faster builds
  - Docker Scout security scanning integration
  - Credential store configuration for secure authentication
  - Plugin management for Docker extensions

### `compose-templates/web-app/docker-compose.yml`
- **Purpose**: Production-ready multi-service web application template
- **Services**: Web server, database, Redis cache, reverse proxy
- **Features**: Health checks, environment configuration, volume management
- **Networks**: Isolated networking with proper service communication

### `scripts/docker-cleanup.sh`
- **Purpose**: Automated Docker resource cleanup
- **Functions**: Remove stopped containers, unused images, orphaned volumes
- **Options**: Selective cleanup with confirmation prompts
- **Safety**: Preserves running containers and named volumes

## Common Commands

### Configuration Management
```bash
# Apply Docker configuration (symlink to ~/.docker/config.json)
stow docker

# Verify configuration
docker info | grep -A5 "Client:"
```

### Container Development
```bash
# Use web application template
cp docker/compose-templates/web-app/docker-compose.yml ./
docker compose up -d

# Development with auto-reload
docker compose watch
```

### Cleanup Operations
```bash
# Interactive cleanup
./docker/scripts/docker-cleanup.sh

# Full system cleanup (caution: removes everything unused)
docker system prune -af --volumes
```

## Development Workflow

### Multi-Service Applications
1. Start with the web-app template
2. Customize services for your tech stack
3. Configure environment variables in `.env`
4. Use named volumes for persistent data
5. Implement health checks for reliability

### Image Management
- Use multi-stage builds for smaller production images
- Tag images with semantic versions
- Implement security scanning in CI/CD
- Regular cleanup with the provided scripts

### Networking
- Use the default network for simple applications
- Create custom networks for complex service isolation
- Configure port mappings carefully to avoid conflicts
- Use service names for inter-container communication

## Security Best Practices

### Container Security
- Run containers as non-root users
- Use specific image tags, not `latest`
- Scan images for vulnerabilities with Docker Scout
- Limit container capabilities and resources

### Configuration Security
- Store secrets in Docker secrets or external vaults
- Use read-only root filesystems where possible
- Enable Docker Content Trust for image verification
- Regular security updates for base images

## Integration with Development Tools

### IDE Integration
- VS Code Dev Containers support via configuration
- IntelliJ Docker plugin compatibility
- Debugging support with volume mounts

### CI/CD Integration
- GitHub Actions workflows with Docker
- Automated testing in containers
- Multi-platform builds for deployment

## Troubleshooting

### Common Issues
- **Port conflicts**: Check `docker ps` and adjust port mappings
- **Permission errors**: Verify user permissions and volume mounts
- **Build failures**: Clear build cache with `docker builder prune`
- **Network issues**: Inspect networks with `docker network ls`

### Performance
- Use `.dockerignore` to exclude unnecessary files
- Leverage Docker layer caching
- Monitor resource usage with `docker stats`
- Regular cleanup to free disk space

## Stow Integration

This configuration is managed by GNU Stow:

```bash
# Apply configuration
stow docker

# Remove configuration
stow -D docker

# Preview changes
stow -n docker
```

The Docker configuration integrates with the overall dotfiles ecosystem for a consistent development environment.