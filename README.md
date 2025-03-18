# Data Journalism Python Tutorial

## 📁 Project Structure

## 📚 Prerequisites
- No programming experience required
- Git (installation instructions below)
- Python 3.12+ and Miniconda (instructions provided)
- Helpful: Basic knowledge of spreadsheets (Excel/Google Sheets)

### Installing Git
Git is required to download some of the tools used in this workshop.

**Windows:**
1. Download the installer from [Git for Windows](https://git-scm.com/download/win)
2. Run the installer with default options
3. Verify installation by opening Command Prompt or PowerShell and typing: `git --version`

**macOS:**
1. If you don't have Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
2. Install Git: `brew install git`
3. Verify installation: `git --version`

**Linux:**
- Debian/Ubuntu: `sudo apt update && sudo apt install git`
- Fedora/RHEL: `sudo dnf install git`
- Verify installation: `git --version`

## 🗂 Course Structure

### 0. Introduction to Python
An introduction to Python programming basics for data journalism:

- Python syntax and data types
- Working with Jupyter notebooks
- Basic data manipulation concepts

[Intro Notebook](notebooks/00_intro.ipynb)
[Cheatsheet](notebooks/CHEATSHEET.md)

### 1. Ski Price Analysis
Learn how to work with tabular data:

- Data cleaning and transformation
- Statistical analysis of pricing patterns
- Correlation with weather conditions
- Trend visualization

[Ski Price Analysis Notebook](notebooks/01_ski-prices.ipynb)

### 2. PDF Analysis
Learn techniques for extracting and analyzing text from PDF documents:

- PDF extraction methods
- Text preprocessing
- Natural language processing

[PDF Analysis Notebook](notebooks/02_pdf-analysis.ipynb)

## 🔄 Development Environment

### Dev Container
This project includes a Dev Container configuration for Visual Studio Code, which provides a consistent development environment. To use it:

1. Install [Docker](https://www.docker.com/products/docker-desktop) and [VS Code](https://code.visualstudio.com/)
2. Install the [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension in VS Code
3. Open the project folder in VS Code and click "Reopen in Container" when prompted

### Setup
For those not using the Dev Container, the following installation instructions can be used for setting up the environment.

#### Setup scripts
The project includes setup scripts to automate the installation process:

- **Windows**: Run `scripts/setup.ps1` in PowerShell (with Administrator privileges)
- **macOS/Linux**: Run `scripts/setup.sh` in Terminal

These scripts will install Python 3.12, Miniconda, create a conda environment, and install required packages.

#### Additional tools
To install additional tools like Fabric:

- **Windows**: Run `scripts/tools.ps1` in PowerShell
- **macOS/Linux**: Run `scripts/tools.sh` in Terminal

These tools enhance the data journalism workflow with specialized capabilities.

#### Conda Environment
If you already set up everything, and want to reactivate your environment, run

```bash
# Activate the environment
conda activate djpyworkshop
```

### VS Code Settings (.vscode folder)
This project includes customized VS Code settings to enhance your development experience:

- **settings.json**: Pre-configured editor settings optimized for Python and Jupyter notebooks
  - Code formatting with Ruff
  - Python language server (Pylance) configuration
  - Jupyter notebook settings
  - Terminal integration with conda environments

- **extensions.json**: Recommended VS Code extensions for this project
  - Python and Jupyter support
  - Remote development capabilities
  - GitHub Copilot
  - Docker integration
  - Markdown editing support

To use these settings, simply open the project in VS Code, and you'll be prompted to install recommended extensions.

### Configuration Files (.config folder)
The project contains configuration files in the `.config` folder:

- **ruff.toml**: Configuration for the Ruff Python linter and formatter
- **.fabric/.env**: Environment variables for working with additional tools

These configurations ensure consistent code style and environment settings across different development environments.
