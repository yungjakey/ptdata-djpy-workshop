FROM ubuntu:22.04

ARG CONDA_ENV_NAME=djpyworkshop

RUN useradd -ms /bin/bash vscode

# Add conda to PATH
ENV PATH=/opt/conda/bin:$PATH

# Install essentials and improve vscode.dev compatibility
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    openssh-client \
    ca-certificates \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Install fabric
RUN curl -L https://github.com/danielmiessler/fabric/releases/latest/download/fabric-linux-arm64 -o /usr/local/bin/fabric \
    && chmod +x /usr/local/bin/fabric && chown vscode:vscode /usr/local/bin/fabric

# Install Miniconda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-$(uname -m).sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh

# Create a conda environment
COPY environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml -n ${CONDA_ENV_NAME} \
    && conda clean -afy \
    && conda init bash \
    && echo "conda activate ${CONDA_ENV_NAME}" >> /etc/bash.bashrc \
    && mkdir -p /opt/conda/envs/${CONDA_ENV_NAME}/etc/conda/activate.d \
    && echo "export PYTHONPATH=/workspace:\$PYTHONPATH" > /opt/conda/envs/${CONDA_ENV_NAME}/etc/conda/activate.d/env_vars.sh \
    && chmod +x /opt/conda/envs/${CONDA_ENV_NAME}/etc/conda/activate.d/env_vars.sh \
    && conda activate djpyworkshop

# Ensure directory structure for vscode.dev
RUN mkdir -p /home/vscode/.vscode-server/extensions \
    && chown -R vscode:vscode /home/vscode/.vscode-server

# Create user
USER vscode
WORKDIR /home/vscode

# Set up conda activation
RUN echo '. /opt/conda/etc/profile.d/conda.sh' >> ~/.bashrc \
    && echo 'conda activate ${CONDA_ENV_NAME}' >> ~/.bashrc

COPY --chown=vscode:vscode . .

# Expose ports for Jupyter and Django
EXPOSE 8888
EXPOSE 8000
