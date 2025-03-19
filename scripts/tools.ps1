# Stop on errors
$ErrorActionPreference = "Stop"

Write-Host "🧰 Installing additional tools for data journalism..." -ForegroundColor Cyan

# Verify Git is installed
try {
    $gitVersion = (git --version) 2>&1
    Write-Host "✅ Git is installed: $gitVersion" -ForegroundColor Green
}
catch {
    Write-Host "❌ Git is not installed. Please install Git first." -ForegroundColor Red
    Write-Host "See README.md for installation instructions." -ForegroundColor Yellow
    exit 1
}

# Install fabric directly in project directory
Write-Host "📂 Installing fabric tool..." -ForegroundColor Cyan

# Create or ensure the .config/fabric directory exists
$configDir = Join-Path $PWD ".config\fabric"
if (-not (Test-Path -Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
}

# Clone or update fabric repository
$toolsDir = Join-Path $PWD "tools"
if (-not (Test-Path -Path $toolsDir)) {
    New-Item -ItemType Directory -Path $toolsDir -Force | Out-Null
}

$fabricDir = Join-Path $toolsDir "fabric"
if (Test-Path -Path $fabricDir) {
    Write-Host "Updating fabric repository..." -ForegroundColor Yellow
    Set-Location $fabricDir
    git pull
}
else {
    Write-Host "Cloning fabric repository..." -ForegroundColor Yellow
    git clone https://github.com/danielmiessler/fabric.git $fabricDir
    Set-Location $fabricDir
}

# Install fabric dependencies
Write-Host "Installing fabric dependencies..." -ForegroundColor Cyan
# Check if we're in a conda environment
if ($env:CONDA_PREFIX) {
    pip install -r requirements.txt
}
else {
    Write-Host "⚠️ No conda environment detected. For best results, run this after activating your conda environment." -ForegroundColor Yellow
    pip install --user -r requirements.txt
}

# Check if .env file exists, if not, copy example
$envFile = Join-Path $configDir ".env"
$envExampleFile = Join-Path $configDir ".env.example"
if ((-not (Test-Path -Path $envFile)) -and (Test-Path -Path $envExampleFile)) {
    Write-Host "Creating .env file from example..." -ForegroundColor Yellow
    Copy-Item -Path $envExampleFile -Destination $envFile
    Write-Host "✅ Created .env file. Please edit with your API keys." -ForegroundColor Green
}

# Return to the original directory
Set-Location $PWD

Write-Host "✅ Fabric installation complete!" -ForegroundColor Green
Write-Host "To use fabric, run: python $fabricDir\fabric.py" -ForegroundColor Cyan
Write-Host "Configuration stored in: $configDir" -ForegroundColor Cyan
