appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/Nextcloud"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
cp /home/app/LudditeOS/LudditeApk/NcPhotos.apk "$appdirectory/NcPhotos.apk"
cp /home/app/LudditeChanges/standardApps/ncphotos/Android.mk "$appdirectory"



