# Deep Learning Templates

This repository provides ready-to-use templates for common deep learning tasks using TensorFlow or PyTorch.  
The goal is to offer an easy-to-start development environment, mainly via Docker Compose, to minimize setup effort.

## 📂 Overview

The project includes folders for data, models, and notebooks, each with its own README explaining usage.  
Docker Compose files provide pre-configured environments for different frameworks and hardware setups.

## 🚀 Getting Started

1. **Install Docker**

    Please follow this tutorial: https://docs.docker.com/engine/install/

2. **Clone the repository:**

```bash
git clone https://github.com/JonathanWekesser/deep_learning_templates
cd deep_learning_templates
```

3. **Start a Docker container:** \
Example: TensorFlow CPU
```bash
docker-compose -f docker.compose.tf.cpu.yml up
``` 

4. **Open Jupyter Lab:**

Open your browser and go to http://localhost:8888.
The notebooks folder is mounted inside the container and ready to use.

## 📚 Folder Descriptions
- `data/` \
    Contains datasets used in the notebooks and models. \
    See `data/README.md` for details.

- `models/` \
    Stores trained model files. \
    See `models/README.md` for details.

- `notebooks/` \
    Contains Jupyter notebooks for various deep learning tasks. \
    See `notebooks/README.md` for details.

## 🔧 Optional Local Setup
If you prefer to run notebooks locally without Docker (what is not recommended), you can install dependencies with:

```bash
pip install -r requirements.txt
``` 

## 📄 License
TODO: license (optional)

---
Created by Your Jonathan Wekesser - 2025
