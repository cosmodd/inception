# Pull alpine image
FROM alpine:3.16

# Install needed packages
RUN apk update && apk upgrade
RUN apk add --no-cache nginx openssl

# Create folder for ssl certificates
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed certificate
# -x509: output a self-signed certificate instead of a certificate request
# -nodes: do not encrypt the output key with a pass phrase
# -newkey: generate a new private key
# -subj: set or modify the subject of a certificate
# -keyout: output the key to the specified file
# -out: output the certificate to the specified file
RUN openssl req -x509 -nodes -newkey rsa:2048 \
	-subj "/C=FR/ST=PACA/L=Nice/O=42/CN=${DOMAIN_NAME}" \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt

# Copy nginx config file and substitute env variables
COPY ./conf/nginx.conf /etc/nginx/http.d/nginx.conf

# Copy scripts to container
COPY ./scripts /scripts/

ENTRYPOINT ["sh", "/scripts/entrypoint.sh"]
