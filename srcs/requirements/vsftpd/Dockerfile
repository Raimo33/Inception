# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/08 23:57:04 by craimond          #+#    #+#              #
#    Updated: 2024/09/05 15:56:32 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID

COPY ./conf/vsftpd.conf	/etc/vsftpd/vsftpd.conf
COPY ./conf/ssl			/etc/ssl

RUN apk add --no-cache vsftpd curl

RUN mkdir -p /var/run/vsftpd /home/vsftpd
RUN touch /var/log/vsftpd.log

RUN addgroup -g $GROUP_ID -S wp-group
RUN adduser -u $USER_ID -G wp-group -SD ftp-user
RUN chown -R ftp-user /etc/vsftpd /var/run/vsftpd /var/log/vsftpd.log
RUN chmod -R 755 /etc/ssl

USER	ftp-user:wp-group
EXPOSE	21 21000-21010 20
WORKDIR	/home/vsftpd/ftp-user
VOLUME	["/var/www/html/wordpress", "/var/log"]

ENTRYPOINT ["vsftpd", "/etc/vsftpd/vsftpd.conf"]

#TODO fix curl: (56) response reading failed (errno: 115)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD ["curl", "-fk", "ftp://vsftpd.backend:21"]
