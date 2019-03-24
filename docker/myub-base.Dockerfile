# myub-base
#   Base images for myub. Intended to build --no-cache option only for update
#   personal settings.
FROM ubuntu

RUN sed -i -e 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

RUN apt update && apt install -y git
RUN apt update && apt install -y vim
RUN apt update && apt install -y tmux
RUN apt update && apt install -y build-essential
RUN apt update && apt install -y cmake

# To reduce image size
RUN apt clean
