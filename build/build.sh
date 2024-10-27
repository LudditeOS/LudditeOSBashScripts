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


if [[ "${STAR2LTE,,}" == "true" ]]; then
    echo "Luddite Build star2lte lineage 20"
    cd /home/app/LudditeOS/android/lineage
    repo init -u https://github.com/LineageOS/android.git -b lineage-20.0 --git-lfs --force-sync
    mkdir -p /home/app/LudditeOS/android/lineage/.repo/local_manifests
    cp /home/app/config/roomservice-star2lte.xml /home/app/LudditeOS/android/lineage/.repo/local_manifests/roomservice.xml

    repo sync --force-sync --force-remove-dirty
    chmod -R a+x /home/app/LudditeChanges
    . /home/app/LudditeChanges/applyLudditeChanges.sh

    source build/envsetup.sh
    breakfast star2lte

    croot
    brunch star2lte
fi

if [[ "${ORIOLE,,}" == "true" ]]; then
    echo "Luddite Build oriole lineage 21"
    cd /home/app/LudditeOS/android/lineage
    repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs --force-sync
    mkdir -p /home/app/LudditeOS/android/lineage/.repo/local_manifests
    cp /home/app/config/roomservice-oriole.xml /home/app/LudditeOS/android/lineage/.repo/local_manifests/roomservice.xml

    repo sync --force-sync --force-remove-dirty
    chmod -R a+x /home/app/LudditeChanges
    . /home/app/LudditeChanges/applyLudditeChanges.sh

    source build/envsetup.sh
    breakfast oriole

    croot
    brunch oriole
fi


cd /home/app/LudditeOS 
chmod -R 777 android