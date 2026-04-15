#!/bin/bash

# ========================================
# Run Backend - Multimodal AI Assistant
# ========================================

cd "$(dirname "$0")/backend"

echo "========================================"
echo "Starting Multimodal AI Assistant Backend"
echo "========================================"
echo ""

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python3 not installed"
    echo "Install from: https://www.python.org"
    exit 1
fi

# Create and activate venv
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

# Activate venv
source venv/bin/activate

# Install dependencies if needed
if ! python3 -c "import fastapi" 2>/dev/null; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
fi

# Check for HF_API_KEY
if [ -z "$HF_API_KEY" ]; then
    echo ""
    echo "WARNING: HF_API_KEY not set!"
    echo "Please set: export HF_API_KEY=your_key_here"
    echo "Get free key from: https://huggingface.co/settings/tokens"
    echo ""
fi

PORT=${PORT:-8000}
echo ""
echo "🚀 Backend running on http://localhost:$PORT"
echo "📝 API Docs: http://localhost:$PORT/docs"
echo ""

# Start with uvicorn
uvicorn main:app --reload --port $PORT
