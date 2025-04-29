FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# 필수 패키지 설치 (wget 등)
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget bzip2 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Miniconda 설치
ENV CONDA_VERSION="Miniconda3-py312_25.1.1-2-Linux-x86_64.sh"
RUN wget --quiet https://repo.anaconda.com/miniconda/$CONDA_VERSION -O /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/miniconda && \
    rm -f /tmp/miniconda.sh
ENV PATH="/opt/miniconda/bin:${PATH}"

# environment.yaml 복사
COPY environment.yaml /tmp/environment.yaml

# train 환경 생성
RUN conda env create -f /tmp/environment.yaml && \
    conda clean -ya

# train 환경에서 추가 패키지 설치 (예: flash-attn)
RUN conda run -n train pip install flash-attn --no-build-isolation

# (선택) train 환경 PATH 세팅
ENV PATH="/opt/miniconda/envs/train/bin:${PATH}"