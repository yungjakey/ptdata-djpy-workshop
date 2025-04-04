# Setup script for Windows with full path usage and prerequisite checks

# Check and install prerequisites
$ErrorActionPreference = "Stop"
Write-Host "Checking prerequisites..." -ForegroundColor Green

# Check Git
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git not found. Installing Git..." -ForegroundColor Yellow
    winget install --id Git.Git -e --source winget
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}
else {
    Write-Host "Git is already installed." -ForegroundColor Green
}

# Check Python
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python not found. Installing Python..." -ForegroundColor Yellow
    winget install -e --id Python.Python.3.10
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}
else {
    Write-Host "Python is already installed." -ForegroundColor Green
}

# Check Conda
$condaPath = "$env:USERPROFILE\miniconda3\Scripts\conda.exe"
$condaPath2 = "$env:USERPROFILE\anaconda3\Scripts\conda.exe"
if (!(Test-Path $condaPath) -and !(Test-Path $condaPath2)) {
    Write-Host "Conda not found. Installing Miniconda..." -ForegroundColor Yellow
    $installerPath = "$env:TEMP\miniconda_installer.exe"
    Invoke-WebRequest -Uri "https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe" -OutFile $installerPath
    Start-Process -FilePath $installerPath -Args "/S /AddToPath=1 /RegisterPython=1 /D=$env:USERPROFILE\miniconda3" -Wait
    $condaPath = "$env:USERPROFILE\miniconda3\Scripts\conda.exe"
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}
else {
    $condaPath = (Test-Path $condaPath) ? $condaPath : $condaPath2
    Write-Host "Conda is already installed." -ForegroundColor Green
}

# Create and activate conda environment
Write-Host "Creating conda environment..." -ForegroundColor Green
& $condaPath env create -f ..\environment.yml -n djpyworkshop 2>$null
& $condaPath activate djpyworkshop

# Get conda environment paths
$envPathBase = & $condaPath info --envs | Select-String "djpyworkshop" | ForEach-Object { $_.ToString().Trim() -replace "djpyworkshop.*", "" }
$envPath = "$envPathBase\djpyworkshop"
$envScriptsPath = "$envPath\Scripts"

# Run Jupyter configuration
Write-Host "Configuring Jupyter..." -ForegroundColor Green
& "$PSScriptRoot\configure-jupyter.ps1" -envPath $envPath -envScriptsPath $envScriptsPath

Write-Host "Setup complete!" -ForegroundColor Green
