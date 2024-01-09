#!/bin/bash -v

echo "build script start"

#Repo installieren
curl https://storage.googleapis.com/git-repo-downloads/repo > /home/app/LudditeOS/bin/repo
chmod a+x /home/app/LudditeOS/bin/repo

#Eigenes Path Skript schreiben das den Pfad in einer neuen Terminal Session wieder setzen kann
PATH=/home/app/LudditeOS/bin:$PATH

cd /home/app/LudditeOS/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-19.1 --git-lfs
git lfs install
git config --global trailer.changeid.key "Change-Id"

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache


#start build
source build/envsetup.sh
lunch lineage_sdk_phone_arm-eng
mka
mka sdk_addon
cd /home/app/LudditeOS 
chmod -R 777 android





