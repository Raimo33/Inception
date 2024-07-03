# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 14:59:01 by craimond          #+#    #+#              #
#    Updated: 2024/07/03 18:43:29 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache mariadb mariadb-client envsubst shadow

ARG DB_NAME DB_USER DB_USER_PASSWORD DB_SUPERUSER DB_SUPERUSER_PASSWORD

COPY ./tools/						/tmp
COPY ./conf/mariadb-server.cnf		/etc/my.cnf.d/mariadb-server.cnf

RUN usermod -u 1001 mysql
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld

EXPOSE 3306
WORKDIR /var/lib/mysql

RUN envsubst < /tmp/create_db.template.sql > /tmp/create_db.sql
RUN envsubst < /tmp/create_user.template.sql > /tmp/create_user.sql
RUN chmod +x /tmp/init.sh

ENTRYPOINT ["/tmp/init.sh"]
CMD ["/usr/bin/mysqld", "--datadir=/var/lib/mysql", "--user=mysql"]

USER mysql

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD mysqladmin ping || exit 1