#!/bin/bash
# set -e

# Install Docker
curl -fsSL https://get.docker.com | sh

# Allow current user to run docker
sudo usermod -aG docker $USER
sudo newgrp docker

sleep 5

cd /local/repository

# Dynamic BASE_URL for this CloudLab node
HOST=$(hostname -f)
echo "BASE_URL=http://$HOST:8080" > /local/repository/.env

# Pull images from registry 
docker compose pull

# Start the stack using pulled images 
docker compose up -d
