#!/usr/bin/env bash

# get directories
basedir=$(dirname "$0")
homedir="$basedir/homedir"

# run all autos in homedir
autos=$(ls $homedir | grep "auto*")
for auto in $autos; do
    $homedir/$auto
done
