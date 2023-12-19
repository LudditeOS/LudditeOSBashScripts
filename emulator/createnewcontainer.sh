sudo docker rm LudditeEmulator
sudo docker rmi luddite-emulator-img:1.0
git pull
sudo docker build -t luddite-emulator-img:1.0 .