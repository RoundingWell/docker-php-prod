FROM alpine:3.9

MAINTAINER devops@roundingwell.com

RUN apk --update --no-cache add \
    php7 \
    php7-bcmath \
    php7-ctype \
    php7-curl \
    php7-fpm \
    php7-intl \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_pgsql \
    php7-phar \
    php7-posix \
    php7-sodium \
    php7-xml \
    php7-zip

COPY php.ini /etc/php7/conf.d/10-production.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf

EXPOSE 9000

CMD ["php-fpm7", "-F"]
