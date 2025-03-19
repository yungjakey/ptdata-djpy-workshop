#!/bin/bash

# Stop on errors
set -e

echo "📦 Setting up reproducible Python environment..."

# Create .python-version file if it doesn't exist
if [ ! -f .python-version ]; then
    echo -n "3.12.1" >.python-version
    echo "📝 Created .python-version file with Python 3.12.1"
fi

# Check if Python 3.12 is installed
PYTHON_INSTALLED=false
if command -v python3 &>/dev/null; then
    PYTHON_VERSION=$(python3 --version)
    if [[ $PYTHON_VERSION == *"Python 3.12"* ]]; then
        PYTHON_INSTALLED=true
        echo "✅ Python 3.12 already installed"
    fi
fi

if [ "$PYTHON_INSTALLED" = false ]; then
    echo "🐍 Installing Python 3.12.1..."

    # Use pyenv on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # ...existing code...
    # For Linux
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # ...existing code...
    fi

    echo "✅ Python 3.12.1 installed successfully"
fi

# Check if conda is installed
if ! command -v conda &>/dev/null; then
    echo "❌ conda is not installed. Installing miniconda..."

    # Download Miniconda installer
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [[ $(uname -m) == "arm64" ]]; then
            # M1/M2 Mac
            MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh"
        else
            # Intel Mac
            MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
    fi

    curl -o miniconda.sh $MINICONDA_URL
    bash miniconda.sh -b -p $HOME/miniconda
    rm miniconda.sh

    # Add conda to path
    export PATH="$HOME/miniconda/bin:$PATH"

    # Initialize conda for the appropriate shell
    if [[ "$SHELL" == */zsh ]]; then
        conda init zsh
    else
        conda init bash
    fi

    echo "✅ Miniconda installed successfully"
    echo "🔄 Please close and reopen your terminal, then run this script again."
    exit 0
else
    echo "✅ Conda already installed: $(conda --version)"
fi

# Create conda environment
echo "🌎 Creating conda environment from environment.yml..."
conda env create -f environment.yml -n djpyworkshop --force

# Activate conda environment
echo "🚀 Activating conda environment..."
source $(conda info --base)/etc/profile.d/conda.sh
conda activate djpyworkshop

# Install spaCy model
echo "🔤 Installing spaCy German model..."
python -m spacy download de_core_news_lg

# Check if Fabric is already installed
if ! command -v fabric &>/dev/null; then
    echo "🧠 Installing Fabric AI framework..."

    # Create a temporary directory for downloads
    TEMP_DIR=$(mktemp -d)

    # Determine OS and architecture
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if [[ $(uname -m) == "arm64" ]]; then
            # M1/M2 Mac (arm64)
            FABRIC_URL="https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-arm64"
            FABRIC_BIN="fabric-darwin-arm64"
        else
            # Intel Mac (amd64)
            FABRIC_URL="https://github.com/danielmiessler/fabric/releases/latest/download/fabric-darwin-amd64"
            FABRIC_BIN="fabric-darwin-amd64"
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if [[ $(uname -m) == "aarch64" ]]; then
            # ARM64 Linux
            FABRIC_URL="https://github.com/danielmiessler/fabric/releases/latest/download/fabric-linux-arm64"
            FABRIC_BIN="fabric-linux-arm64"
        else
            # AMD64 Linux
            FABRIC_URL="https://github.com/danielmiessler/fabric/releases/latest/download/fabric-linux-amd64"
            FABRIC_BIN="fabric-linux-amd64"
        fi
    fi

    # Download the appropriate Fabric binary
    echo "Downloading Fabric binary..."
    curl -L -o "$TEMP_DIR/fabric" $FABRIC_URL

    # Make it executable
    chmod +x "$TEMP_DIR/fabric"

    # Move to a directory in PATH
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
    mv "$TEMP_DIR/fabric" "$INSTALL_DIR/fabric"

    # Add to PATH if it's not already there
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        echo "Adding $INSTALL_DIR to PATH"
        if [[ "$SHELL" == */zsh ]]; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.zshrc
        else
            echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
        fi
        export PATH="$INSTALL_DIR:$PATH"
    fi

    echo "✅ Fabric installed successfully"

    # Initial setup
    echo "🔧 Running Fabric setup..."
    fabric --setup
else
    echo "✅ Fabric already installed: $(fabric --version)"
fi

echo "✅ Environment setup complete! Activate with: conda activate djpyworkshop"
