#!/bin/bash
set -e 

bash /home/app/LudditeChanges/bootanimation/bootanimation.sh
bash /home/app/LudditeChanges/standardApps/LudditeInstaller/ludditeinstaller.sh



if [ "${BUILD_LINEAGE_VERSION}" = "22.1" ]; then
bash /home/app/LudditeChanges/PackageInstaller221/packageinstaller.sh
bash /home/app/LudditeChanges/removeBrowser22/removeBrowser22.sh
fi
if [ "${BUILD_LINEAGE_VERSION}" = "20.0" ]; then
bash /home/app/LudditeChanges/PackageInstaller/packageinstaller.sh
bash /home/app/LudditeChanges/removeBrowser20/removeBrowser20.sh
fi
