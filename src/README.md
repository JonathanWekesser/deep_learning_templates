# 📂 src/

This folder contains utility scripts and tools that can be used in your deep learning workflows.
You can also place your own scripts here. 

## Contents
- **`gpu_benchmark.py`**  
  A benchmarking script for testing GPU availability and performance in both TensorFlow and PyTorch.  
  - Runs convolution benchmarks on CPU and GPU (if available).  
  - Reports runtime and GPU speedup factor.  
  - Automatically skips the framework benchmark if the framework is not installed in the current environment.

## Usage of benchmarking script (`gpu_benchmark.py`)

1. **Enter the running docker container** \
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
    
    <details><summary><b>Example Output</b></summary>
   
        === TensorFlow ===
        TensorFlow v 2.20.0
        Num GPUs Available: 1
        GPU(s): [PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
        CPU (s): 11.6321
        GPU (s): 1.3846
        Speedup: 8.4x

        === PyTorch ===
        PyTorch v 2.8.0+cu128
        CUDA available: True
        Num GPUs: 1
        Current GPU: Quadro T2000
        CPU (s): 10.0154
        GPU (s): 0.0041
        Speedup: 2460.7x
    </details>

> **Tips:**
> - If the script reports GPU device not found, make sure you are running the GPU-enabled version of the container.
> - Performance results can vary based on hardware, driver versions, and Docker configuration.
