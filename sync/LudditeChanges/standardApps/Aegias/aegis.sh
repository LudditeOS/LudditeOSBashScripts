#install Focuslauncher

url="https://f-droid.org/repo/com.beemdevelopment.aegis_62.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Aegis"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/Aegis.apk" "$url"
cp Android.mk "$appdirectory"



