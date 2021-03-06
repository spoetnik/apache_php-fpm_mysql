FROM php:7.4.1-fpm-alpine

ARG WEB_USER
ARG WEB_GROUP
ARG PHP_ROOT_DIR

RUN deluser ${WEB_USER} \
    && addgroup -g 1000 ${WEB_GROUP} \
    && adduser -u 1000 -G ${WEB_GROUP} -D ${WEB_USER}

RUN apk add --no-cache  libpng \
                        libpng-dev \
                        freetype-dev \
                        libwebp-dev \
                        libjpeg-turbo-dev \
                        libzip-dev\
                        ca-certificates \
                        msmtp \
        && docker-php-ext-configure zip \
        && docker-php-ext-configure gd \
            --with-freetype \
            --with-jpeg \
            --with-webp \
        && docker-php-ext-install \
                iconv \
                gd \
                opcache \
                sockets \
                mysqli \
                pdo \
                pdo_mysql \
                zip \
        && rm -rf /var/cache/apk/*

COPY ./zz-socket.conf ${PHP_ROOT_DIR}/php-fpm.d/zz-socket.conf
COPY ./mail.ini ${PHP_ROOT_DIR}/php/conf.d/mail.ini
# Copy init scripts and custom .htaccess
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm"]