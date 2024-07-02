# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/21 12:37:04 by craimond          #+#    #+#              #
#    Updated: 2024/07/02 14:23:06 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache vsftpd
RUN adduser -u 1004 -S ftp-user

COPY ./conf/vsftpd.conf	/etc/vsftpd/vsftpd.conf

EXPOSE 21
USER ftp-user

ENTRYPOINT ["/usr/sbin/vsftpd"]
CMD []

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f ftp://localhost:21 || exit 1
