#!/bin/sh
# Build docker script
set -e
export DOCKER_CLI_EXPERIMENTAL=enabled

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

# Build x86 images
docker build --build-arg IMAGEARCH= \
                   --build-arg QEMUARCH="x86_64" \
                   --file Dockerfile --tag sgerrand/glibc-builder:"$CIRCLE_SHA1"-amd64 .
# Build arm64 image
docker build --build-arg IMAGEARCH="arm64v8/" \
                   --build-arg QEMUARCH="aarch64" \
                   --file Dockerfile --tag sgerrand/glibc-builder:"$CIRCLE_SHA1"-arm64 .
