#! /bin/bash

TMUX_CONF_DIR=~/.tmux
TMUX_CONF_REPO="https://github.com/cgbahk/tmux-config"
mkdir -p ${TMUX_CONF_DIR}
cd ${TMUX_CONF_DIR}
# TODO remove error message for some case,as it is not actually error for this
ORIGIN_URL=$(git remote get-url origin)

if [ $? -ne 0 ]; then
  git clone ${TMUX_CONF_REPO} ${TMUX_CONF_DIR}
elif echo ${ORIGIN_URL} | grep -q "cgbahk"; then
  git pull
  git checkout downstream
else
  git remote set-url origin ${TMUX_CONF_REPO}
  git pull
  git checkout downstream
fi

rm ~/.tmux.conf
ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
