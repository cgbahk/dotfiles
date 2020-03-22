#!/bin/bash

set -ex

PIP=pip3

apt update && apt install -y \
  git python3-dev python3-pip
${PIP} install urwid psutil pyinstaller

git clone https://github.com/amanusk/s-tui ${DOCKER_WORKSPACE}
pushd ${DOCKER_WORKSPACE}

git checkout v1.0.0
pyinstaller s_tui/s_tui.py
