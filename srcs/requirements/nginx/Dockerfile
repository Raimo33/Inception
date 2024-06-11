# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/11 15:36:41 by craimond          #+#    #+#              #
#    Updated: 2024/06/11 15:36:41 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#base image
FROM alpine:3.19

#install dependencies
RUN apk update && apk add nginx openssl && mkdir -p /run/nginx

#copy the actual local files in the image during the building process
COPY conf/* /etc/nginx/conf.d/

#DOCUMENT (not actually expose yet) the port the container listens on at runtime.
EXPOSE 80 443

# Use tini as the init system for forwarding signals to the child processes
ENTRYPOINT ["/sbin/tini", "--"]

#command to run the container
CMD ["nginx", "-g", "daemon off;"]