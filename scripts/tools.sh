#!/bin/bash

# Stop on errors
set -e

echo "🧰 Installing additional tools for data journalism..."

# Verify Git is installed
if ! command -v git &>/dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    echo "See README.md for installation instructions."
    exit 1
else
    echo "✅ Git is installed: $(git --version)"
fi

# Install fabric directly in project directory
echo "📂 Installing fabric tool..."

# Create or ensure the .config/fabric directory exists
CONFIG_DIR="$(pwd)/.config/fabric"
mkdir -p "$CONFIG_DIR"

# Clone or update fabric repository
FABRIC_DIR="$(pwd)/tools/fabric"
mkdir -p "$(pwd)/tools"

if [ -d "$FABRIC_DIR" ]; then
    echo "Updating fabric repository..."
    cd "$FABRIC_DIR"
    git pull
else
    echo "Cloning fabric repository..."
    git clone https://github.com/danielmiessler/fabric.git "$FABRIC_DIR"
    cd "$FABRIC_DIR"
fi

# Install fabric dependencies
echo "Installing fabric dependencies..."
# Check if conda environment is active
if [[ -n "$CONDA_PREFIX" ]]; then
    pip install -r requirements.txt
else
    echo "⚠️ No conda environment detected. For best results, run this after activating your conda environment."
    pip install --user -r requirements.txt
fi

# Check if .env file exists, if not, copy example
if [ ! -f "$CONFIG_DIR/.env" ] && [ -f "$CONFIG_DIR/.env.example" ]; then
    echo "Creating .env file from example..."
    cp "$CONFIG_DIR/.env.example" "$CONFIG_DIR/.env"
    echo "✅ Created .env file. Please edit with your API keys."
fi

# Return to the original directory
cd "$(pwd)"

echo "✅ Fabric installation complete!"
echo "To use fabric, run: python $FABRIC_DIR/fabric.py"
echo "Configuration stored in: $CONFIG_DIR"
