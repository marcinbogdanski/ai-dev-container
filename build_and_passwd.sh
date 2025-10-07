#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
PROJECTS_DIR="$HOME/Projects"
mkdir -p "$PROJECTS_DIR"
PLAYWRIGHT_OUTPUT_DIR="$HOME/Tmp/playwright-mcp-output"
mkdir -p "$PLAYWRIGHT_OUTPUT_DIR"

# Stop and remove existing container
echo "Stopping and removing existing container..."
docker stop devcont 2>/dev/null || true
docker rm devcont 2>/dev/null || true

# Create a Docker volume for persistent data
echo "Creating Docker volume for persistent data..."
docker volume create devcont-home 2>/dev/null || true

# Build the Docker image
echo "Building dev-container image..."
docker build -t dev-container .

# Start the container with mounted volume
echo "Starting container..."
docker run -d \
  --name devcont \
  --hostname devcont \
  -v devcont-home:/home/devuser \
  -v $PROJECTS_DIR:/home/devuser/projects \
  -v $PLAYWRIGHT_OUTPUT_DIR:/tmp/playwright-mcp-output \
  -p 2222:22 \
  dev-container

# Set password for devuser
echo "Setting password for devuser..."
docker exec -it devcont passwd devuser

# Final message
echo "Done! Container is running."
echo "SSH into it with: ssh devuser@localhost -p 2222"
