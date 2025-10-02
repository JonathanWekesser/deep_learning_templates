FROM tensorflow/tensorflow:2.17.0-gpu-jupyter

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# Install Python packages
# use --no-deps for keras that the tf version is not overwritten by keras
RUN python -m pip install --upgrade pip setuptools wheel && pip install \
    jupyter jupyterlab tqdm \
    numpy pandas matplotlib scikit-learn \
    transformers huggingface-hub datasets tokenizers sentencepiece evaluate \
    tensorflow_datasets \
    keras --no-deps \
    keras-nlp --no-deps
    
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
