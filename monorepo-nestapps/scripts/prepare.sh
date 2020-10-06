#!/bin/bash

if (($# == 0)); then
    echo "Please pass arguments -o <option>.."
    exit 2
fi

function freshBuild() {
  removeExistContainers

  docker images -a | grep "monorepo-nestapps" | awk '{print $3}' | xargs docker rmi
  docker rmi pkg-builder
  docker rmi $(docker images -f "dangling=true" -q)
    # It creates an initial builder image from which the “real” builder image can copy the build directory.
  yarn docker:bootstrap
  # Build and deploy images
  yarn docker:up
}

function build() {
  removeAppContainers
  docker images -a | grep "monorepo-nestapps" | awk '{print $3}' | xargs docker rmi

  docker build --tag=monorepo-nestapps_foo ./packages/foo
  docker build --tag=monorepo-nestapps_bar ./packages/bar
}

function removeAppContainers() {
  if [ "$(docker ps -aq -f status=running)" ]; then
    docker stop $(docker ps -a -q)
    if [ "$(docker ps -aq -f status=exited)" ]; then
        docker ps -a | grep "monorepo-nestapps" | awk '{print $1}' | xargs docker rm
    fi
  else
    docker ps -a | grep "monorepo-nestapps" | awk '{print $1}' | xargs docker rm
  fi
}

function removeExistContainers() {
  if [ "$(docker ps -aq -f status=running)" ]; then
    docker stop $(docker ps -a -q)
    if [ "$(docker ps -aq -f status=exited)" ]; then
        # Remove all exited containers
        docker rm $(docker ps -a -f status=exited -q)
    fi
  else
    docker rm $(docker ps -a -f status=exited -q)
  fi
}

while getopts ":o:" opt; do
    case $opt in
        o)
            echo "-o was triggered, Parameter: $OPTARG" >&2
            echo $OPTARG
            if [ "$OPTARG" == "fresh" ]; then
              freshBuild
            elif [ "$OPTARG" == "build" ]; then
              build
            else
              echo "Command not found"
              exit 1
            fi
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done