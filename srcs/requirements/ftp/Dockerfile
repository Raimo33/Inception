# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/21 12:37:04 by craimond          #+#    #+#              #
#    Updated: 2024/07/08 13:59:24 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

COPY ./conf/vsftpd.conf	/etc/vsftpd/vsftpd.conf
COPY ./conf/ssl			/etc/ssl

RUN apk add --no-cache vsftpd tini curl

RUN adduser -u 1004 -S ftp-user
RUN chmod -R 744 /etc/ssl

EXPOSE 21
USER ftp-user

ENTRYPOINT ["tini", "--"]
CMD ["vsftpd"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f ftp://localhost:21 || exit 1
