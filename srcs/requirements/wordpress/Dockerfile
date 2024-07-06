# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/07/06 16:40:54 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#TODO incorporare il sito, mettere il logo e altri asset in mariadb forse

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml curl

WORKDIR /var/www/html

RUN curl -sL https://wordpress.org/wordpress-6.5.5.tar.gz | tar -xz

COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./conf/wp-config.php	wordpress/wp-config.php

RUN addgroup -g 1000 -S webgroup && adduser -u 1003 -G webgroup -SD wp-user
RUN chown -R wp-user:webgroup /var/log/php82

USER wp-user:webgroup
EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost:9000/fpm-ping || exit 1