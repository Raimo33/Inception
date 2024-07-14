# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 14:59:01 by craimond          #+#    #+#              #
#    Updated: 2024/07/11 11:33:49 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache mariadb mariadb-client envsubst shadow tini

ARG USER_ID DB_NAME DB_USER DB_PASSWORD

COPY ./tools/							/tmp
COPY ./conf/mariadb-server_build.cnf	/etc/my.cnf.d/mariadb-server.cnf

RUN usermod -u $USER_ID mysql
RUN mariadb-install-db --datadir=/var/lib/mysql --user=mysql

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld /etc/my.cnf.d/mariadb-server.cnf
RUN chmod +x /tmp/init_db.sh

WORKDIR /tmp
RUN ./init_db.sh

COPY ./conf/mariadb-server_run.cnf		/etc/my.cnf.d/mariadb-server.cnf

WORKDIR /var/lib/mysql
USER mysql
EXPOSE 3306

CMD ["/usr/bin/mysqld", "--datadir=/var/lib/mysql"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["mariadb-admin", "ping"]
