FROM multiarch/ubuntu-debootstrap:amd64-slim
ENV PREFIX_DIR /usr/glibc-compat
ENV GLIBC_VERSION 2.23
ENV ARCH x86_64
RUN apt-get -q update \
	&& apt-get -qy install build-essential wget openssl gawk
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
