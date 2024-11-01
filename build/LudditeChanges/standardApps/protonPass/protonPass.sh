#install ProtonPass

url="https://f-droid.org/repo/proton.android.pass.fdroid_12601000.apk"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/ProtonPass"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/ProtonPass.apk" "$url"
cp /home/app/LudditeChanges/standardApps/protonPass/Android.mk "$appdirectory"



