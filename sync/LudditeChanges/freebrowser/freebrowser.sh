#install Focuslauncher

url="https://f-droid.org/repo/org.woheller69.browser_2600.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/FreeBrowser"
buildDirectory="/home/oliver/LudditeOS/android/lineage/build/target/product"

mkdir -p "$appdirectory"
wget -O "$appdirectory/FreeBrowser.apk" "$url"
cp Android.mk "$appdirectory"

mkdir -p "$buildDirectory"
patch "$buildDirectory/handheld_product.mk" < FreeBrowserPatch



