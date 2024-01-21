docker rm LudditeSync
git pull
docker build --cache-from luddite-sync-img:1.0 -t luddite-sync-img:1.0 .

