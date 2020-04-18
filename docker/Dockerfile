FROM ubuntu:16.04

RUN sed -i s/archive.ubuntu.com/ftp.daumkakao.com/g /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update 
RUN apt-get install -y make 
RUN apt-get install -y git unzip 
RUN apt-get install -y wget
RUN apt-get install -y build-essential
RUN apt-get install -y git bc bison flex libssl-dev make libc6-dev libncurses5-dev

# Set environment variables
# UBUNTU korean locale
RUN apt-get install -y locales
ENV LANGUAGE=ko_KR.UTF-8 
ENV LANG=ko_KR.UTF-8
RUN locale-gen ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8

RUN mkdir -p /workdir/build
RUN mkdir -p /workdir/pi

VOLUME /workdir/build
VOLUME /workdir/pi

WORKDIR /workdir/build
WORKDIR /workdir/pi

CMD ["/bin/bash"]
