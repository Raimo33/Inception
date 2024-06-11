# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/11 15:36:35 by craimond          #+#    #+#              #
#    Updated: 2024/06/11 16:54:28 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#base image
FROM alpine:3.19

#install dependencies
RUN apk update && apk add mariadb-server

#copy the actual local files in the image during the building process
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

#create a separate directory for running the bash script
RUN mkdir -p /run/mysqld

#copy the bash script in the image during the building process
COPY tools/init_db.sh	/run/mysqld/init_db.sh

#DOCUMENT the exposing of the port
EXPOSE 3306

#run the mariadb server
CMD ["bash", "/run/mysqld/init_db.sh"]