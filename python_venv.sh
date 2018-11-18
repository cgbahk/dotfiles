#!/usr/bin/env bash
# Usage:
#   source __/python_venv.sh
#   or
#   bash <(curl -s https://raw.githubusercontent.com/cgbahk/dotfiles/master/python_venv.sh)

venv_name="env"  # TODO: command input customize
echo "-- Generate venv on ${PWD}/${venv_name}..."
python3.6 -m venv ${venv_name} # by default python 3.6

echo "-- Activate venv..."
source ${venv_name}/bin/activate && \

echo "-- Upgrade pip..." && \
pip install --upgrade pip && \

# TODO: check existance of requirements.txt
echo "-- Add requirements..." && \
pip install -r requirements.txt
