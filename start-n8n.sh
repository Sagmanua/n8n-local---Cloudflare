#!/bin/bash

# 1. Cleanup any old logs or containers
rm -f tunnel.log
podman stop n8n || true

# 2. Start Cloudflare Tunnel
echo "Starting Cloudflare Tunnel..."
cloudflared tunnel --url http://localhost:5678 > tunnel.log 2>&1 &

# 3. Wait for the URL to actually appear in the log
echo "Waiting for Cloudflare URL..."
CF_URL=""
while [ -z "$CF_URL" ]; do
    sleep 1
    CF_URL=$(grep -o 'https://[-0-9a-z.]*trycloudflare.com' tunnel.log | head -n 1)
done

echo "Tunnel created at: $CF_URL"

# 4. Start n8n with the captured URL
echo "Starting n8n..."
podman run -d --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n:Z \
  -e WEBHOOK_URL="$CF_URL/" \
  -e N8N_EDITOR_BASE_URL="$CF_URL/" \
  docker.io/n8nio/n8n

echo "Done! You can access n8n at $CF_URL"