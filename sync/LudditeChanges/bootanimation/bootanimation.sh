cp "$(dirname "$0")/bootanimation.tar" /home/oliver/LudditeOS/android/lineage/vendor/lineage/bootanimation/bootanimation.tar
patch /home/oliver/LudditeOS/android/lineage/vendor/lineage/bootanimation/Android.mk < "$(dirname "$0")/MkPatch"
