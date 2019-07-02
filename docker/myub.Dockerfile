# myub
#   collection of almost all packages
#   virtual development environment
FROM myub-base

# load auto config script
ENV DOCKER_PROMPT 1
RUN git clone https://github.com/cgbahk/dotfiles.git &&\
    dotfiles/auto_homedir.sh
