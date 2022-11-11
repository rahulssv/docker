FROM igorferreir4/caddy:2.6.2 AS source

FROM alpine:3.16.2 AS final
COPY --from=source /usr/bin/caddy /usr/bin/caddy

LABEL Maintainer="Igor Ferreira <igorferreir4@gmail.com>" \
    Description="Lightweight PHPBB container with Caddy 2.6.2 & PHP-FPM 8.1 based on Alpine Linux." \
    alpine-version="3.16" \
    caddy-version="2.6.2" \
    php-version="8.1" \
    phpbb-version="3.3.8"

RUN apk add --no-cache \
    curl \
    supervisor \
    unzip \
    su-exec \
    tzdata \
    shadow \
    imagemagick \
    php81 \
    php81-fpm \
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
    php81-zip && \
    adduser --disabled-password --uid 65432 phpbb && \
    mkdir -p /phpbb /phpbb/www /phpbb/sqlite /phpbb/opcache && \
    chown -R phpbb:phpbb /phpbb && \
    rm -rf /var/cache/apk/*

COPY 3.3.8/files/ /tmp/TEMP/
WORKDIR /tmp
RUN mv /tmp/TEMP/www /tmp/www && \
    mv /tmp/TEMP/phpbb/config.php /tmp/config.php && \
    cp /tmp/TEMP/php/php.ini /etc/php81/ && \
    cp /tmp/TEMP/php/php-cli.ini /etc/php81/ && \
    cp /tmp/TEMP/php/conf.d/* /etc/php81/conf.d/ && \
    cp /tmp/TEMP/supervisord.conf /etc/supervisord.conf && \
    mkdir -p /etc/caddy && \
    cp /tmp/TEMP/Caddyfile /etc/caddy && \
    cp /tmp/TEMP/entrypoint.sh / && \
    chmod +x /entrypoint.sh && \
    sed -i 's/user = nobody/user = phpbb/g' /etc/php81/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = phpbb/g' /etc/php81/php-fpm.d/www.conf && \
    rm -r /tmp/TEMP

WORKDIR /phpbb/www

#VOLUME /phpbb/sqlite
#VOLUME /phpbb/www/files
#VOLUME /phpbb/www/store
#VOLUME /phpbb/www/images/avatars/upload

ENV PHPBB_INSTALL= \
    PHPBB_DB_DRIVER=sqlite3 \
    PHPBB_DB_HOST=/phpbb/sqlite/sqlite.db \
    PHPBB_DB_PORT= \
    PHPBB_DB_NAME= \
    PHPBB_DB_USER= \
    PHPBB_DB_PASSWD= \
    PHPBB_DB_TABLE_PREFIX=phpbb_ \
    PUID=65432 \
    PGID=65432

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1/adm