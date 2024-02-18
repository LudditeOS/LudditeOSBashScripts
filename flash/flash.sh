fastboot oem unlock

adb -d sideload release/neusteVersion.zip #-> installieren der neusten version

fastboot oem lock #am schluss das installieren von recovery images blocken
adb 'devices' #-> get unique device identification