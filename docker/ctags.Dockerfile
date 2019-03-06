# ctags
FROM ubuntu

RUN sed -i -e 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

RUN apt update && apt install ctags
RUN apt clean && apt autoclean
