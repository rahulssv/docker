FROM alpine:3.16

RUN apk add --no-cache caddy --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community && \
    apk --no-cache add \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-openssl \
    php81-curl \
    php81-zlib \
    php81-xml \
    php81-phar \
    php81-intl \
    php81-dom \
    php81-xmlreader \
    php81-xmlwriter \
    php81-exif \
    php81-fileinfo \
    php81-sodium \
    php81-gd \
    php81-simplexml \
    php81-ctype \
    php81-mbstring \
    php81-zip \
    php81-opcache \
    php81-iconv \
    php81-pecl-imagick \
    supervisor \
    unzip


caddy run --config /root/Caddyfile --adapter caddyfile


wget -O wordpress.zip https://br.wordpress.org/latest-pt_BR.zip

unzip wordpress.zip


/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf