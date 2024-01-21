#!/bin/bash -v
mkdir -p /home/app/LudditeOS/android/lineage

#Repo installieren
curl https://storage.googleapis.com/git-repo-downloads/repo > /home/app/LudditeOS/bin/repo
chmod a+x /home/app/LudditeOS/bin/repo

#Eigenes Path Skript schreiben das den Pfad in einer neuen Terminal Session wieder setzen kann
PATH=/home/app/LudditeOS/bin:$PATH

git lfs install
git config --global trailer.changeid.key "Change-Id"

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache



cd /home/app/LudditeOS/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs
cp /home/app/config/roomservicestar2lte.xml /home/app/LudditeOS/android/lineag#e/.repo/local_manifests/roomservice.xml



repo sync --force-sync
source build/envsetup.sh
breakfast star2lte

