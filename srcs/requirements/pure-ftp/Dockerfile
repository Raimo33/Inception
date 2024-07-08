# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/21 12:37:04 by craimond          #+#    #+#              #
#    Updated: 2024/07/08 18:03:27 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

COPY ./conf/ssl	/etc/ssl

RUN apk add --no-cache pure-ftpd tini curl

RUN addgroup -g 1000 -S webgroup && adduser -u 1003 -G webgroup -SD ftp-user
RUN chmod -R 744 /etc/ssl

USER ftp-user:webgroup
EXPOSE 21 30000-30009

ENTRYPOINT ["tini", "--"]
CMD ["pure-ftpd", "-c", "50", "-C", "20", "-E", "-j", "-R", "--tls=2", "--certfile=/etc/ssl/certs/pure-ftp.crt"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f ftps://localhost:21 || exit 1
