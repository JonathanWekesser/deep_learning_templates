FROM tensorflow/tensorflow:2.17.0-jupyter

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# Install Python packages
RUN python -m pip install --upgrade pip setuptools wheel && pip install \
    jupyter jupyterlab tqdm \
    numpy pandas matplotlib scikit-learn \
    transformers huggingface-hub datasets tokenizers sentencepiece evaluate \
    tensorflow_datasets \
    keras \
    keras-nlp

ENV JUPYTER_TOKEN=""
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.token="${JUPYTER_TOKEN}"
