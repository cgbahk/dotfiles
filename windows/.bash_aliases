# aliases for mintty in windows

# docker alias
alias dockerrun='winpty docker run --rm -it'
alias dockerrunpwd='winpty docker run --rm -it -v ${PWD}:${PWD} -w ${PWD}'
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
