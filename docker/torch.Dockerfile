FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ffmpeg && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
      jupyter jupyterlab tqdm \
      numpy pandas matplotlib scikit-learn \
      transformers sentence-transformers huggingface-hub adapters datasets peft evaluate trl tokenizers sentencepiece trl && \
    pip install --no-cache-dir \
      --index-url https://download.pytorch.org/whl/cpu \
      torch torchvision torchao torchtext && \
    pip install --no-cache-dir torchtune

ENV JUPYTER_TOKEN=""
CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --ServerApp.token="${JUPYTER_TOKEN}"
