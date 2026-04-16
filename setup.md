# Install docker

sudo snap install docker && sudo apt  install docker.io && sudo apt  install podman-docker

# Setup + Run n8n

sudo chown -R 1000:1000 ~/.n8n

chmod -R 777 ~/.n8n

# Run m8n 

podman run -it --rm --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n:Z docker.io/n8nio/n8n

# Install CloudFlares

sudo wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

# Start CloudFlares

cloudflared tunnel --url http://localhost:5678