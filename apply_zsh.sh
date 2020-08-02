#!/bin/bash

ZSHRC_PATH=${HOME}/.zshrc

if [ -f ${ZSHRC_PATH} ]; then
  cp ${ZSHRC_PATH} ${ZSHRC_PATH}.bak
fi

cp homedir/.zshrc ${ZSHRC_PATH}
