#!/usr/bin/env bash
# Usage:
#   source __/python_venv.sh
#   or
#   curl -sL https://raw.githubusercontent.com/cgbahk/dotfiles/master/python_venv.sh > __VENV_TEMP__ && source __VENV_TEMP__ && rm __VENV_TEMP__

venv_name="venv"  # TODO: command input customize
echo "-- Generate venv on ${PWD}/${venv_name}..."
python3.6 -m venv ${venv_name} # by default python 3.6 TODO: make this reliable

echo "-- Activate venv..."
source ${venv_name}/bin/activate

echo "-- Upgrade pip..."
pip install --upgrade pip

if [ -f requirements.txt ] ; then
    echo "-- Add requirements..."
    pip install -r requirements.txt
else
    echo "-- No requirements found..."
fi

echo "-- Add project directory($(pwd)) to python import path..."
if [ -z $PYTHONPATH ] ; then
    export PYTHONPATH=$(pwd)
else
    export PYTHONPATH="$PYTHONPATH:$(pwd)"
fi
