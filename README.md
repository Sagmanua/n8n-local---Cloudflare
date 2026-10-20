# Setup n8n for free
This is a small repo where you can create a n8n in free server CloudFlares in Linux that is pc is your server.
The problem of this metod that is you gona conect is to some pages like Elevenlabs or Google Develop console after each restart of server you need again conect it (it jsut edit link)
This is best test is a work and create a test version of n8n with some conectors  

# How to setup 

## Install docker

sudo snap install docker && sudo apt  install docker.io && sudo apt  install podman-docker

## Setup + Run n8n

sudo chown -R 1000:1000 ~/.n8n

chmod -R 777 ~/.n8n

## Run n8n 

podman run -it --rm --name n8n -p 5678:5678 -v ~/.n8n:/home/node/.n8n:Z docker.io/n8nio/n8n

## Install CloudFlares

sudo wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb

## Start CloudFlares

cloudflared tunnel --url http://localhost:5678

## Stop n8n 
podman stop n8n

## Nano excute start

nano start-n8n.sh

chmod +x start-n8n.sh

./start-n8n.sh


## Nano excute stop

nano stop-n8n.sh

chmod +x stop-n8n.sh

./stop-n8n.sh