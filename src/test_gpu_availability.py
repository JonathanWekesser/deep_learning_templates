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
    # print("Num GPUs Available:", len(tf.config.list_physical_devices('GPU')))

    if gpus:
        print("GPU(s):", gpus)
        for gpu in gpus:
            tf.config.experimental.set_memory_growth(gpu, True)
    else:
        print("No GPU detected for TensorFlow.")

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

if __name__ == "__main__":
    benchmark_tf()
    benchmark_torch()
