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

# Stash all except staged
alias gitstash='git stash --keep-index --include-untracked'

# Update master and rebase current branch to it
gitrebase()
{
  branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

  if [ $branch == "master" ]; then
    echo "Cannot rebase master branch"
    return
  fi

  git checkout master
  git pull
  git checkout $branch
  git rebase master
}

# git commit --amend --no-edit
gitcommitamend()
{
  # TODO Do not commit if commit message have signed-off msg
  git commit --amend --no-edit $@
}

gitextract()
{
  read -p "Branch name? " branch
  git checkout -b $branch
  git reset HEAD^
}

# TODO echo as well
# TODO remove newline
alias githash='git rev-parse --short HEAD | xclip -sel clip'

alias gitrv=gitreview
gitreview()
{
  local branch=$1
  if [[ -z ${branch} ]]; then
    echo "ERROR! Branch name is not provided."
    return 1
  fi

  local proper_branch=${branch}
  proper_branch=$(echo ${proper_branch} | tr ":" "/")
  proper_branch=$(echo ${proper_branch} | sed s/ch-bahk/origin/g)
  proper_branch=$(echo ${proper_branch} | sed s/cgbahk/origin/g)

  local git_user_name=$(echo ${proper_branch} | cut -d'/' -f1)

  echo
  echo "Checking out for review..."
  echo

  if [[ -z $(git remote | grep ${git_user_name}) ]]; then
    echo "ERROR! Git user's fork is not on local."
    return 1
  fi

  git pull && git fetch ${git_user_name}
  git checkout --track ${proper_branch}
  git reset $(git merge-base $(git rev-parse ${proper_branch}) $(git rev-parse master))
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
vimchanged()
{
  local gitroot=$(git rev-parse --show-toplevel)
  vim -p1 $(git status --porcelain | sed s%^...%${gitroot}/%)
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
  vim -p1 $(git status -s | grep -E "UU|AA" | awk '{print $2}')
}

vimfzf()
{
  vim $(fzf)
}


######################################################################
# etc.

stderred()
{
  $@ 2> >(while read line; do echo -e "\e[01;31m$line\e[0m" >&2; done)
}

export FZF_DEFAULT_COMMAND='find .* * -not -path "*.git/*"'
export FZF_DEFAULT_OPTS='--height 1% --layout=reverse -m'

export PATH=$PATH:${HOME}/go/bin

# TODO Support for other system, e.g. mac
alias cdtemp="cd $(mktemp -d) && pwd | xclip -sel clip"


######################################################################
# Github CLI

ghissue ()
{
  gh issue view --web $1 > /dev/null 2>&1
}

if [[ -n $(which gh) ]]; then
  eval "$(gh completion -s bash)"
fi
