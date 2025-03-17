#!/bin/bash
set -e

echo "📦 Setting up reproducible Python environment..."

# Create .python-version file if it doesn't exist
if [ ! -f .python-version ]; then
    echo "3.12.1" >.python-version
    echo "📝 Created .python-version file with Python 3.12.1"
fi

# Check if pyenv is installed
if ! command -v pyenv &>/dev/null; then
    echo "❌ pyenv is not installed. Installing pyenv..."
    brew install pyenv
    echo 'eval "$(pyenv init --path)"' >>~/.zprofile
    eval "$(pyenv init --path)"
fi

# Install Python using pyenv
echo "🐍 Installing Python 3.12.1 via pyenv..."
pyenv install -s 3.12.1
pyenv local 3.12.1

# Check if conda is installed
if ! command -v conda &>/dev/null; then
    echo "❌ conda is not installed. Installing miniconda..."
    curl -o miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    bash miniconda.sh -b -p $HOME/miniconda
    rm miniconda.sh
    export PATH="$HOME/miniconda/bin:$PATH"
    conda init zsh
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
fi

# Configure poetry to create virtual envs in the project directory
poetry config virtualenvs.in-project true

# Install project dependencies using poetry
echo "📚 Installing project dependencies with poetry..."
poetry install

# Install spaCy model
echo "🔤 Installing spaCy German model..."
poetry run python -m spacy download de_core_news_lg

echo "✅ Environment setup complete! Activate with: conda activate djpyworkshop"
