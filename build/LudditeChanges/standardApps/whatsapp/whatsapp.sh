

url="https://scontent.whatsapp.net/v/t61.25591-34/10000000_1778151816032877_1875809237834907106_n.apk/WhatsApp.apk?ccb=1-7&_nc_sid=c49adc&_nc_ohc=b3RgFAOIVWwAX8FFKn_&_nc_ht=scontent.whatsapp.net&oh=01_AdQ7i9zautK30FT0IUjvmR8uBlfzYjFR8TwoiCKaDyokzw&oe=661E9581"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Whatsapp"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/Whatsapp.apk" "$url"
cp /home/app/LudditeChanges/standardApps/whatsapp/Android.mk "$appdirectory"