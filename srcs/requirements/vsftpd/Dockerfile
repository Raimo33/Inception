# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: egualand <egualand@student.42firenze.it    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/08 23:57:04 by craimond          #+#    #+#              #
#    Updated: 2024/07/09 17:50:12 by egualand         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID

COPY ./conf/ssl			/etc/ssl
COPY ./conf/vsftpd.conf	/etc/vsftpd/vsftpd.conf

RUN apk add --no-cache vsftpd tini curl

RUN addgroup -g $GROUP_ID -S webgroup && adduser -u $USER_ID -G webgroup -SD ftp-user
RUN chown -R ftp-user /etc/vsftpd
RUN chmod -R 755 /etc/ssl

USER ftp-user:webgroup
EXPOSE 21 21000-21010 20

# ENTRYPOINT ["tini", "--"]
# CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
CMD ["tail", "-f", "/dev/null"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD ["curl", "-fi", "ftp://localhost:21"]
