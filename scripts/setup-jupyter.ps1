# Create and activate conda environment
conda env create -f .\environment.yml -n djpyworkshop 2>$null
conda activate djpyworkshop

# Install jupyter components
pip install jupyter notebook ipykernel

# Generate Jupyter config
jupyter notebook --generate-config

# Register kernel
python -m ipykernel install --user --name=djpyworkshop --display-name="Python (djpyworkshop)"

# Start a Jupyter server
jupyter notebook
