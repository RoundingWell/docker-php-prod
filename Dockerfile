FROM php:7.3-fpm

MAINTAINER woody.gilk@roundingwell.com

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY conf/intl.ini "$PHP_INI_DIR/conf.d/intl.ini"
COPY conf/timezone.ini "$PHP_INI_DIR/conf.d/timezone.ini"

RUN apt-get update && apt-get install -y \
    libicu-dev \
    libpq-dev \
    zlib1g-dev

RUN docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) pgsql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql
