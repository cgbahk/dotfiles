#!/usr/bin/env bash

# get directories
basedir=$(dirname "$0")
homedir="$basedir/homedir"

# run all autos in homedir
# TODO make users to choose what they want to apply, not all
# TODO make it more verbose
autos=$(ls $homedir | grep "auto*")
for auto in $autos; do
    $homedir/$auto
done
