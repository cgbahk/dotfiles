# doxygen
FROM ubuntu

RUN sed -i -e 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list

RUN apt update && \
    apt install -y \
    flex bison make cmake binutils python graphviz g++ git
    # qt5-default latex

RUN git clone https://github.com/doxygen/doxygen.git && \
    mkdir -p /doxygen/build
WORKDIR /doxygen/build

RUN cmake -G "Unix Makefiles" .. && \
    make

WORKDIR /
COPY doxyfile Doxyfile
RUN echo "PATH=$PATH:/doxygen/build/bin/" >> ~/.bashrc && \
    echo "alias doxyfile='cp /Doxyfile ./Doxyfile'" >> ~/.bash_aliases

RUN apt-get clean

