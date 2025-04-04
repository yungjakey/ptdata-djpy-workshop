param(
    [string]$envPath,
    [string]$envScriptsPath
)

$ErrorActionPreference = "Stop"

# Install jupyter components
Write-Host "Installing Jupyter components..." -ForegroundColor Green
& "$envScriptsPath\pip.exe" install jupyter notebook ipykernel jupyterlab pdfplumber google-generativeai

# Check if config exists, only generate if not
Write-Host "Configuring Jupyter..." -ForegroundColor Green
$ConfigFile = "$env:USERPROFILE\.jupyter\jupyter_notebook_config.py"
if (-not (Test-Path $ConfigFile)) {
    & "$envScriptsPath\jupyter.exe" notebook --generate-config
    Add-Content -Path $ConfigFile -Value "c.JupyterApp.theme = 'dark'"
}

# Register kernel
Write-Host "Registering kernel..." -ForegroundColor Green
& "$envPath\python.exe" -m ipykernel install --user --name=djpyworkshop --display-name="Python (djpyworkshop)"
