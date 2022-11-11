FROM scratch

ARG MAJOR_VERSION=3.16 \
    MINOR_VERSION=3.16.2

ADD https://dl-cdn.alpinelinux.org/alpine/v${MAJOR_VERSION}/releases/$(arch)/alpine-minirootfs-${MINOR_VERSION}-$(arch).tar.gz /

CMD ["/bin/sh"]