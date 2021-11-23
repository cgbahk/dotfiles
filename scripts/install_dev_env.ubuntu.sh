#!/bin/bash
#
# TODO
# - Make option to enable each

set -e

echo "Install dev environment - BEG"

function force_link()
{
  local SOURCE=$1; shift;
  local LINK=$1; shift;

  rm -f ${LINK}
  ln -s ${SOURCE} ${LINK}
}

#
# Install dotfiles
#
DOTFILES_REPO_DIR=~/r/dotfiles
mkdir -p ${DOTFILES_REPO_DIR}
git clone https://github.com/cgbahk/dotfiles ${DOTFILES_REPO_DIR}

#
# Install zsh and setting
#
sudo apt install -y zsh
# TODO This script is interactive. Remove this behavior.
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

force_link ${DOTFILES_REPO_DIR}/homedir/.zshrc ~/.zshrc
force_link ${DOTFILES_REPO_DIR}/homedir/.zshrc.alias ~/.zshrc.alias

#
# git setting
#
force_link ${DOTFILES_REPO_DIR}/homedir/.gitconfig ~/.gitconfig

#
# tmux setting
#
TMUX_REPO_DIR=~/.tmux
git clone https://github.com/cgbahk/tmux-config ${TMUX_REPO_DIR}
force_link ${TMUX_REPO_DIR}/.tmux.conf ~/.tmux.conf

#
# vim setting
#
VIM_REPO_DIR=~/.vim_runtime
git clone https://github.com/cgbahk/vimrc ${VIM_REPO_DIR}
${VIM_REPO_DIR}/install_awesome_vimrc.sh

# TODO fzf
# TODO ntfy

echo "Install dev environment - END"
exit
