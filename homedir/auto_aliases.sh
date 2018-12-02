#! /bin/bash

fname=".bash_aliases"
if [ -f $HOME/$fname ]; then
    echo "Error: '$fname' already existed on $HOME"
    exit 255
fi

echo "-- copy '$fname' to $HOME..."
BASEDIR=$(dirname "$0")
cp $BASEDIR/$fname $HOME/$fname

# todo: check '.bashrc' exists

echo "-- check '.bashrc' whether it refers '$fname'..."
ref=$(grep $fname $HOME/.bashrc)
if [ -n $"ref" ]; then
    echo "Warning: '$fname' refered in '$HOME/.bashrc'. Check out manually to add in '$fname'"
    exit 255
fi

echo "-- Add '.bashrc' to include '$fname'..."
echo "if [ -f ~/.bash_aliases  ]; then; . ~/.bash_aliases; fi" >> $HOME/.bash_test

# todo: actually this is not working immediately, but applied to next session
echo "-- register aliases..."
source $HOME/$fname

