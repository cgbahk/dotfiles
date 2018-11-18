#!/usr/bin/env bash
# Usage:
#   source __/python_venv.sh
#   or
#   bash <(curl -s https://raw.githubusercontent.com/cgbahk/dotfiles/master/python_venv.sh)

venv_name="env"  # TODO: command input customize
echo "-- Generate venv on ${PWD}/${venv_name}..."
python3.6 -m venv ${venv_name} # by default python 3.6

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

if [ -z $PYTHONPATH ] ; then
    export PYTHONPATH=$(pwd)
else
    export PYTHONPATH="$PYTHONPATH:$(pwd)"
fi
