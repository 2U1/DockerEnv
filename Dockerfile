FROM pytorch/pytorch:2.6.0-cuda12.6-cudnn9-devel

COPY environment.yaml /tmp/environment.yaml

RUN source activate base && \
    conda env create -f /tmp/environment.yaml

RUN conda run -n train pip install flash-attn --no-build-isolation

# (선택) 컨테이너 내에서 기본으로 train 환경을 활성화하고 싶다면:
ENV PATH /opt/conda/envs/train/bin:$PATH