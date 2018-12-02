#! /bin/bash

BASEDIR=$(dirname "$0")
# todo: backup existing .tmux.conf first
cp $BASEDIR/.tmux.conf $HOME/.tmux.conf

# for immediate refresh, run this. 
#tmux source-file $HOME/.tmux.conf
