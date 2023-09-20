FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
#        ca-certificates \
        python3-dev \
        python3-pip \
        wget \
        libturbojpeg && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# install required packages w/ pip
#COPY requirements.txt /requirements.txt

RUN pip3 install torch==2.0.1+cu117 torchvision==0.15.2+cu117 --index-url https://download.pytorch.org/whl/cu117 && \
#RUN pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu118 && \
    rm -rf ~/.cache/pip/*

#RUN pip3 install -r /requirements.txt && \
#    rm -rf ~/.cache/pip

COPY mobile_sam /mobile_same
COPY setup.py /setup.py
COPY weights /weights

WORKDIR /

RUN python setup.py
