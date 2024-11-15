appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/Phoenix"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
cp /home/app/LudditeOS/LudditeApk/Phoenix.apk "$appdirectory/Phoenix.apk"
cp /home/app/LudditeChanges/standardApps/phoenix/Android.mk "$appdirectory"