

url="https://github.com/ACINQ/phoenix/releases/download/android-v2.2.1/phoenix-77-2.2.1-mainnet.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Phoenix"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/Phoenix.apk" "$url"
cp /home/app/LudditeChanges/standardApps/phoenix/Android.mk "$appdirectory"