docker rm LudditeBuild
docker rmi luddite-build-img:1.0
git pull
docker build -t luddite-build-img:1.0 .