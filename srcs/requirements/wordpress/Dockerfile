FROM alpine:3.16

ARG	PHP_VERSION=8
ARG	WORDPRESS_VERSION=wordpress-6.2

# Install needed packages
RUN apk update && apk upgrade
RUN apk add --no-cache wget gettext

# Install php
# Based on https://make.wordpress.org/hosting/handbook/server-environment/
RUN apk add --no-cache \
	php${PHP_VERSION} \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-json \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-dom \
	php${PHP_VERSION}-exif \
	php${PHP_VERSION}-fileinfo \
	php${PHP_VERSION}-mbstring \
	php${PHP_VERSION}-openssl \
	php${PHP_VERSION}-xml \
	php${PHP_VERSION}-zip

# Copy php-fpm pool configuration
COPY ./conf/www.conf /etc/php${PHP_VERSION}/php-fpm.d/www.conf

# Install Wordpress
WORKDIR /var/www
RUN wget https://wordpress.org/${WORDPRESS_VERSION}.tar.gz
RUN tar -xvf ${WORDPRESS_VERSION}.tar.gz
RUN mv wordpress/* .
RUN rm -rf wordpress ${WORDPRESS_VERSION}.tar.gz
RUN chown -R 0777 /var/www

# Install wordpress-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Copy entrypoint script
COPY ./conf/wp_config.sh /tmp/wp_config.sh

# Run php-fpm in foreground
ENTRYPOINT [ "sh", "/tmp/wp_config.sh" ]
