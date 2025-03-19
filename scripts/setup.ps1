#Requires -RunAsAdministrator

# Stop on errors
$ErrorActionPreference = "Stop"

Write-Host "📦 Setting up reproducible Python environment..." -ForegroundColor Cyan

# Create .python-version file if it doesn't exist
if (-not (Test-Path -Path ".python-version")) {
    "3.12.1" | Out-File -FilePath ".python-version"
    Write-Host "📝 Created .python-version file with Python 3.12.1" -ForegroundColor Green
}

# Check if Python 3.12 is installed
$pythonInstalled = $false
try {
    $pythonVersion = (python --version) 2>&1
    if ($pythonVersion -like "*Python 3.12*") {
        $pythonInstalled = $true
        Write-Host "✅ Python 3.12 already installed" -ForegroundColor Green
    }
}
catch {
    Write-Host "❌ Python 3.12 is not installed" -ForegroundColor Yellow
}

if (-not $pythonInstalled) {
    Write-Host "🐍 Installing Python 3.12.1..." -ForegroundColor Yellow

    # Create a temporary directory for downloads
    $tempDir = Join-Path $env:TEMP "python-install"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    # Download Python installer
    $pythonUrl = "https://www.python.org/ftp/python/3.12.1/python-3.12.1-amd64.exe"
    $pythonInstaller = Join-Path $tempDir "python-3.12.1-installer.exe"

    Write-Host "Downloading Python 3.12.1..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonInstaller

    # Install Python with necessary options
    Write-Host "Running Python installer..." -ForegroundColor Cyan
    Start-Process -FilePath $pythonInstaller -ArgumentList "/quiet", "PrependPath=1", "Include_test=0" -Wait

    # Refresh the PATH environment variable
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    Write-Host "✅ Python 3.12.1 installed successfully" -ForegroundColor Green
}

# Check if conda is installed
$condaInstalled = $false
try {
    $condaVersion = (conda --version) 2>&1
    if ($condaVersion -match "conda") {
        $condaInstalled = $true
        Write-Host "✅ Conda already installed: $condaVersion" -ForegroundColor Green
    }
}
catch {
    Write-Host "❌ Conda is not installed" -ForegroundColor Yellow
}

if (-not $condaInstalled) {
    Write-Host "❌ conda is not installed. Installing miniconda..." -ForegroundColor Yellow

    # Create a temporary directory for downloads
    $tempDir = Join-Path $env:TEMP "miniconda-install"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    # Download Miniconda installer
    $minicondaUrl = "https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe"
    $minicondaInstaller = Join-Path $tempDir "Miniconda3-latest-Windows-x86_64.exe"

    Write-Host "Downloading Miniconda..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $minicondaUrl -OutFile $minicondaInstaller

    # Install Miniconda
    Write-Host "Running Miniconda installer..." -ForegroundColor Cyan
    Start-Process -FilePath $minicondaInstaller -ArgumentList "/S", "/RegisterPython=1", "/AddToPath=1" -Wait

    # Refresh the PATH environment variable
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

    Write-Host "✅ Miniconda installed successfully" -ForegroundColor Green
    Write-Host "🔄 Please close and reopen PowerShell, then run this script again." -ForegroundColor Yellow
    exit
}

# Create conda environment
Write-Host "🌎 Creating conda environment from environment.yml..." -ForegroundColor Cyan
conda env create -f environment.yml -n djpyworkshop --force

# Activate conda environment
Write-Host "🚀 Activating conda environment..." -ForegroundColor Cyan
conda activate djpyworkshop

# Install spaCy model
Write-Host "🔤 Installing spaCy German model..." -ForegroundColor Cyan
python -m spacy download de_core_news_lg

Write-Host "✅ Environment setup complete! Activate with: conda activate djpyworkshop" -ForegroundColor Green
