# 📂 notebooks/

All Jupyter notebooks are stored here.  

- Each task or experiment has its own `.ipynb` file.
- Notebooks typically load data from `../data/` and save/load models from `../models/`.
- The working directory inside the container is `/workspace/notebooks`.

Example structure:
- notebooks/
- image_classification_mnist.ipynb
- text_classification_imdb.ipynb
- time_series_forecasting.ipynb

> **Recommendation**: Use clear, descriptive file names like `framework_task_dataset.ipynb`  
> (e.g., `torch_image_mnist.ipynb`).
