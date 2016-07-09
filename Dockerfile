FROM ej52/alpine-nginx:latest
MAINTAINER Kieran Patel "https://kieranajp.co.uk"

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk --update add \
        php7 \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fpm \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-posix \
        php7-redis \
        php7-session \
        php7-xml \
        php7-iconv \
        php7-phar \
        php7-openssl \
        php7-zip \
    && rm -rf /var/cache/apk/*

COPY php.ini /etc/php7/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf

RUN ln -s /usr/bin/php7 /usr/bin/php
# Set docroot
RUN sed -i 's/\/var\/www/\/var\/www\/public/' /etc/nginx/conf.d/default.conf
# Set up query string for clean URLs
RUN sed -i 's/\/index\.php;/\/index\.php$is_args$args;/' /etc/nginx/conf.d/default.conf
# Display PHP errors
RUN sed -i 's/display_errors              = Off/display_errors              = On/' /etc/php/php.ini

VOLUME /app
EXPOSE 9000

CMD ["php-fpm7", "-F"]
