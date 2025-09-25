# Deep Learning Templates

This repository provides ready-to-use templates for common deep learning tasks using TensorFlow or PyTorch.  
The goal is to offer an easy-to-start development environment, mainly via Docker Compose, to minimize setup effort.

## 📂 Overview

The project includes folders for data, models, and notebooks, each with its own README explaining usage.  
Docker Compose files provide pre-configured environments for different frameworks and hardware setups.

## 📚 Folder Descriptions
- `data/` \
    Contains datasets used in the notebooks and models. \
    See [`data/README.md`](data/README.md) for details.

- `models/` \
    Stores trained model files. \
    See [`models/README.md`](models/README.md) for details.

- `notebooks/` \
    Contains Jupyter notebooks for various deep learning tasks. \
    See [`notebooks/README.md`](notebooks/README.md) for details.

- `src/` \
    Contains Python scripts and helper utilities for the project. \
    See [`src/README.md`](src/README.md) for details.

## 🚀 Getting Started

1. **Install Docker** \
    Please follow this tutorial: https://docs.docker.com/engine/install/

2. **Clone the repository:**
    ```bash
    git clone https://github.com/JonathanWekesser/deep_learning_templates
    cd deep_learning_templates
    ```

3. **Start a Docker container:** \
    See [`commands.md`](commands.md) for details.

4. **Open Jupyter Lab:** \
    Now you can test, if your setup is working:
    1. Open your browser and go to http://localhost:8888.
    2. The `notebooks` folder is mounted inside the container and ready to use.

## PyCharm Setup
If you don't want to use Jupyter in a web interface, you also can set up the Python-Interpreter of PyCharm to the docker container.

## Nvidia Container Toolkit
To get access to your Nvidia GPU inside a docker container, you have to install the [Nvidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html). 
This only works on a Linux machine. 
Please follow the steps described in the guide of Nvidia: [Installation Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#).

*Note*: Do not forget the [configuration](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuration).

## 🔧 Optional: Local Setup
If you prefer to run notebooks locally without Docker (which is not recommended), you can install dependencies with:
```bash
pip install -r requirements.txt
```

## 📄 License
TODO: license (optional)

---
Created by Jonathan Wekesser - 2025
