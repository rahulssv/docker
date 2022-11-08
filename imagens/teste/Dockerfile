FROM alpine:3.16
LABEL Maintainer="Igor Ferreira <igorferreir4@gmail.com>" \
      Description="Lightweight WordPress container with Caddy 2.6.2 & PHP-FPM 8.1 based on Alpine Linux."

WORKDIR /tmp

ENV CADDY_VERSION=2.6.2

RUN set -eux; \
    apkArch="$(apk --print-arch)"; \
    case "$apkArch" in \
		x86_64)  binArch='amd64' ;; \
		aarch64) binArch='arm64' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
    esac; \
    wget -O caddy.tar.gz "https://github.com/caddyserver/caddy/releases/download/v${CADDY_VERSION}/caddy_${CADDY_VERSION}_linux_${binArch}.tar.gz"; \
    tar -oxzf caddy.tar.gz -C /usr/sbin \
    && rm caddy.tar.gz \
    && ln -s /usr/sbin/caddy /usr/bin/caddy

# Install packages
RUN apk update && apk upgrade && \
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
    unzip \
    shadow \
    curl && \
# adduser
    adduser --disabled-password --uid 65432 caddy \
# Wordpress
    && mkdir /var/www \
    && mkdir /var/www/wordpress \
    && wget -O wordpress.tar.gz https://br.wordpress.org/latest-pt_BR.tar.gz \
    && tar -oxzf wordpress.tar.gz \
    && rm wordpress.tar.gz \
    && find /tmp/wordpress -type d -exec chmod 755 {} \; \
    && find /tmp/wordpress -type f -exec chmod 644 {} \;

# Configure PHP-FPM, supervisord, caddy & add WP CLI
COPY /teste/config /tmp/config
RUN mkdir /etc/supervisor /etc/supervisor/conf.d \
    && cp /tmp/config/fpm-pool.conf /etc/php81/php-fpm.d/zzz_custom.conf \
    && cp /tmp/config/php.ini /etc/php81/conf.d/zzz_custom.ini \
    && cp /tmp/config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf \
    && cp /tmp/config/wp-config.php /tmp/wordpress \
    && cp /tmp/config/wp-secrets.php /tmp/wordpress \
    && cp /tmp/config/Caddyfile /usr/sbin \
    && cp /tmp/config/entrypoint.sh / \
    && chown -R caddy.caddy /tmp/wordpress /var/www \
    && curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp \
    && chown caddy.caddy /tmp/wordpress/wp-config.php && chmod 640 /tmp/wordpress/wp-config.php \
    && chown caddy.caddy /tmp/wordpress/wp-secrets.php && chmod 640 /tmp/wordpress/wp-secrets.php

# Wordpress volume
VOLUME /var/www/wordpress
WORKDIR /var/www/wordpress

ENV PORT=80 \
    PUID=65432 \
    PGID=65432

ENTRYPOINT [ "/entrypoint.sh" ]

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1/wp-login.php