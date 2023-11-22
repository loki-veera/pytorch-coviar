# Using Ubuntu 22.04
FROM ubuntu:22.04

# Setting the working directory to /app
WORKDIR /app

COPY . /app

# Install python, pip, git in the environment
RUN apt-get update && apt-get install -y python3 python3-pip git 
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install FFMPEG related stuff
RUN apt-get update ; apt-get install -y git build-essential gcc make yasm autoconf automake cmake libtool checkinstall libmp3lame-dev pkg-config libunwind-dev zlib1g-dev libssl-dev

RUN apt-get update \
    && apt-get clean \
    && apt-get install -y --no-install-recommends libc6-dev libgdiplus wget software-properties-common libgl1

# Install Pytorch
RUN pip install torch==2.0.0 torchvision==0.15.1 torchaudio==2.0.1 

# Install OpenCV
RUN pip3 install opencv-python

# Install FFMPEG
# RUN cd ./FFmpeg; ./configure --prefix=${FFMPEG_INSTALL_PATH} --enable-pic --disable-yasm --enable-shared --enable-gpl --enable-libmp3lame --enable-decoder=mjpeg,png --enable-encoder=png --enable-openssl --enable-nonfree
# RUN cd ./FFmpeg; git checkout 74c6a6d3735f79671b177a0e0c6f2db696c2a6d2
RUN cd ./FFmpeg; ./configure --prefix=${FFMPEG_INSTALL_PATH} --enable-pic --disable-yasm --enable-shared
RUN cd ./FFmpeg; make clean
RUN cd ./FFmpeg; ./configure --prefix=${FFMPEG_INSTALL_PATH} --enable-pic --disable-yasm --enable-shared
RUN cd ./FFmpeg; make
RUN cd ./FFmpeg; ./configure --prefix=${FFMPEG_INSTALL_PATH} --enable-pic --disable-yasm --enable-shared
RUN cd ./FFmpeg; make install
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64/:/usr/local/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
RUN cd ./data_loader; ./install.sh