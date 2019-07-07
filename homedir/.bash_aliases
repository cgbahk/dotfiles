#!/bin/bash
# Bash configuration setting
#   file name is '.bash_aliases' but used as it is sourced by almost .bashrc or .bash_profile


######################################################################
# docker alias

alias dockerrun='docker run --rm -it'
alias dockerrunpwd='dockerrun -v ${PWD}:${PWD} -w ${PWD}'
alias dockeronce='docker run --rm -v ${PWD}:${PWD} -w ${PWD}'
# TODO yields error for 2 or more running container
alias dockerexeconly='docker exec -it $(docker ps -q) bash'
alias dockerrmi='docker rmi $(docker images -f "dangling=true" -q)'
alias dockerrm='docker rm $(docker ps -qf status=exited)'


######################################################################
# git alias

github()
{
  repo="https://github.com/$1"
  # todo: --recursive?
  if [ -z "$2" ]; then
      git clone $repo
      cd $(basename $1)
  else
      git clone $repo "$2"
      cd $2
  fi
}
alias gitlogb='git log --oneline --graph --branches=*'
alias gitlog='git log --pretty=format:"%h%x09%ad%x09%an%x09%s"'
alias gitdiff='git diff --cached'

gitpush() {
  # Based on `git-aware-prompt/prompt.sh`
  branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  git push -u origin $branch
}

# sort branch by commit date
gitbranch()
{
  git for-each-ref \
    --sort=committerdate \
    refs/heads/ \
    --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
}


######################################################################
# grep & find
mgrep()
{
  # TODO exclude .gitignore list
  exclude_option=(--exclude-dir={.git,./build})
  if [ $# == 1 ]; then
    search_dir=.
  else
    if [ ! -d "$1" ]; then
      echo "$1 is not directory!"
      return
    fi
    search_dir=$1
    shift
  fi
  grep -rn ${exclude_option[@]} $search_dir -ie $1
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


######################################################################
# Simple web server deploy

deploy-httpd()
{
docker run -d --rm \
  -p $1:80 \
  -v $2:/usr/local/apache2/htdocs/ \
  httpd
}


######################################################################
# vim command line

alias vimyaml="vim -c 'se syntax=yaml' -c 'se foldmethod=indent'"
