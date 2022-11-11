FROM alpine:3.16 AS source

ARG MAJOR_VERSION=3.16 \
    MINOR_VERSION=3.16.2

WORKDIR /tmp

RUN wget -O alpine.tar.gz "https://dl-cdn.alpinelinux.org/alpine/v${MAJOR_VERSION}/releases/$(uname -m)/alpine-minirootfs-${MINOR_VERSION}-$(uname -m).tar.gz" && \
    tar -oxzf alpine.tar.gz &&
    rm alpine.tar.gz

FROM scratch

COPY --from=source /tmp/* /

CMD ["/bin/sh"]