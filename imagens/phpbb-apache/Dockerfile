FROM alpine:3.16.2

#igor
LABEL maintainer="igorsferreir4@gmail.com"

COPY phpbb-apache/temp /tmp

RUN apk update && apk upgrade && apk add --no-cache curl \
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
    php8-tokenizer \
    php8-xml \
    php8-zlib \
    php8-zip \
    composer \
    unzip \
    && mkdir /phpbb \
    && cd /tmp/www/ \
    && unzip phpBB3.zip \
    && rm phpBB3.zip \
    && cd /tmp \
    && cp /tmp/apache2/httpd.conf /etc/apache2/ \
    && cp /tmp/apache2/conf.d/mpm.conf /etc/apache2/conf.d/ \
    && cp /tmp/php/php.ini /etc/php8/ \
    && cp /tmp/php/php-cli.ini /etc/php8/ \
    && cp /tmp/php/conf.d/opcache.ini /etc/php8/conf.d/ \
    && cp -r /tmp/www /phpbb/ \
    && rm -r /tmp/* \
    && cd /phpbb/www \
    && composer install \
    && mkdir -p /run/apache2 /phpbb/opcache \
    && chown apache:apache /run/apache2 \
    && chown -R apache:apache /phpbb

WORKDIR /phpbb/www

EXPOSE 80

CMD httpd -DFOREGROUND