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

# Generate a self-signed certificate
# -x509: output a self-signed certificate instead of a certificate request
# -nodes: do not encrypt the output key with a pass phrase
# -newkey: generate a new private key
# -subj: set or modify the subject of a certificate
# -keyout: output the key to the specified file
# -out: output the certificate to the specified file
openssl req -x509 -nodes -newkey rsa:2048 \
	-subj "/C=FR/ST=PACA/L=Nice/O=42/CN=${DOMAIN_NAME}" \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt

# Run nginx in foreground
nginx -g "daemon off;"
