# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/13 15:12:45 by craimond          #+#    #+#              #
#    Updated: 2024/06/13 15:12:47 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Base image
FROM alpine:3.19

# Install dependencies
RUN apk update && \
    apk add mariadb mariadb-client mariadb-server-utils bash

# Copy the MariaDB server configuration file
COPY conf/50-server.conf /etc/mysql/mariadb.conf.d/50-server.conf

# Create a separate directory for running the bash script
RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Copy the initialization script
COPY tools/init_db.sh /run/mysqld/init_db.sh
RUN chmod +x /run/mysqld/init_db.sh

# Expose the port for MariaDB
EXPOSE 3306

# Run the MariaDB server with initialization
ENTRYPOINT ["/run/mysqld/init_db.sh"]