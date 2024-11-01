#install ProtonPass

url="https://f-droid.org/repo/at.bitfire.davdroid_404030200.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Davx"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/Davx.apk" "$url"
cp /home/app/LudditeChanges/standardApps/davx/Android.mk "$appdirectory"



