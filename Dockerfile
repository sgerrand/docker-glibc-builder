FROM ubuntu-debootstrap:14.04
ENV PREFIX_DIR /usr/glibc-compat
ENV GLIBC_VERSION 2.21
RUN apt-get -q update \
	&& apt-get -qy install build-essential wget openssl gawk
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
