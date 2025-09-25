# Base image: Ubuntu with Python
FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
# Build arguments for hardware and frameworks
ARG USE_CUDA=OFF
ARG USE_ROCM=OFF

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    git \
    wget \
    curl \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Make python3 default "python"
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install Python packages from requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --upgrade pip setuptools wheel && \
    pip install -r /tmp/requirements.txt

# --- Framework-specific packages (choose by build ARGs) ---
RUN if [ "${USE_CUDA}" = "ON" ]; then \
        pip install --upgrade \
          torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
        pip install --upgrade 'tensorflow[and-cuda]'; \
    elif [ "${USE_ROCM}" = "ON" ]; then \
        pip install --upgrade \
          torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.0 && \
        pip install --upgrade tensorflow-rocm; \
    else \
        pip install --upgrade torch torchvision torchaudio && \
        pip install --upgrade tensorflow; \
    fi

WORKDIR /workspace
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
