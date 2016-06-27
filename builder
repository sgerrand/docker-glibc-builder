#!/usr/bin/env bash

set -eo pipefail; [[ "$TRACE" ]] && set -x

main() {
	declare version="${1:-$GLIBC_VERSION}" prefix="${2:-$PREFIX_DIR}" arch="${3:-$ARCH}"

	: "${version:?}" "${prefix:?}"

	{
		wget -qO- "http://ftp.gnu.org/gnu/glibc/glibc-$version.tar.gz" \
			| tar zxf -
		mkdir -p /glibc-build && cd /glibc-build
		"/glibc-$version/configure" \
			--prefix="$prefix" \
			--libdir="$prefix/lib" \
			--libexecdir="$prefix/lib" \
			--host=${arch}-linux \
			--enable-multi-arch
		make && make install
		tar --hard-dereference -zcf "/glibc-bin-$version-$arch.tar.gz" "$prefix"
	} >&2

	[[ $STDOUT ]] && cat "/glibc-bin-$version-$arch.tar.gz"
}

main "$@"
