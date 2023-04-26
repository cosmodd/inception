#!/bin/sh

# If wp-config.php doesn't exist, configure wordpress
if [ ! -e /var/www/wp-config.php ]; then

	# Use wp-cli to configure wordpress
	# Create wp-config.php
	wp config create \
		--allow-root \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASS \
		--dbhost=mariadb:3306 \
		--path='/var/www/'

	# Install wordpress
	wp core install \
		--url=$DOMAIN_NAME \
		--title=$WEBSITE_NAME \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASS \
		--admin_email=$ADMIN_MAIL \
		--allow-root \
		--path='/var/www/'

	# Create one user
	wp user create \
		--allow-root \
		--role=author $USER_LOGIN $USER_MAIL \
		--user_pass=$USER_PASS \
		--path='/var/www/' >> /log.txt
fi

# Start php-fpm in foreground
/usr/sbin/php-fpm8 -F
