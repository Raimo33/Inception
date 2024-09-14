# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/08 23:57:04 by craimond          #+#    #+#              #
#    Updated: 2024/09/14 17:02:19 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#TODO fix file transfer

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

ARG USER_ID GROUP_ID1

COPY ./conf/vsftpd.conf	/etc/vsftpd/vsftpd.conf

RUN apk add --no-cache vsftpd lftp

RUN mkdir -p /var/run/vsftpd /home/vsftpd-user
RUN touch /var/log/vsftpd.log

RUN addgroup -g $GROUP_ID1 -S wordpress-group
RUN adduser -u $USER_ID -G wordpress-group -SD vsftpd-user
RUN chown -R vsftpd-user /home/vsftpd-user /etc/vsftpd /var/run/vsftpd /var/log/vsftpd.log

USER	vsftpd-user
EXPOSE	21 20 21000-21010
WORKDIR	/home/vsftpd-user
VOLUME	["/var/www/html/wordpress", "/etc/ssl/certs", "/var/log"]

ENTRYPOINT ["vsftpd", "/etc/vsftpd/vsftpd.conf"]

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD ["lftp", "-e", "quit", "-u", "anonymous,", "-p", "21", "vsftpd.backend"]