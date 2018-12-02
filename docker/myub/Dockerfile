FROM ubuntu

# RUN echo "deb http://kr.archive.ubuntu.com/ubuntu/ xenial main restricted" >> /etc/apt/sources.list

RUN sed -i -e 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list


RUN apt update && \
    apt-get install -y \
    git vim tmux

# load auto config script
RUN git clone https://github.com/cgbahk/dotfiles.git &&\
    dotfiles/auto/auto &&\
    dotfiles/auto_homedir.sh

# To reduce image size
RUN apt-get clean
