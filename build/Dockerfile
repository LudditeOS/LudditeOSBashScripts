FROM ubuntu:latest

COPY . /home/app

RUN mkdir /home/app/LudditeOS
RUN mkdir /home/app/LudditeOS/bin
RUN mkdir /home/app/LudditeOS/source

ENV GIT_NAME=git_name
ENV GIT_MAIL=git_mail

RUN apt-get -y update && apt-get -y install git
RUN apt-get -y install curl
RUN apt-get install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev x11proto-core-dev libx11-dev libgl1-mesa-dev libxml2-utils xsltproc unzip python3 openjdk-8-jdk rsync
RUN apt-get install -y python-is-python3


RUN git config --global user.name ${GIT_NAME}
RUN git config --global user.email ${GIT_MAIL}
RUN git config --global http.version HTTP/1.1

RUN chmod +x /home/app/build.sh



CMD ./home/app/build.sh