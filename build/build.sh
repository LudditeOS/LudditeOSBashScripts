#!/bin/bash -v

mkdir -p /home/app/LudditeOS/android/lineage
mkdir -p /home/app/dockerbin/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > /home/app/dockerbin/bin/repo

chmod a+x /home/app/dockerbin/bin/repo
PATH=/home/app/dockerbin/bin:$PATH
git lfs install
git config --global trailer.changeid.key "Change-Id"
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache




if [[ "${STAR2LTE,,}" == "true" ]]; then
    echo "Luddite Build star2lte lineage 20"
    
    rm -rf /home/app/LudditeOS/android/lineage
    mkdir -p /home/app/LudditeOS/android/lineage

    cd /home/app/LudditeOS/android/lineage
    repo init -u /home/app/LudditeOS/LineageMirror/LineageOS/android.git -b lineage-20.0 --git-lfs
    
    mkdir -p /home/app/LudditeOS/android/lineage/.repo/local_manifests
    cp /home/app/config/roomservice-star2lte.xml /home/app/LudditeOS/android/lineage/.repo/local_manifests/roomservice.xml

    repo sync --force-remove-dirty --force-sync
    chmod -R a+x /home/app/LudditeChanges
    . /home/app/LudditeChanges/applyLudditeChanges.sh

    source build/envsetup.sh
    breakfast star2lte

    croot
    brunch star2lte

    cd /home/app/LudditeOS 
    chmod -R 777 android

    currentTime=$(date +"%Y%m%d_%H%M%S")
    mkdir -p "/home/app/LudditeOS/release/${currentTime}/star2lte-20"
    cp -r /home/app/LudditeOS/android/lineage/out/target/product/star2lte "/home/app/LudditeOS/release/${currentTime}/star2lte-20" 
fi

if [[ "${ORIOLE,,}" == "true" ]]; then
    echo "Luddite Build oriole lineage 21"

    rm -rf /home/app/LudditeOS/android/lineage
    mkdir -p /home/app/LudditeOS/android/lineage

    cd /home/app/LudditeOS/android/lineage
    repo init -u /home/app/LudditeOS/LineageMirror/LineageOS/android.git -b lineage-21.0 --git-lfs


    mkdir -p /home/app/LudditeOS/android/lineage/.repo/local_manifests
    cp /home/app/config/roomservice-oriole.xml /home/app/LudditeOS/android/lineage/.repo/local_manifests/roomservice.xml

    repo sync --force-remove-dirty --force-sync
    chmod -R a+x /home/app/LudditeChanges
    . /home/app/LudditeChanges/applyLudditeChanges.sh

    source build/envsetup.sh
    breakfast oriole

    croot
    brunch oriole

    cd /home/app/LudditeOS 
    chmod -R 777 android

    currentTime=$(date +"%Y%m%d_%H%M%S")
    mkdir -p "/home/app/LudditeOS/release/${currentTime}/oriole-21"
    cp -r /home/app/LudditeOS/android/lineage/out/target/product/oriole "/home/app/LudditeOS/release/${currentTime}/oriole-21" 
fi




#den release nach release kopieren