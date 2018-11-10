FROM ubuntu:16.04

# RUN echo "deb http://kr.archive.ubuntu.com/ubuntu/ xenial main restricted" >> /etc/apt/sources.list

RUN sed -i -e 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list


RUN apt update && \
    apt-get install -y \
    git vim tmux

# RUN git clone https://github.com/cgbahk/dotfiles.git
# TODO: load auto config script

# To reduce image size
RUN apt-get clean
