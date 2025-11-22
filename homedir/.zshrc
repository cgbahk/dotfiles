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

export EDITOR='nvim'

if command -v nvim >/dev/null 2>&1; then
    alias vi='nvim'
    alias vim='nvim'
fi

# Override prompt style provided by agnoster theme
# 
# For detail check: '.oh-my-zsh/themes/agnoster.zsh-theme'
SEGMENT_SEPARATOR=$'\u2599'  # To be compatible with most fonts

prompt_dir() {
  prompt_segment blue $CURRENT_FG $(shrink_path -f)
}

# TODO Use `prompt_end`. There is issue on coloring.
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

prompt_git_() {
  # Original code use hard coded `\ue0a0`. Let's not use it.
  # Note `sed` only accepts actual byte reprsentation.
  echo -n $(echo $(prompt_git) | sed 's/\xee\x82\xa0//')
}

build_prompt() {
  RETVAL=$?
  echo  # This added
  prompt_status
  prompt_virtualenv
  prompt_aws
  # prompt_context  # This removed
  prompt_dir
  prompt_git_  # post-processed
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
  eval "$(ntfy shell-integration --longer-than 1)"
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
append_ntfy_ignore vim
append_ntfy_ignore vi

# This was helpful: https://stackoverflow.com/a/1489935/4214521
export FZF_DEFAULT_COMMAND='find -L . -type d \( -name .git -o -name venv -o -name conda.env \) -prune -o -print'
export FZF_DEFAULT_OPTS='--height 1% --layout=reverse -m'

[ -f ~/.zshrc.alias ] && source ~/.zshrc.alias

# Things to add in local setting
# - source fzf key binding file for zsh
# - mamba or conda setting
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
