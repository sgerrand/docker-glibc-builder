#!/usr/bin/env bash

set -eo pipefail; [[ "$TRACE" ]] && set -x

main() {
	declare version="$1" prefix="${2:-/usr/glibc-compat}"

	: "${version:?}" "${prefix:?}"

	{
		wget -qO- "http://ftp.gnu.org/gnu/glibc/glibc-$version.tar.gz" \
			| tar zxf -
		mkdir -p /glibc-build && cd /glibc-build
		"/glibc-$version/configure" \
			--prefix="$prefix" \
			--libdir="$prefix/lib" \
			--libexecdir="$prefix/lib" \
			--enable-multi-arch
		make && make install
		tar zcf "/glibc-bin-$version.tar.gz" "$prefix"
	} >&2

	[[ $STDOUT ]] && cat "/glibc-bin-$version.tar.gz"
}

main "$@"
