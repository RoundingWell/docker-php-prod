FROM php:7.3-fpm-alpine

MAINTAINER devops@roundingwell.com

# Add required system packages
RUN apk --no-cache --update add \
    gzip \
    icu \
    libpq \
    libxml2 \
    tar \
    zip

# Add required PHP extensions
RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
        icu-dev \
        gmp-dev \
        postgresql-dev \
    && docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) gmp \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) opcache \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && apk del .build-deps

# Use default production config
# The PHP_INI_DIR variable is defined by the base image.
# https://github.com/php/php-src/blob/master/php.ini-production
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Add additional settings
COPY php.ini "$PHP_INI_DIR/conf.d/10-settings.ini"
