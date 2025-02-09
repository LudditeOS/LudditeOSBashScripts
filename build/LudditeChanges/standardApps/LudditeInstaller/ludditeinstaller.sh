#!/bin/bash
url="https://github.com/ostaubzug/LudditeInstaller/releases/download/V0.44/ludditeinstaller-aligned.apk"
# Use the LineageOS vendor directory instead
appdirectory="/home/app/LudditeOS/android/lineage/vendor/lineage/apps/LudditeInstaller"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/ludditeinstaller.apk" "$url"
cp /home/app/LudditeChanges/standardApps/LudditeInstaller/Android.mk "$appdirectory"

# Add our package to the existing LineageOS common makefile
if ! grep -q "LudditeInstaller" "/home/app/LudditeOS/android/lineage/vendor/lineage/config/common.mk"; then
    echo "" >> "/home/app/LudditeOS/android/lineage/vendor/lineage/config/common.mk"
    echo "# LudditeInstaller app" >> "/home/app/LudditeOS/android/lineage/vendor/lineage/config/common.mk"
    echo "PRODUCT_PACKAGES += \\" >> "/home/app/LudditeOS/android/lineage/vendor/lineage/config/common.mk"
    echo "    LudditeInstaller" >> "/home/app/LudditeOS/android/lineage/vendor/lineage/config/common.mk"
fi