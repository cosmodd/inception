-- Switch to the 'mysql' database
USE mysql;

-- Reload MySQL privilege tables to apply changes
FLUSH PRIVILEGES;

-- Delete any MySQL user accounts with empty usernames
DELETE FROM mysql.user WHERE User='';

-- Drop the 'test' database
DROP DATABASE test;

-- Delete any references to the 'test' database in the mysql.db table
DELETE FROM mysql.db WHERE Db='test';

-- Delete MySQL user accounts with 'root' username and host not in ('localhost', '127.0.0.1', '::1')
-- This is done to restrict access of root user to local connections only
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Update the password for the MySQL root user for connections from localhost
-- The new password is specified in the ${DB_ROOT_PASS} variable
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';

-- Create a new MySQL database with the name specified in the ${DB_NAME} variable
-- The character set and collation are set to utf8 and utf8_general_ci, respectively
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Create a new MySQL user with the username and password specified in the ${DB_USER} and ${DB_PASS} variables
-- The user is granted access from any host (%)
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';

-- Grant all privileges on the database ${DB_NAME} to the MySQL user created in the previous statement
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';

-- Reload MySQL privilege tables to apply changes
FLUSH PRIVILEGES;
