#!/bin/bash

echo "Stopping n8n container..."
podman stop n8n

echo "Shutting down Cloudflare tunnel..."
pkill cloudflared

echo "Cleaning up logs..."
rm -f tunnel.log

echo "Everything is offline."