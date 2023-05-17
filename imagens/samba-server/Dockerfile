FROM alpine:3.18 AS build

ENV S6-VERSION=v3.1.5.0

RUN apk add --no-cache openssl curl && \
    apkArch="$(apk --print-arch)"; \
	  case "$apkArch" in \
      amd64|x86_64) ARCH='x86_64';; \
      arm) ARCH='arm';; \
      armhf|arm/v7) ARCH='armhf';; \
      aarch64|arm64|arm/v8) ARCH='aarch64';; \
      *) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
    esac; \
    curl -o /tmp/s6-overlay.tar.gz -fsSL --compressed https://github.com/just-containers/s6-overlay/releases/download/${S6-VERSION}/s6-overlay-${ARCH}.tar.gz

FROM alpine:3.18

ENV USERNAME samba
ENV PASSWORD password
ENV UID 1000
ENV GID 1000

RUN apk add --no-cache samba-server samba-common-tools openssl curl

COPY --chown=0:0 --from=build /tmp/s6-overlay.tar.gz /tmp/
RUN tar -xzf /tmp/s6-overlay.tar.gz -C /

COPY s6/config.init /etc/cont-init.d/00-config
COPY s6/smbd.run /etc/services.d/smbd/run
COPY s6/nmbd.run /etc/services.d/nmbd/run

EXPOSE 137/udp 138/udp 139/tcp 445/tcp

ENTRYPOINT ["/init"]

