<?php
define('DB_NAME', '${DB_NAME}');		# Database name
define('DB_USER', '${DB_USER}');		# Database user
define('DB_PASSWORD', '${DB_PASS}');	# Database password
define('DB_HOST', 'mariadb');			# Database host
define('DB_CHARSET', 'utf8');			# Database charset
define('DB_COLLATE', '');				# Database collate
define('FS_METHOD', 'direct');			# Filesystem method
$table_prefix = 'wp_';					# Table prefix
define('WP_DEBUG', false);				# Debug mode

# Absolute path to the WordPress directory.
if ( !defined('ABSPATH') ) { define('ABSPATH', dirname(__FILE__) . '/'); }

require_once ABSPATH . 'wp-settings.php';
