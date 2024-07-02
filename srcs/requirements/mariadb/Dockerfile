# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 14:59:01 by craimond          #+#    #+#              #
#    Updated: 2024/07/02 14:07:46 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache mariadb mariadb-client envsubst shadow

ARG DB_NAME DB_USER DB_USER_PASSWORD DB_SUPERUSER DB_SUPERUSER_PASSWORD

COPY --chmod=755 ./tools/init.sh	/tmp/init.sh
COPY ./conf/*.sql					/tmp/
COPY ./conf/mariadb-server.cnf		/etc/my.cnf.d/mariadb-server.cnf

RUN usermod -u 1001 mysql
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld
RUN cd tmp && ./init.sh

EXPOSE 3306

USER mysql

ENTRYPOINT ["/usr/bin/mysqld"]
CMD ["--datadir=/var/lib/mysql"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD mysqladmin ping || exit 1