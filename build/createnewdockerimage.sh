docker rm LudditeBuild
git pull
docker build --cache-from luddite-build-img:1.0 -t luddite-build-img:1.0 .
