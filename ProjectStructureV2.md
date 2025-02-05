# Project Structure for /Users/oliverstaub/gitroot/LudditeOSBashScripts

- **.git/**
- **.github/**
  - **workflows/**
    - docker-publish-build.yml (723 bytes)
      - Content preview:
```
name: ludditebuild
on:
  push:
    branches:
      - main
    tags:
      - "*"
jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Set up QEMU
        uses: docker/setup-qemu-action@v3

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and push
        uses: docker/build-push-action@v6
        with:
          context: "{{defaultContext}}:build"
          push: true
          tags: oli1115/ludditebuild:${{ github.ref_type == 'tag' && github.ref_name || 'latest' }}

```
    - docker-publish-mirror.yml (662 bytes)
      - Content preview:
```
name: ludditemirrorsync

on:
  push:
    branches:
      - main

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Set up QEMU
        uses: docker/setup-qemu-action@v3
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      - name: Build and push
        uses: docker/build-push-action@v6
        with:
          context: "{{defaultContext}}:LineageMirror"
          push: true
          tags: oli1115/ludditemirrorsync:latest

```
- **build/**
  - **BlobExtractor/**
    - docker-compose.yml (369 bytes)
      - Content preview:
```
version: "3"
services:
  blob_extractor:
    build: .
    privileged: true
    network_mode: "host" # Use host network mode for ADB
    volumes:
      - ./output:/home/blob-extractor/output
      - /dev/bus/usb:/dev/bus/usb
      - $HOME/.android:/root/.android # Share ADB keys
    environment:
      - ANDROID_HOME=/opt/android
      - ADB_VENDOR_KEYS=$HOME/.android

```
    - Dockerfile (824 bytes)
      - Content preview:
```
FROM ubuntu:22.04

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    adb \
    android-tools-adb \
    android-tools-fastboot \
    usbutils \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
RUN mkdir -p /home/blob-extractor
WORKDIR /home/blob-extractor

# Set up ADB
RUN mkdir -p /opt/android
ENV ANDROID_HOME=/opt/android
ENV PATH=${PATH}:${ANDROID_HOME}/platform-tools

# Copy the extraction script
COPY extract-blobs.sh /home/blob-extractor/
RUN chmod +x /home/blob-extractor/extract-blobs.sh

# Set up the directory structure
RUN mkdir -p /home/blob-extractor/lineage/device/google/oriole
RUN mkdir -p /home/blob-extractor/output

# Start ADB server as root
ENTRYPOINT ["bash", "-c", "adb kill-server && adb start-server && ./extract-blobs.sh"]
```
    - extract-blobs.sh (1181 bytes)
      - Content preview:
```
#!/bin/bash

echo "Starting blob extraction process..."

# Check if device is connected
if ! adb devices | grep -q "device$"; then
    echo "Error: No device connected or device not authorized"
    echo "Please ensure:"
    echo "1. Your device is connected via USB"
    echo "2. USB debugging is enabled"
    echo "3. You have authorized the computer on your device"
    exit 1
fi

# Create temporary lineage directory structure
cd /home/blob-extractor/lineage

# Clone necessary repositories
echo "Cloning device repository..."
git clone https://github.com/LineageOS/android_device_google_oriole.git device/google/oriole

# Run extraction script
echo "Running extraction script..."
cd device/google/oriole
./extract-files.sh

# Check if vendor directory was created and contains files
if [ -d "/home/blob-extractor/lineage/vendor/google/oriole" ]; then
    echo "Creating backup archive..."
    cd /home/blob-extractor/lineage
    tar -czf /home/blob-extractor/output/oriole-blobs.tar.gz vendor/google/oriole/
    echo "Blob extraction complete! Archive saved to output/oriole-blobs.tar.gz"
else
    echo "Error: Blob extraction failed - vendor directory not found"
    exit 1
fi
```
  - **config/**
    - roomservice-oriole-20.0.xml (407 bytes)
      - Content preview:
```
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <remote fetch="https://gitlab.com" name="gitlab" />
    <project name="the-muppets/proprietary_vendor_google_oriole" path="vendor/google/oriole"
        remote="gitlab" revision="lineage-20" />
    <project name="the-muppets/proprietary_vendor_firmware" path="vendor/firmware" remote="gitlab"
        revision="lineage-20" clone-depth="1" />
</manifest>
```
    - roomservice-oriole-21.0.xml (202 bytes)
      - Content preview:
```
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <project name="TheMuppets/proprietary_vendor_google_oriole" path="vendor/google/oriole"
        remote="github" revision="lineage-21" />
</manifest>
```
    - roomservice-oriole-22.1.xml (180 bytes)
      - Content preview:
```
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <project name="TheMuppets/proprietary_vendor_google_oriole" path="vendor/google/oriole"
        remote="github" />
</manifest>
```
    - roomservice-star2lte-20.0.xml (467 bytes)
      - Content preview:
```
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <remote name="TheMuppets" fetch="https://github.com/" revision="refs/heads/lineage-20" />
    <project name="TheMuppets/proprietary_vendor_samsung_star2lte" path="vendor/samsung/star2lte"
        remote="TheMuppets" depth="1" />
    <project
        name="TheMuppets/proprietary_vendor_samsung_exynos9810-common"
        path="vendor/samsung/exynos9810-common"
        remote="TheMuppets" depth="1" />
</manifest>
```
  - **LudditeChanges/**
    - **bootanimation/**
      - bootanimation.sh (274 bytes)
        - Content preview:
```
cp /home/app/LudditeChanges/bootanimation/bootanimation.tar /home/app/LudditeOS/android/lineage/vendor/lineage/bootanimation/bootanimation.tar
patch /home/app/LudditeOS/android/lineage/vendor/lineage/bootanimation/Android.mk < /home/app/LudditeChanges/bootanimation/MkPatch

```
      - bootanimation.tar (655360 bytes)
      - MkPatch (447 bytes)
        - Content preview:
```
--- AndroidOriginal.mk	2024-01-30 22:06:46.828772989 +0000
+++ Android.mk	2024-01-30 16:52:54.019178521 +0000
@@ -29,7 +29,7 @@
 	fi; \
 	IMAGESCALEWIDTH=$$IMAGEWIDTH; \
 	IMAGESCALEHEIGHT=$$(expr $$IMAGESCALEWIDTH / 3); \
-	if [ "$(TARGET_BOOTANIMATION_HALF_RES)" = "true" ]; then \
+	if [ "$(TARGET_BOOTANIMATION_HALF_RES)" = "false" ]; then \
 	    IMAGEWIDTH="$$(expr "$$IMAGEWIDTH" / 2)"; \
 	fi; \
 	IMAGEHEIGHT=$$(expr $$IMAGEWIDTH / 3); \

```
    - **standardApps/**
      - **handheldProduct/**
        - handheld_product.mk (50 bytes)
          - Content preview:
```
$(call inherit-product, vendor/luddite/luddite.mk)
```
        - handheldProduct.sh (158 bytes)
          - Content preview:
```
cp /home/app/LudditeChanges/standardApps/handheldProduct/handheld_product.mk /home/app/LudditeOS/android/lineage/build/make/target/product/handheld_product.mk
```
      - **LudditeInstaller/**
        - Android.mk (322 bytes)
          - Content preview:
```
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := LudditeInstaller
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := ludditeinstaller.apk
LOCAL_MODULE_CLASS := APPS
LOCAL_PRODUCT_MODULE := true
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
include $(BUILD_PREBUILT)
```
        - ludditeinstaller.sh (701 bytes)
          - Content preview:
```
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
```
      - **PackageInstaller/**
        - activity.patch (619 bytes)
          - Content preview:
```
--- PackageInstallerActivityOriginal.java	2024-12-26 23:35:30.682568894 +0000
+++ PackageInstallerActivity.java	2024-12-25 12:43:17.720667750 +0000
@@ -143,9 +143,15 @@
 
         viewToEnable.setVisibility(View.VISIBLE);
 
-        mEnableOk = true;
-        mOk.setEnabled(true);
+        mEnableOk = false;
+        mOk.setEnabled(false);
         mOk.setFilterTouchesWhenObscured(true);
+
+        if ("com.luddite.app.store.INSTALL_PACKAGE".equals(getIntent().getAction())) {
+            mEnableOk = true;  // Enable install button for our store
+            mOk.setEnabled(true);
+        }
+
     }
 
     /**


```
        - installstart.patch (689 bytes)
          - Content preview:
```
--- InstallStart-original.java	2024-12-24 09:07:54.881593300 +0000
+++ InstallStart.java	2024-12-25 21:30:35.431342985 +0000
@@ -80,6 +80,12 @@
         final ApplicationInfo sourceInfo = getSourceInfo(callingPackage);
         final int originatingUid = getOriginatingUid(sourceInfo);
         boolean isTrustedSource = false;
+
+        if ("com.luddite.app.store.INSTALL_PACKAGE".equals(intent.getAction())) {
+            isTrustedSource = true;
+        }
+
+
         if (sourceInfo != null
                 && (sourceInfo.privateFlags & ApplicationInfo.PRIVATE_FLAG_PRIVILEGED) != 0) {
             isTrustedSource = intent.getBooleanExtra(Intent.EXTRA_NOT_UNKNOWN_SOURCE, false);


```
        - manifest.patch (786 bytes)
          - Content preview:
```
--- AndroidManifestOriginal.xml	2024-12-28 19:11:37.086576671 +0000
+++ AndroidManifest.xml	2024-12-28 18:49:50.118627204 +0000
@@ -59,6 +59,12 @@
                 <action android:name="android.content.pm.action.CONFIRM_INSTALL" />
                 <category android:name="android.intent.category.DEFAULT" />
             </intent-filter>
+            <intent-filter android:priority="1">
+                <action android:name="com.luddite.app.store.INSTALL_PACKAGE" />
+                <category android:name="android.intent.category.DEFAULT" />
+                <data android:scheme="content" />
+                <data android:mimeType="application/vnd.android.package-archive" />
+            </intent-filter>
         </activity>
 
         <activity android:name=".InstallStaging"

```
        - packageinstaller.sh (606 bytes)
          - Content preview:
```
patch /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/src/com/android/packageinstaller/PackageInstallerActivity.java < /home/app/LudditeChanges/standardApps/PackageInstaller/activity.patch
patch /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/src/com/android/packageinstaller/InstallStart.java < /home/app/LudditeChanges/standardApps/PackageInstaller/installstart.patch
patch /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/AndroidManifest.xml < /home/app/LudditeChanges/standardApps/PackageInstaller/manifest.patch

```
      - **removeBrowser/**
        - common_mobile.mk (2435 bytes)
          - Content preview:
```
# Inherit common mobile Lineage stuff
$(call inherit-product, vendor/lineage/config/common.mk)

# Include AOSP audio files
include vendor/lineage/config/aosp_audio.mk

# Include Lineage audio files
include vendor/lineage/config/lineage_audio.mk

# Default notification/alarm sounds
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg

# Apps
PRODUCT_PACKAGES += \
    Backgrounds \
    ExactCalculator

ifeq ($(PRODUCT_TYPE), go)
PRODUCT_PACKAGES += \
    TrebuchetQuickStepGo

PRODUCT_DEXPREOPT_SPEED_APPS += \
    TrebuchetQuickStepGo
else
PRODUCT_PACKAGES += \
    TrebuchetQuickStep

PRODUCT_DEXPREOPT_SPEED_APPS += \
    TrebuchetQuickStep
endif

PRODUCT_PACKAGES += \
    TrebuchetOverlay

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

ifneq ($(WITH_LINEAGE_CHARGER),false)
PRODUCT_PACKAGES += \
    lineage_charger_animation \
    lineage_charger_animation_vendor
endif

# Customizations
PRODUCT_PACKAGES += \
    IconPackCircularAndroidOverlay \
    IconPackCircularLauncherOverlay \
    IconPackCircularSettingsOverlay \
    IconPackCircularSystemUIOverlay \
    IconPackFilledAndroidOverlay \
    IconPackFilledLauncherOverlay \
    IconPackFilledSettingsOverlay \
    IconPackFilledSystemUIOverlay \
    IconPackKaiAndroidOverlay \
    IconPackKaiLauncherOverlay \
    IconPackKaiSettingsOverlay \
    IconPackKaiSystemUIOverlay \
    IconPackRoundedAndroidOverlay \
    IconPackRoundedLauncherOverlay \
    IconPackRoundedSettingsOverlay \
    IconPackRoundedSystemUIOverlay \
    IconPackSamAndroidOverlay \
    IconPackSamLauncherOverlay \
    IconPackSamSettingsOverlay \
    IconPackSamSystemUIOverlay \
    IconPackVictorAndroidOverlay \
    IconPackVictorLauncherOverlay \
    IconPackVictorSettingsOverlay \
    IconPackVictorSystemUIOverlay \
    IconShapePebbleOverlay \
    IconShapeRoundedRectOverlay \
    IconShapeSquareOverlay \
    IconShapeSquircleOverlay \
    IconShapeTaperedRectOverlay \
    IconShapeTeardropOverlay \
    IconShapeVesselOverlay \
    LineageNavigationBarNoHint \
    NavigationBarMode2ButtonOverlay

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# Themes
PRODUCT_PACKAGES += \
    LineageBlackTheme \
    ThemePicker \
    ThemesStub

PRODUCT_PACKAGE_OVERLAYS += vendor/lineage/overlay/mobile


```
        - gsi_product.mk (1340 bytes)
          - Content preview:
```
#
# Copyright (C) 2021 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This makefile contains the product partition contents for CTS on
# GSI compliance testing. Only add something here for this purpose.
$(call inherit-product, $(SRC_TARGET_DIR)/product/media_product.mk)

PRODUCT_PACKAGES += \
    Camera2 \
    Dialer \
    LatinIME \
    messaging \

# Default AOSP sounds
$(call inherit-product-if-exists, frameworks/base/data/sounds/AllAudio.mk)

# Additional settings used in all AOSP builds
PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.ringtone?=Ring_Synth_04.ogg \
    ro.config.notification_sound?=pixiedust.ogg \
    ro.com.android.dataroaming?=true \

ifeq ($(LINEAGE_BUILD),)
PRODUCT_COPY_FILES += \
    device/sample/etc/apns-full-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml
endif
```
        - removeBrowser.sh (291 bytes)
          - Content preview:
```
cp /home/app/LudditeChanges/standardApps/removeBrowser/common_mobile.mk /home/app/LudditeOS/android/lineage/vendor/lineage/config/common_mobile.mk

cp /home/app/LudditeChanges/standardApps/removeBrowser/gsi_product.mk /home/app/LudditeOS/android/lineage/device/generic/common/gsi_product.mk

```
      - .DS_Store (10244 bytes)
    - .DS_Store (6148 bytes)
    - applyLudditeChanges.sh (374 bytes)
      - Content preview:
```
bash /home/app/LudditeChanges/bootanimation/bootanimation.sh
bash /home/app/LudditeChanges/standardApps/handheldProduct/handheldProduct.sh

bash /home/app/LudditeChanges/standardApps/LudditeInstaller/ludditeinstaller.sh
bash /home/app/LudditeChanges/standardApps/PackageInstaller/packageinstaller.sh
#bash /home/app/LudditeChanges/standardApps/removeBrowser/removeBrowser.sh
```
  - .DS_Store (6148 bytes)
  - build.sh (1970 bytes)
    - Content preview:
```
#!/bin/bash
# At the start of build.sh
exec 1> >(grep -v "^ninja\|^FAILED:\|^Checking\|^Reading\|^Including\|^\[" | grep -v "^$")

if [[ "${DEBUG_MODE}" == "true" ]]; then
    echo "Container started in debug mode. Waiting..."
    tail -f /dev/null
fi

if [[ "${FULL_BUILD}" == "true" ]]; then
    echo "Starting full build process..."
    rm -rf /home/app/LudditeOS/bin
    rm -rf /home/app/LudditeOS/android
    
    mkdir -p /home/app/LudditeOS/android/lineage
    mkdir -p /home/app/LudditeOS/bin
    curl https://storage.googleapis.com/git-repo-downloads/repo > /home/app/LudditeOS/bin/repo
    chmod a+x /home/app/LudditeOS/bin/repo

    PATH=/home/app/LudditeOS/bin:$PATH
    git lfs install
    git config --global trailer.changeid.key "Change-Id"
    export USE_CCACHE=1
    export CCACHE_EXEC=/usr/bin/ccache


    cd /home/app/LudditeOS/android/lineage


    repo init -u http://www.github.com/LineageOS/android -b lineage-${BUILD_LINEAGE_VERSION} --git-lfs --reference=/home/app/LudditeOS/LineageMirror/LineageOS/android.git
    repo sync
    
    mkdir -p /home/app/LudditeOS/android/lineage/.repo/local_manifests
    cp /home/app/config/roomservice-${BUILD_TARGET}-${BUILD_LINEAGE_VERSION}.xml /home/app/LudditeOS/android/lineage/.repo/local_manifests/roomservice.xml

    repo sync

    mkdir -p /home/app/LudditeOS/android/lineage/vendor/luddite/apps
    chmod -R a+x /home/app/LudditeChanges
    . /home/app/LudditeChanges/applyLudditeChanges.sh
fi

cd /home/app/LudditeOS/android/lineage
PATH=/home/app/LudditeOS/bin:$PATH
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache

source build/envsetup.sh
breakfast ${BUILD_TARGET}

croot
brunch ${BUILD_TARGET}

cd /home/app/LudditeOS 
chmod -R 777 android

currentTime=$(date +"%Y%m%d_%H%M%S")
mkdir -p "/home/app/LudditeOS/release/${currentTime}/${BUILD_TARGET}"
cp -r /home/app/LudditeOS/android/lineage/out/target/product/${BUILD_TARGET} "/home/app/LudditeOS/release/${currentTime}/${BUILD_TARGET}" 
```
  - buildlog.txt (5363 bytes)
    - Content preview:
```
Starting full build process...
Git LFS initialized.

repo has been initialized in /home/app/LudditeOS/android/lineage
device/qcom/sepolicy: Shared project LineageOS/android_device_qcom_sepolicy found, disabling pruning.
device/qcom/sepolicy_vndr/legacy-um: Shared project LineageOS/android_device_qcom_sepolicy_vndr found, disabling pruning.
hardware/qcom-caf/bt: Shared project LineageOS/android_hardware_qcom_bt found, disabling pruning.
hardware/qcom-caf/msm8953/audio: Shared project LineageOS/android_hardware_qcom_audio found, disabling pruning.
hardware/qcom-caf/msm8953/display: Shared project LineageOS/android_hardware_qcom_display found, disabling pruning.
hardware/qcom-caf/msm8953/media: Shared project LineageOS/android_hardware_qcom_media found, disabling pruning.
hardware/qcom-caf/sm8450/audio/agm: Shared project LineageOS/android_vendor_qcom_opensource_agm found, disabling pruning.
hardware/qcom-caf/sm8450/audio/pal: Shared project LineageOS/android_vendor_qcom_opensource_arpal-lx found, disabling pruning.
hardware/qcom-caf/sm8450/audio/primary-hal: Shared project LineageOS/android_hardware_qcom_audio-ar found, disabling pruning.
hardware/qcom-caf/sm8450/data-ipa-cfg-mgr: Shared project LineageOS/android_vendor_qcom_opensource_data-ipa-cfg-mgr found, disabling pruning.
hardware/qcom-caf/wlan: Shared project LineageOS/android_hardware_qcom_wlan found, disabling pruning.
repo sync has finished successfully.
repo sync has finished successfully.
patching file /home/app/LudditeOS/android/lineage/vendor/lineage/bootanimation/Android.mk
patching file /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/src/com/android/packageinstaller/PackageInstallerActivity.java
Hunk #1 succeeded at 170 with fuzz 2 (offset 27 lines).
patching file /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/src/com/android/packageinstaller/InstallStart.java
Hunk #1 FAILED at 80.
1 out of 1 hunk FAILED -- saving rejects to file /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/src/com/android/packageinstaller/InstallStart.java.rej
patching file /home/app/LudditeOS/android/lineage/frameworks/base/packages/PackageInstaller/AndroidManifest.xml
Hunk #1 succeeded at 72 with fuzz 1 (offset 13 lines).
repo sync has finished successfully.
repo sync has finished successfully.
repo sync has finished successfully.
repo sync has finished successfully.
Device oriole not found. Attempting to retrieve device repository from LineageOS Github (http://github.com/LineageOS).
Found repository: android_device_google_oriole
Default revision: lineage-22.1
Checking branch info
Checking if device/google/oriole is fetched from android_device_google_oriole
Adding dependency: LineageOS/android_device_google_oriole -> device/google/oriole
Syncing repository to retrieve project.
Repository synced!
Looking for dependencies in device/google/oriole
Default revision: lineage-22.1
Checking branch info
Adding dependencies to manifest
Checking if device/google/raviole is fetched from android_device_google_raviole
Adding dependency: LineageOS/android_device_google_raviole -> device/google/raviole
Syncing dependencies
Looking for dependencies in device/google/raviole
Default revision: lineage-22.1
Checking branch info
Adding dependencies to manifest
Checking if device/google/gs101 is fetched from android_device_google_gs101
Adding dependency: LineageOS/android_device_google_gs101 -> device/google/gs101
Checking if device/google/raviole-kernels/5.10 is fetched from device/google/raviole-kernels/5.10
Adding dependency: device/google/raviole-kernels/5.10 -> device/google/raviole-kernels/5.10
Syncing dependencies
Looking for dependencies in device/google/gs101
Default revision: lineage-22.1
Checking branch info
Adding dependencies to manifest
Checking if device/google/gs-common is fetched from android_device_google_gs-common
Adding dependency: LineageOS/android_device_google_gs-common -> device/google/gs-common
Syncing dependencies
Looking for dependencies in device/google/gs-common
device/google/gs-common has no additional dependencies.
Looking for dependencies in device/google/raviole-kernels/5.10
device/google/raviole-kernels/5.10 has no additional dependencies.
Done

** Don't have a product spec for: 'lineage_oriole'
** Do you have the right repo manifest?

repo sync has finished successfully.
Device oriole not found. Attempting to retrieve device repository from LineageOS Github (http://github.com/LineageOS).
Found repository: android_device_google_oriole
Default revision: lineage-22.1
Checking branch info
Checking if device/google/oriole is fetched from android_device_google_oriole
LineageOS/android_device_google_oriole already fetched to device/google/oriole
Syncing repository to retrieve project.
Repository synced!
Looking for dependencies in device/google/oriole
Looking for dependencies in device/google/raviole
Looking for dependencies in device/google/gs101
Looking for dependencies in device/google/gs-common
device/google/gs-common has no additional dependencies.
Looking for dependencies in device/google/raviole-kernels/5.10
device/google/raviole-kernels/5.10 has no additional dependencies.
Done

** Don't have a product spec for: 'lineage_oriole'
** Do you have the right repo manifest?

No such item in brunch menu. Try 'breakfast'

```
  - docker-compose-full-build.yml (368 bytes)
    - Content preview:
```
version: "3"
services:
  luddite_build:
    image: oli1115/ludditebuild:latest
    container_name: LudditeBuild
    environment:
      - GIT_NAME=ludditesrv
      - GIT_MAIL=git@luddite-os.ch
      - BUILD_TARGET=oriole
      - BUILD_LINEAGE_VERSION=22.1
      - FULL_BUILD=true
      - DEBUG_MODE=false
    volumes:
      - /home/oliver/LudditeOS:/home/app/LudditeOS

```
  - docker-compose.yml (371 bytes)
    - Content preview:
```
version: "3"
services:
  luddite_build:
    image: oli1115/ludditebuild:latest
    container_name: LudditeBuild
    environment:
      - GIT_NAME=ludditesrv
      - GIT_MAIL=git@luddite-os.ch
      - BUILD_TARGET=star2lte
      - BUILD_LINEAGE_VERSION=20.0
      - FULL_BUILD=false
      - DEBUG_MODE=false
    volumes:
      - /home/oliver/LudditeOS:/home/app/LudditeOS

```
  - Dockerfile (1246 bytes)
    - Content preview:
```
FROM ubuntu:22.04

RUN mkdir -p /home/app/LudditeOS
RUN mkdir -p /home/app/LudditeOS/bin
RUN mkdir -p /home/app/LudditeOS/android
RUN mkdir -p /home/app/LudditeOS/android/lineage

ENV GIT_NAME=git_name
ENV GIT_MAIL=git_mail
ENV BUILD_TARGET=star2lte
ENV BUILD_LINEAGE_VERSION=20.0
ENV FULL_BUILD=true
ENV DEBUG_MODE=false 


RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get install sed
RUN apt-get install -y python-is-python3
RUN apt-get install -y unzip python3 openjdk-8-jdk rsync libx11-dev x11proto-core-dev git-core libgl1-mesa-dev
RUN apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
RUN apt-get update && apt-get install -y --no-install-recommends lib32ncurses5-dev libncurses5 libncurses5-dev
RUN apt-get update && apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*

RUN git config --global user.name ${GIT_NAME}
RUN git config --global user.email ${GIT_MAIL}
RUN git config --global http.version HTTP/1.1

COPY . /home/app

CMD ./home/app/build.sh

```
- **LineageMirror/**
  - docker-compose.yml (278 bytes)
    - Content preview:
```
version: "3"
services:
  luddite_mirror_sync:
    image: oli1115/ludditemirrorsync:latest
    container_name: LudditeMirrorSync
    environment:
      - GIT_NAME=ludditmirrorsync
      - GIT_MAIL=git@luddite-os.ch
    volumes:
      - /home/oliver/LudditeOS:/home/app/LudditeOS

```
  - Dockerfile (1082 bytes)
    - Content preview:
```
FROM ubuntu:22.04

RUN mkdir -p /home/app/LudditeOS
RUN mkdir -p /home/app/LudditeOS/bin
RUN mkdir -p /home/app/LudditeOS/android
RUN mkdir -p /home/app/LudditeOS/android/lineage

ENV GIT_NAME=git_name
ENV GIT_MAIL=git_mail


RUN apt-get -y update
RUN apt-get -y install git
RUN apt-get -y install curl
RUN apt-get install -y python-is-python3
RUN apt-get install -y unzip python3 openjdk-8-jdk rsync libx11-dev x11proto-core-dev git-core libgl1-mesa-dev
RUN apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
RUN apt-get update && apt-get install -y --no-install-recommends lib32ncurses5-dev libncurses5 libncurses5-dev
RUN rm -rf /var/lib/apt/lists/*

RUN git config --global user.name ${GIT_NAME}
RUN git config --global user.email ${GIT_MAIL}
RUN git config --global http.version HTTP/1.1

COPY . /home/app

CMD ./home/app/syncmirror.sh

```
  - syncmirror.sh (632 bytes)
    - Content preview:
```
#!/bin/bash -v



mkdir -p /home/app/LudditeOS/LineageMirror
mkdir -p /home/app/LudditeOS/LineageMirror/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > /home/app/LudditeOS/LineageMirror/bin/repo


chmod a+x /home/app/LudditeOS/LineageMirror/bin/repo
PATH=/home/app/LudditeOS/LineageMirror/bin:$PATH

cd /home/app/LudditeOS/LineageMirror

git lfs install
git config --global trailer.changeid.key "Change-Id"
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache

repo init -u https://github.com/LineageOS/mirror --mirror
repo sync --force-remove-dirty --force-sync


chmod -R 777 /home/app/LudditeOS/LineageMirror
```
- **utilities/**
  - OTA.txt (358 bytes)
    - Content preview:
```
$ docker run \
    --restart=always \
    -d \
    -p 5500:80 \
    -v "/home/oliver/LudditeOS/release/ota/builds:/var/www/html/builds/full" \
    julianxhokaxhiu/lineageota

sudo adb pull /mnt/system/system/build.prop build.prop
adb shell getprop ro.adb.secure
adb shell getprop lineage.updater.uri




- todo: README zusammenstellen und open source machen.
```
  - search.sh (265 bytes)
    - Content preview:
```
#in das LudditeRoot Verzeichnis kopieren

#sudo find /home/oliver/LudditeOS/ -iname '*'$1'*' > ${1}results.txt


sudo egrep -I -n -H -ir --exclude-dir=out --exclude='*.java' --exclude='*.html' --exclude='*/test/*' '*'$1'*' /home/oliver/LudditeOS >> ${1}results.txt

```
  - startshareservice.sh (25 bytes)
    - Content preview:
```
sudo service smbd restart
```
  - update.sh (307 bytes)
    - Content preview:
```
sudo apt update -y        # Fetches the list of available updates
sudo apt upgrade -y       # Installs some updates; does not remove packages
sudo apt full-upgrade -y  # Installs updates; may also remove some packages, if needed
sudo apt autoremove -y    # Removes any old packages that are no longer needed
```
- README.md (243 bytes)
  - Content preview:
```
![ludditebuild](https://github.com/ostaubzug/LudditeOSBashScripts/actions/workflows/docker-publish-build.yml/badge.svg)

![ludditemirror](https://github.com/ostaubzug/LudditeOSBashScripts/actions/workflows/docker-publish-mirror.yml/badge.svg)

```
