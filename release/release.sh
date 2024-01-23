timestamp=$(date +%Y-%m-%d-%H-%M-%S)
cd /home/oliver/LudditeOS/release
sudo mkdir "$timestamp"
sudo cp /home/oliver/LudditeOS/android/lineage/out/target/product/star2lte/*.zip /home/oliver/LudditeOS/release/"$timestamp"
cd /home/oliver/gitroot/LudditeOSBashScripts/release

