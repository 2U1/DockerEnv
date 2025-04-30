# VLM/LLM-Fine-Tuning Docker Build

Minimal repository containing the **Dockerfile** and **environment.yaml** used to
produce the public image [**`john119/vlm`**](https://hub.docker.com/r/john119/vlm)

## 🔧 Build locally

```bash
docker build -t vlm:latest .
```

## 🐳 Run (GPU + Conda env)

Run the container by using the command below.

```bash
docker run --gpus all -it -v /host/path:/docker/path --name train --ipc=host vlm /bin/bash
```

Then run this command to activate the env inside the container.

```bash
source activate train
```
