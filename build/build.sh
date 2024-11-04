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
repo init -u http://www.github.com/LineageOS/android -b lineage-20.0 --git-lfs --reference=/home/app/LudditeOS/LineageMirror/LineageOS/android.git
    
#https://luk1337.github.io/muppets/
#https://gist.github.com/fourkbomb/261ced58cd029c5f7742350aafdd9825

repo sync
    
mkdir -p /home/app/LudditeOS/android/lineage/.repo/local_manifests
cp /home/app/config/roomservice-star2lte.xml /home/app/LudditeOS/android/lineage/.repo/local_manifests/roomservice.xml

repo sync

chmod -R a+x /home/app/LudditeChanges
. /home/app/LudditeChanges/applyLudditeChanges.sh

source build/envsetup.sh
breakfast star2lte

source build/envsetup.sh
breakfast star2lte

croot
brunch star2lte

cd /home/app/LudditeOS 
chmod -R 777 android

currentTime=$(date +"%Y%m%d_%H%M%S")
mkdir -p "/home/app/LudditeOS/release/${currentTime}/star2lte-20"
cp -r /home/app/LudditeOS/android/lineage/out/target/product/star2lte "/home/app/LudditeOS/release/${currentTime}/star2lte-20" 