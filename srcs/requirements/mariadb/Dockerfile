# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/15 17:42:50 by craimond          #+#    #+#              #
#    Updated: 2024/06/15 17:54:55 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt update && apt install -y mariadb-server

EXPOSE 3306

COPY ./tools/create_db.sql /tmp/create_db.sql
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mysql start
RUN mysql -u root < /tmp/create_db.sql && rm /tmp/create_db.sql

CMD ["mysqld"]