FROM alpine:3.16.2

LABEL maintainer="igorferreir4@gmail.com"

COPY 3.3.8/temp /tmp

RUN apk add --no-cache curl \
    shadow \
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
    php81-zip \
    && mkdir /phpbb \
    && mkdir /phpbb/sqlite \
    && mv /tmp/www /phpbb/www \
    && cd /phpbb/www \
    && unzip phpbb3.zip \
    && rm phpbb3.zip \
    && cp /tmp/phpbb/config.php /phpbb/www \
    && mkdir -p /run/apache2 /phpbb/opcache \
    && chown apache:apache /run/apache2 /phpbb/opcache \
    && cp /tmp/apache2/httpd.conf /etc/apache2/ \
    && cp /tmp/apache2/conf.d/* /etc/apache2/conf.d/ \
    && cp /tmp/php/php.ini /etc/php81/ \
    && cp /tmp/php/php-cli.ini /etc/php81/ \
    && cp /tmp/php/conf.d/* /etc/php81/conf.d/ \
    && cp /tmp/start.sh /usr/local/bin/ \
    && chmod +x /usr/local/bin/start.sh \
    && adduser --disabled-password --uid 65432 phpbb \
    && rm -r /tmp/*

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