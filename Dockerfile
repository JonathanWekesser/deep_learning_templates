ARG IMAGE=ubuntu:22.04

FROM ${IMAGE}

ARG DEBIAN_FRONTEND=noninteractive
ARG REQ=requirements/requirements.txt

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
COPY ${REQ} /tmp/requirements.txt
RUN python -m pip install --upgrade pip setuptools wheel && \
    pip install -r /tmp/requirements.txt

WORKDIR /workspace
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
