#!/bin/bash

# Eve Server Startup Script

# Print system info banner
echo "═══════════════════════════════════════════════════════"
echo "                    Eve Server Startup                  "
echo "═══════════════════════════════════════════════════════"
echo ""
echo "System Information:"
echo "  OS:      $(uname -s) $(uname -r)"
echo "  Arch:    $(uname -m)"
echo "  Node:    $(node --version 2>/dev/null || echo 'Not found')"
echo "  pnpm:    $(pnpm --version 2>/dev/null || echo 'Not found')"
if [ "$(uname -s)" = "Darwin" ]; then
    echo "  CPU:     $(sysctl -n machdep.cpu.brand_string 2>/dev/null || echo 'Unknown')"
    echo "  Memory:  $(( $(sysctl -n hw.memsize 2>/dev/null) / 1073741824 )) GB"
else
    echo "  CPU:     $(grep -m1 'model name' /proc/cpuinfo 2>/dev/null | cut -d: -f2 | xargs || echo 'Unknown')"
    echo "  Memory:  $(free -h 2>/dev/null | awk '/^Mem:/{print $2}' || echo 'Unknown')"
fi
echo ""
echo "═══════════════════════════════════════════════════════"
echo ""

# Function to handle errors
handle_error() {
    echo "Error: $1" >&2
    exit 1
}

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    handle_error "Node.js is not installed. Please install Node.js and try again."
fi

# Set the path to the server file
SERVER_FILE="server/eve-server.js"

# Check if the server file exists
if [ ! -f "$SERVER_FILE" ]; then
    handle_error "Server file not found: $SERVER_FILE"
fi

# Function to start the server
start_server() {
    echo "Starting the server with command: node $SERVER_FILE"
    if [ -f ".env" ]; then
        env $(cat .env | grep -v '^#' | xargs) node "$SERVER_FILE" &
    else
        node "$SERVER_FILE" &
    fi
    SERVER_PID=$!

    # Wait for the server to start (adjust the sleep time if needed)
    sleep 5

    # Check if the server process is still running
    if ps -p $SERVER_PID > /dev/null; then
        echo "Server is running..."
    else
        echo "Server failed to start. Exiting."
        exit 1
    fi
}

echo "Checking npm packages..."
pnpm install 2>&1 | grep -v "Warning\|Ignored build scripts\|pnpm approve-builds\|^╭\|^│\|^╰"

# Start the server
echo "Starting Eve server..."
start_server

# Keep the script running and capture any errors
wait $SERVER_PID || { echo "Server process exited with an error. Exiting."; exit 1; }
