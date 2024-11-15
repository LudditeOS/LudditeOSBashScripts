appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/Davx"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
cp /home/app/LudditeOS/LudditeApk/Davx.apk "$appdirectory/Davx.apk"
cp /home/app/LudditeChanges/standardApps/davx/Android.mk "$appdirectory"



