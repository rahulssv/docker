FROM alpine:3.16.2

LABEL maintainer="igorferreir4@gmail.com"

COPY 3.3.8/temp /tmp
COPY 3.3.8/temp/Caddyfile /etc/caddy/Caddyfile

ENV CADDY_VERSION=2.6.2

RUN set -eux; \
	mkdir -p /config/caddy /data/caddy /etc/caddy /usr/share/caddy && \
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
    tar -oxzf caddy.tar.gz -C /usr/bin \
    && rm -f caddy.tar.gz \
    && chmod +x /usr/bin/caddy \
    && caddy version

RUN apk add --no-cache curl \
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
    php81-zip \
    su-exec \
    unzip \
    supervisor && \
    adduser --disabled-password --uid 65432 phpbb && \
    sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php81/php.ini && \
    sed -i 's/expose_php = On/expose_php = Off/g' /etc/php81/php.ini && \
    sed -i 's/user = nobody/user = phpbb/g' /etc/php81/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = phpbb/g' /etc/php81/php-fpm.d/www.conf \
    && mkdir /phpbb \
    && mkdir /phpbb/sqlite \
    && mv /tmp/www /phpbb/www \
    && cd /phpbb/www \
    && unzip phpbb3.zip \
    && rm phpbb3.zip \
    && cp /tmp/phpbb/config.php /phpbb/www \
    && mkdir -p /phpbb/opcache \
    && chown phpbb:phpbb /phpbb/opcache \
    && cp /tmp/php/php.ini /etc/php81/ \
    && cp /tmp/php/php-cli.ini /etc/php81/ \
    && cp /tmp/php/conf.d/* /etc/php81/conf.d/ \
    && cp /tmp/start.sh /usr/local/bin/ \
    && chmod +x /usr/local/bin/start.sh \
    && rm -r /tmp/* \
    && rm -rf /var/cache/apk/*

COPY 3.3.8/temp/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

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
    PGID=65432

EXPOSE 80
CMD ["/usr/local/bin/start.sh"]