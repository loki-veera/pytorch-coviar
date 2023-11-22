docker build -t coviar .
# docker rmi $(docker images -f "dangling=true" -q) --force
docker run -it --rm -v $(pwd):/app/ coviar
