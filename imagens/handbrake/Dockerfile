FROM alpine:3.17

RUN apk --update --upgrade --no-cache add bash x264 && \
    apk add --no-cache handbrake --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY start.sh /usr/bin/start.sh
RUN chmod +x /usr/bin/start.sh

WORKDIR /media
VOLUME /media

CMD ["/usr/bin/start.sh"]