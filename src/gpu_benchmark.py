import timeit

# ==============================
# TensorFlow Benchmark
# ==============================
def benchmark_tf():
    print("\n=== TensorFlow ===")
    try:
        import tensorflow as tf
    except ImportError:
        print("TensorFlow not installed in this environment. Skipping...")
        return

    print("TensorFlow v", tf.__version__)

    gpus = tf.config.list_physical_devices('GPU')
    print("Num GPUs Available:", len(gpus))
    if gpus:
        print("GPU(s):", gpus)
        for gpu in gpus:
            tf.config.experimental.set_memory_growth(gpu, True)
    else:
        print("No GPU detected for TensorFlow.")

    height, width, batch_size = 200, 200, 128

    def cpu():
        with tf.device('/cpu:0'):
            x = tf.random.normal((batch_size, height, width, 3))
            y = tf.keras.layers.Conv2D(32, 7)(x)
            return tf.reduce_sum(y)

    def gpu():
        with tf.device('/GPU:0'):
            x = tf.random.normal((batch_size, height, width, 3))
            y = tf.keras.layers.Conv2D(32, 7)(x)
            return tf.reduce_sum(y)

    # Warmup
    cpu()
    if gpus:
        gpu()

    # Benchmark
    runs = 30
    cpu_time = timeit.timeit(cpu, number=runs)
    print(f"CPU (s): {cpu_time:.4f}")
    if gpus:
        gpu_time = timeit.timeit(gpu, number=runs)
        print(f"GPU (s): {gpu_time:.4f}")
        print(f"Speedup: {cpu_time/gpu_time:.1f}x")


# ==============================
# PyTorch Benchmark
# ==============================
def benchmark_torch():
    print("\n=== PyTorch ===")
    try:
        import torch
    except ImportError:
        print("PyTorch not installed in this environment. Skipping...")
        return

    print("PyTorch v", torch.__version__)
    cuda_available = torch.cuda.is_available()
    print("CUDA available:", cuda_available)
    print("Num GPUs:", torch.cuda.device_count())
    if cuda_available:
        print("Current GPU:", torch.cuda.get_device_name(0))

    height, width, batch_size = 200, 200, 128

    conv_cpu = torch.nn.Conv2d(3, 32, 7)
    conv_gpu = torch.nn.Conv2d(3, 32, 7).cuda() if cuda_available else None

    def cpu():
        x = torch.randn(batch_size, 3, height, width)
        y = conv_cpu(x)
        return torch.sum(y)

    def gpu():
        x = torch.randn(batch_size, 3, height, width, device="cuda")
        y = conv_gpu(x)
        return torch.sum(y)

    # Warmup
    cpu()
    if cuda_available:
        gpu()

    # Benchmark
    runs = 30
    cpu_time = timeit.timeit(cpu, number=runs)
    print(f"CPU (s): {cpu_time:.4f}")
    if cuda_available:
        gpu_time = timeit.timeit(gpu, number=runs)
        print(f"GPU (s): {gpu_time:.4f}")
        print(f"Speedup: {cpu_time/gpu_time:.1f}x")


if __name__ == "__main__":
    benchmark_tf()
    benchmark_torch()
