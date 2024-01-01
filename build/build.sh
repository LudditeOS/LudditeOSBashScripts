#!/bin/bash -v

echo "build script start"

#Repo installieren
curl https://storage.googleapis.com/git-repo-downloads/repo > /home/app/LudditeOS/bin/repo
chmod +x /home/app/LudditeOS/bin/repo

#Eigenes Path Skript schreiben das den Pfad in einer neuen Terminal Session wieder setzen kann
PATH=/home/app/LudditeOS/bin:$PATH

cd /home/app/LudditeOS/source
repo init -u https://android.googlesource.com/platform/manifest -b android-13.0.0_r78

#start build
. build/envsetup.sh
lunch sdk_phone_x86_64-userdebug
m
cd /home/app/LudditeOS 
chmod -R 777 source