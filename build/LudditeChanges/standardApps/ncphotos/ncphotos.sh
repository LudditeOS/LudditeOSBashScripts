#install Focuslauncher

url="https://github.com/nkming2/nc-photos/releases/download/69.1/nc_photos-69-1.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Nextcloud"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/ncphotos.apk" "$url"
cp Android.mk "$appdirectory"



