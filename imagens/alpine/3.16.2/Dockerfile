FROM alpine:3.16 AS source

ARG MAJOR_VERSION=3.16 \
    MINOR_VERSION=3.16.2

WORKDIR /tmp

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64)  binArch='x86_64' ;; \
		armhf)   binArch='armhf' ;; \
		armv7)   binArch='armv7' ;; \
		aarch64) binArch='aarch64' ;; \
		ppc64el|ppc64le) binArch='ppc64le' ;; \
		s390x)   binArch='s390x' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
	esac; \
    apk add curl && \
    curl -L "https://dl-cdn.alpinelinux.org/alpine/v${MAJOR_VERSION}/releases/${binArch}/alpine-minirootfs-${MINOR_VERSION}-${binArch}.tar.gz" -o alpine.tar.gz && \
    tar -oxzf alpine.tar.gz && \
    rm alpine.tar.gz

FROM scratch

COPY --from=source /tmp/ /

CMD ["/bin/sh"]