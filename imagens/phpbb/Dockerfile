FROM alpine:3.16.2

COPY phpbb/temp /tmp

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
    php81-pdo \
    php81-xmlwriter \
    php81-simplexml \
    unzip \
    && apk add composer --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    && mkdir /phpbb \
    && cp -r /tmp/php* /etc/php81/ \
    && cp /tmp/Caddyfile /etc/caddy/Caddyfile \
    && cp -r /tmp/www /phpbb/ \
    && cd /phpbb/www \
    && unzip phpBB3.zip \
    && rm phpBB3.zip \
    && rm -r /tmp/* \
    && rm -rf vendor && composer install \
    && mkdir -p /phpbb/opcache \
    && find /phpbb/www/ -type d -exec chmod 755 {} \; \
    && find /phpbb/www/ -type f -exec chmod 644 {} \; \
    && chmod -R 777 /phpbb/www/files /phpbb/www/cache /phpbb/www/store /phpbb/www/images/avatars/upload \
    && chmod 666 /phpbb/www/config.php


WORKDIR /phpbb/www

CMD ["/bin/ash", "-c", "php-fpm81 -D && caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]