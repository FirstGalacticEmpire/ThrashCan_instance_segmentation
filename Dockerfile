###1

FROM python:3.8

RUN apt update && \
    apt install --no-install-recommends -y build-essential software-properties-common && \
#     add-apt-repository -y ppa:deadsnakes/ppa && \
#     apt install --no-install-recommends -y python3.8 python3-pip python3-setuptools python3-distutils && \
    apt install ffmpeg libsm6 libxext6  -y && \
    apt clean && rm -rf /var/lib/apt/lists/*


WORKDIR /app

COPY src /app/src

COPY models/yolact/best_model.pth /app/models/yolact/best_model.pth

COPY requirements.txt /app/requirements.txt

RUN python3.8 -m pip install --no-cache-dir -r /app/requirements.txt
#--mount=type=cache,target=/root/.cache \
#     python3.8 -m pip install --upgrade pip && \
#     python3.8 -m pip install --no-cache-dir -r /app/requirements.txt
#     python3.8 -m pip install torch==1.10.1+cu113 torchvision==0.11.2+cu113 torchaudio==0.10.1+cu113 -f https://download.pytorch.org/whl/cu113/torch_stable.html

CMD ["uvicorn", "src.api.api:app", "--host", "0.0.0.0"]
