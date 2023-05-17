FROM alpine:3.18

ENV USERNAME samba
ENV PASSWORD password
ENV UID 1000
ENV GID 1000

RUN apk add --no-cache samba-server samba-common-tools openssl curl s6-overlay

COPY s6/config.init /etc/cont-init.d/00-config
COPY s6/smbd.run /etc/services.d/smbd/run
COPY s6/nmbd.run /etc/services.d/nmbd/run

RUN chmod +x /etc/cont-init.d/00-config /etc/services.d/smbd/run /etc/services.d/nmbd/run

EXPOSE 137/udp 138/udp 139/tcp 445/tcp

ENTRYPOINT ["/init"]

