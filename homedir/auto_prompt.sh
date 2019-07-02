#! /bin/bash

# Download bash prompt
git clone https://github.com/cgbahk/git-aware-prompt.git ~/.git-aware-prompt

# Enable prompt
fname=".bash_prompt"
BASEDIR=$(dirname "$0")
cp $BASEDIR/$fname $HOME/$fname

# TODO This script should run after .bash_aliases correctly made
echo ". ~/.bash_prompt" >> ~/.bash_aliases
