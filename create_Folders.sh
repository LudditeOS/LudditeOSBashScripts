#!/bin/bash -v


cd $HOME/gitroot/
mkdir LudditeOS
cd LudditeOS
mkdir bin
mkdir source


#Repo installieren
curl https://storage.googleapis.com/git-repo-downloads/repo > $HOME/gitroot/LudditeOS/bin/repo
chmod +x $HOME/gitroot/LudditeOS/bin/repo

#Eigenes Path Skript schreiben das den Pfad in einer neuen Terminal Session wieder setzen kann
PATH=/home/oliver/gitroot/LudditeOS/bin:$PATH

cd source
repo init -u https://android.googlesource.com/platform/manifest



echo "repo erfolgreich initialisiert"
