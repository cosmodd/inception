# Pull alpine image
FROM alpine:3.17.2

# Install needed packages
RUN apk update && apk upgrade
RUN apk add --no-cache nginx gettext openssl

# Expose port 443 to allow https traffic to this container
EXPOSE 443
EXPOSE 80

# Create folder for ssl certificates
RUN mkdir -p /etc/nginx/ssl

# Copy nginx config file and substitute env variables
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Copy html files
COPY ./html /var/www/html

# Copy scripts to container
COPY ./scripts /scripts/

CMD ["sh", "/scripts/entrypoint.sh"]
