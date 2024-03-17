#install Focuslauncher

url="https://f-droid.org/repo/net.osmand.plus_461403.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/OSMMaps"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/OSMMaps.apk" "$url"
cp Android.mk "$appdirectory"



