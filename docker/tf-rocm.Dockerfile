FROM rocm/tensorflow:rocm7.0-py3.10-tf2.17-dev

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# Install Python packages
RUN python -m pip install --upgrade pip setuptools wheel && pip install \
    jupyter jupyterlab tqdm \
    numpy pandas matplotlib scikit-learn \
    transformers huggingface-hub datasets tokenizers sentencepiece evaluate \
    tensorflow_datasets 

RUN pip install tf-keras --no-deps

ENV JUPYTER_TOKEN=""
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.token="${JUPYTER_TOKEN}"
