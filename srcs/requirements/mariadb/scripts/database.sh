#!/bin/sh

# If the database is not initialized, initialize it
if [ ! -d /var/lib/mysql/mysql ]; then

	echo "[INFO] Initializing MariaDB database..."

	# Initialize MariaDB database
	# --user=mysql: run mysqld as the user mysql
	# --datadir=/var/lib/mysql: use /var/lib/mysql as the database directory
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

fi

# Setup Wordpress database if it doesn't exist
if [ ! -d /var/lib/mysql/${DB_NAME} ]; then

	echo "[INFO] Creating '${DB_NAME}' database..."

	# Replace environment variables in SQL file
	cp /tmp/wordpress.sql /tmp/wordpress.sql.tmp
	envsubst < /tmp/wordpress.sql.tmp > /tmp/wordpress.sql

	# Initialize Wordpress database
	# --user=mysql: run mysqld as the user mysql
	# --bootstrap: run the SQL statements in the file /tmp/wordpress.sql
	#              without starting a server
	mysqld --user=mysql --bootstrap < /tmp/wordpress.sql

fi

echo "[INFO] Starting MariaDB..."

# Start MariaDB
# --skip-log-error: don't log errors to the error log
mysqld --skip-log-error
