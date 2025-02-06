#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "🔹 Updating package lists..."
sudo apt update -y || sudo yum update -y || sudo dnf update -y

echo "🔹 Installing required dependencies..."
sudo apt install -y curl jq || sudo yum install -y curl jq || sudo dnf install -y curl jq

echo "🔹 Fetching the latest Docker Compose version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')

echo "🔹 Installing Docker Compose v$LATEST_VERSION..."
sudo curl -L "https://github.com/docker/compose/releases/download/${LATEST_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

echo "🔹 Setting executable permissions..."
sudo chmod +x /usr/local/bin/docker-compose

echo "✅ Docker Compose installed successfully!"
echo "🛠️ Version:"
docker-compose --version
