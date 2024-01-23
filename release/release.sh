timestamp=$(date +%Y%m%d%H%M%S)
cd /home/oliver/LudditeOS/relase
mkdir "$timestamp"
cp /home/oliver/LudditeOS/android/lineage/out/target/product/star2lte/*.zip /home/oliver/LudditeOS/relase/"$timestamp"

