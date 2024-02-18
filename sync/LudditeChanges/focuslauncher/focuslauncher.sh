url="https://github.com/ostaubzug/focuslauncher/archive/refs/tags/V-0.1-Snapshot.zip"

directory="/home/oliver/LudditeOS/android/lineage/packages/apps/FocusLauncher/"
buildDirectory="/home/oliver/LudditeOS/android/lineage/build/target/product/"


mkdir -p "$directory"

wget "$url" -P "$directory"

unzip "$directory/V-0.1-Snapshot.zip" -d "$directory"

cp Android.mk "$directory"

mkdir -p "$buildDirectory"
patch "$directory/handheld_product.mk" < FocusLauncherPatch



