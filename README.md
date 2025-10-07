# Deep Learning Templates

![Docker](https://img.shields.io/badge/Docker-ready-blue?logo=docker)
![TensorFlow](https://img.shields.io/badge/TensorFlow-supported-orange?logo=tensorflow)
![PyTorch](https://img.shields.io/badge/PyTorch-supported-red?logo=pytorch)
![Jupyter](https://img.shields.io/badge/Jupyter-Lab-orange?logo=jupyter)
![Python](https://img.shields.io/badge/Python-3.10%20%7C%203.11-blue?logo=python)
![CUDA](https://img.shields.io/badge/CUDA-supported-green?logo=nvidia)
![ROCm](https://img.shields.io/badge/ROCm-supported-red?logo=amd)

This repository provides ready-to-use templates for common deep learning tasks using **TensorFlow** and **PyTorch**.

Its goal is to **minimize setup effort** and ensure a **reproducible, hardware-agnostic environment** through Docker Compose.  
You can easily switch between **CPU**, **NVIDIA GPU (CUDA)**, or **AMD GPU (ROCm)** setups with a single command.

## Quickstart

```bash
git clone https://github.com/JonathanWekesser/deep_learning_templates
cd deep_learning_templates

# Build and start the container
./build cpu       # or: nvidia / amd
./run cpu
```

Then open [http://localhost:8888](http://localhost:8888) (TensorFlow) or [http://localhost:8889](http://localhost:8889) (PyTorch) in your browser.

## Project Overview

The repository is structured to support clean organization of data, models, notebooks, and scripts.  
Each folder contains its own `README.md` explaining its purpose and usage.

### Folder Descriptions

- `data/`  
  Contains datasets used in the notebooks and models.  
  See [`data/README.md`](data/README.md) for details.

- `models/`  
  Stores trained model files.  
  See [`models/README.md`](models/README.md) for details.

- `notebooks/`  
  Contains Jupyter notebooks for various deep learning tasks.  
  See [`notebooks/README.md`](notebooks/README.md) for details.

- `src/`  
  Contains Python scripts and helper utilities for experiments and benchmarking.  
  See [`src/README.md`](src/README.md) for details.

## Containers and Profiles

The project includes separate containers for each framework and hardware configuration.  
Each container is defined in the Docker Compose setup and can be started independently.

| Hardware              | TensorFlow  | PyTorch        |
|-----------------------|-------------|----------------|
| **CPU**               | `tf-cpu`    | `torch-cpu`    |
| **NVIDIA GPU (CUDA)** | `tf-nvidia` | `torch-nvidia` |
| **AMD GPU (ROCm)**    | `tf-amd`    | `torch-amd`    |

### Docker Compose Profiles

You can also use profiles directly with Docker Compose:

| Profile  | Starts                      |
|----------|-----------------------------|
| `cpu`    | `tf-cpu`, `torch-cpu`       |
| `nvidia` | `tf-nvidia`, `torch-nvidia` |
| `amd`    | `tf-amd`, `torch-amd`       |

Example:
```bash
# only tf container (CPU)
docker compose --profile cpu up tf-cpu

# only torch (CPU)
docker compose --profile cpu up torch-cpu

# both (CPU)
docker compose --profile cpu up
```

### Helper Scripts
To simplify working with containers, several Bash scripts are included in the project root.
All scripts take a profile as argument (cpu, nvidia or amd).

| Script    | Description                                                 |
|-----------|-------------------------------------------------------------|
| `./build` | Builds all required Docker images for a given profile.      |
| `./run`   | Starts the corresponding container and exposes Jupyter Lab. |
| `./stop`  | Stops all running containers for the current project.       |

> Tip: The scripts automatically detect the correct container names and Docker Compose profiles, 
> so you don’t need to remember or type long Docker commands manually.

## Getting Started

1. **Install Docker**  
   Follow the official [Docker installation guide](https://docs.docker.com/engine/install/).

2. **Clone the repository**
   ```bash
   git clone https://github.com/JonathanWekesser/deep_learning_templates
   cd deep_learning_templates
   ```

3. **Build the container**
   ```bash
   ./build [cpu|nvidia|amd]
   ```

4. **Run the container**
   ```bash
   ./run [cpu|nvidia|amd]
   ```

5. **Verify the environment**  
   The Jupyter Lab instance should open in your browser at  
   [http://localhost:8888](http://localhost:8888) (TensorFlow) or  
   [http://localhost:8889](http://localhost:8889) (PyTorch).

   You can test GPU availability using:
   ```bash
   docker compose exec tf-nvidia python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
   docker compose exec torch-nvidia python -c "import torch; print(torch.cuda.is_available())"
   ```

   Alternatively, open the example notebook [`showcase.ipynb`](notebooks/showcase.ipynb) or run `src/gpu_benchmark.py`.

## PyCharm Setup (Recommended)

If you prefer using **PyCharm** instead of the browser-based Jupyter interface,
follow the detailed setup guide here:

→ View [PyCharm Setup Guide](docs/pycharm_setup.md) in this repository. 

![PyCharm Icon](docs/images/pycharm_icon.png)

## VS Code Setup (Alternative)

If you prefer using **Visual Studio Code**, you can also connect it directly to the Docker Compose environment.  
This allows you to develop, debug, and run notebooks inside the same containerized setup (similar to [PyCharm](#-pycharm-setup-recommended)).

→ View [VS Code Setup Guide](docs/vscode_setup.md) in this repository. 

![VS Code Icon](docs/images/vscode_icon.png)

## Environment Configuration

You can customize environment variables in a `.env` file at the project root.

Default values:
```dotenv
IMAGE_BASENAME=dl-multi-framework
JUPYTER_PORT_TF=8888
JUPYTER_PORT_TORCH=8889
```

You can override these values as needed, for example to change exposed ports or image names.

### Security (Jupyter Token)

By default, Jupyter runs without a token for local development.
If you want to protect your server, set a token via `.env`:

```dotenv
JUPYTER_TOKEN=your-secure-token
```

## GPU Setup

> **Note:** If GPU setup becomes too time-consuming or fails after multiple attempts, simply use the CPU containers — they work out of the box on all systems.

### NVIDIA GPU (CUDA)

To use your NVIDIA GPU inside a Docker container, install the  
**[NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html)**.

Follow these steps:

1. [Installation Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installation)
2. [Configuration Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuration)

After installation, verify your setup:
```bash
docker run --rm --gpus all nvidia/cuda:12.6.0-base nvidia-smi
```
Make sure the CUDA version matches the one on your system. 
You can check your local CUDA version with:
`nvidia-smi`

### AMD GPU (ROCm)

For AMD GPUs, follow the [ROCm Docker quick start guide](https://github.com/ROCm/ROCm-docker/blob/master/quick-start.md).  
This is only supported on **Linux** (Windows users should use the CPU version).

## Local Setup (Optional)

If you prefer running notebooks locally (not recommended for reproducibility), install dependencies with:

```bash
pip install -r requirements.txt
```

> Some features (e.g., GPU detection) may not work outside Docker.

## Troubleshooting

- **NVIDIA GPU not visible in container**  
  Check host: `nvidia-smi`. Then test container:  
  `docker run --rm --gpus all nvidia/cuda:12.6.9-base nvidia-smi`

- **AMD ROCm not working on Windows**  
  ROCm is Linux-only → use the CPU profile on Windows.

- **Port already in use (8888/8889)**  
  Change ports in `.env`:
  ```dotenv 
    JUPYTER_PORT_TF=18888
    JUPYTER_PORT_TORCH=18889
  ```

## Contributing

Contributions, ideas, or suggestions are very welcome!  
Please feel free to open issues or pull requests on GitHub.

## License

This project is licensed under the [MIT License](LICENSE).  
© 2025 Jonathan Wekesser
