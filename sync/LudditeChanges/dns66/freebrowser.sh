#install Focuslauncher

url="https://f-droid.org/repo/org.jak_linux.dns66_29.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Dns66"
buildDirectory="/home/oliver/LudditeOS/android/lineage/build/target/product"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/Dns66.apk" "$url"
cp Android.mk "$appdirectory"

mkdir -p "$buildDirectory"
patch "$buildDirectory/handheld_product.mk" < Dns66Patch



