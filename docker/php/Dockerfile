FROM php:7.3.13-fpm-alpine

ARG WEB_USER
ARG WEB_GROUP
ARG PHP_ROOT_DIR

RUN deluser ${WEB_USER} \
    && addgroup -g 1000 ${WEB_GROUP} \
    && adduser -u 1000 -G ${WEB_GROUP} -D ${WEB_USER}

RUN apk add --no-cache libpng libpng-dev libzip-dev \
        && docker-php-ext-configure zip --with-libzip \
        && docker-php-ext-install \
                gd \
                opcache \
                sockets \
                mysqli \
                pdo \
                pdo_mysql \
                zip \
        && apk del libpng-dev libzip-dev \
        && rm -rf /var/cache/apk/*

COPY ./zz-socket.conf ${PHP_ROOT_DIR}/php-fpm.d/zz-socket.conf
COPY ./mail.ini ${PHP_ROOT_DIR}/php/conf.d/mail.ini
