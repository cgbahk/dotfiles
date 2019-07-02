#! /bin/bash

# Copy bash configuration
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

# TODO: check '.bashrc' or .bash_profile exists
echo "-- check '.bashrc' whether it refers '$fname'..."
ref=$(grep $fname $HOME/.bashrc)
if [ -n $"ref" ]; then
  echo "-- '$fname' refered in '$HOME/.bashrc'. '$fname' maybe sourced already."
else
  echo "-- Please edit '.bashrc' or '.bash_profile' to include '$fname' manually"
fi

# TODO: actually this is not working immediately, but applied to next session
echo "-- register aliases..."
source $HOME/$fname
