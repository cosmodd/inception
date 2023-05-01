# Pull alpine image
FROM alpine:3.16

# Install needed packages
RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client gettext

# Setup mysqld
# Having /var/run/mysqld owned by mysql is a requirement for mysqld to start
# it is used to store the socket file
RUN mkdir -p /var/run/mysqld
RUN chmod 777 /var/run/mysqld

# Copy config file
COPY ./conf/mysqld.cnf /etc/my.cnf.d/mysqld.cnf
COPY ./conf/wordpress.sql /tmp/wordpress.sql
RUN chown mysql /tmp/wordpress.sql

# Setup networking
RUN sed -i 's/skip-networking/skip-networking=0/g' /etc/my.cnf.d/mariadb-server.cnf

# Switch to mysql user
USER mysql

# Entrypoint
COPY ./scripts/database.sh .

CMD ["sh", "database.sh"]
