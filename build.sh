#!/bin/bash
# Build docker script
set -e

#Login into dockerhub
# Please export dockerhub user and password
#docker login -u=${DOCKERHUB_USERNAME} -p=${DOCKERHUB_PASSWORD}

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx rm  multi-builder | true
docker buildx create --use --name multi-builder --platform linux/arm64,linux/amd64

docker buildx build --platform linux/amd64,linux/arm64 --push -f Dockerfile . -t sgerrand/glibc-builder:${CIRCLE_SHA1}