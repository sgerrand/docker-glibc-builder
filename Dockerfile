FROM ubuntu:20.04
LABEL maintainer="Sasha Gerrand <github+docker-glibc-builder@sgerrand.com>"
ENV DEBIAN_FRONTEND=noninteractive \
    GLIBC_VERSION=2.31 \
    PREFIX_DIR=/usr/glibc-compat \
    ADD_CONF=-v
RUN apt-get -q update \
	&& apt-get -qy install \
		bison \
		build-essential \
		gawk \
		gettext \
		openssl \
		python3 \
		texinfo \
		wget
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
