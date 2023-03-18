# Pull alpine image
FROM alpine:3.17.2

# Install nginx
RUN apk update && apk upgrade
RUN apk add --no-cache nginx gettext

# Expose port 443 to allow https traffic to this container
EXPOSE 443
EXPOSE 80

# Copy nginx config file and substitute env variables
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Copy public folder
COPY ./public /var/www/public

# Copy scripts to container
COPY ./scripts /scripts/

CMD ["sh", "/scripts/entrypoint.sh"]
