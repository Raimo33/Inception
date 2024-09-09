# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/09 15:02:50 by craimond          #+#    #+#              #
#    Updated: 2024/09/09 15:14:07 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID

RUN apk add --no-cache nginx

COPY ./conf/vector.yaml	/etc/vector/vector.yaml

RUN mkdir -p 

RUN adduser -u $USER_ID -SD vector-user
RUN chown -R vector-user /etc/vector

USER vector-user
VOLUME ["/var/log/mariadb", "/var/log/nginx", "/var/log/wordpress", "/var/log/redis", "/var/log/vsftpd", "/var/log/adminer"]

ENTRYPOINT ["nginx", "-g", "daemon off;"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD []