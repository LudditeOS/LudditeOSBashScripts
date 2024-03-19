#install Focuslauncher

url="https://f-droid.org/repo/at.bitfire.davdroid_403140002.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Davx"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/Davx.apk" "$url"
cp Android.mk "$appdirectory"



