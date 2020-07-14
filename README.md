# docker-glibc-builder

A glibc binary package builder in Docker. Produces a glibc binary package that can be imported into a rootfs to run applications dynamically linked against glibc.

## Usage

Build a glibc package based on version 2.31 with a prefix of `/usr/glibc-compat`:

    docker run --rm --env STDOUT=1 sgerrand/glibc-builder 2.31 /usr/glibc-compat [Configuration additional parameters] > glibc-bin.tar.gz

You can also keep the container around and copy out the resulting file:

    docker run --name glibc-binary sgerrand/glibc-builder 2.31 /usr/glibc-compat [Configuration additional parameters]
    docker cp glibc-binary:/glibc-bin-2.31.tar.gz ./
    docker rm glibc-binary
