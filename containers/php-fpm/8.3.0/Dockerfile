FROM php:8.3.0-fpm-alpine3.19

# Instala as dependências necessárias
RUN apk update && apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
	imagemagick-dev \
    libpng-dev \
    libzip-dev \
	libwebp-dev \
    icu-dev \
    oniguruma-dev \
    curl \
    unzip \
	bash \	
	ghostscript \
	imagemagick \
	php-pecl-imagick \
	php83-pecl-igbinary \
	php83-mbstring \
	php83-dom \
	php83-xml \
	php83-zip \
	openssl

# Configura e instala as extensões PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install exif pcntl bcmath opcache \
	&& docker-php-ext-enable imagick

RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-install pdo_mysql

RUN set -eux; \
	docker-php-ext-enable opcache; \
	{ \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN { \
		echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
		echo 'display_errors = Off'; \
		echo 'display_startup_errors = Off'; \
		echo 'log_errors = On'; \
		echo 'error_log = /dev/stderr'; \
		echo 'log_errors_max_len = 1024'; \
		echo 'ignore_repeated_errors = On'; \
		echo 'ignore_repeated_source = Off'; \
		echo 'html_errors = Off'; \
	} > /usr/local/etc/php/conf.d/error-logging.ini

CMD ["php-fpm"]

# FROM php:8.3.0-fpm-alpine3.19

# RUN set -eux; \
# 	apk add --no-cache \
# 		bash \
# 		ghostscript \
# 		imagemagick \
# 	;

# RUN set -ex; \
# 	\
# 	apk add --no-cache --virtual .build-deps \
# 		$PHPIZE_DEPS \
# 		freetype-dev \
# 		icu-dev \
# 		imagemagick-dev \
# 		libjpeg-turbo-dev \
# 		libpng-dev \
# 		libwebp-dev \
# 		libzip-dev \
# 	; \
# 	\
# 	docker-php-ext-configure gd \
# 		--with-freetype \
# 		--with-jpeg \
# 		--with-webp \
# 	; \
# 	docker-php-ext-install -j "$(nproc)" \
# 		bcmath \
# 		exif \
# 		gd \
# 		intl \
# 		mysqli \
# 		zip \
# 	; \
# 	pecl install imagick-3.7.0; \
# 	docker-php-ext-enable imagick; \
# 	rm -r /tmp/pear; \
# 	\
# 	out="$(php -r 'exit(0);')"; \
# 	[ -z "$out" ]; \
# 	err="$(php -r 'exit(0);' 3>&1 1>&2 2>&3)"; \
# 	[ -z "$err" ]; \
# 	\
# 	extDir="$(php -r 'echo ini_get("extension_dir");')"; \
# 	[ -d "$extDir" ]; \
# 	runDeps="$( \
# 		scanelf --needed --nobanner --format '%n#p' --recursive "$extDir" \
# 			| tr ',' '\n' \
# 			| sort -u \
# 			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
# 	)"; \
# 	apk add --no-network --virtual .wordpress-phpexts-rundeps $runDeps; \
# 	apk del --no-network .build-deps; \
# 	\
# 	! { ldd "$extDir"/*.so | grep 'not found'; }; \
# 	err="$(php --version 3>&1 1>&2 2>&3)"; \
# 	[ -z "$err" ]

# RUN docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
#     && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
#     && docker-php-ext-install pdo_mysql

# RUN set -eux; \
# 	docker-php-ext-enable opcache; \
# 	{ \
# 		echo 'opcache.memory_consumption=128'; \
# 		echo 'opcache.interned_strings_buffer=8'; \
# 		echo 'opcache.max_accelerated_files=4000'; \
# 		echo 'opcache.revalidate_freq=60'; \
# 		echo 'opcache.fast_shutdown=1'; \
# 		echo 'opcache.enable_cli=1'; \
# 	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# RUN { \
# 		echo 'error_reporting = E_ERROR | E_WARNING | E_PARSE | E_CORE_ERROR | E_CORE_WARNING | E_COMPILE_ERROR | E_COMPILE_WARNING | E_RECOVERABLE_ERROR'; \
# 		echo 'display_errors = Off'; \
# 		echo 'display_startup_errors = Off'; \
# 		echo 'log_errors = On'; \
# 		echo 'error_log = /dev/stderr'; \
# 		echo 'log_errors_max_len = 1024'; \
# 		echo 'ignore_repeated_errors = On'; \
# 		echo 'ignore_repeated_source = Off'; \
# 		echo 'html_errors = Off'; \
# 	} > /usr/local/etc/php/conf.d/error-logging.ini

# CMD ["php-fpm"]