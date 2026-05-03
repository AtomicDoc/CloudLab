#!/bin/bash
set -e

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

# Start GitHub Actions self-hosted runner if it exists
if [ -d "/local/repository/actions-runner" ]; then
    echo "GitHub Actions runner directory found."

    cd /local/repository/actions-runner

    if [ -f "./svc.sh" ]; then
        echo "Installing/starting GitHub Actions runner service..."

        # Install service if it has not been installed yet
        sudo ./svc.sh install || true

        # Start runner service
        sudo ./svc.sh start || true

        # Print runner service status
        sudo ./svc.sh status || true
    else
        echo "svc.sh not found. Runner has not been configured yet."
    fi
else
    echo "No GitHub Actions runner directory found at /local/repository/actions-runner."
    echo "Configure the runner manually once using GitHub's self-hosted runner setup instructions."
fi
