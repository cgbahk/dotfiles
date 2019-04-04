# docker alias
alias dockerrun='docker run --rm -it'
alias dockerrunpwd='dockerrun -v ${PWD}:${PWD} -w ${PWD}'
alias dockeronce='docker run --rm -v ${PWD}:${PWD} -w ${PWD}'
# TODO yields error for 2 or more running container
alias dockerexeconly='docker exec -it $(docker ps -q) bash'
alias dockerrmi='docker rmi $(docker images -f "dangling=true" -q)'

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

# grep & find
alias mgrep='grep -rn . -ie'
alias mfind='find . -name'

# apt
alias mapt='apt update && apt install -y'

# at alias: it wraps command at specific directory and turn back
at()
{
  pushd $1
  shift
  # TODO This is work-around. Found better solution
  ftemp="$HOME/.at_alias_temp"
  echo $* > ${ftemp}
  source ${ftemp}
  rm ${ftemp}
  popd
}
