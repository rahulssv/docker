FROM alpine:3.16.2

LABEL Maintainer="Igor Ferreira <igorferreir4@gmail.com>" \
    Description="Lightweight PHPBB container with Apache 2.4 & PHP-FPM 8.1 based on Alpine Linux." \
    alpine-version="3.16" \
    apache-version="2.4" \
    php-version="8.1" \
    phpbb-version="3.3.8"

RUN apk add --no-cache curl \
    shadow \
    tzdata \
    imagemagick \
    su-exec \
    unzip \
    apache2 \
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
    php81-sqlite3 \
    php81-tokenizer \
    php81-xml \
    php81-zlib \
    php81-zip && \
    adduser --disabled-password --uid 65432 phpbb && \
    mkdir -p /phpbb /phpbb/sqlite /phpbb/www /phpbb/opcache /run/apache2 && \
    chown apache:apache /run/apache2 /phpbb/opcache && \
    rm -rf /var/cache/apk/*

COPY 3.3.8/files/ /tmp/TEMP/
WORKDIR /tmp
RUN mv /tmp/TEMP/www /tmp/www && \
    mv /tmp/TEMP/phpbb/config.php /tmp/config.php && \
    cp /tmp/TEMP/apache2/httpd.conf /etc/apache2/ && \
    cp /tmp/TEMP/apache2/conf.d/* /etc/apache2/conf.d/ && \
    cp /tmp/TEMP/php/php.ini /etc/php81/ && \
    cp /tmp/TEMP/php/php-cli.ini /etc/php81/ && \
    cp /tmp/TEMP/php/conf.d/* /etc/php81/conf.d/ && \
    cp /tmp/TEMP/start.sh /usr/local/bin/ && \
    chmod +x /usr/local/bin/start.sh && \
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
    PHPBB_DB_AUTOMIGRATE= \
    PHPBB_DISPLAY_LOAD_TIME= \
    PHPBB_DEBUG= \
    PHPBB_DEBUG_CONTAINER= \
    PUID=65432 \
    PGID=65432 \
    TZ=UTC

EXPOSE 80
CMD ["/usr/local/bin/start.sh"]