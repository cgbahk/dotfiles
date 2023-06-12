# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#
# TODO Can we make a per-directory setting for this?
#
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Command execution time stamp shown in the history command output.
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(\
  shrink-path\
)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# Override prompt style provided by agnoster theme
# 
# For detail check: '.oh-my-zsh/themes/agnoster.zsh-theme'
prompt_dir() {
  prompt_segment blue $CURRENT_FG $(shrink_path -f)
}

build_prompt() {
  RETVAL=$?
  echo  # This added
  prompt_status
  prompt_virtualenv
  prompt_aws
  # prompt_context  # This removed
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}

# Use vi keybindings
bindkey -v
# Default behavior of '^R' is hidden by vi keybindings
# This is to restore its behavior
bindkey '^R' history-incremental-search-backward

# vi binding: distinguish normal/insert mode
function zle-line-init zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[4 q'  # Use 'underline' cursor

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]]; then
    echo -ne '\e[2 q'  # Use 'block' cursor
  fi
}
zle -N zle-line-init
zle -N zle-keymap-select

setopt share_history

VENV_ACTIVATE="venv/bin/activate"
if [[ -f ${VENV_ACTIVATE} ]]; then
  . ${VENV_ACTIVATE}
fi

# Enable completion (Not sure what it does)
autoload -Uz compinit
compinit

# ntfy config
if [ -x "$(command -v ntfy)" ]; then
  eval "$(ntfy shell-integration -L1)"
fi

AUTO_NTFY_DONE_IGNORE=""
function append_ntfy_ignore()
{
  local arg=$1; shift
  export AUTO_NTFY_DONE_IGNORE="${AUTO_NTFY_DONE_IGNORE} ${arg}"
}

# Most ntfy ignore list becomes not required by https://github.com/cgbahk/ntfy/pull/2
append_ntfy_ignore tmux
append_ntfy_ignore ssh

# conda initialization
#
# Content copied from result of `mamba init zsh` with come edit
if [[ -d ~/mambaforge ]]; then
  __conda_setup="$(~/mambaforge/bin/conda shell.zsh hook 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    echo "ERROR - conda initialization failed"
  fi
  unset __conda_setup

  if [ -f ~/mambaforge/etc/profile.d/mamba.sh ]; then
    . ~/mambaforge/etc/profile.d/mamba.sh
  fi
fi

CONDA_ENV_DIR="./conda.env"
if [[ -d ${CONDA_ENV_DIR} ]]; then
  conda activate ${CONDA_ENV_DIR}
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.zshrc.alias ] && source ~/.zshrc.alias
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
