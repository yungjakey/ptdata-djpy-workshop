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
        if ! command -v pyenv &>/dev/null; then
            echo "❌ pyenv is not installed. Installing pyenv..."
            brew install pyenv
            echo 'eval "$(pyenv init --path)"' >>~/.zprofile
            eval "$(pyenv init --path)"
        fi

        echo "🐍 Installing Python 3.12.1 via pyenv..."
        pyenv install -s 3.12.1
        pyenv local 3.12.1
    # For Linux
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Installing Python dependencies..."
        sudo apt-get update
        sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
            libreadline-dev libsqlite3-dev curl llvm libncurses5-dev libncursesw5-dev \
            xz-utils tk-dev libffi-dev liblzma-dev python-openssl

        if ! command -v pyenv &>/dev/null; then
            echo "Installing pyenv..."
            curl https://pyenv.run | bash

            # Add pyenv to path
            echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >>~/.bashrc
            echo 'eval "$(pyenv init --path)"' >>~/.bashrc
            echo 'eval "$(pyenv virtualenv-init -)"' >>~/.bashrc

            export PATH="$HOME/.pyenv/bin:$PATH"
            eval "$(pyenv init --path)"
        fi

        echo "Installing Python 3.12.1 via pyenv..."
        pyenv install -s 3.12.1
        pyenv local 3.12.1
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
else
    echo "✅ Conda already installed: $(conda --version)"
fi

# Create conda environment
echo "🌎 Creating conda environment from environment.yml..."
conda env create -f environment.yml -n djpyworkshop --force

# Activate conda environment
echo "🚀 Activating conda environment..."
conda activate djpyworkshop

# Install poetry if not already installed
if ! command -v poetry &>/dev/null; then
    echo "📜 Installing poetry..."
    curl -sSL https://install.python-poetry.org | python3 -

    # Add Poetry to PATH if needed
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        export PATH="$HOME/.local/bin:$PATH"

        if [[ "$SHELL" == */zsh ]]; then
            echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.zshrc
        else
            echo 'export PATH="$HOME/.local/bin:$PATH"' >>~/.bashrc
        fi
    fi
else
    echo "✅ Poetry already installed: $(poetry --version)"
fi

# Configure poetry to create virtual envs in the project directory
echo "Configuring poetry..."
poetry config virtualenvs.in-project true

# Install project dependencies using poetry
echo "📚 Installing project dependencies with poetry..."
poetry install

# Install spaCy model
echo "🔤 Installing spaCy German model..."
poetry run python -m spacy download de_core_news_lg

echo "✅ Environment setup complete! Activate with: conda activate djpyworkshop"
