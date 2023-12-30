docker rm LudditeSync
docker rmi luddite-sync-img:1.0
git pull
docker build -t luddite-sync-img:1.0 .