#install Focuslauncher

url="https://f-droid.org/repo/com.nextcloud.client_30280090.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Nextcloud"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/Nextcloud.apk" "$url"
cp Android.mk "$appdirectory"



