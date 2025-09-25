# Commands to start docker container
Here are all the running commands documented. \
Select your command depending on your systems hardware and your choice of framework.

## TensorFlow

### tf on CPU
```bash
docker compose -f docker-compose.tf.cpu.yml up
```

### tf on Nvidia-GPU
```bash
docker compose -f docker-compose.tf.nvidia.yml up
```

### tf on AMD-GPU
```bash
docker compose -f docker-compose.tf.cpu.yml up
```

## PyTorch

### torch on CPU
```bash
docker compose -f docker-compose.torch.cpu.yml up
```

### torch on Nvidia-GPU
```bash
docker compose -f docker-compose.torch.nvidia.yml up
```

### torch on AMD-GPU
```bash
docker compose -f docker-compose.torch.cpu.yml up
```
