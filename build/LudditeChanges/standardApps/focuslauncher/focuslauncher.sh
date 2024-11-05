#install Focuslauncher

url="https://github.com/ostaubzug/FocusLauncherRelease/releases/download/V0.2/focuslauncher.apk"
appdirectory="/home/app/LudditeOS/android/lineage/packages/apps/FocusLauncher"
buildDirectory="/home/app/LudditeOS/android/lineage/build/target/product"


if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget "$url" -P "$appdirectory"
cp /home/app/LudditeChanges/standardApps/focuslauncher/Android.mk "$appdirectory"

mkdir -p "$buildDirectory"



