# docker alias
function dockerrun { docker run --rm -it $args }
function dockerrunpwd { dockerrun -v ${PWD}:/project -w /project $args }

# git alias
function github { git clone https://github.com/$args }
function gitlogb { git log --oneline --graph --branches=* }
