FROM alpine:3.18 AS build

ENV S6VERSION=v3.1.5.0

RUN apk add --no-cache openssl curl && \
    apkArch="$(apk --print-arch)" && \
    curl -o /tmp/s6-overlay.tar.xz -fsSL --compressed https://github.com/just-containers/s6-overlay/releases/download/${S6VERSION}/s6-overlay-${apkArch}.tar.xz

FROM alpine:3.18

ENV USERNAME samba
ENV PASSWORD password
ENV UID 1000
ENV GID 1000

RUN apk add --no-cache samba-server samba-common-tools openssl curl

COPY --chown=0:0 --from=build /tmp/s6-overlay.tar.xz /tmp/
RUN tar -xzf /tmp/s6-overlay.tar.xz -C /

COPY s6/config.init /etc/cont-init.d/00-config
COPY s6/smbd.run /etc/services.d/smbd/run
COPY s6/nmbd.run /etc/services.d/nmbd/run

EXPOSE 137/udp 138/udp 139/tcp 445/tcp

ENTRYPOINT ["/init"]

