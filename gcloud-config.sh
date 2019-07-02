#!/bin/bash
# Script to set google cloud shell environment for me

install_tmux_2_6()
{
  sudo apt-get -y remove tmux
  sudo apt-get -y install wget tar libevent-dev libncurses-dev

  VERSION=2.6
  wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
  tar xf tmux-${VERSION}.tar.gz
  rm -f tmux-${VERSION}.tar.gz

  cd tmux-${VERSION}
  ./configure
  make
  sudo make install
  cd -
  sudo rm -rf /usr/local/src/tmux-\*
  sudo mv tmux-${VERSION} /usr/local/src
}

auto_homedir()
{
  git clone https://github.com/cgbahk/dotfiles
  ./dotfiles/homedir/auto_bash.sh
  ./dotfiles/homedir/auto_git.sh
  ./dotfiles/homedir/auto_tmux.sh
  ./dotfiles/homedir/auto_vim.sh
}

extra_setting()
{
  # for bash
  echo "if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi" >> $HOME/.bashrc

  # for tmux
  echo "set-option -g status on" >> $HOME/.tmux/.tmux.conf
  echo "set -g status-left '#S'" >> $HOME/.tmux/.tmux.conf
}

set -x
install_tmux_2_6
auto_homedir
extra_setting
set +x
