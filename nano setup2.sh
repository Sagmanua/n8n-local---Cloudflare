# 1. Start Cloudflared in the background and save the log
echo "Starting Cloudflare Tunnel..."
cloudflared tunnel --url http://localhost:5678 > tunnel.log 2>&1 &

# 2. Wait a moment and grab the random URL from the log
sleep 5
CF_URL=$(grep -o 'https://[-0-9a-z.]*trycloudflare.com' tunnel.log | head -n 1)

echo "Tunnel created at: $CF_URL"

# 3. Run Podman with the WEBHOOK_URL variable
echo "Starting n8n..."
podman run -d --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n:Z \
  -e WEBHOOK_URL="$CF_URL/" \
  -e N8N_EDITOR_BASE_URL="$CF_URL/" \
  docker.io/n8nio/n8n