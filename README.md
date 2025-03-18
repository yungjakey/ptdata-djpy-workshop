# Data Journalism Python Tutorial

## 📁 Project Structure

## 📚 Prerequisites
- No programming experience required
- Installation of Python 3.12+ and Miniconda (instructions provided)
- Helpful: Basic knowledge of spreadsheets (Excel/Google Sheets)

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
TODO: Add info about setup scripts

#### Conda Environment

```bash
# Create the environment
conda env create -f environment.yml

# Activate the environment
conda activate djpyworkshop
```

#### Additional tools
TODO: add info about installation of additional tooling

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
