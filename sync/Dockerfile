FROM ubuntu:latest

COPY . /home/app
RUN mkdir /home/app/LudditeOS
RUN mkdir /home/app/LudditeOS/bin
RUN mkdir /home/app/LudditeOS/source

ENV GIT_NAME=git_name
ENV GIT_MAIL=git_mail

RUN apt-get -y update && apt-get -y install git
RUN apt-get -y install curl

RUN git config --global user.name ${GIT_NAME}
RUN git config --global user.email ${GIT_MAIL}
RUN git config --global http.version HTTP/1.1


CMD ./home/app/syncSource.sh
