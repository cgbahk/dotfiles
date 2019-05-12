#!/bin/bash
# Bash configuration setting
#   file name is '.bash_aliases' but used as it is sourced by almost .bashrc or .bash_profile

################################################################################
# command line alias

# docker alias
alias dockerrun='docker run --rm -it'
alias dockerrunpwd='dockerrun -v ${PWD}:${PWD} -w ${PWD}'
alias dockeronce='docker run --rm -v ${PWD}:${PWD} -w ${PWD}'
# TODO yields error for 2 or more running container
alias dockerexeconly='docker exec -it $(docker ps -q) bash'
alias dockerrmi='docker rmi $(docker images -f "dangling=true" -q)'
alias dockerrm='docker rm $(docker ps -qf status=exited)'

# git alias
github()
{
  repo="https://github.com/$1"
  # todo: --recursive?
  if [ -z "$2" ]; then
      git clone $repo
  else
      git clone $repo "$2"
  fi
}
alias gitlogb='git log --oneline --graph --branches=*'
alias gitlog='git log --pretty=format:"%h%x09%ad%x09%an%x09%s"'
alias gitdiff='git diff --cached'

# grep & find
mgrep()
{
  if [ $# == 1 ]; then
    grep -rn . -ie $1
  else
    if [ ! -d "$1" ]; then
      echo "$1 is not directory!"
      return
    fi
    grep -rn $1 -ie $2
  fi
}
# TODO Change mfind similar to mgrep. This is rather complicated than mgrep
alias mfind='find . -name'

# apt
alias mapt='apt update && apt install -y'

# at alias: it wraps command at specific directory and turn back
at()
{
  pushd $1 >> /dev/null
  shift
  # TODO This is work-around. Found better solution
  ftemp="$HOME/.at_alias_temp"
  echo $* > ${ftemp}
  source ${ftemp}
  rm ${ftemp}
  popd >> /dev/null
}

# custom alias by project
mmake()
{
  if [ -f .idea/Makefile ]; then
    make -f .idea/Makefile $@
  elif [ -f .vscode/Makefile ]; then
    make -f .vscode/Makefile $@
  else
    echo "No matching local makefile"
  fi
}

################################################################################
# Bash prompt
export GITAWAREPROMPT=~/.git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
