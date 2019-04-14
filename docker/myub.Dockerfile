# myub
#   collection of almost all packages
#   virtual development environment
FROM myub-base

# load auto config script
RUN git clone https://github.com/cgbahk/dotfiles.git &&\
    dotfiles/auto_homedir.sh
