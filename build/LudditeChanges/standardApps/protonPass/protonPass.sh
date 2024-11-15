appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/ProtonPass"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
cp /home/app/LudditeOS/LudditeApk/ProtonPass.apk "$appdirectory/ProtonPass.apk"
cp /home/app/LudditeChanges/standardApps/protonPass/Android.mk "$appdirectory"



