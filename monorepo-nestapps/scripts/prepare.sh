#!/bin/sh

if [ "$(docker ps -aq -f status=running)" ]; then
    docker stop $(docker ps -a -q)
    if [ "$(docker ps -aq -f status=exited)" ]; then
        # Remove all exited containers
        docker rm $(docker ps -a -f status=exited -q)
    fi
else
  docker rm $(docker ps -a -f status=exited -q)
fi

docker rmi $(docker images -f "dangling=true" -q)
docker rmi pkg-builder
docker rmi monorepo-nestapps_foo

  # It creates an initial builder image from which the “real” builder image can copy the build directory.
yarn docker:bootstrap
# Build and deploy images
yarn docker:up