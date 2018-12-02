#!/usr/bin/env bash

basedir=$(dirname "$0")
homedir="$basedir/homedir"

autos=$(ls $homedir | grep "auto*")
for auto in $autos; do
    $homedir/$auto
done
