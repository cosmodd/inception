# Pull alpine image
FROM alpine:3.17.2

# Install nginx
RUN apk update && apk upgrade
RUN apk add --no-cache nginx

# Expose port 443 to allow https traffic to this container
EXPOSE 443

# Copy nginx config file and substitute env variables
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
RUN envsubst < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf

# Copy public folder
COPY ./public /var/www/public

CMD ["nginx", "-g", "daemon off;"]