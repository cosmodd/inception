# Pull alpine image
FROM alpine:3.17.2

# Install needed packages
RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client gettext

# Setup mysqld
RUN mkdir -p /var/run/mysqld
RUN chmod 777 /var/run/mysqld

# Copy config file
COPY ./conf/mysqld.cnf /etc/my.cnf.d/mysqld.cnf
COPY ./conf/wordpress.sql /tmp/wordpress.sql
RUN chown mysql /tmp/wordpress.sql

# Setup networking
RUN sed -i 's/skip-networking/skip-networking=0/g' /etc/my.cnf.d/mariadb-server.cnf
EXPOSE 3306

RUN mysql_install_db --user=mysql --datadir="/var/lib/mysql"

USER mysql

# Entrypoint
COPY ./scripts/database.sh .

CMD ["sh", "database.sh"]