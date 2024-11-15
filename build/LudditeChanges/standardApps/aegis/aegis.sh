appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/Aegis"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
cp /home/app/LudditeOS/LudditeApk/Aegis.apk "$appdirectory/Aegis.apk"
cp /home/app/LudditeChanges/standardApps/aegis/Android.mk "$appdirectory"



