# colorize shell prompt
echo 'PS1="\[\033[1;31m\]#\# [\u:\w] $\[\033[0m\] "' >> ~/.bashrc
source ~/.bashrc
# TODO: .bashrc? ./bash_profile?
