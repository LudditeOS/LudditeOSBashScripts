

url="https://scontent.whatsapp.net/v/t61.25591-34/10000000_1939333329914724_837274820006153567_n.apk/WhatsApp.apk?ccb=1-7&_nc_sid=c49adc&_nc_ohc=3UT9UDhMMJ4Q7kNvgE4ywRD&_nc_zt=3&_nc_ht=scontent.whatsapp.net&_nc_gid=A-TJtuRkIwNAUoakgyjueoZ&oh=01_Q5AaIPJAcl0_KcnEaj9U95uLuxvFuU-cqGqtJdlGcmDTq44C&oe=674DAF8F"
appdirectory="/home/oliver/LudditeOS/android/lineage/packages/apps/Whatsapp"

if [ -d "$appdirectory" ]; then
    rm -rf "$appdirectory"
fi
mkdir -p "$appdirectory"
wget -O "$appdirectory/Whatsapp.apk" "$url"
cp /home/app/LudditeChanges/standardApps/whatsapp/Android.mk "$appdirectory"