FROM php:7.3-fpm-alpine

MAINTAINER devops@roundingwell.com

# Add system packages to build extensions
RUN apk --no-cache --update add \
    icu-dev \
    postgresql-dev

# Add required PHP extensions
RUN docker-php-ext-install -j$(nproc) bcmath \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-install -j$(nproc) opcache \
    && docker-php-ext-install -j$(nproc) pgsql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql

# Use default production config
# The PHP_INI_DIR variable is defined by the base image.
# https://github.com/php/php-src/blob/master/php.ini-production
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Add additional settings
COPY php.ini "$PHP_INI_DIR/conf.d/10-settings.ini"
