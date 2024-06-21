# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/21 12:37:04 by craimond          #+#    #+#              #
#    Updated: 2024/06/21 14:49:36 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

RUN apk add --no-cache vsftpd shadow
RUN adduser -S -u 1002 ftp-user

COPY ./conf/vsftpd.conf	/etc/vsftpd/vsftpd.conf
COPY ./conf/ssl/		/etc/ssl/

EXPOSE 21

ENTRYPOINT ["/usr/sbin/vsftpd"]