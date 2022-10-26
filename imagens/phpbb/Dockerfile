FROM caddy:2.6.2-alpine

RUN apk add --no-cache curl \
    imagemagick \
    php81 \
    php81-apache2 \
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
    su-exec \
    unzip \
    tzdata \
    wget \
    ca-certificates \
    mailcap

COPY phpbb/Caddyfile /etc/caddy/Caddyfile

### phpBB
COPY phpbb/phpBB3.zip /phpbb/www/
RUN cd /phpbb/www \
    && unzip phpBB3.zip \
    && rm phpBB3.zip \
    && mkdir -p /phpbb/opcache \
    && find /phpbb/www -type d -exec chmod 755 {} \; \
    && find /phpbb/www -type f -exec chmod 644 {} \; \
    && chmod -R 777 /phpbb/www/files /phpbb/www/cache /phpbb/www/store /phpbb/www/images/avatars/upload \
    && chmod 666 /phpbb/www/config.php

COPY phpbb-caddy/php/* /etc/php81/

WORKDIR /phpbb/www

#VOLUME /phpbb/www/files
#VOLUME /phpbb/www/store
#VOLUME /phpbb/www/images/avatars/upload

ENV TZ=

CMD ["/bin/ash", "-c", "php-fpm81 -D && caddy run --config /etc/caddy/Caddyfile --adapter caddyfile"]