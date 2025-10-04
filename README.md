# Development Container Setup

## Overview

Lightweight alternative to running a full KVM VM for development work. Uses Docker container with persistent storage to provide a complete Ubuntu development environment on a memory-constrained laptop.

## Key Features

- **Persistent environment**: Preserves manual configs, apt/pip/npm packages
- **Low memory overhead**: Uses ~1GB RAM vs full VM allocation
- **Full Ubuntu environment**: Complete OS with sudo access
- **Multiple connection methods**: SSH, VSCode Dev Containers, or direct `docker exec`
- **Snapshot capability**: Use `docker commit` to create snapshots
- **Flexible networking**: Supports `--network=host` for simplicity

## Use Cases

- Running CLI development tools (Claude Code, Gemini CLI, Codex)
- Python and JavaScript development
- Multiple terminal sessions to same environment
- Multiple VSCode windows connected to different folders in same container
- Occasional Flask app debugging

## Architecture

- **Base**: Ubuntu container (22.04 or 24.04)
- **Persistence**: Named Docker volume for home directory (configs, user packages)
- **Optional**: Bind mount for critical project files to host
- **User setup**: Non-root user with sudo privileges
- **Services**: SSH server for remote/VSCode connectivity

## Workflow

1. **Daily use**: `docker start/stop` to preserve all state
2. **Access**: Connect via SSH, VSCode Dev Containers, or `docker exec bash`
3. **Snapshots**: `docker commit` when you want to save a checkpoint
4. **Restore**: `docker run` from snapshot image to return to previous state

## Requirements

- Host: Ubuntu 22.04 Desktop
- RAM: 8GB laptop (container uses ~1GB actively)
- Disk: Few GB for container filesystem + volumes

## Important Notes

- Container is started/stopped, NOT removed/recreated (preserves everything)
- System-wide and home folder config changes live in container only
- Git repos can be cloned fresh or bind-mounted from host
- Manual environment configuration is preserved between restarts
- No automatic container rebuilds - changes persist until explicitly reset
