FROM alpine:3.16.2

LABEL maintainer="igorferreir4@gmail.com"

COPY phpbb-teste/temp /tmp

RUN apk add caddy --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && apk add --no-cache curl \
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
    php81-sqlite3 \
    php81-tokenizer \
    php81-xml \
    php81-zlib \
    php81-zip \
    php81-fpm \
    unzip \
    && mkdir /phpbb \
    && mkdir /phpbb/sqlite \
    && mv /tmp/www /phpbb/www \
    && cd /phpbb/www \
    && unzip phpbb3.zip \
    && rm phpbb3.zip \
    && mkdir -p /run/caddy /phpbb/opcache \
    && chown caddy:caddy /run/caddy /phpbb/opcache \
    && cp /tmp/php/php.ini /etc/php81/ \
    && cp /tmp/php/php-cli.ini /etc/php81/ \
    && cp /tmp/php/conf.d/* /etc/php81/conf.d/ \
    && cp /tmp/php/php-fpm.d/* /etc/php81/pfp-fpm.d/ \
    && cp /tmp/Caddyfile /etc/caddy/ \
    && rm -r /tmp/* \
    && chown -R caddy:caddy /phpbb

WORKDIR /phpbb/www

#VOLUME /phpbb/sqlite
#VOLUME /phpbb/www/files
#VOLUME /phpbb/www/store
#VOLUME /phpbb/www/images/avatars/upload

EXPOSE 80
CMD ["php-fpm81 && caddy run --config /etc/caddy/Caddyfile"]