#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
DEV_CONT_HOME="/home/marcin/DevContHome"

# Check if host directory exists
if [ ! -d "$DEV_CONT_HOME" ]; then
  echo "Host directory $DEV_CONT_HOME does not exist."
  exit 1
fi

# Stop and remove existing container
echo "Stopping and removing existing container..."
docker stop devcont 2>/dev/null || true
docker rm devcont 2>/dev/null || true

# Build the Docker image
echo "Building dev-container image..."
docker build -t dev-container .

# Start the container with mounted volume
echo "Starting container..."
docker run -d \
  --name devcont \
  --hostname devcont \
  -v $DEV_CONT_HOME:/home/devuser \
  -p 2222:22 \
  dev-container

# Seed the dotfiles into the mounted home
docker exec devcont cp /etc/skel/.profile /home/devuser/
docker exec devcont cp /etc/skel/.bashrc /home/devuser/
docker exec devcont cp /etc/skel/.bash_logout /home/devuser/
docker exec devcont chown -R devuser:devuser /home/devuser

# Set password for devuser
echo "Setting password for devuser..."
docker exec -it devcont passwd devuser

# Final message
echo "Done! Container is running."
echo "SSH into it with: ssh devuser@localhost -p 2222"
