FROM scratch

ARG MAJOR_VERSION=3.16 \
    MINOR_VERSION=3.16.2

ADD "https://dl-cdn.alpinelinux.org/alpine/v${MAJOR_VERSION}/releases/$(uname -m)/alpine-minirootfs-${MINOR_VERSION}-$(uname -m).tar.gz" /

CMD ["/bin/sh"]