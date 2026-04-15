#!/bin/bash

# ========================================
# Run Frontend - Multimodal AI Assistant
# ========================================

cd "$(dirname "$0")/frontend"

echo "========================================"
echo "Starting Multimodal AI Assistant Frontend"
echo "========================================"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js not installed"
    echo "Install from: https://nodejs.org"
    exit 1
fi

echo "Node version:"
node --version
echo ""

# Install dependencies
if [ ! -d "node_modules" ]; then
    echo "Installing npm dependencies..."
    npm install
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to install npm packages"
        exit 1
    fi
fi

echo ""
echo "🚀 Frontend running on http://localhost:5173"
echo ""

# Start development server
sleep 2
open http://localhost:5173 2>/dev/null || xdg-open http://localhost:5173 2>/dev/null || echo "Open http://localhost:5173 in your browser"
npm run dev
