# Deep Learning Templates

This repository provides ready-to-use templates for common deep learning tasks using TensorFlow or PyTorch.  
The goal is to offer an easy-to-start development environment, mainly via Docker Compose, to minimize setup effort.

## 📁 Project Structure

TODO: structure plan ... 

Each folder contains a `README.md` explaining its purpose and usage.

## 🚀 Getting Started

1. **Clone the repository:**

```bash
git clone https://github.com/JonathanWekesser/deep_learning_templates
cd deep_learning_templates
```

2. **Start a Docker container:** \
Example: TensorFlow CPU
```bash
docker-compose -f docker.compose.tf.cpu.yml up
``` 

3. **Open Jupyter Lab:**

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
