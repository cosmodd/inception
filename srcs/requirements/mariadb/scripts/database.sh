#!/bin/sh

if [ ! -d /var/lib/mysql/mysql ]; then

	echo "[INFO] Initializing MariaDB database..."

	mysql_install_db --user=mysql --datadir=/var/lib/mysql

fi

# Setup Wordpress database if it doesn't exist
if [ ! -d /var/lib/mysql/${DB_NAME} ]; then

	echo "[INFO] Creating '${DB_NAME}' database..."

	# Replace environment variables in SQL file
	cp /tmp/wordpress.sql /tmp/wordpress.sql.tmp
	envsubst < /tmp/wordpress.sql.tmp > /tmp/wordpress.sql

	# --bootstrap is used to execute the SQL commands without starting the server
	/usr/bin/mysqld --user=mysql --bootstrap < /tmp/wordpress.sql

fi

echo "[INFO] Starting MariaDB..."

# Start MariaDB
/usr/bin/mysqld --skip-log-error
