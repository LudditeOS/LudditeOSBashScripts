#!/bin/bash -v


#Repo installieren
sudo curl https://storage.googleapis.com/git-repo-downloads/repo > /home/oliver/LudditeOS/bin/repo
chmod +x /home/oliver/LudditeOS/bin/repo

#Eigenes Path Skript schreiben das den Pfad in einer neuen Terminal Session wieder setzen kann
PATH=/home/oliver/LudditeOS/bin:$PATH

cd /home/oliver/LudditeOS/source
sudo repo init -u https://android.googlesource.com/platform/manifest -b android-13.0.0_r78

. build/envsetup.sh
lunch aosp_x86_64-eng
emulator --foo



