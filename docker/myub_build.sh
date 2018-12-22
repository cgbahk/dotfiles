#! /bin/bash

# get file direction
BASEDIR=$(dirname "$0")
cd $BASEDIR

docker build --no-cache -t myub .
