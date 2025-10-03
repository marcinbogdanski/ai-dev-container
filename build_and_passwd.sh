#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Stopping and removing existing container..."
docker stop devcont 2>/dev/null || true
docker rm devcont 2>/dev/null || true

echo "Building dev-container image..."
docker build -t dev-container .

echo "Starting container..."
docker run -d --name devcont --hostname devcont -p 2222:22 dev-container

echo "Setting password for devuser..."
docker exec -it devcont passwd devuser

echo "Done! Container is running."
echo "SSH into it with: ssh devuser@localhost -p 2222"
