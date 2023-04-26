# Pull alpine image
FROM alpine:3.16

# Install needed packages
RUN apk update && apk upgrade
RUN apk add --no-cache nginx openssl

# Expose port 443 to allow https traffic to this container
EXPOSE 443

# Create folder for ssl certificates
RUN mkdir -p /etc/nginx/ssl

# Copy nginx config file and substitute env variables
COPY ./conf/nginx.conf /etc/nginx/http.d/nginx.conf

# Copy scripts to container
COPY ./scripts /scripts/

ENTRYPOINT ["sh", "/scripts/entrypoint.sh"]
