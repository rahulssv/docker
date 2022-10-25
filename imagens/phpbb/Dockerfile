FROM alpine:3.16.2

LABEL maintainer="igorsferreir4@gmail.com"

RUN apk add --no-cache curl \
    imagemagick \
    apache2 \
    php8 \
    php8-apache2 \
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
    php8-sqlite3 \
    php8-tokenizer \
    php8-xml \
    php8-zlib \
    php8-zip \
    su-exec \
    unzip \
    tzdata

### phpBB
ENV PHPBB_VERSION 3.3.8
ENV PHPBB_SHA256 '8e46b1a3c6896a82eb6aab9a6da1449c38ea286d70a52f660410abcd4dea1835'

WORKDIR /tmp

RUN curl -SL https://download.phpbb.com/pub/release/3.3/${PHPBB_VERSION}/phpBB-${PHPBB_VERSION}.tar.bz2 -o phpbb.tar.bz2 \
    && echo "${PHPBB_SHA256}  phpbb.tar.bz2" | sha256sum -c - \
    && tar -xjf phpbb.tar.bz2 \
    && mkdir /phpbb \
    && mkdir /phpbb/sqlite \
    && mv phpBB3 /phpbb/www \
    && rm -f phpbb.tar.bz2 \
    && cd /phpbb/www \
    && curl -SL https://www.phpbb.com/customise/db/download/197826 -o ptbr.zip \
    && unzip ptbr.zip \
    && rm -f ptbr.zip \
    && cd /phpbb/www/ext \
    && curl -SL https://www.phpbb.com/customise/db/download/194851 -o mediaembed.zip \
    && unzip mediaembed.zip \
    && rm -f mediaembed.zip \
    && cd /phpbb/www/styles \
    && curl -SL https://www.phpbb.com/customise/db/download/198441 -o dark.zip \
    && unzip dark.zip \
    && rm -f dark.zip

COPY phpbb/phpbb/config.php /phpbb/www

### Servidor
RUN mkdir -p /run/apache2 /phpbb/opcache \
    && chown apache:apache /run/apache2 /phpbb/opcache

COPY phpbb/apache2/httpd.conf /etc/apache2/
COPY phpbb/apache2/conf.d/* /etc/apache2/conf.d/

COPY phpbb/php/php.ini /etc/php8/
COPY phpbb/php/php-cli.ini /etc/php8/
COPY phpbb/php/conf.d/* /etc/php8/conf.d/

COPY phpbb/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

RUN chmod -R 777 /phpbb/www/files /phpbb/www/cache /phpbb/www/store /phpbb/www/images/avatars/upload
RUN chown -R apache:apache /phpbb
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
    TZ=

EXPOSE 80
CMD ["/usr/local/bin/start.sh"]