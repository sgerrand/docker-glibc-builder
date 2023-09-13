#Add qemu function for supporting multiarch
ARG IMAGEARCH
FROM alpine:3.12 as qemu
RUN apk add --no-cache curl
ARG QEMUVERSION=4.0.0
ARG QEMUARCH

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

RUN curl -fsSL https://github.com/multiarch/qemu-user-static/releases/download/v${QEMUVERSION}/qemu-${QEMUARCH}-static.tar.gz | tar zxvf - -C /usr/bin
RUN chmod +x /usr/bin/qemu-*

FROM ${IMAGEARCH}ubuntu:20.04
LABEL maintainer="Sasha Gerrand <github+docker-glibc-builder@sgerrand.com>"
ARG QEMUARCH
COPY --from=qemu /usr/bin/qemu-${QEMUARCH}-static /usr/bin/

ENV DEBIAN_FRONTEND=noninteractive \
    GLIBC_VERSION=2.37 \
    PREFIX_DIR=/usr/glibc-compat
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
