#!/bin/bash

# Setup script for macOS/Linux with full path usage and prerequisite checks
set -e
echo "Checking prerequisites..."

# Check Git
if ! command -v git &>/dev/null; then
    echo "Git not found. Installing Git..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        xcode-select --install || echo "Xcode command line tools may already be installed"
    else
        # Linux
        sudo apt-get update && sudo apt-get install -y git || sudo yum install -y git
    fi
else
    echo "Git is already installed."
fi

# Check Python
if ! command -v python3 &>/dev/null; then
    echo "Python not found. Installing Python..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install python || echo "Failed to install Python via Homebrew"
    else
        # Linux
        sudo apt-get update && sudo apt-get install -y python3 python3-pip || sudo yum install -y python3 python3-pip
    fi
else
    echo "Python is already installed."
fi

# Check Conda
CONDA_PATH="$HOME/miniconda3/bin/conda"
CONDA_PATH2="$HOME/anaconda3/bin/conda"
if [ ! -f "$CONDA_PATH" ] && [ ! -f "$CONDA_PATH2" ]; then
    echo "Conda not found. Installing Miniconda..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        INSTALLER_PATH="$HOME/miniconda_installer.sh"
        ARCHITECTURE=$(uname -m)
        if [ "$ARCHITECTURE" = "arm64" ]; then
            # M1/M2 Mac
            curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o "$INSTALLER_PATH"
        else
            # Intel Mac
            curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -o "$INSTALLER_PATH"
        fi
    else
        # Linux
        INSTALLER_PATH="$HOME/miniconda_installer.sh"
        curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o "$INSTALLER_PATH"
    fi
    bash "$INSTALLER_PATH" -b -p "$HOME/miniconda3"
    rm "$INSTALLER_PATH"
    CONDA_PATH="$HOME/miniconda3/bin/conda"
    export PATH="$HOME/miniconda3/bin:$PATH"
else
    [ -f "$CONDA_PATH" ] || CONDA_PATH="$CONDA_PATH2"
    echo "Conda is already installed."
fi

# Initialize conda for bash
source "$HOME/miniconda3/etc/profile.d/conda.sh" 2>/dev/null || source "$HOME/anaconda3/etc/profile.d/conda.sh"

# Create and activate conda environment
echo "Creating conda environment..."
"$CONDA_PATH" env create -f ../environment.yml -n djpyworkshop 2>/dev/null || echo "Environment already exists"
conda activate djpyworkshop

# Get conda environment paths
ENV_PATH=$(conda info --envs | grep djpyworkshop | awk '{print $NF}')
ENV_BIN_PATH="$ENV_PATH/bin"

# Run Jupyter configuration
echo "Configuring Jupyter..."
bash "$(dirname "$0")/configure-jupyter.sh" "$ENV_PATH" "$ENV_BIN_PATH"

echo "Setup complete!"
