#! /bin/bash

fname=".bash_aliases"
fname_backup="${fname}_backup"
if [ -f $HOME/$fname ]; then
    echo "-- '$fname' detected on '$HOME'..."
    echo "-- back up '$fname' to '$fname_backup'"
    mv $HOME/$fname $HOME/${fname_backup}
fi

echo "-- copy '$fname' to $HOME..."
BASEDIR=$(dirname "$0")
cp $BASEDIR/$fname $HOME/$fname

# todo: check '.bashrc' or .bash_profile exists
echo "-- check '.bashrc' whether it refers '$fname'..."
ref=$(grep $fname $HOME/.bashrc)
if [ -n $"ref" ]; then
    echo "Warning: '$fname' refered in '$HOME/.bashrc'. Check out manually to add in '$fname'"
    exit 255
fi

echo "-- Add '.bashrc' to include '$fname'..."
echo "if [ -f ~/.bash_aliases  ]; then; . ~/.bash_aliases; fi" >> $HOME/.bashrc

# todo: actually this is not working immediately, but applied to next session
echo "-- register aliases..."
source $HOME/$fname

