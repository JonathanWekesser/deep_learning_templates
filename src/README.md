# 📂 src/

This folder contains utility scripts and tools that can be used in your deep learning workflows.
You can also place your own scripts here. 

## Contents
- **`gpu_benchmark.py`**  
  A benchmarking script for testing GPU availability and performance in both TensorFlow and PyTorch.  
  - Runs convolution benchmarks on CPU and GPU (if available).  
  - Reports runtime and GPU speedup factor.  
  - Automatically skips the framework benchmark if the framework is not installed in the current environment.

  > **Note:** Since each Docker container only includes *one* framework (TensorFlow **or** PyTorch), the script will skip tests for the missing framework.

## Usage of benchmarking script (`gpu_benchmark.py`)

1. **Enter a running docker container** \
    Replace `<container_name>` with the actual name from `docker ps`:
```bash
docker exec -it <container-name> bash
```

2. **Navigate (if necessary) to the workspace folder** \
    By default, you should already be in /workspace inside the container.

3. **Run the benchmark script** 
```bash
python src/gpu_benchmark.py
```

**Example Output**

TODO: Example Output

> **Tips:**
> - If the script reports GPU device not found, make sure you are running a GPU-enabled Docker container (e.g., docker-compose.tf.amd.yml or the CUDA version for NVIDIA).
> - Performance results can vary based on hardware, driver versions, and Docker configuration.
