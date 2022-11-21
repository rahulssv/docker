FROM alpine:3.16.3

LABEL Maintainer="Igor Ferreira <igorferreir4@gmail.com>" \
    Description="Lightweight PHPBB container with Caddy 2.6.2 & PHP-FPM 8.1 based on Alpine Linux." \
    alpine-version="3.16" \
    caddy-version="2.6.2" \
    php-version="8.1" \
    phpbb-version="3.3.8"

COPY --from=caddy:2.6.2 /usr/bin/caddy /usr/bin/caddy
COPY files/Caddyfile /etc/caddy/Caddyfile

# See https://caddyserver.com/docs/conventions#file-locations for details
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data

RUN apk update && apk upgrade && \
    apk add --update --no-cache \
    ca-certificates \
    mailcap \
    curl \
    shadow \
    tzdata \
    imagemagick \
    supervisor \
    unzip \
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
    rm -rf /var/cache/apk/*

RUN adduser --disabled-password --uid 65432 phpbb && \
    mkdir -p /phpbb /phpbb/sqlite /phpbb/www /phpbb/opcache && \
    chown -R phpbb:phpbb /phpbb && \
    sed -i 's/user = nobody/user = phpbb/g' /etc/php81/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = phpbb/g' /etc/php81/php-fpm.d/www.conf

COPY files/php/php-cli.ini /etc/php81/php-cli.ini
COPY files/php/php.ini /etc/php81/php.ini
COPY files/php/conf.d/opcache.ini /etc/php81/conf.d/opcache.ini
COPY files/supervidord.conf /etc/supervisor/conf.d/supervisord.conf
COPY files/start.sh /usr/local/bin/start.sh
COPY files/phpbb3.zip /tmp/phpbb3.zip
RUN chmod +x /usr/local/bin/start.sh

ENV PUID=65432 \
    PGID=65432 \
    TZ=UTC

EXPOSE 80

WORKDIR /phpbb

CMD ["/usr/local/bin/start.sh"]