FROM ubuntu:22.04

RUN mkdir -p /home/app/LudditeOS
RUN mkdir -p /home/app/LudditeOS/bin
RUN mkdir -p /home/app/LudditeOS/android
RUN mkdir -p /home/app/LudditeOS/android/lineage

ENV GIT_NAME=git_name
ENV GIT_MAIL=git_mail
ENV BUILD_TARGET=star2lte
ENV BUILD_LINEAGE_VERSION=20.0
ENV FULL_BUILD=true
ENV APPLY_LUDDITECHANGES=true
ENV DEBUG_MODE=false 


RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get install sed
RUN apt-get install -y python-is-python3
RUN apt-get install -y unzip python3 openjdk-8-jdk rsync libx11-dev x11proto-core-dev git-core libgl1-mesa-dev
RUN apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
RUN apt-get update && apt-get install -y --no-install-recommends lib32ncurses5-dev libncurses5 libncurses5-dev
RUN apt-get update && apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*

RUN git config --global user.name ${GIT_NAME}
RUN git config --global user.email ${GIT_MAIL}
RUN git config --global http.version HTTP/1.1

COPY . /home/app

CMD ./home/app/build.sh
