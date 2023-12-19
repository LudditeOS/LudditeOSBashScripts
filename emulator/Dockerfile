FROM ubuntu:latest

COPY . /home/app

RUN mkdir /home/app/LudditeOS
RUN mkdir /home/app/LudditeOS/bin
RUN mkdir /home/app/LudditeOS/source


RUN chmod +x /home/app/emulate.sh



CMD ./home/app/emulate.sh
