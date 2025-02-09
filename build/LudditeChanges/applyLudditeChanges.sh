#!/bin/bash
set -e 

bash /home/app/LudditeChanges/bootanimation/bootanimation.sh
bash /home/app/LudditeChanges/standardApps/LudditeInstaller/ludditeinstaller.sh
bash /home/app/LudditeChanges/standardApps/removeBrowser/removeBrowser.sh


if [[ "${BUILD_LINEAGE_VERSION}" > "22.1" ]] || [[ "${BUILD_LINEAGE_VERSION}" = "22.1" ]]; then
bash /home/app/LudditeChanges/standardApps/PackageInstaller/packageinstaller.sh
else
bash /home/app/LudditeChanges/standardApps/PackageInstaller221/packageinstaller.sh
fi
