##!/bin/bash
#set -e

# Install Docker
curl -fsSL https://get.docker.com | sh

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Allow current user to run docker in future login sessions
sudo usermod -aG docker "$USER"

cd /local/repository

# Dynamic BASE_URL for this CloudLab node
HOST=$(hostname -f)
echo "BASE_URL=http://$HOST:8080" | sudo tee /local/repository/.env

# Pull images from registry
sudo docker compose pull

# Start the stack using pulled images
sudo docker compose up -d

# Show status for CloudLab logs
sudo docker compose ps
