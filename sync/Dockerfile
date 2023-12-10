FROM ubuntu:latest

ENV GIT_NAME=git_name
ENV GIT_MAIL=git_mail

COPY . /home/app

RUN apt-get -y update && apt-get -y install git
#RUN apt-get install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib x11proto-core-dev libx11-dev libgl1-mesa-dev libxml2-utils xsltproc unzip python python3 openjdk-8-jdk rsync
RUN apt-get -y install curl

RUN git config --global user.name ${GIT_NAME}
RUN git config --global user.email ${GIT_MAIL}
RUN git config --global http.version HTTP/1.1


CMD ./home/app/syncSource.sh
