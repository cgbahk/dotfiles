# doxygen
FROM ubuntu

RUN sed -i -e 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

RUN apt update && \
    apt install -y \
    flex bison make cmake binutils python graphviz g++ wget
    # qt5-default latex

ENV version="Release_1_8_14"
RUN wget https://github.com/doxygen/doxygen/archive/${version}.tar.gz && \
    gunzip ${version}.tar.gz && \
    tar xf ${version}.tar && \
    mkdir -p /doxygen-${version}/build
WORKDIR /doxygen-${version}/build

RUN cmake -G "Unix Makefiles" .. && \
    make

WORKDIR /
COPY doxyfile Doxyfile
RUN echo "PATH=$PATH:/doxygen-${version}/build/bin/" >> ~/.bashrc && \
    echo "alias doxyfile='cp /Doxyfile ./Doxyfile'" >> ~/.bash_aliases

RUN apt-get clean
