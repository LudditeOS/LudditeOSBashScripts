#!/bin/bash -v


cd /home/app
mkdir LudditeOS
cd LudditeOS
mkdir bin
mkdir source


#Repo installieren
curl https://storage.googleapis.com/git-repo-downloads/repo > $HOME/gitroot/LudditeOS/bin/repo
chmod +x /home/app/LudditeOS/bin/repo

#Eigenes Path Skript schreiben das den Pfad in einer neuen Terminal Session wieder setzen kann
PATH=/home/app/LudditeOS/bin:$PATH

cd source
repo init -u https://android.googlesource.com/platform/manifest -b android-13.0.0_r78
repo sync

echo "repo synced into source Folder"
