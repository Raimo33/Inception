# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 14:59:01 by craimond          #+#    #+#              #
#    Updated: 2024/06/19 13:08:16 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client envsubst

COPY ./tools/* /tmp/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
RUN chown -R mysql:mysql /var/lib/mysql
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

USER mysql

CMD ["sh", "/tmp/start.sh"]
