# Base image: Ubuntu with Python
FROM ubuntu:22.04

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

# CUDA (if USE_CUDA=ON)
RUN if [ "$USE_CUDA" = "ON" ]; then \
        apt-get update && apt-get install -y --no-install-recommends \
            cuda-toolkit-12-2 \
            cuda-libraries-12-2 \
            && rm -rf /var/lib/apt/lists/*; \
    fi

# ROCm (if USE_ROCM=ON)
RUN if [ "$USE_ROCM" = "ON" ]; then \
        apt-get update && apt-get install -y --no-install-recommends \
            rocm-opencl-runtime \
            rocm-libs \
            && rm -rf /var/lib/apt/lists/*; \
    fi

# Install Python packages from requirements.txt
COPY requirements.txt .
RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt

# Install framework-specific packages
RUN if [ "$USE_CUDA" = "ON" ]; then \
        pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
        pip3 install tensorflow[and-cuda]; \
    elif [ "$USE_ROCM" = "ON" ]; then \
        pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm5.6 && \
        pip3 install tensorflow-rocm; \
    else \
        pip3 install torch torchvision torchaudio && \
        pip3 install tensorflow; \
    fi

WORKDIR /workspace
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
