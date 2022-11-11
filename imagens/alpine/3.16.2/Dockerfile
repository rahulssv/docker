FROM scratch

ARG MAJOR_VERSION=3.16 \
    MINOR_VERSION=3.16.2 \
    ARCH=$(arch)

ADD https://dl-cdn.alpinelinux.org/alpine/v${MAJOR_VERSION}/releases/${ARCH}/alpine-minirootfs-${MINOR_VERSION}-${ARCH}.tar.gz /

CMD ["/bin/sh"]