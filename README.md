# docker-glibc-builder

A glibc binary package builder in Docker. Produces a glibc binary package that can be imported into a rootfs to run applications dynamically linked against glibc.

## Usage

Build a glibc package based on version 2.32 with a prefix of `/usr/glibc-compat`:

    docker run --rm --env STDOUT=1 sgerrand/glibc-builder 2.32 /usr/glibc-compat > glibc-bin.tar.gz

You can also keep the container around and copy out the resulting file:

    docker run --name glibc-binary sgerrand/glibc-builder 2.32 /usr/glibc-compat
    docker cp glibc-binary:/glibc-bin-2.32.tar.gz ./
    docker rm glibc-binary
