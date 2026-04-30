#!/bin/bash

# 1. Configuration
MY_DOMAIN="https://n8n.sagman_n8n.com"

# 2. Cleanup
podman stop n8n || true

# 3. Start the Tunnel in the background
# cloudflared will automatically find your config.yml in ~/.cloudflared/
echo "Starting Permanent Cloudflare Tunnel..."
cloudflared tunnel run n8n-server > tunnel.log 2>&1 &

# 4. Start n8n
echo "Starting n8n at $MY_DOMAIN..."
podman run -d --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n:Z \
  -e WEBHOOK_URL="$MY_DOMAIN/" \
  -e N8N_EDITOR_BASE_URL="$MY_DOMAIN/" \
  docker.io/n8nio/n8n

echo "Successfully deployed! Access your server at $MY_DOMAIN"