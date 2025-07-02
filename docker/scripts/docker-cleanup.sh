#!/bin/bash
# Docker Cleanup Script
# Safely removes unused Docker resources

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

show_help() {
    echo "Docker Cleanup Script"
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -a, --all       Remove all unused resources (containers, images, volumes, networks)"
    echo "  -c, --containers Remove stopped containers only"
    echo "  -i, --images    Remove unused images only"
    echo "  -v, --volumes   Remove unused volumes only"
    echo "  -n, --networks  Remove unused networks only"
    echo "  -f, --force     Skip confirmation prompts"
    echo "  -h, --help      Show this help"
    echo ""
    echo "Examples:"
    echo "  $0 -a           # Clean everything (interactive)"
    echo "  $0 -af          # Clean everything (no prompts)"
    echo "  $0 -ci          # Clean containers and images only"
}

confirm() {
    if [[ "${FORCE:-false}" == "true" ]]; then
        return 0
    fi
    
    local message="$1"
    echo -e "${YELLOW}$message${NC}"
    read -p "Continue? (y/N): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

cleanup_containers() {
    echo -e "${BLUE}Checking for stopped containers...${NC}"
    local stopped_containers
    stopped_containers=$(docker ps -aq --filter status=exited --filter status=created 2>/dev/null || echo "")
    
    if [[ -n "$stopped_containers" ]]; then
        echo -e "${YELLOW}Found stopped containers:${NC}"
        docker ps -a --filter status=exited --filter status=created --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"
        
        if confirm "Remove stopped containers?"; then
            docker rm $stopped_containers
            echo -e "${GREEN}Stopped containers removed.${NC}"
        fi
    else
        echo -e "${GREEN}No stopped containers found.${NC}"
    fi
}

cleanup_images() {
    echo -e "${BLUE}Checking for unused images...${NC}"
    
    # Remove dangling images
    local dangling_images
    dangling_images=$(docker images -f "dangling=true" -q 2>/dev/null || echo "")
    
    if [[ -n "$dangling_images" ]]; then
        echo -e "${YELLOW}Found dangling images:${NC}"
        docker images -f "dangling=true"
        
        if confirm "Remove dangling images?"; then
            docker rmi $dangling_images
            echo -e "${GREEN}Dangling images removed.${NC}"
        fi
    else
        echo -e "${GREEN}No dangling images found.${NC}"
    fi
    
    # Remove unused images
    echo -e "${BLUE}Checking for unused images...${NC}"
    if confirm "Remove all unused images? (This will remove images not used by any container)"; then
        docker image prune -a
        echo -e "${GREEN}Unused images removed.${NC}"
    fi
}

cleanup_volumes() {
    echo -e "${BLUE}Checking for unused volumes...${NC}"
    local unused_volumes
    unused_volumes=$(docker volume ls -q --filter dangling=true 2>/dev/null || echo "")
    
    if [[ -n "$unused_volumes" ]]; then
        echo -e "${YELLOW}Found unused volumes:${NC}"
        docker volume ls --filter dangling=true
        
        if confirm "Remove unused volumes? (This will permanently delete volume data!)"; then
            docker volume rm $unused_volumes
            echo -e "${GREEN}Unused volumes removed.${NC}"
        fi
    else
        echo -e "${GREEN}No unused volumes found.${NC}"
    fi
}

cleanup_networks() {
    echo -e "${BLUE}Checking for unused networks...${NC}"
    if confirm "Remove unused networks?"; then
        docker network prune -f
        echo -e "${GREEN}Unused networks removed.${NC}"
    fi
}

show_usage() {
    echo -e "${BLUE}Current Docker usage:${NC}"
    docker system df
}

# Parse command line arguments
CLEANUP_ALL=false
CLEANUP_CONTAINERS=false
CLEANUP_IMAGES=false
CLEANUP_VOLUMES=false
CLEANUP_NETWORKS=false
FORCE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -a|--all)
            CLEANUP_ALL=true
            shift
            ;;
        -c|--containers)
            CLEANUP_CONTAINERS=true
            shift
            ;;
        -i|--images)
            CLEANUP_IMAGES=true
            shift
            ;;
        -v|--volumes)
            CLEANUP_VOLUMES=true
            shift
            ;;
        -n|--networks)
            CLEANUP_NETWORKS=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Show current usage
show_usage
echo ""

# If no specific options, show help
if [[ "$CLEANUP_ALL" == false && "$CLEANUP_CONTAINERS" == false && "$CLEANUP_IMAGES" == false && "$CLEANUP_VOLUMES" == false && "$CLEANUP_NETWORKS" == false ]]; then
    show_help
    exit 0
fi

# Perform cleanup operations
if [[ "$CLEANUP_ALL" == true ]]; then
    cleanup_containers
    cleanup_images
    cleanup_volumes
    cleanup_networks
else
    [[ "$CLEANUP_CONTAINERS" == true ]] && cleanup_containers
    [[ "$CLEANUP_IMAGES" == true ]] && cleanup_images
    [[ "$CLEANUP_VOLUMES" == true ]] && cleanup_volumes
    [[ "$CLEANUP_NETWORKS" == true ]] && cleanup_networks
fi

echo ""
echo -e "${GREEN}Cleanup completed!${NC}"
echo ""
echo -e "${BLUE}Updated Docker usage:${NC}"
docker system df