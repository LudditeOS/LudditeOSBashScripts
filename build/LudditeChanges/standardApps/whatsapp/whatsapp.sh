appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/Whatsapp"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
cp /home/app/LudditeOS/LudditeApk/Whatsapp.apk "$appdirectory/Whatsapp.apk"
cp /home/app/LudditeChanges/standardApps/whatsapp/Android.mk "$appdirectory"