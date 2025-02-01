url="https://github.com/ostaubzug/LudditeInstaller/releases/download/V0.4.4/ludditeinstaller.apk"
appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/LudditeInstaller"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/ludditeinstaller.apk" "$url"
cp /home/app/LudditeChanges/standardApps/LudditeInstaller/Android.mk "$appdirectory"