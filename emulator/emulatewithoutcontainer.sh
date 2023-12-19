#!/bin/bash -v

chmod +x /home/oliver/LudditeOS/bin/repo

PATH=/home/oliver/LudditeOS/bin:$PATH

cd /home/oliver/LudditeOS/source
repo init -u https://android.googlesource.com/platform/manifest -b android-13.0.0_r78



. build/envsetup.sh
lunch aosp_x86_64-eng
emulator



