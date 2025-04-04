#!/bin/bash

ENV_PATH="$1"
ENV_BIN_PATH="$2"

set -e

# Install jupyter components
echo "Installing Jupyter components..."
"$ENV_BIN_PATH/pip" install jupyter notebook ipykernel jupyterlab pdfplumber google-generativeai

# Check if config exists, only generate if not
echo "Configuring Jupyter..."
CONFIG_FILE="$HOME/.jupyter/jupyter_notebook_config.py"
if [ ! -f "$CONFIG_FILE" ]; then
    "$ENV_BIN_PATH/jupyter" notebook --generate-config
    echo "c.JupyterApp.theme = 'dark'" >>"$CONFIG_FILE"
fi

# Register kernel
echo "Registering kernel..."
"$ENV_BIN_PATH/python" -m ipykernel install --user --name=djpyworkshop --display-name="Python (djpyworkshop)"
