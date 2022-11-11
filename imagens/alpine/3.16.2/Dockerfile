FROM scratch

ARG MAJOR_VERSION=3.16 \
    MINOR_VERSION=3.16.2 \
    BUILDPLATFORM=

ADD https://dl-cdn.alpinelinux.org/alpine/v${MAJOR_VERSION}/releases/${BUILDPLATFORM}/alpine-minirootfs-${MINOR_VERSION}-${BUILDPLATFORM}.tar.gz /

CMD ["/bin/sh"]