#! /bin/bash

# TODO check whether installed already
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# apply custom config
homedir=$(dirname "$0")
config=my_configs.vim
cp $homedir/$config ~/.vim_runtime/$config
