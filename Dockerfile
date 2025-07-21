FROM --platform=linux/amd64 ubuntu:20.04

WORKDIR /app

LABEL maintainer="Arisht"
LABEL description="Docker image for Notion Snapshot"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git wget curl unzip \
    software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.11 python3-pip && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb && \
    rm -rf /var/lib/apt/lists/* google-chrome-stable_current_amd64.deb 

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY notionsnapshot/ ./notionsnapshot/

ENTRYPOINT ["python3", "-m", "notionsnapshot"]
