#!/bin/sh

# Function that replaces env variables in a file using `envsubst` command
replace_env_variables() {
	local file_path="$1"
	local file_name="$(basename $file_path)"
	local tmp_path="/tmp/$file_name"

	cp $file_path $tmp_path
	envsubst < $tmp_path > $file_path
	rm $tmp_path
}

# Replace env variables in the config file of NGINX
replace_env_variables /etc/nginx/nginx.conf

# Run nginx in foreground
nginx -g "daemon off;"
