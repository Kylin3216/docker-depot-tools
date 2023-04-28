FROM registry.cn-shanghai.aliyuncs.com/icekylin/ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "" > /etc/apt/sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ jammy main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ jammy-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ jammy-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt update && apt upgrade -y
RUN apt install -y clang cmake build-essential pkg-config libegl1-mesa-dev libxkbcommon-dev libgles2-mesa-dev \
    libwayland-dev wayland-protocols git curl wget unzip git python2 virtualenv
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /opt/flutter && cd /opt/flutter && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
RUN export PATH=$PATH:$(pwd)/depot_tools
COPY .gclient /opt/flutter/
RUN gclient sync
WORKDIR /root
CMD tail -f /dev/null
