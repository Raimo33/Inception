# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 14:59:01 by craimond          #+#    #+#              #
#    Updated: 2024/07/07 16:57:42 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache mariadb mariadb-client envsubst shadow

ARG DB_NAME DB_USER DB_PASSWORD

COPY ./tools/	/run/
COPY ./conf/	/etc/my.cnf.d/

RUN usermod -u 1001 mysql
RUN mariadb-install-db --datadir=/var/lib/mysql --user=mysql --defaults-file=/etc/my.cnf.d/mariadb-server_build.cnf

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld /etc/my.cnf.d/
RUN chmod +x /run/init_db.sh

WORKDIR /run
RUN ./init_db.sh

EXPOSE 3306
USER mysql

CMD ["/usr/bin/mysqld", "--datadir=/var/lib/mysql"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD mysqladmin ping || exit 1