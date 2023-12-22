FROM ubuntu:latest

COPY . /home/app

RUN mkdir /home/app/LudditeOS
RUN mkdir /home/app/LudditeOS/bin
RUN mkdir /home/app/LudditeOS/source

RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get install -y python-is-python3
RUN apt-get install -y git-core gnupg flex bison gperf libncurses5 build-essential zip curl zlib1g-dev gcc-multilib g++-multilib x11proto-core-dev libx11-dev libc6-dev-i386 lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip python3 openjdk-8-jdk rsync fontconfig
RUN apt-get install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils



RUN chmod +x /home/app/emulate.sh



CMD ./home/app/emulate.sh
