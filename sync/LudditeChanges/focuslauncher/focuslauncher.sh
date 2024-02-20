url="https://github.com/ostaubzug/FocusLauncherRelease/releases/download/V0.1/app-release.apk"

appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/FocusLauncher/"
buildDirectory="/home/oliver/LudditeOS/android/lineage/build/target/product/"


mkdir -p "$appdirectory"
wget "$url" -P "$appdirectory"
unzip "$appdirectory/V-0.1-Snapshot.zip" -d "$appdirectory"
cp "$(dirname "$0")/Android.mk" "$appdirectory"

mkdir -p "$buildDirectory"
patch "$appdirectory/handheld_product.mk" < "$(dirname "$0")/FocusLauncherPatch"



