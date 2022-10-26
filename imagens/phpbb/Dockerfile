FROM alpine:3.16.2

ARG PUID=1000
ENV USER=server

RUN apk update && apk upgrade && apk add caddy --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    && apk add --no-cache curl \
    imagemagick \
    php81 \
    php81-ctype \
    php81-curl \
    php81-dom \
    php81-ftp \
    php81-gd \
    php81-iconv \
    php81-json \
    php81-mbstring \
    php81-mysqli \
    php81-opcache \
    php81-openssl \
    php81-pgsql \
    php81-tokenizer \
    php81-xml \
    php81-zlib \
    php81-zip \
    php81-fpm \
    unzip \
    tzdata

COPY phpbb/Caddyfile /etc/caddy/Caddyfile

### phpBB3
COPY phpbb/phpBB3.zip /usr/share/caddy/
RUN cd /usr/share/caddy \
    && unzip phpBB3.zip \
    && rm phpBB3.zip \
    && mkdir -p /phpbb/opcache \
    && find /usr/share/caddy/ -type d -exec chmod 755 {} \; \
    && find /usr/share/caddy/ -type f -exec chmod 644 {} \; \
    && chmod -R 777 /usr/share/caddy/files /usr/share/caddy/cache /usr/share/caddy/store /usr/share/caddy/images/avatars/upload \
    && chmod 666 /usr/share/caddy/config.php \
    && adduser --disabled-password -u "${PUID}" "${USER}" \
    && touch /var/log/php81/error.log \
    && chown server:server /var/log/php81/error.log \
    && chmod 755 /var/log/php81/error.log

COPY phpbb-caddy/php/* /etc/php81/

USER server
WORKDIR /usr/share/caddy

#VOLUME /phpbb/www/files
#VOLUME /phpbb/www/store
#VOLUME /phpbb/www/images/avatars/upload

ENV TZ=

CMD ["/bin/ash", "-c", "php-fpm81 -D && caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]