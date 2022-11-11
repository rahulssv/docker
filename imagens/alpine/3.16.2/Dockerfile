FROM scratch

ARG MAJOR_VERSION=3.16 \
    MINOR_VERSION=3.16.2 \
    TARGETARCH=

ADD https://dl-cdn.alpinelinux.org/alpine/v${MAJOR_VERSION}/releases/${TARGETARCH}/alpine-minirootfs-${MINOR_VERSION}-${TARGETARCH}.tar.gz /

CMD ["/bin/sh"]