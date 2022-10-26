FROM alpine:3.16.2

LABEL maintainer="igorsferreir4@gmail.com"

RUN apk add --no-cache curl \
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
    php81-fpm \
    su-exec \
    unzip \
    tzdata \
    wget \
    ca-certificates \
    mailcap

### Caddy Server
ENV CADDY_VERSION v2.6.2

RUN set -eux; \
	mkdir -p \
		/config/caddy \
		/data/caddy \
		/etc/caddy \
		/usr/share/caddy \
	; \
	wget -O /usr/share/caddy/index.html "https://github.com/caddyserver/dist/raw/8c5fc6fc265c5d8557f17a18b778c398a2c6f27b/welcome/index.html"

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64)  binArch='amd64'; checksum='ae18c0facae7c8ee872492a1ba63a4c7608915d6d9fe267aef4f869cf65ebd4b7f9ff57f609aff2bd52db98c761d877b574aea2c0c9ddc2ec53d0d5e174cb542' ;; \
		armhf)   binArch='armv6'; checksum='6de688e6514df67594635c79be51a3fe3b7b29254b36349955979571d0624dd9bb228abcb798e76fc64ec0e1c4884443c3fd5074a5b5124ee895d29d239bcf1c' ;; \
		armv7)   binArch='armv7'; checksum='ba2186fd97c2e3f8930ee04bf01774938fc3682365fe4be70d9326f2b2a430f337c617f2c385aaa3d4e6dccb7ba980990d26cdc395574e6a5172c4f74cd9391d' ;; \
		aarch64) binArch='arm64'; checksum='91b5d50cd5c0dd84bf7dfcc437880df0d39dc62af57574cea2b560000c5bf12ba415b8723c5cb091276a93b979249ff939d567fef3a2a6ed417f93af266effcc' ;; \
		ppc64el|ppc64le) binArch='ppc64le'; checksum='f8aa3a478a989217a5f4e6b58936d2a69ffb99f2b7625760451ecab6fdc6d2534f815b8414a2121d63cdbea4f92022cebaa8550f9e3a61681ec25893ebf11ee6' ;; \
		s390x)   binArch='s390x'; checksum='2c8f9b6b28194dcc14db98c0657f6a47f35dbfa6c0a45fc485b488ada7c5b77abb4f880d3763dac1699d1007ba8e0f622a075fc7f394a0f3898fb90883c00407' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
	esac; \
	wget -O /tmp/caddy.tar.gz "https://github.com/caddyserver/caddy/releases/download/v2.6.2/caddy_2.6.2_linux_${binArch}.tar.gz"; \
	echo "$checksum  /tmp/caddy.tar.gz" | sha512sum -c; \
	tar x -z -f /tmp/caddy.tar.gz -C /usr/bin caddy; \
	rm -f /tmp/caddy.tar.gz; \
	chmod +x /usr/bin/caddy; \
	caddy version

# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/docker-library/golang/blob/1eb096131592bcbc90aa3b97471811c798a93573/1.14/alpine3.12/Dockerfile#L9
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data

COPY phpbb-caddy/Caddyfile /etc/caddy/Caddyfile

### phpBB
RUN mkdir -p /phpbb/www
COPY phpbb-caddy/phpBB3.zip /phpbb/www/
RUN cd /phpbb/www \
    && unzip phpBB3.zip \
    && rm phpBB3.zip

RUN mkdir -p /phpbb/opcache

COPY phpbb-caddy/php/* /etc/php81/
# COPY phpbb/php/conf.d/* /etc/php81/conf.d/

COPY phpbb-caddy/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh \
    && chmod -R 777 /phpbb/www/files /phpbb/www/cache /phpbb/www/store /phpbb/www/images/avatars/upload \
    && chmod 666 /phpbb/www/config.php

WORKDIR /phpbb/www

#VOLUME /phpbb/sqlite
#VOLUME /phpbb/www/files
#VOLUME /phpbb/www/store
#VOLUME /phpbb/www/images/avatars/upload

ENV TZ=

EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/start.sh"]