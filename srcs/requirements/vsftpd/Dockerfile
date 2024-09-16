# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/08 23:57:04 by craimond          #+#    #+#              #
#    Updated: 2024/09/16 15:32:19 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#TODO fix file transfer

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID1 FTP_USER FTP_USER_PASSWORD

COPY ./conf/vsftpd.conf			/etc/vsftpd/vsftpd.conf
COPY ./conf/pam.d/vsftpd		/etc/pam.d/vsftpd
COPY ./tools/create_users.sh	/tmp/create_users.sh

RUN apk add --no-cache vsftpd lftp

RUN mkdir -p /var/run/vsftpd
RUN touch /var/log/vsftpd.log

RUN addgroup -g $GROUP_ID1 -S wordpress-group
RUN adduser -u $USER_ID -G wordpress-group -SDH vsftpd-user
RUN chmod 755 /tmp/create_users.sh /var/run/vsftpd /var/log/vsftpd.log

RUN /tmp/create_users.sh && rm -rf /tmp

EXPOSE	21 20 21000-21010
WORKDIR	/home
VOLUME	["/var/www/html/wordpress", "/etc/ssl/certs", "/var/log"]

ENTRYPOINT ["vsftpd", "/etc/vsftpd/vsftpd.conf"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD ["lftp", "-e", "quit", "-u", "anonymous,", "-p", "21", "vsftpd.backend"]