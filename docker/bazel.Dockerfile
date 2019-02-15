# reference:
#    https://docs.bazel.build/versions/master/install-ubuntu.html#install-with-installer-ubuntu
#    Using Bazel custom APT repository

# bazel
FROM ubuntu

RUN sed -i -e 's/archive.ubuntu.com/kr.archive.ubuntu.com/g' /etc/apt/sources.list
RUN apt update && apt install -y curl pkg-config

RUN apt install -y openjdk-8-jdk
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" \
    | tee /etc/apt/sources.list.d/bazel.list
RUN curl https://bazel.build/bazel-release.pub.gpg \
    | apt-key add -
RUN apt update && apt install -y bazel

RUN apt clean
