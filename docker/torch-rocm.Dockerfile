FROM rocm/pytorch:rocm7.0_ubuntu22.04_py3.10_pytorch_release_2.8.0

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# Install Python packages
RUN python -m pip install --upgrade pip setuptools wheel && pip install \
    jupyter jupyterlab tqdm \
    numpy pandas matplotlib scikit-learn \
    transformers sentence-transformers huggingface-hub adapters datasets peft evaluate trl tokenizers sentencepiece \
    torch torchtune torchvision torchao torchtext

ENV JUPYTER_TOKEN=""
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.token="${JUPYTER_TOKEN}"
