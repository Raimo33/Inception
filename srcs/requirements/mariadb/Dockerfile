# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: femorell <femorell@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 14:59:01 by craimond          #+#    #+#              #
#    Updated: 2024/06/21 18:03:02 by femorell         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache mariadb mariadb-client envsubst shadow

COPY ./tools/ /tmp/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN usermod -u 1001 mysql
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr

RUN mkdir -p /run/mysqld /var/log/mysql
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql
RUN chmod +x /tmp/init.sh

RUN /tmp/init.sh

EXPOSE 3306

USER mysql

ENTRYPOINT ["/usr/bin/mysqld"]
CMD ["--datadir=/var/lib/mysql"]
