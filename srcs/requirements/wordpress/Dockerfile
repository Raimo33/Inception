# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: craimond <bomboclat@bidol.juis>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/06/17 15:51:03 by craimond          #+#    #+#              #
#    Updated: 2024/07/03 18:51:25 by craimond         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.19

SHELL ["/bin/ash", "-c"]

#TODO in www.conf listen = nginx:9000

RUN apk add --no-cache php php-fpm php-mysqli php-json php-curl php-mbstring php-xml curl

WORKDIR /var/www/html

RUN curl -o wordpress-6.5.5.tar.gz https://wordpress.org/wordpress-6.5.5.tar.gz && tar -xvf wordpress-6.5.5.tar.gz && rm -rf wordpress-6.5.5.tar.gz
RUN curl -o /tmp/wp-keys-salts api.wordpress.org/secret-key/1.1/salt/

COPY ./conf/www.conf		/etc/php8/php-fpm.d/www.conf
COPY ./conf/www.conf		/etc/php82/php-fpm.d/www.conf
COPY ./conf/wp-config.php	wordpress/wp-config.php

RUN cat /tmp/wp-keys-salts >> wordpress/wp-config.php

RUN addgroup -g 1000 -S webgroup && adduser -u 1003 -G webgroup -SD wp-user
RUN chown -R wp-user:webgroup /var/log/php82

#TODO remove debug
RUN apk add --no-cache vim mariadb-client

USER wp-user:webgroup
EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost:9000/fpm-ping || exit 1