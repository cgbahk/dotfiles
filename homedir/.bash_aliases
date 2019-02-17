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

# tree alias
alias treerepo='tree -I .git -aC | more'
