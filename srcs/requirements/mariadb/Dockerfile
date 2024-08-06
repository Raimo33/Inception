# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 14:59:01 by craimond          #+#    #+#              #
#    Updated: 2024/08/06 12:46:42 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache mariadb mariadb-client envsubst shadow tini

ARG USER_ID DB_NAME DB_USER DB_PASSWORD

COPY ./tools/					/tmp
COPY ./conf/mariadb-server.cnf	/etc/my.cnf.d/mariadb-server.cnf

RUN mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql
RUN touch /var/log/mysql/error.log /var/log/mysql/query.log /var/log/mysql/slow_query.log

RUN adduser -u $USER_ID -SD mariadb_user
RUN chown -R mariadb_user /var/lib/mysql /var/log/mysql /run/mysqld /etc/my.cnf.d/
RUN chmod +x /tmp/init_db.sh

RUN mariadb-install-db --datadir=/var/lib/mysql --user=mariadb_user

WORKDIR /tmp
RUN ./init_db.sh

WORKDIR /var/lib/mysql
USER mariadb_user
EXPOSE 3306
VOLUME /var/lib/mysql
VOLUME /var/log

CMD ["/usr/bin/mysqld", "--datadir=/var/lib/mysql", "--user=mariadb_user"]
#TODO fix: in build -> error: no database selected

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD ["mariadb-admin", "ping"]
