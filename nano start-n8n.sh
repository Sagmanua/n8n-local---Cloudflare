#!/bin/bash
# Start n8n in the background
podman run -d --rm --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n:Z docker.io/n8nio/n8n

# Wait a few seconds for the service to wake up
echo "Starting n8n..."
sleep 5

# Run Cloudflared and show the link
echo "Creating Cloudflare Tunnel..."
cloudflared tunnel --url http://localhost:5678