FROM alpine:3.16.2

COPY phpbb/temp /tmp

RUN apk update && apk upgrade && apk add caddy --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    unzip \
    && mkdir /phpbb \
    && cp /tmp/Caddyfile /etc/caddy/Caddyfile \
    && cp -r /tmp/www /phpbb/ \
    && cd /phpbb/www \
    && unzip phpBB3.zip \
    && rm phpBB3.zip \
    && rm -r /tmp/* \
    && find /phpbb/www/ -type d -exec chmod 755 {} \; \
    && find /phpbb/www/ -type f -exec chmod 644 {} \; \
    && chmod -R 777 /phpbb/www/files /phpbb/www/cache /phpbb/www/store /phpbb/www/images/avatars/upload \
    && chmod 666 /phpbb/www/config.php \
    && chown -R caddy:caddy /phpbb

WORKDIR /phpbb/www

CMD ["/bin/ash", "-c", "caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]