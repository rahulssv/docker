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
        armhf)   binArch='armv6' ;; \
		armv7)   binArch='armv7' ;; \
		ppc64el|ppc64le) binArch='ppc64le' ;; \
		s390x)   binArch='s390x' ;; \
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
    rm -rf /var/cache/apk/* && \
# Configure opcache
    { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
	} > /etc/php81/conf.d/opcache-recommended.ini && \
# Configure logs
# https://www.php.net/manual/en/errorfunc.constants.php
# https://github.com/docker-library/wordpress/issues/420#issuecomment-517839670
    { \
		echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
		echo 'display_errors = Off'; \
		echo 'display_startup_errors = Off'; \
		echo 'log_errors = On'; \
		echo 'error_log = /dev/stderr'; \
		echo 'log_errors_max_len = 1024'; \
		echo 'ignore_repeated_errors = On'; \
		echo 'ignore_repeated_source = Off'; \
		echo 'html_errors = Off'; \
	} > /etc/php81/conf.d/error-logging.ini && \
# Adduser
    adduser --disabled-password --uid 65432 caddy \
# Wordpress
    && mkdir /var/www \
    && mkdir /var/www/wordpress \
    && wget -O wordpress.tar.gz https://br.wordpress.org/latest-pt_BR.tar.gz \
    && tar -oxzf wordpress.tar.gz \
    && rm wordpress.tar.gz \
    && find /tmp/wordpress -type d -exec chmod 755 {} \; \
    && find /tmp/wordpress -type f -exec chmod 644 {} \; \
# Change user php-fpm
    && sed -i 's/nobody/caddy/g' /etc/php81/php-fpm.d/www.conf

# Configure Caddy
COPY config/Caddyfile /etc/caddy/Caddyfile

# Configure ENTRYPOINT
COPY config/entrypoint.sh /entrypoint.sh

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php81/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php81/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# WP config
COPY config/wp-config.php /tmp/wordpress

# Append WP secrets
COPY config/wp-secrets.php /tmp/wordpress

# Add WP CLI and fix chown and chmod to files in COPY
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp \
    && chmod +x /entrypoint.sh \
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