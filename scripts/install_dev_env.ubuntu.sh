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

sudo apt update

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

#
# fzf
#
# TODO ubuntu 20.04 apt includes fzf
FZF_REPO_DIR=~/.fzf
git clone https://github.com/junegunn/fzf ${FZF_REPO_DIR}
${FZF_REPO_DIR}/install

#
# ntfy
#
sudo apt install -y python3-pip
sudo pip3 install ntfy

NTFY_CONFIG_PATH=~/.config/ntfy/ntfy.yml
mkdir -p $(dirname ${NTFY_CONFIG_PATH})
touch ${NTFY_CONFIG_PATH}
echo "Caveat: Need to fill '${NTFY_CONFIG_PATH}' manually"  # TODO Find better way

# TODO delta - Manual install from https://github.com/dandavison/delta/releases
# TODO gh

echo "Install dev environment - END"
exit
