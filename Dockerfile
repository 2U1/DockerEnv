FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget bzip2 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV CONDA_VERSION="Miniconda3-py312_25.1.1-2-Linux-x86_64.sh"
RUN wget --quiet https://repo.anaconda.com/miniconda/$CONDA_VERSION -O /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm -f /tmp/miniconda.sh
ENV PATH="/opt/miniconda/bin:${PATH}"

COPY environment.yaml /tmp/environment.yaml

RUN conda env create -f /tmp/environment.yaml && \
    conda clean -ya

RUN conda run -n train pip install flash-attn --no-build-isolation

ENV PATH="/opt/miniconda/envs/train/bin:${PATH}"