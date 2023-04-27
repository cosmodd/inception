#!/bin/sh

echo "Waiting for MariaDB to be ready..."

# Wait for mariadb to be ready
while ! mysqladmin ping -h $DB_HOST --silent; do
	sleep 1
done

# If wp-config.php doesn't exist, configure wordpress
if [ ! -e /var/www/wp-config.php ]; then

	echo "Configuring wordpress..."

	# Use wp-cli to configure wordpress
	# Create wp-config.php
	wp config create \
		--allow-root \
		--dbname=$DB_NAME \
		--dbuser=$DB_USER \
		--dbpass=$DB_PASS \
		--dbhost=$DB_HOST \
		--path='/var/www/'

	echo "Installing wordpress..."

	# Install wordpress
	wp core install \
		--url=$DOMAIN_NAME \
		--title=$WEBSITE_NAME \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASS \
		--admin_email=$ADMIN_EMAIL \
		--allow-root \
		--path='/var/www/'

	echo "Creating user..."

	# Create one user
	wp user create \
		--allow-root \
		--role=author $USER_LOGIN $USER_EMAIL \
		--user_pass=$USER_PASS \
		--path='/var/www/' >> /log.txt
fi

# Start php-fpm in foreground
/usr/sbin/php-fpm8 -F
