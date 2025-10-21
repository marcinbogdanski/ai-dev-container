#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
PLAYWRIGHT_OUTPUT_DIR="$HOME/Tmp/playwright-mcp-output"
mkdir -p "$PLAYWRIGHT_OUTPUT_DIR"

docker run -d --rm \
  --name playwright-mcp \
  -p 0.0.0.0:8931:8931 \
  -v $PLAYWRIGHT_OUTPUT_DIR:/tmp/playwright-mcp-output \
  playwright-mcp --port 8931 --host 0.0.0.0
