FROM httpd:2.4.54-alpine3.16

LABEL maintainer="igorsferreir4@gmail.com"

COPY phpbb-apache/temp /tmp

RUN apk update && apk upgrade && apk add --no-cache curl \
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
    unzip \
    && mkdir /phpbb \
    && cd /tmp/www/ \
    && unzip phpBB3.zip \
    && rm phpBB3.zip \
    && cd /tmp \
    && cp /tmp/apache2/httpd.conf /usr/local/apache2/conf \
    && cp /tmp/apache2/conf.d/mpm.conf /usr/local/apache2/conf/conf.d/ \
    && cp /tmp/php/php.ini /etc/php81/ \
    && cp /tmp/php/php-cli.ini /etc/php81/ \
    && cp /tmp/php/conf.d/opcache.ini /etc/php81/conf.d/ \
    && cp -r /tmp/www /phpbb \
    && rm -r /tmp/* \
    && cd /phpbb/www \
    && mkdir -p /run/apache2 /phpbb/opcache \
    && chown apache:apache /run/apache2 \
    && chown -R apache:apache /phpbb

WORKDIR /phpbb/www