# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/08 23:57:04 by craimond          #+#    #+#              #
#    Updated: 2024/09/15 16:06:02 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#TODO fix file transfer

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID1 FTP_USER FTP_PASSWORD

COPY ./conf/vsftpd.conf	/etc/vsftpd/vsftpd.conf

RUN apk add --no-cache vsftpd lftp

RUN mkdir -p /var/run/vsftpd
RUN touch /var/log/vsftpd.log

RUN addgroup -g $GROUP_ID1 -S wordpress-group
RUN adduser -u $USER_ID -G wordpress-group -SDH vsftpd-user
RUN chown -R vsftpd-user /etc/vsftpd /var/run/vsftpd /var/log/vsftpd.log

RUN adduser -D $FTP_USER
RUN echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

USER	vsftpd-user
EXPOSE	21 20 21000-21010
WORKDIR	/home/ftp-user
VOLUME	["/var/www/html/wordpress", "/etc/ssl/certs", "/var/log"]

ENTRYPOINT ["vsftpd", "/etc/vsftpd/vsftpd.conf"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD ["lftp", "-e", "quit", "-u", "anonymous,", "-p", "21", "vsftpd.backend"]