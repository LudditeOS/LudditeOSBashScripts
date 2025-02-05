#!/bin/bash
url="https://github.com/ostaubzug/LudditeInstaller/releases/download/V0.44/ludditeinstaller-aligned.apk"
# Create and use the new vendor directory
appdirectory="/home/app/LudditeOS/android/lineage/vendor/luddite/apps/LudditeInstaller"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/ludditeinstaller.apk" "$url"
cp /home/app/LudditeChanges/standardApps/LudditeInstaller/Android.mk "$appdirectory"

# Create a basic vendor makefile to include our apps
cat > "/home/app/LudditeOS/android/lineage/vendor/luddite/luddite.mk" << 'EOL'
PRODUCT_SOONG_NAMESPACES += \
    vendor/luddite

PRODUCT_PACKAGES += \
    LudditeInstaller
EOL