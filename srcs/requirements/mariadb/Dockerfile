# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 14:59:01 by craimond          #+#    #+#              #
#    Updated: 2024/06/25 17:31:25 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client envsubst shadow

ARG DB_NAME DB_USER DB_PASSWORD DB_ADMIN

COPY ./tools/ /tmp/
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

RUN usermod -u 1001 mysql
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld
RUN chmod +x /tmp/init.sh

RUN cd tmp && ./init.sh

EXPOSE 3306

USER mysql

ENTRYPOINT ["/usr/bin/mysqld"]
CMD ["--datadir=/var/lib/mysql"]