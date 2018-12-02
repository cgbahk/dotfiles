#! /bin/bash

BASEDIR=$(dirname "$0")
# todo: backup existing .tmux.conf first
cp $BASEDIR/.tmux.conf $HOME/.tmux.conf
tmux source-file $HOME/.tmux.conf

