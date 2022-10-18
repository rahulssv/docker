FROM php:8.1.11-fpm-alpine3.16

RUN apk update && apk upgrade

RUN apk add --no-cache curl \
    zip \
    unzip \
    imagemagick \
    imagemagick-dev \
    imagemagick-libs \
    php81 \
    php81-curl \
    php81-dom \
    php81-exif \
    php81-fileinfo \
    php81-pecl-imagick \
    php81-mbstring \
    php81-openssl \
    php81-xml \
    php81-zip \
    php81-opcache \
    php81-gd \
    php81-iconv \
    php81-json \
    php81-mysqli \
    php81-pgsql \
    php81-sqlite3 \
    php81-tokenizer \
    php81-zlib \
    php81-ftp \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    libpng \
    libpng-dev \
    freetype \
    freetype-dev \
    libzip \
    libzip-dev \
    icu \
    icu-dev \
    nano

RUN mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/refs/tags/3.7.0.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    docker-php-ext-install imagick;

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli exif zip intl imagick  \
    && docker-php-ext-enable mysqli exif zip intl imagick 

RUN echo "upload_max_filesize = 1024M" >> /usr/local/etc/php/php.ini && \
    echo "post_max_size = 1024M" >> /usr/local/etc/php/php.ini && \
    echo "max_execution_time = 300" >> /usr/local/etc/php/php.ini

RUN apk add tzdata && \
    cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    echo "America/Sao_Paulo" >  /etc/timezone && \
    apk del tzdata
