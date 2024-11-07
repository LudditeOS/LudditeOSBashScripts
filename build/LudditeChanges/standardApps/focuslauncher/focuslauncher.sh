#install Focuslauncher

url="https://github.com/ostaubzug/FocusLauncherRelease/releases/download/V0.0.42/focuslauncher.apk"
appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/FocusLauncher"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/focuslauncher.apk" "$url"
cp /home/app/LudditeChanges/standardApps/focuslauncher/Android.mk "$appdirectory"

mkdir -p "$buildDirectory"

