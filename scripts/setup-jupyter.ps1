# Create and activate conda environment
conda env create -f ..\environment.yml -n djpyworkshop 2>$null
conda activate djpyworkshop

# Install jupyter components
pip install jupyter notebook ipykernel jupyterlab pdfplumber google-generativeai

# Check if config exists, only generate if not
$ConfigFile = "$env:USERPROFILE\.jupyter\jupyter_notebook_config.py"
if (-not (Test-Path $ConfigFile)) {
    jupyter notebook --generate-config
    Add-Content -Path $ConfigFile -Value "c.JupyterApp.theme = 'dark'"
}

# Register kernel
python -m ipykernel install --user --name=djpyworkshop --display-name="Python (djpyworkshop)"

