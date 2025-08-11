# 📂 data/

This folder stores datasets used by the notebooks and models.

- Place downloaded datasets here (e.g., MNIST, CIFAR-10, IMDB).
- Mounted into the Docker container as `/workspace/data`.
- You can organize datasets into subfolders, for example:
    - data/
    - mnist/
    - cifar10/
    - imdb/

> **Tip**: Avoid committing large datasets to Git; add them to `.gitignore`.
