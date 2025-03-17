FROM ubuntu:22.04

ARG CONDA_ENV_NAME=djpyworkshop

RUN useradd -ms /bin/bash vscode

# Add conda to PATH
ENV PATH=/opt/conda/bin:$PATH

# Install essentials
RUN apt-get update && apt-get install -y \
    curl \
    wget \
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
    && conda activate djpyworkshop \
    && python -m spacy download de_core_news_lg

# Create user
USER vscode
WORKDIR /home/vscode

# Set up conda activation
RUN echo '. /opt/conda/etc/profile.d/conda.sh' >> ~/.bashrc \
    && echo 'conda activate ${CONDA_ENV_NAME}' >> ~/.bashrc

COPY --chown=vscode:vscode . .
