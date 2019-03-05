#! /bin/bash

# github@tony/tmux-config
git clone --recursive https://github.com/tony/tmux-config.git ~/.tmux
if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf.backup
fi
ln -s ~/.tmux/.tmux.conf ~/.tmux.conf
