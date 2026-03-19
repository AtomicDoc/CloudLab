#!/bin/bash
set -e

curl -fsSL https://get.docker.com | sh

# start Docker
sudo systemctl enable docker
sudo systemctl start docker

sudo usermod -aG docker $USER

sleep 5

cd /local/repository

HOST=$(hostname -f)
echo "BASE_URL=http://$HOST:8080" > .env
