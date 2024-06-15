# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/11 15:36:41 by craimond          #+#    #+#              #
#    Updated: 2024/06/15 14:36:35 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#base image
FROM alpine:3.19

#install dependencies
RUN apk update && apk add nginx openssl tini && mkdir -p /run/nginx

#copy the actual local files in the image during the building process
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/certs/* /etc/ssl/certs/
COPY conf/private/* /etc/ssl/private/

RUN chmod 644 /etc/ssl/certs/*
RUN chmod 600 /etc/ssl/private/*

#DOCUMENT (not actually expose yet) the port the container listens on at runtime.
EXPOSE 80 443

# Use tini as the init system for forwarding signals to the child processes
ENTRYPOINT ["/sbin/tini", "--"]

#command to run the container
CMD ["nginx", "-g", "daemon off;"]