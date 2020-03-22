#!/bin/bash
# Install s-tui using docker and extract only package including executable

set -ex

CURRENT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOCKER_MOUNT_DIRECTORY=/mount
DOCKER_WORKSPACE=/workspace
DOCKER_CONTAINER_NAME=s-tui-builder
if [[ -z $1 ]]; then
  HOST_S_TUI_DIR=~/lab
else
  HOST_S_TUI_DIR=$1
fi

docker run \
  --name ${DOCKER_CONTAINER_NAME} \
  -e DOCKER_WORKSPACE=${DOCKER_WORKSPACE} \
  -v ${CURRENT_PATH}:${DOCKER_MOUNT_DIRECTORY} \
  -w ${DOCKER_MOUNT_DIRECTORY} \
  ubuntu:18.04 \
  bash install-s-tui-internal.sh

mkdir -p ${HOST_S_TUI_DIR}
docker cp \
  ${DOCKER_CONTAINER_NAME}:${DOCKER_WORKSPACE}/dist/s_tui \
  ${HOST_S_TUI_DIR}

docker rm ${DOCKER_CONTAINER_NAME}

echo "-- s-tui installed in ${HOST_S_TUI_DIR}"
echo "-- Run s-tui with ${HOST_S_TUI_DIR}/s_tui/s_tui"
