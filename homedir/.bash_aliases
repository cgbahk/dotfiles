#!/bin/bash
# Bash configuration setting
#   file name is '.bash_aliases' but used as it is sourced by almost .bashrc or .bash_profile


######################################################################
# docker alias

alias dockerrun='docker run --rm -it'
alias dockerrunpwd='dockerrun -v ${PWD}:${PWD} -w ${PWD}'
alias dockerrunuser='dockerrunpwd -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro -u=$(id -u $USER):$(id -g $USER)'
alias dockeronce='docker run --rm -v ${PWD}:${PWD} -w ${PWD}'
# TODO yields error for 2 or more running container
alias dockerexeconly='docker exec -it $(docker ps -q) bash'
alias dockerrmi='docker rmi $(docker images -f "dangling=true" -q)'
alias dockerrm='docker rm $(docker ps -qf status=exited)'

export MY_DOCKER_GDB_OPTION="--cap-add=SYS_PTRACE --security-opt seccomp=unconfined"

function docker_cleanup()
{
  # Newly created files during during docker run can have different ownership.
  # Let's change owner of all files under current directory
  OWNER_UID=$(stat -c "%u" $PWD)
  OWNER_GID=$(stat -c "%g" $PWD)

  CMD="chown -R $OWNER_UID:$OWNER_GID $PWD"
  dockerrunpwd ubuntu $CMD
}


######################################################################
# git alias
# TODO Move git alias into git's alias, e.g. git hub / git clear

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

# TODO
# _get_current_branch()

gitpush()
{
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

# clear all
# TODO make it safer
alias gitclear='git checkout -- . && git clean -df'

# Remove current branch
gitrmb()
{
  branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

  if [ $branch == "master" ]; then
    echo "Cannot remove master branch"
    return
  fi

  gitclear
  git checkout master
  git branch -D $branch
}


######################################################################
# grep & find
mgrep()
{
  # TODO exclude .gitignore list
  # This does not work as intended
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
  --name $3 \
  httpd
}


######################################################################
# vim command line

alias vimyaml="vim -c 'se syntax=yaml' -c 'se foldmethod=indent'"
vimreview()
{
  vim -p1 $(git status --porcelain | sed s/^...//)
}

vimcommit()
{
  vim -p1 $(git log --name-only --format="" -1)
}

vimprev()
{
  prev=$(history | tail -2 | head -1 | cut -c8-999)
  eval $prev | vim $@ -
}

vimrebase()
{
  vim -p1 $(git status -s | grep UU | awk '{print $2}')
}


######################################################################
# etc.

stderred()
{
  $@ 2> >(while read line; do echo -e "\e[01;31m$line\e[0m" >&2; done)
}
