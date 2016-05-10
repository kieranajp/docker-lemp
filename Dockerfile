M ej52/alpine-nginx-php:latest
MAINTAINER Kieran Patel "https://kieranajp.co.uk"

# Set docroot
RUN sed -i 's/\/var\/www/\/var\/www\/public/' /etc/nginx/conf.d/default.conf

# Set up query string for clean URLs
RUN sed -i 's/\/index\.php;/\/index\.php$is_args$args;/' /etc/nginx/conf.d/default.conf

# Display PHP errors
RUN sed -i 's/display_errors              = Off/display_errors              = On/' /etc/php/php.ini

