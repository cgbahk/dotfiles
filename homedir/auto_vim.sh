#! /bin/bash

VIM_RUNTIME=~/.vim_runtime
VIMRC_REPO="https://github.com/cgbahk/vimrc"

mkdir -p ${VIM_RUNTIME}
cd ${VIM_RUNTIME}
# TODO remove error message for some case,as it is not actually error for this
ORIGIN_URL=$(git remote get-url origin)

if [ $? -ne 0 ]; then
  git clone --depth=1 ${VIMRC_REPO} ${VIM_RUNTIME}
elif echo ${ORIGIN_URL} | grep -q "cgbahk/vimrc"; then
  git pull
  git checkout downstream
else
  git remote set-url origin ${VIMRC_REPO}
  git pull
  git checkout downstream
fi
sh ~/.vim_runtime/install_awesome_vimrc.sh
