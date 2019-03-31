# isl

FROM myub

RUN apt update && apt install -y autoconf
RUN apt update && apt install -y libgmp-dev
RUN apt update && apt install -y libtool
RUN apt update && apt install -y python
RUN apt update && apt install -y libntl-dev

# To reduce image size
RUN apt clean
