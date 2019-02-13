# TODO use this file for setting
# TODO copy default linux / mac setting
# TODO consider .bash_profile as well

# auto completion for make
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make
