# tf-dev

# Note that this base image is built from ubuntu:16.04
FROM tensorflow/tensorflow:devel

# install vim 8.0 on ubuntu 16.04
RUN add-apt-repository ppa:jonathonf/vim -y && \
    apt update && apt install -y vim

RUN git clone https://github.com/cgbahk/dotfiles && \
    ./dotfiles/auto_homedir.sh

WORKDIR /tensorflow_src
