#!/bin/bash -v



mkdir -p /home/app/LudditeOS/LineageMirror
mkdir -p /home/app/LudditeOS/bin

curl https://storage.googleapis.com/git-repo-downloads/repo > /home/app/LudditeOS/bin/repo


chmod a+x /home/app/LudditeOS/bin/repo
PATH=/home/app/LudditeOS/bin:$PATH
git lfs install
git config --global trailer.changeid.key "Change-Id"
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache

repo init -u https://github.com/LineageOS/mirror --mirror
repo sync --force-remove-dirty --force-sync


chmod -R 777 /home/app/LudditeOS/LineageMirror