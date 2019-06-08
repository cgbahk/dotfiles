# myub-base
#   Base images for myub. Intended to build --no-cache option only for update
#   personal settings.
FROM ubuntu

RUN sed -i -e 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

# Enable man
RUN sed -i -e 's/path-exclude/#path-exclude/g' /etc/dpkg/dpkg.cfg.d/excludes
RUN apt update && apt install -y man

RUN apt update && apt install -y git
# TODO vim clipboard enabled
RUN apt update && apt install -y vim
RUN apt update && apt install -y tmux
RUN apt update && apt install -y build-essential
RUN apt update && apt install -y cmake

# To reduce image size
RUN apt clean
