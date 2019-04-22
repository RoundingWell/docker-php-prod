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

# Compile libsodium 1.0.17
RUN mkdir -p /tmpbuild/libsodium && \
    cd /tmpbuild/libsodium && \
    curl -L https://download.libsodium.org/libsodium/releases/libsodium-1.0.17.tar.gz -o libsodium-1.0.17.tar.gz && \
    tar xfvz libsodium-1.0.17.tar.gz && \
    cd /tmpbuild/libsodium/libsodium-1.0.17/ && \
    ./configure && \
    make && make check && \
    make install && \
    mv src/libsodium /usr/local/ && \
    rm -Rf /tmpbuild/

# Ensure the libsodium extension is up to date
RUN pecl install libsodium
