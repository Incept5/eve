#!/bin/bash

# Parse command line arguments
DETACH=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--detach) DETACH=true; shift ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
done

# Function to handle errors
handle_error() {
    echo "Error: $1" >&2
    exit 1
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    handle_error "Docker is not installed. Please install Docker and try again."
fi

# Verify docker compose command is available
if ! docker compose version &> /dev/null; then
    handle_error "Docker Compose (V2) is not available. Please ensure you have a recent version of Docker installed."
fi

# Check if .env file exists in parent directory, if not copy from example
if [ ! -f ../.env ]; then
    if [ -f ../.env.example ]; then
        echo "Creating .env file from .env.example..."
        cp ../.env.example ../.env
    else
        handle_error ".env file not found and no .env.example to copy from"
    fi
fi

# Build and start the containers
echo "Building and starting Docker containers..."
if [ "$DETACH" = true ]; then
    # Start in detached mode if detach flag is set
    docker compose up --build -d

    # Wait for services to be ready
    echo "Waiting for services to start..."
    sleep 5

    # Check if the services are running
    if docker compose ps | grep -q "eve.*"; then
        echo "Eve service is running"
    else
        handle_error "Eve service failed to start"
    fi

    if docker compose ps | grep -q "chroma.*"; then
        echo "Chroma service is running"
    else
        handle_error "Chroma service failed to start"
    fi

    echo "All services are up and running!"
    echo "Eve is available at http://localhost:3010"
    echo "Chroma is available at http://localhost:8000"
else
    # Start in foreground with logs (default behavior)
    docker compose up --build
fi
