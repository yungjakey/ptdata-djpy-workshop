#!/bin/bash

# Create and activate conda environment
conda env create -f ../environment.yml -n djpyworkshop 2>/dev/null || echo "Environment already exists"
conda activate djpyworkshop

# Install jupyter components
pip install jupyter notebook ipykernel jupyterlab

# Check if config exists, only generate if not
CONFIG_FILE=~/.jupyter/jupyter_notebook_config.py
if [ ! -f "$CONFIG_FILE" ]; then
    jupyter notebook --generate-config
    echo "c.JupyterApp.theme = 'dark'" >>$CONFIG_FILE
fi

# Register kernel, don't overwrite if exists
python -m ipykernel install --user --name=djpyworkshop --display-name="Python (djpyworkshop)"
