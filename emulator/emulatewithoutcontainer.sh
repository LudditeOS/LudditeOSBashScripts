#!/bin/bash -v

sudo rm -rf /home/oliver/LudditeOS/bin
echo "bin folder deleted"

cd /home/oliver/LudditeOS
mkdir bin
cd bin
echo "bin folder created"

#Repo installieren

curl https://storage.googleapis.com/git-repo-downloads/repo > /home/oliver/LudditeOS/bin/repo
echo "repo downloaded"
chmod +x /home/oliver/LudditeOS/bin/repo
echo "repo executable"

#Eigenes Path Skript schreiben das den Pfad in einer neuen Terminal Session wieder setzen kann
PATH=/home/oliver/LudditeOS/bin:$PATH
echo "path set"

cd /home/oliver/LudditeOS/source
echo "source folder"
repo init -u https://android.googlesource.com/platform/manifest -b android-13.0.0_r78
echo "repo init"

. build/envsetup.sh
echo "envsetup"
lunch aosp_x86_64-eng
echo "lunch"
emulator



