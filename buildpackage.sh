#!/bin/sh
# Build binary script
set -e

export DOCKER_CLI_EXPERIMENTAL=enabled

docker run --rm --privileged multiarch/qemu-user-static --reset

# Build x86 package
docker run --rm --env GLIBC_VERSION --env STDOUT=1 sgerrand/glibc-builder:$CIRCLE_SHA1-amd64 > artefacts/glibc-bin-$GLIBC_VERSION-0-x86_64.tar.gz

# Build arm64 package
docker run --rm --env GLIBC_VERSION --env STDOUT=1 sgerrand/glibc-builder:$CIRCLE_SHA1-arm64 > artefacts/glibc-bin-$GLIBC_VERSION-0-aarch64.tar.gz
