#!/bin/bash -v


rm -rf /home/app/LudditeOS/bin
rm -rf /home/app/LudditeOS/android
    
mkdir -p /home/app/LudditeOS/android/lineage
mkdir -p /home/app/LudditeOS/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > /home/app/LudditeOS/bin/repo
chmod a+x /home/app/LudditeOS/bin/repo

PATH=/home/app/LudditeOS/bin:$PATH
git lfs install
git config --global trailer.changeid.key "Change-Id"
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache


cd /home/app/LudditeOS/android/lineage
repo init -u http://www.github.com/LineageOS/android -b lineage-${BUILD_LINEAGE_VERSION} --git-lfs --reference=/home/app/LudditeOS/LineageMirror/LineageOS/android.git

repo sync
    
mkdir -p /home/app/LudditeOS/android/lineage/.repo/local_manifests
cp /home/app/config/roomservice-${BUILD_TARGET}.xml /home/app/LudditeOS/android/lineage/.repo/local_manifests/roomservice.xml

repo sync

chmod -R a+x /home/app/LudditeChanges
. /home/app/LudditeChanges/applyLudditeChanges.sh

source build/envsetup.sh
breakfast ${BUILD_TARGET}

source build/envsetup.sh
breakfast ${BUILD_TARGET}

croot
brunch ${BUILD_TARGET}

cd /home/app/LudditeOS 
chmod -R 777 android

currentTime=$(date +"%Y%m%d_%H%M%S")
mkdir -p "/home/app/LudditeOS/release/${currentTime}/${BUILD_TARGET}"
cp -r /home/app/LudditeOS/android/lineage/out/target/product/${BUILD_TARGET} "/home/app/LudditeOS/release/${currentTime}/${BUILD_TARGET}" 