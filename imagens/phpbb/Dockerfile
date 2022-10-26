FROM alpine:3.16.2

COPY phpbb/temp /tmp

RUN apk update && apk upgrade && apk add caddy --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    && apk add --no-cache curl \
    imagemagick \
    php8 \
    php8-ctype \
    php8-curl \
    php8-dom \
    php8-ftp \
    php8-gd \
    php8-iconv \
    php8-json \
    php8-mbstring \
    php8-mysqli \
    php8-opcache \
    php8-openssl \
    php8-pgsql \
    php8-tokenizer \
    php8-xml \
    php8-zlib \
    php8-zip \
    php8-fpm \
    unzip \
    && mkdir /phpbb \
    && cp -r /tmp/php/* /etc/php8/ \
    && cp /tmp/Caddyfile /etc/caddy/Caddyfile \
    && cp -r /tmp/www /phpbb/ \
    && cd /phpbb/www \
    && unzip phpBB3.zip \
    && rm phpBB3.zip \
    && rm -r /tmp/* \
    && mkdir -p /phpbb/opcache \
    && find /phpbb/www/ -type d -exec chmod 755 {} \; \
    && find /phpbb/www/ -type f -exec chmod 644 {} \; \
    && chmod -R 777 /phpbb/www/files /phpbb/www/cache /phpbb/www/store /phpbb/www/images/avatars/upload \
    && chmod 666 /phpbb/www/config.php \
    && chown -R caddy:caddy /phpbb

WORKDIR /phpbb/www

CMD ["/bin/ash", "-c", "php-fpm8 -D && caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]