sudo docker rm LudditeSync
sudo docker rmi luddite-sync-img:1.0
git pull
sudo docker build -t luddite-sync-img:1.0 .