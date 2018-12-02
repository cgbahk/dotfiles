# docker alias
alias dockerrun='docker run --rm -it'

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

# tree alias
alias treerepo='tree -I .git -a | less'

